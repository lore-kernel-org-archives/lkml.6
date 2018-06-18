Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22EBC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923DD208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLExMCxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923DD208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934140AbeFRPrc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:47:32 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43375 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933524AbeFRPra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:47:30 -0400
Received: by mail-lf0-f66.google.com with SMTP id x13-v6so9962420lff.10;
        Mon, 18 Jun 2018 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qgzqnrQalWsGW1RJVA40c2sIz7hW8l0vaoU27TZiEco=;
        b=ZLExMCxNBYTqhWy/KRYNEbP0v74/bZNn2kC6fDdbzepymZqDoIeuClUhYhnJ+EoWfF
         UIN5wwdwqJR641ZAdWtJGAkBvuCvcBPf1UTYx4ICUSKs5Ah6b9SWNEOM5c9L8BgfCswh
         AKUgVhEakh6cPSTev7Vx/qNPdOK1IYihMz+/ScngoHxVWjeR2v7+pNgodcnAydjFQsJV
         Tv6GpXSQF57ZUd/ijPLNxh5yU52v4uuzk+dg0juk+9nikbudkE8WrJm8pIPHcxmO12MT
         hY9ubxMw8UejiPLA6VM6/u2m2j7Lx211ay/7C10bCbR+zE4Kehck4bFVvNrYhjrjG8RD
         PP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qgzqnrQalWsGW1RJVA40c2sIz7hW8l0vaoU27TZiEco=;
        b=JvfQSbNoKe/pObgPSmeDEq6wudzbs3RXRXwHUMfUajRf4Rc6OK6L01340logzozQts
         IpYXohU6CJCfuRkS5ZxqNSC6ddfLMC/BHNGQS0RK0mAd0E7v1H5s9WuXR98NFk5Uommr
         Z6Khehp6Y9twbF4UIT/kkI7AaLVLCGYKK2vFmTd60dBqtyy0VmTe/xiO8Z8Zl1IY2pp1
         aGzWAdIcezC4Orh2tOtRfMgFb929XgMqRUOPz4WYo9Ww3yVWQkLJcQ1/JAxrzBDcVsza
         8sMbVeYxl3Pk069k6tiPCoKTBjtn8gRdiD7Hckgsf9CFnT1fO/RF37GPTANtIW3F+ugl
         1qZA==
X-Gm-Message-State: APt69E2VmnIsV2L7/oTwiVZw3KzGY+ZGijLGg8CaGmOPEZck7pkpehe2
        Et9OTb9v7OUiizZDxg1PUtb7rpGJWtidMR3Z0mw=
X-Google-Smtp-Source: ADUXVKI5mFeSzSlEh8xn8+Kudft9xYR5VJUplKTE26kDGptmPtSvO12sUb+AfOrDy+rWglC2Hq3gQP3JbDNKhCOFS8c=
X-Received: by 2002:a2e:9ac4:: with SMTP id p4-v6mr8528334ljj.60.1529336849179;
 Mon, 18 Jun 2018 08:47:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 08:47:28
 -0700 (PDT)
In-Reply-To: <20180618150715.GA30470@amd>
References: <20180618144210.72367-1-arnd@arndb.de> <20180618150715.GA30470@amd>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jun 2018 17:47:28 +0200
X-Google-Sender-Auth: GmNvrDGxJQNLPUaVoGXl3Pz7yAU
Message-ID: <CAK8P3a1K19WoEGaqrj6Fx0GYyj1jmA50dS+dMJuF7ugkwjCiug@mail.gmail.com>
Subject: Re: [PATCH] leds: ledtrig-activity: use ktime_get_boot_ns()
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Kees Cook <keescook@chromium.org>, Willy Tarreau <w@1wt.eu>,
        linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 5:07 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> get_monotonic_boottime() is deprecated, so let's convert this to
>> the simpler ktime_get_boot_ns().
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Have you tested it?

No, only build-tested.

>> diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
>> index 5081894082bd..589c1bc4d0b9 100644
>> --- a/drivers/leds/trigger/ledtrig-activity.c
>> +++ b/drivers/leds/trigger/ledtrig-activity.c
>> @@ -37,7 +37,6 @@ static void led_activity_function(struct timer_list *t)
>>       struct activity_data *activity_data = from_timer(activity_data, t,
>>                                                        timer);
>>       struct led_classdev *led_cdev = activity_data->led_cdev;
>> -     struct timespec boot_time;
>>       unsigned int target;
>>       unsigned int usage;
>>       int delay;
>> @@ -57,7 +56,7 @@ static void led_activity_function(struct timer_list *t)
>>               return;
>>       }
>>
>> -     get_monotonic_boottime(&boot_time);
>> +     curr_boot = ktime_get_boot_ns();
>>
>>       cpus = 0;
>>       curr_used = 0;
>> @@ -76,7 +75,6 @@ static void led_activity_function(struct timer_list *t)
>>        * down to 16us, ensuring we won't overflow 32-bit computations below
>>        * even up to 3k CPUs, while keeping divides cheap on smaller systems.
>>        */
>> -     curr_boot = timespec_to_ns(&boot_time) * cpus;
>
> Original code is pretty weird (notice the * cpus), so I'm
> double-checking.

Ok, dropping the *cpus was not intentional, I'll repost a version that puts
it that back. Thanks for pointing this out!

       Arnd
