Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28156C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0204A21874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfADPsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:48:05 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46711 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfADPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:48:04 -0500
Received: by mail-ua1-f67.google.com with SMTP id v24so12097141uap.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 07:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3Ng2b81bRrQXvMTkjqBGgcGksIn6799zvFk/OioS4E=;
        b=VDv4nm4Ze50zwKDchW549gBXHSlXHjJqjjeAR5SHDSvQsm1QlC7DyoUeWX5tF878OA
         7shfDvWDhItKdeNszLuZzYRJDwslV1i+ULuKLjUNDzddkA/GywuumffV+1N6ZieonSv0
         F3t5qLp6WyJgM9IC7+/Kl1+iJX0xqwRP/4McGZHAFcz0VwzEPalZhOhwqeuXckZLELFV
         fNl2JZIpYfw5Brm66GGnBQy/FKo9NUad0XF1pgQUSuidjEbk36TpECPi6tztJi3ZkVSO
         wuQtrxdmTVkuK8x27dXYRq3PbtNDLPiXNIh1ioPyiWSaFvAB5h6Tbrw4R3gmuso+6CKK
         pFZg==
X-Gm-Message-State: AJcUukfjrxaXc0Wr0W6cA/K4ewIkGQzML8/VF+7C82SEtr3IauBSXgMY
        xxHgzq7aiEFK+jrOZVYFJXNDHglh1KW/5CNdJ3w=
X-Google-Smtp-Source: ALg8bN7rb2GuWhw0D0kjPArWxqpJhTypvrZUofKWl/xKCEkPW4OgyzoQcOJosf4Cj5NT30k8CzrGGU9a2u4cyVzVDZQ=
X-Received: by 2002:ab0:1393:: with SMTP id m19mr18768817uae.75.1546616881263;
 Fri, 04 Jan 2019 07:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20181227084443.GA23991@localhost.localdomain> <CAMuHMdUg=C+pNrbauM-f7LchXRnwu1ufYyUSp=jO+8hs_SrgXQ@mail.gmail.com>
 <20181231191428.GM1846@sirena.org.uk> <CAMuHMdXi60ZnVMgAxTnBr2ydvhcFzVbooosc+O+gC4q0-0_sEA@mail.gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB70221795DAD@SW-EX-MBX02.diasemi.com>
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB70221795DAD@SW-EX-MBX02.diasemi.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Jan 2019 16:47:48 +0100
Message-ID: <CAMuHMdWbV2=LfSWz0rFTGRakZ=2iXKOYdM_Uwaov8-OsJpUgoA@mail.gmail.com>
Subject: Re: [PATCH] regmap: regmap-irq: silently ignore unsupported type settings
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

()Hi Steve,

On Wed, Jan 2, 2019 at 4:31 PM Steve Twiss
<stwiss.opensource@diasemi.com> wrote:
> On 01 January 2019 @17:36, Geert Uytterhoeven wrote:
> > Subject: Re: [PATCH] regmap: regmap-irq: silently ignore unsupported type settings
> > On Mon, Dec 31, 2018 at 8:14 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Sat, Dec 29, 2018 at 12:13:32PM +0100, Geert Uytterhoeven wrote:
> > > > > Geert, do you know if anyone vould to test this?
> > >
> > > > Thanks, that seems to fix the issue with da9063-rtc.
> > >
> > > > I don't know how to trigger an actual interrupt, though.
> > >
> > > If it's a RTC does it have an alarm you can set?
> >
> > That's what I had expected, too, but there is no alarm file under
> > /sys/class/rtc/.
> >
> > Gr{oetje,eeting}s,
> >
> > Geert
>
> To communicate with the DA9063 RTC I am use ioctl function calls
>
>  - RTC_SET_TIME
>  - RTC_RD_TIME
>  - RTC_ALM_SET
>  - RTC_ALM_READ
>  - RTC_AIE_ON
>  - RTC_AIE_OFF
>
> - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/rtc.txt
> - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/rtc
>
> Although I don't use the test programs found in Linux, the ioctl calls I
> make are shown in the Linux selftests. I believe that Alexandre Belloni
> updated the RTC tests recently -- but I am not up to date with the latest.
>
> git show d8da8665e8e34c14f9b20fe3f21dff29b24cbf02:tools/testing/selftests/rtc/rtctest.c

root@koelsch:~# tools/testing/selftests/rtc/rtctest
[==========] Running 5 tests from 2 test cases.
[ RUN      ] rtc.date_read
rtctest.c:49:rtc.date_read:Current RTC date/time is 04/01/2019 14:44:25.
[       OK ] rtc.date_read
[ RUN      ] rtc.uie_read
[       OK ] rtc.uie_read
[ RUN      ] rtc.uie_select
rtctest.c:98:rtc.uie_select:Expected 0 (0) != rc (0)
rtc.uie_select: Test terminated by assertion
[     FAIL ] rtc.uie_select
[ RUN      ] rtc.alarm_alm_set
rtctest.c:137:rtc.alarm_alm_set:Alarm time now set to 14:47:23.
rtctest.c:148:rtc.alarm_alm_set:Expected 0 (0) != rc (0)
rtc.alarm_alm_set: Test failed at step #5
[     FAIL ] rtc.alarm_alm_set
[ RUN      ] rtc.alarm_wkalm_set
rtctest.c:198:rtc.alarm_wkalm_set:Alarm time now set to 04/01/2019 14:47:28.
rtctest.c:205:rtc.alarm_wkalm_set:Expected 0 (0) != rc (0)
rtctest.c:214:rtc.alarm_wkalm_set:Expected new (1546613934) == secs (1546613248)
rtc.alarm_wkalm_set: Test terminated by assertion
[     FAIL ] rtc.alarm_wkalm_set
[==========] 2 / 5 tests passed.
[  FAILED  ]
root@koelsch:~#

No interrupt fired, as witnessed by /proc/interrupts, and the pr_info()
I had added to da9063_alarm_event().

Note that rtctest behaves the same before the regmap irq breakage,
so this is not a recent regression...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
