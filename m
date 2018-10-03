Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D85C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877D821473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ7S7OPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877D821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeJDDg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:36:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39531 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeJDDg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 23:36:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id 61-v6so6848292wrb.6;
        Wed, 03 Oct 2018 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0ANK0TI/9cZik6o3EpEoBxc9kdbZCu3Mtrbs4maRRPQ=;
        b=PQ7S7OPUmBBFo7HytXkcPQLnhrPPomg2utJUiqXKYC3eUxSSCNzDbyX8OEtE+EXais
         Y1TcTqSDVW4Lq+EMz/pb2O7U8K9/2fbopevrAhc21tX6+Opz6wFreL/v+mTqDIMz40D5
         42HYmht7Nc3azo7SW1Jl3l1eUHZOWa2eOC0n3B8S8vXt2cDLmDc6UO+2SC052x5/L3M8
         PdpprZXRrZ0A4lfacTT1K2uJ5kjXA2AqvvjHim9vAP67tFQzNP0y0506e9tB7ogX4duc
         uucVsAwJQiNA+Nmat51LcMx+fU3fIi7Ak4ooZmt7khpj7SWeHFTDX21b7gGH3EaZWlyN
         78Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ANK0TI/9cZik6o3EpEoBxc9kdbZCu3Mtrbs4maRRPQ=;
        b=AiFnJp0QjzDFuOLVjfgJETcYb7iqeUSkuZ3MLVi+TLobJ1mIIHct6uFQItie9bhZ5P
         urrEDyT1lcKk/34H7FZ3C9b9j11XA3Y7bI0l2FA1s34K5N+AbjWLc9jMd9JJg4ccoeb/
         7rYVbkeFZyjR84RhomFJlMJpmTqdi4KuDWF7k9DITNI9j5sKOZBaWWt1psx4iW5O4wwm
         eAuKusGxcIEWp+HiyN2cs7qMXdqlL8/2H53+26kvR7dcOX3B+xPXhTZ1lcvtvWdp/b/k
         x+4f713N5PP7RPWR8EYxzCmDk5851UGt2RqSst2c6k3mSWpdCv5PI2UcdtSA44TgD2Fp
         g24A==
X-Gm-Message-State: ABuFfogyzPWz+C0dRnZd8Ax1ihC48w5kwupdJL/buh/nayDW60oQoc7c
        ctkmh88MXU0n9Q4lKckmGI2+nXva
X-Google-Smtp-Source: ACcGV60ifJiLcVNYnnTU2B+HvUwW2it01iATFPlZq2iuotf3rRkSGwpOp7up/to/gzo8L84UG4D8BA==
X-Received: by 2002:a5d:540d:: with SMTP id g13-v6mr2576676wrv.4.1538599614283;
        Wed, 03 Oct 2018 13:46:54 -0700 (PDT)
Received: from [192.168.1.18] (chn147.neoplus.adsl.tpnet.pl. [83.31.11.147])
        by smtp.gmail.com with ESMTPSA id k25-v6sm4211074wre.18.2018.10.03.13.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 13:46:53 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [RFC PATCH v2 2/9] dt-bindings: ti-lmu: Remove LM3697
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-3-dmurphy@ti.com> <20181002072827.GA19677@amd>
 <fef2c612-ac35-126e-669e-335fb3075f64@ti.com> <20181003130154.GA20418@amd>
Message-ID: <f4ed1450-6c99-e4c6-0092-f355ab3278f7@gmail.com>
Date:   Wed, 3 Oct 2018 22:46:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003130154.GA20418@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2018 03:01 PM, Pavel Machek wrote:
> On Wed 2018-10-03 07:24:23, Dan Murphy wrote:
>> Hello
>>
>> On 10/02/2018 02:28 AM, Pavel Machek wrote:
>>> On Fri 2018-09-28 13:29:47, Dan Murphy wrote:
>>>> Remove support for the LM3697 LED device
>>>> from the ti-lmu.  The LM3697 will be supported
>>>> via a stand alone LED driver.
>>>>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>
>>> NAK, for reasons I explained before. Please add it to the patch so
>>> that it does not get applied by mistake. Ouch and AFAICT Rob was not
>>> happy with this either.
>>>
>>> Yes, you are creating new drivers, ok; but that does _not_ mean you
>>> should create new binding.
>>
>> I am copying my comment here on the review of this original binding for
>> records
>>
>> I found the review or at least the reference for the ti-lmu.txt binding.
>>
>> https://lore.kernel.org/patchwork/patch/764180/
>>
>> Does not appear that the binding was sent to the device tree mail list.
>> (Maybe that email list did not exist in Feb 2017).
> 
> Quick google shows:
> 
> https://lwn.net/Articles/666023/

This link refreshed my memory and allowed me to recall Milo's patch set
from the end of 2015, and the related discussion. I had an impression
that I had had some request regarding the bindings but there was no
follow-up.

I've googled that thread [0] and it proved I was right [1].

From Milo's messages we can infer that there will be next
version of the patch set and it appeared but over a year later [2],
and without the leds-lm3633 driver and related bindings, and without
drivers/video/backlight/ti-lmu-backlight-core.c.

Patch set gets merged despite dangling DT references.

Dan, I propose you to resend the patch removing the bindings from
MFD, and explain the rationale in the patch below commit message
after "---" .

> Now can we stop this nonsense? If there is a problem with the binding,
> submit patches to fix the problem.

[0]
https://lore.kernel.org/lkml/1448521025-2796-1-git-send-email-milo.kim@ti.com/
[1] https://lore.kernel.org/lkml/56656468.8020300@samsung.com/
[2]
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1341860.html

-- 
Best regards,
Jacek Anaszewski
