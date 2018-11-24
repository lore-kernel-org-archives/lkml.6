Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED010C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966212086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVPpO9Ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966212086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeKYGiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 01:38:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43813 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeKYGiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 01:38:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so15118485wrs.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 11:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eZ86WDoX0dcbFS5Ew7w8sfoMi/znBZaQN9tOsxYV/2Q=;
        b=kVPpO9JuijgQeZN/jmiZi62flIaBuyU/sIKhOqqV+Oiwalh1ZymDn/tzgr7wXkwFtl
         VQPN+qET8CeKsYvHmhPRbUib+Qs8WQcPeUy05OQ9q7r2tb/StUX+iUsR0qA4/UpLMas5
         U3wyfDCdVh7n6+CztsSUBRtZWYZA0N52OmAAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eZ86WDoX0dcbFS5Ew7w8sfoMi/znBZaQN9tOsxYV/2Q=;
        b=IrM2T5fPv+Bm1BmU+0eCXocC2GSHaRcBxSCDd28aoxAt8CsS3jpE7FcZRI28thbQ+R
         jJ2NIt5TiI3ZWGfuKguwUYI2i5drWmFhCFxUs+ffFjXEXQLm925rjgRONto7SGW/z/nT
         wAgGqQQ/5r8PH0U8z19BfDjF5bRhNK+iG/7sV+duIlUqMc9m/PUDkSNEXoag6gGJmLkn
         4gg/+frAuj4JSJVTQvl7A3y8JolpTzN5V6B6HakdgglXJM8ySCEADQnSMllnnDM55s3r
         on9p+EQ/34+MrBaqOvhs+7Pa7d7Lkp1a+F/3kdfjSv/lKXz5ev7MiFZnRIRjJe84VZAn
         wHwQ==
X-Gm-Message-State: AA+aEWbvEU7/KE4BIndyfCqu4Q7TuMOCVoDWTcJj/Fr0UakHqm5UKwnh
        fBLDHpGnsAFpILFS2pvywmdQK3ZEKN4=
X-Google-Smtp-Source: AFSGD/VyLnQgUJGszi1vPL5osgJmaLgFCuNseeZrc1T3vZs0q5RU6/c7/0FBcA+9t3Svm9yrUv4hrQ==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr17948109wrr.271.1543088953356;
        Sat, 24 Nov 2018 11:49:13 -0800 (PST)
Received: from [192.168.0.40] (85.64.136.77.rev.sfr.net. [77.136.64.85])
        by smtp.googlemail.com with ESMTPSA id j199sm25745700wmf.13.2018.11.24.11.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 11:49:12 -0800 (PST)
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add missing
 of_node_put()
To:     Frank Lee <tiny.windzz@gmail.com>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
References: <20181122152331.25739-1-tiny.windzz@gmail.com>
 <CAEExFWt45G5hyAEZvaAW--ZANnTqmi7-i473jRfFLD0Wacp6-w@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <97b95b60-8420-bad9-4d2c-6baee749b90f@linaro.org>
Date:   Sat, 24 Nov 2018 20:49:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEExFWt45G5hyAEZvaAW--ZANnTqmi7-i473jRfFLD0Wacp6-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2018 15:58, Frank Lee wrote:
> On Thu, Nov 22, 2018 at 11:23 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>>
>> of_find_node_by_path() acquires a reference to the node
>> returned by it and that reference needs to be dropped by its caller.
>> integrator_ap_timer_init_of() doesn't do that, so fix it.
>>
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>> ---
>>  drivers/clocksource/timer-integrator-ap.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
>> index 76e526f58620..1f04069470bb 100644
>> --- a/drivers/clocksource/timer-integrator-ap.c
>> +++ b/drivers/clocksource/timer-integrator-ap.c
>> @@ -177,7 +177,7 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
>>  {
>>         const char *path;
>>         void __iomem *base;
>> -       int err;
>> +       int err,rc = 0;
>>         int irq;
>>         struct clk *clk;
>>         unsigned long rate;
>> @@ -210,26 +210,34 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
>>                                 "arm,timer-secondary", &path);
>>         if (err) {
>>                 pr_warn("Failed to read property\n");
>> -               return err;
>> +               rc = err;
>> +               goto out_put_pri_node;
>>         }
>>
>>
>>         sec_node = of_find_node_by_path(path);
>>
>> -       if (node == pri_node)
>> +       if (node == pri_node){
>>                 /* The primary timer lacks IRQ, use as clocksource */
>> -               return integrator_clocksource_init(rate, base);
>> +               rc = integrator_clocksource_init(rate, base);
>> +               goto out;
>> +       }
>>
>>         if (node == sec_node) {
>>                 /* The secondary timer will drive the clock event */
>>                 irq = irq_of_parse_and_map(node, 0);
>> -               return integrator_clockevent_init(rate, base, irq);
>> +               rc = integrator_clockevent_init(rate, base, irq);
>> +               goto out;
>>         }
>>
>>         pr_info("Timer @%p unused\n", base);
>>         clk_disable_unprepare(clk);
>> +out:
>> +       of_node_put(sec_node);
>> +out_put_pri_node:
>> +       of_node_put(pri_node);
>>
>> -       return 0;
>> +       return rc;
>>  }
>>
>>  TIMER_OF_DECLARE(integrator_ap_timer, "arm,integrator-timer",
>> --
>> 2.17.0
>>
> Hi Daniel：
> 
> How about this?

Hi,

I think there is a simpler fix. The pri_node and the sec_node are used
as an identifier to compare against the current node, we can directly
drop the refcount after getting the node from path as it is not used as
pointer. In addition, a single variable is needed, so we end up with a
fix like that.

	alias_node = of_find_node_by_path(path);
	of_node_put(alias_node);
	if (node == alias_node)
		return integrator_clocksource_init(rate, base);



> 
> Thanks，
> Yangtao
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

