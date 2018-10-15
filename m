Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E654C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB55C20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRr8Qt7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB55C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeJPC7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:59:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55971 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeJPC7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:59:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so20045124wmb.5;
        Mon, 15 Oct 2018 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EMAKzCJAbrOc3V6pZdFxkOUbn3FPg3/bb5nA7JA8Egs=;
        b=nRr8Qt7r50jXGXCLieYHiKscD/bLIa3K0ZZ8LZ/N00hlEjFrcIHjDhd3xyB0nWNx0Y
         0qESutOBsY6AhkA/Ng1/OAWEcKPdYrEM8ckLmZ42oMTS9l3OmGmhecdQT+WlOAilazCH
         1O/Ond/KR5krGNrm84ugS6RAsqEvNhzIhH5IToK266B+atBliTf3cuzyO+LX0xZ/YjiZ
         kCrNNGB5Zj+z1dPV6/js4kd/ksLx/5Yq30YB4juKnEidUgkDV4cZ698AzWcGdiT9H0hb
         wPlLq7GA/KWGEpS+z86qlIU/fHNh6BRNT+JqC6JMEQnBl1JhapV/AwX2CKjXxjbGBm2M
         C++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EMAKzCJAbrOc3V6pZdFxkOUbn3FPg3/bb5nA7JA8Egs=;
        b=lVOviLWuzN6IwVaZPr1HcVm6TdBbk7LXttqXa7EvQgtou4/oTDKU3R5GhN7QKJIdXf
         J99wiBkTB9Hha8NQiqYMCfP5RAg8yWocdis6cmEOtUmDYcWL5YR4jpPyQEIdgIHAmGZ+
         wOBa4/JRzAlfjU3zdvobS/AgbAjx0oVrH4Gyr4eJgvP0MtSspVb6dX/tL4sgqnxM+q1p
         l6G9yE5/iZnqw7sL5CPHNH19SDG6MM0Yuj3T1GH828ggpeM/Nz0T3yJbEOsJ1wnHUPFO
         R/VHF1vp8xlEv1HQiQ2VbSKFmLXbPS8laIEtYRgDX0Zteqhjt4hV+bdRjUAn38Mgsx56
         2ncQ==
X-Gm-Message-State: ABuFfoipSDk9uktC1uk9Pc4TMqzufhS+uxMnymUOelC/JbmTp73qUgqS
        AZfq7pZxKHLGFfyNw9lf/pcjg0/p
X-Google-Smtp-Source: ACcGV60wh4fo0dR8dDpLzTBtJNXU83iqFS4S5lJqmQezp3buHQJnkbV6MPKZ9qQEK0E4bHLvWoz7ig==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184-v6mr14662109wmf.143.1539630796907;
        Mon, 15 Oct 2018 12:13:16 -0700 (PDT)
Received: from [192.168.1.18] (blc117.neoplus.adsl.tpnet.pl. [83.28.196.117])
        by smtp.gmail.com with ESMTPSA id l11-v6sm17106869wrn.61.2018.10.15.12.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 12:13:16 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
To:     Rob Herring <robh@kernel.org>, Dan Murphy <dmurphy@ti.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <20181011165123.32198-1-dmurphy@ti.com>
 <20181011165123.32198-3-dmurphy@ti.com> <20181011182734.GA7973@amd>
 <4fcb91c7-b2b2-798d-8a41-fa1b475086e0@ti.com>
 <8c1559e1-b703-4c98-8bd9-7c9993bd59f5@gmail.com>
 <20181012162619.GA28573@bogus> <20181012180312.GB5565@amd>
 <60cc9238-aba2-aa6a-64a4-2b5e20835549@gmail.com>
 <CAL_Jsq+Yspr_iNP1eYanvtmiuMf-xNEZ0suDH3tQayV=V5r5=g@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <73647af4-0258-49a9-d9b6-eeef7e7813dc@gmail.com>
Date:   Mon, 15 Oct 2018 21:13:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+Yspr_iNP1eYanvtmiuMf-xNEZ0suDH3tQayV=V5r5=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/2018 02:56 AM, Rob Herring wrote:
> On Sat, Oct 13, 2018 at 1:46 PM Jacek Anaszewski
> <jacek.anaszewski@gmail.com> wrote:
>>
>> On 10/12/2018 08:03 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>>>>
>>>>>>> NAK.
>>>>>>
>>>>>> Thanks for the NAK.
>>>>>>
>>>>>> This NAK was NAK'd by other maintainer in the V2 RFC patchset
>>>>>>
>>>>>> https://lore.kernel.org/patchwork/patch/993171/
>>>>>
>>>>> I confirm. LM3697 is a standalone device and not a cell of any
>>>>> MFD device.
>>>>>
>>>>> Waiting for DT maintainer's ack.
>>>>
>>>> You all sort out what you want... I can't follow it all, and I'm not
>>>> going to spend the time trying to figure out what is going on here.
>>>
>>> This is what I want:
>>>
>>>> As this is worded, changing the driver is a Linux problem and irrelevant
>>>> to the binding. Now if you want to move documentation to a location that
>>>> makes more sense, then fine. But structure patches that way and make it
>>>> clear that from an binding ABI perspective, nothing is changing.
>>>
>>> ...but apparently I did not have enough authority to get it.
>>>
>>> (I'm ok with move, and it is possible that binding does need some
>>> fixups besides the move; still it should be done as fixup not as a new
>>> binding).
>>
>> There is a fundamental question - should the bindings be considered
>> an ABI, even though there is no mainline "*.dts" implementation basing
>> on these bindings?
> 
> In theory there could be out of tree users. Having a dts file using it
> in tree shouldn't be a requirement to maintain the ABI IMO. However, a
> lack of dts is one piece of determining whether this is in use or not.
> 
>> This patch fixes the issues of bindings in a way that would change
>> the ABI, if only it existed. But it apparently doesn't exist in
>> mainline. Unless a DT documentation itself constitutes an ABI.
>>
>> I'd like to have it clarified at this occasion, and that's why
>> I kindly ask for DT maintainer's ack or NACK for this modification
>> of bindings.
>>
>> For a reference we have a nice summary of the MFD driver and related
>> bindings' flaws in [0] and [1].
>>
>> [0] https://lkml.org/lkml/2018/9/7/774
>> [1] https://lkml.org/lkml/2018/9/11/984
> 
> Given this one seems to have not really been finished, it's probably
> okay to make changes in this case. Still, it would be good to see
> patches structured so that it's obvious we're breaking things. But how
> the patches are structured doesn't matter until there's some agreement
> on the end result.

OK, so if I'm getting it right, the correct patch structure in this case
means that changes removing bindings from MFD and moving them along
with the modifications to the LED subsystem should be placed in a single
patch.

Dan, could you please arrange the next patch set version accordingly?

-- 
Best regards,
Jacek Anaszewski
