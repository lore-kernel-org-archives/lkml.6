Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C14C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D82222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knIKOGgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfBOTaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:30:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35594 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBOTaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:30:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so5428219plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rwOZ1HLdnisi89R4DCRW0Oj216+vPC7LAjgiAbDKFCU=;
        b=knIKOGgRDVfu4l66MiDcZg4MdvjI6dFd49zhlqiJGhJDGdy0sJT1Cyh6B/X/ZPhn8g
         C457Hs31lDjD+8Y2U2Tbmvrs8gnT/tsEf0Vf/O3tZ2TQ9tdwoOd0c2Kh0Ca+SkSkFsv+
         D7JiIQ7iwzQ/pFh8e5dURzrul4kAbkcR3jhyElX6qPIya73DjdHKFThJyzMzgN+FxVub
         pxlpYn83gX4tTABisMP460RNk/bjVy41EcioWtYs1QrzTG6UmxO3+LDJMZQ+cs7SQpaq
         S9jYeC97kWTOzWUE+jJrYZUZj7RUI6lrFkCxvjwBJKXdiKfsA1qi7998FKQgbd4Y9JY9
         AsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rwOZ1HLdnisi89R4DCRW0Oj216+vPC7LAjgiAbDKFCU=;
        b=OAwJHskpTNA+ZWju7NGzJ4Z/ai0VlR3hTDVrDfL0gzmixe4klS1j/Wvhj1C7N1zrDq
         Nx4nYJaKcf/v96S9U/+O0lae3xzKuLqIMJFKw2Sv/u9nhkyh4YgoObi/2NM54e1BMt6O
         TIGYQUy5DyjT9hixVrCIPSD7Ijjj9OfHD1ai3TpugAHM2RcqrEpbAW5HQH/T+93Pckxi
         rFBBDF2RGmm/gaw5DIuZu6XRiqvex7/zhPGzmoIT+nm74mzfiR/Fa++2iJGyZT7o8CKC
         +ebHWrSXiY6yXsLAf+w57doqpSHcYHF6Ff6c+ga+0IQ/cnktiB2GL3dFCeLve8IvdLQf
         DoGg==
X-Gm-Message-State: AHQUAuZP2kt3llFewhuHgQBS03zstcyj5G0+cN5LZcxBfax+cak4MNp8
        3gTNctbQb6U9ODNV+GwvnowaEeW7
X-Google-Smtp-Source: AHgI3IYU3vhR6PgWvXeDIKAx3DlLl/iE0yrg5W+Z7ug74BV3s7mdpeqe1APEXnMvnHYFq8sdyr0R8A==
X-Received: by 2002:a17:902:bb89:: with SMTP id m9mr11691746pls.320.1550258999655;
        Fri, 15 Feb 2019 11:29:59 -0800 (PST)
Received: from [10.67.48.220] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id h15sm8724127pfn.9.2019.02.15.11.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 11:29:58 -0800 (PST)
Subject: Re: [PATCH 2/2] soc: bcm: bcm2835-pm: Fix error paths of
 initialization.
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20190213003324.15224-1-eric@anholt.net>
 <20190213003324.15224-2-eric@anholt.net>
 <648bbc3e-6690-9b05-cae5-bf81edbec74a@i2se.com> <87tvh7v8yd.fsf@anholt.net>
 <1278623750.602548.1550097191567@email.ionos.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <cfe72e6c-4419-9d8a-184b-b0928ab69e11@gmail.com>
Date:   Fri, 15 Feb 2019 11:29:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1278623750.602548.1550097191567@email.ionos.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 2:33 PM, Stefan Wahren wrote:
> 
>> Eric Anholt <eric@anholt.net> hat am 13. Februar 2019 um 19:28 geschrieben:
>>
>>
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>
>>> Hi Eric,
>>>
>>> Am 13.02.19 um 01:33 schrieb Eric Anholt:
>>>> The clock driver may probe after ours and so we need to pass the
>>>> -EPROBE_DEFER out.  Fix the other error path while we're here.
>>>>
>>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>>> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
>>>> ---
>>>>  drivers/soc/bcm/bcm2835-power.c | 30 +++++++++++++++++++++++++-----
>>>>  1 file changed, 25 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
>>>> index 4a1b99b773c0..11f9469423f7 100644
>>>> --- a/drivers/soc/bcm/bcm2835-power.c
>>>> +++ b/drivers/soc/bcm/bcm2835-power.c
>>>> @@ -485,7 +485,7 @@ static int bcm2835_power_pd_power_off(struct generic_pm_domain *domain)
>>>>  	}
>>>>  }
>>>>  
>>>> -static void
>>>> +static int
>>>>  bcm2835_init_power_domain(struct bcm2835_power *power,
>>>>  			  int pd_xlate_index, const char *name)
>>>>  {
>>>> @@ -493,6 +493,12 @@ bcm2835_init_power_domain(struct bcm2835_power *power,
>>>>  	struct bcm2835_power_domain *dom = &power->domains[pd_xlate_index];
>>>>  
>>>>  	dom->clk = devm_clk_get(dev->parent, name);
>>>> +	if (IS_ERR(dom->clk)) {
>>>> +		int ret = PTR_ERR(dom->clk);
>>>> +
>>>> +		if (ret == -EPROBE_DEFER)
>>>> +			return ret;
>>> is it safe to proceed in the other error cases?
>>> Even it would be more consistent with clk_prepare_enable() to print an
>>> error here.
>>
>> Yes, not all domains have a clk, so we want to ignore the other error.
> 
> But shouldn't we set dom->clk to NULL instead of keeping the error pointer? AFAIK clk_prepare_enable is aware of NULL instead of error pointer.

If the clock is really optional, then yes, this should be the way to go.
-- 
Florian
