Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E82C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 18:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470CF20652
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 18:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saugA1xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470CF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJNCYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 22:24:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55735 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbeJNCYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 22:24:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so15158457wmb.5;
        Sat, 13 Oct 2018 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mTVNAo9AVB24FhVpV1eb8pKcy2XaOw3BwCLRwgOY+P8=;
        b=saugA1xtYuFexv7cUiaTvqH8qyHb6CVO4F+4vR9pbzafTJ02fRmKFBRSGsE+LPzgAH
         IhGRe4PONKsacW3pkGU9MpW5Zh/zdpd/GNzJf+Cfxt/BmmbIdCH1P30djb/CrJQSc0n3
         sV/kz3qY1iYONpYumccObaED/sKe+oRISYV9otMnsgKykDW36zK8ID728j7dljVAJWFi
         M07EA2YtCgb1qzgCx/MA5460K0zXNK2AMFDCvJn2ZtwmLtKirO2s2tDSNQdaSXuvjmP+
         qoOPW0NucwsTFyZuyRJFjaucKgCDckY+qpshWsyJ7PvW0C+L1sm6xefSN2UdisqufMlX
         lWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mTVNAo9AVB24FhVpV1eb8pKcy2XaOw3BwCLRwgOY+P8=;
        b=fGs6kNlYASO4x9TKtppudx/QcI0RFnPGMWOM/BS7zpenoXYHiDx487qDvunfWwFQkY
         IOHW/eO3fgXRh8QHf41dhKzYaBmN1EDF1LLnP13WiR0dXZ3noJahv0NMxWQKbj374Tzi
         LvYhkvrq97iRthCCMTYLoNdVAjZKjLUJetZCowkOmwKQTPnNkP/tTuG0GPt8N479/Ij7
         gXYtqUxNpSxc4fwen8uEyf3gKRQJv0nqYWU3v2FSR5iSgtkmUpTVo/ulpjku7X49vHJ5
         FeDzkftK0f+0RACIPzd6ZhdrIXOFGVh9dQfOVk/Tkj4vKfnPRSVRYAawkNTIxS+HV+QQ
         evOg==
X-Gm-Message-State: ABuFfoixU1VrI1EB2tMNBfGfz1LXNs8TpCai7gj36w5JBH6DhJerS+4e
        fsZ4Wz2d/oCJneA3Qo3Q/2BFcBTf
X-Google-Smtp-Source: ACcGV6389P/Ldj3zSKxWv+Jgt7tUEHaWMdrhcHM6+BRtODqP7xh2q39hkAOu5wdwxWWnsnCzA1fyOA==
X-Received: by 2002:a1c:838a:: with SMTP id f132-v6mr9079170wmd.51.1539456367215;
        Sat, 13 Oct 2018 11:46:07 -0700 (PDT)
Received: from [192.168.1.18] (dns107.neoplus.adsl.tpnet.pl. [83.24.100.107])
        by smtp.gmail.com with ESMTPSA id y125-v6sm4117068wme.12.2018.10.13.11.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 11:46:02 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>
Cc:     Dan Murphy <dmurphy@ti.com>, lee.jones@linaro.org,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20181011165123.32198-1-dmurphy@ti.com>
 <20181011165123.32198-3-dmurphy@ti.com> <20181011182734.GA7973@amd>
 <4fcb91c7-b2b2-798d-8a41-fa1b475086e0@ti.com>
 <8c1559e1-b703-4c98-8bd9-7c9993bd59f5@gmail.com>
 <20181012162619.GA28573@bogus> <20181012180312.GB5565@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <60cc9238-aba2-aa6a-64a4-2b5e20835549@gmail.com>
Date:   Sat, 13 Oct 2018 20:45:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012180312.GB5565@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 08:03 PM, Pavel Machek wrote:
> Hi!
> 
>>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>>
>>>>> NAK.
>>>>
>>>> Thanks for the NAK.
>>>>
>>>> This NAK was NAK'd by other maintainer in the V2 RFC patchset
>>>>
>>>> https://lore.kernel.org/patchwork/patch/993171/
>>>
>>> I confirm. LM3697 is a standalone device and not a cell of any
>>> MFD device.
>>>
>>> Waiting for DT maintainer's ack.
>>
>> You all sort out what you want... I can't follow it all, and I'm not 
>> going to spend the time trying to figure out what is going on here.
> 
> This is what I want:
> 
>> As this is worded, changing the driver is a Linux problem and irrelevant 
>> to the binding. Now if you want to move documentation to a location that 
>> makes more sense, then fine. But structure patches that way and make it 
>> clear that from an binding ABI perspective, nothing is changing.
> 
> ...but apparently I did not have enough authority to get it.
> 
> (I'm ok with move, and it is possible that binding does need some
> fixups besides the move; still it should be done as fixup not as a new
> binding).

There is a fundamental question - should the bindings be considered
an ABI, even though there is no mainline "*.dts" implementation basing
on these bindings?

This patch fixes the issues of bindings in a way that would change
the ABI, if only it existed. But it apparently doesn't exist in
mainline. Unless a DT documentation itself constitutes an ABI.

I'd like to have it clarified at this occasion, and that's why
I kindly ask for DT maintainer's ack or NACK for this modification
of bindings.

For a reference we have a nice summary of the MFD driver and related
bindings' flaws in [0] and [1].

[0] https://lkml.org/lkml/2018/9/7/774
[1] https://lkml.org/lkml/2018/9/11/984

-- 
Best regards,
Jacek Anaszewski
