Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149A6C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F462081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F462081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeKAXxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:53:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46883 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbeKAXxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:53:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id f8-v6so4412846edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 07:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=2Fpw53EzW9CoJaasImTdQZHWdlesNBxs4g0CHhPe+YA=;
        b=PfM0oBLyB9h13bUExy5sSEpnCY+JjE+EeOv9DaXUF2pIYJfulHWzsapyzA4RWBCHcs
         /Xp1T7TjUOxBnCanFT0DePonks8eP+UUnHp9zHCs5jCB2BLWOELUCWSXdOOL2poFT2xY
         kQOcUnuoF720xRHnAh5YG8ysZGqPdh+p6XTTcW930RVE5Hyi2aLFUeixeorWd8hTepnQ
         aNX0u8S3C18viP9mCvAkyVe+FebQqeLBG98jU/b2gX9TmtTAqfZclgkowA1C9pz4D3An
         f3sLqHiRMK0wleiljJS+wSrCYxbEc92b8m1jioTc1rJll6P09ipeky2edT3GROeLlX09
         XZqQ==
X-Gm-Message-State: AGRZ1gJPvPim+cxDmQWz6mLn5iHThQRHdd81tgOrPNAH1afruuq9Xc7W
        DfjzXTxOGtFixh/hvrK3AkMFMQ==
X-Google-Smtp-Source: AJdET5d8XqdOWqvWv448mz0W+Mok7uYGRJ4q6H6KF+3bGtbX+n2GNXyqjNauqmd2eHU32bfw0WxwBw==
X-Received: by 2002:a50:aa22:: with SMTP id o31-v6mr5350442edc.23.1541083786807;
        Thu, 01 Nov 2018 07:49:46 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id g19-v6sm8957642edh.36.2018.11.01.07.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 07:49:45 -0700 (PDT)
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Dean Wallace <duffydack73@gmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mogens Jensen <mogens-jensen@protonmail.com>
References: <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <20181030161534.wk5cf7nxbwhp2far@picard>
 <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
 <20181031200709.xrmu6wsdel7dtcjq@picard>
 <da025116-580d-e442-d96f-875282306f1b@linux.intel.com>
 <20181101103705.ay36te4qr5pxtgop@picard>
 <37e44480-44d3-9355-6119-ae46bb38678a@redhat.com>
 <20181101142859.oxtuhbwtt44h2u3r@picard>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <67a7d54b-49cc-aa4e-fe47-bb6277f02bc8@redhat.com>
Date:   Thu, 1 Nov 2018 15:49:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181101142859.oxtuhbwtt44h2u3r@picard>
Content-Type: multipart/mixed;
 boundary="------------4C6AD7A7F5E4C83A3777E2D3"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4C6AD7A7F5E4C83A3777E2D3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 01-11-18 15:28, Dean Wallace wrote:
> On 01-11-18, Hans de Goede wrote:
>> Hi,
>>
>> On 01-11-18 11:37, Dean Wallace wrote:
>>> On 31-10-18, Pierre-Louis Bossart wrote:
>>>>
>>>>> Just thought it worth mentioning, this new patch that fixes sound
>>>>> again, seems to have ressurected an old issue with PLL unlock.  I'm
>>>>> seeing journal entries after fresh boot ......
>>>>>
>>>>> ```
>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>> picard systemd[462]: Started Sound Service.
>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>> picard kernel: max98090_pll_work: 141 callbacks suppressed
>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>> ```
>>>>>
>>>>> sound is ok, but sometimes plugging in headphones spams journal with
>>>>> those PLL messages, and sound turns into "daleks", and I have to
>>>>> remove/insert headphones few times or stop/start audio to fix it.
>>>>> It's a very old issue, maybe you'd know more about it.
>>>>
>>>> I noticed this error on my Orco device used for tests many moons ago, but I
>>>> could never find out what led to this error case, it wasn't deterministic
>>>> and didn't impact the audio quality. All I could do is rate_limit it... If
>>>> we have an A vs. B situation it'd be really helpful to diagnose further.
>>>>
>>>> Is there really a causality between the changes from Hans and this PLL
>>>> unlock error? Are you 100% sure this was not present in the previous install
>>>> you used (4.18.14 as mentioned earlier in the thread)?
>>>>
>>>> Thanks
>>>>
>>>> -Pierre
>>>>
>>> Well, numerous boots, kernels, headphone inserting - no PLL or
>>> 'Daleks'.  My laptop must have been haunted that day (halloween).
>>> I'll put it to bed.
>>
>> So you can no longer reproduce. Bummer. Note this might be caused by
>> the temperature of the laptop when you were running the tests...
>>
>> Anyways if you hit this again and you can reproduce it, please
>> give adding a msleep(10) after code mucking with the clk a try.
>>
>> Regards,
>>
>> Hans
>>
> Right then, I can make it unlock and 'daleks' by going into
> pavucontrol and switching the Profile back and forth from Stereo
> Output to Stereo Output+Analog Mono Input, which is actually something
> I've done to make it correct itself as well.  I don't use the mic or
> anything so I've had it set to Stereo Ouput only which I 'think' has
> somehow made it more stable for me.  With all my playing around, one
> of the things I did was clean out my .config/pulse folder which meant
> by default the 'Profile' in pavucontrol was set to Output+Input, which
> seems to help trigger the PLL issue when inserting headphones.
> 
> So what would you like me to do, as I can trigger it on demand it
> seems.

Please give the attached patch a try (on top of my patch for the clk quirk)
and let us know if that fixes these errors.

Regards,

Hans


--------------4C6AD7A7F5E4C83A3777E2D3
Content-Type: text/x-patch;
 name="0001-ASoC-intel-cht_bsw_max98090_ti-Sleep-a-bit-after-ena.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ASoC-intel-cht_bsw_max98090_ti-Sleep-a-bit-after-ena.pa";
 filename*1="tch"

From d81f1906f08bb6d3aa45a0403adc1d36754c13cc Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 1 Nov 2018 15:47:42 +0100
Subject: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Sleep a bit after enabling
 the mclk

Sleep a bit after enabling the mclk to give the PLL some time to lock,
this fixes the log showing a whole bunch of:

kernel: max98090 i2c-193C9890:00: PLL unlocked

errors.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 9d9f6e41d81c..f3bc0bfdfe08 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -19,6 +19,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -66,6 +67,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 				"could not configure MCLK state");
 			return ret;
 		}
+		usleep_range(5000, 10000);
 	} else {
 		clk_disable_unprepare(ctx->mclk);
 	}
-- 
2.19.0


--------------4C6AD7A7F5E4C83A3777E2D3--
