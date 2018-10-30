Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5E5ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D869C2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj6rn36c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D869C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeJ3XcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:32:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35441 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeJ3XcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:32:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id q12-v6so8863686wmq.0;
        Tue, 30 Oct 2018 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ou+CqMJ5ZdQgrQbGX/Z+TllV6uAGGC2Cb1qqaaefu78=;
        b=Uj6rn36cACEMNZiqPVKcr8njmDgfl27FDJJW+ouqbozXsU7ha/BaWcC1wPfrS3WXez
         PKOdmPrj+EFuUf7yPjWLdpIgeKe2zhv7IvsoTue1DHPG9AVjmzNyJqIn/QtO3xSfa0rZ
         a+YQROF83qajP6vNxq0+pq19i99i4fngbSyU8a8rvTytifUzhHEd7/diWaRToAoqIcwR
         8WTNc563NjxzyEW95nfgEdVC9538K6DYJpuuslvg65I526HKYJWVYny4t/VSGBXPrGhC
         saY8sDZ7YtfnY8j5WJ35NuGQ7P4C91711q/1mx+PWhvtnqUldR1cLRAzmYnB7s5fTYQr
         j0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ou+CqMJ5ZdQgrQbGX/Z+TllV6uAGGC2Cb1qqaaefu78=;
        b=EesQKmdbKBuSaqiS9PYY/LHjbKieBEfp/Grvpu3BtMSTDRQ9Jf+I58ODiJO41l3sKP
         9C+SEfJbU6WiEPA+Hn3uetdP7dmgaFBc+pfvFZJB/XUnTavH8DXfFmPrOViSiSBJ7/NS
         Ss4/LGf6E2m0nkng3oCFXrMXp56UilXI0n1dzSLynNSzgTGSq/IaJWcmZVfBa2arU48H
         4KZ+TTtFxwzIpiXzfiHG3EQdXaA8h+IBAlxj2FgjjqcI7Hai+MDW7ilZ+ns9RtWnOiry
         S7gAWUEbk+rkS0Hr8sFmAtIA5DboUs+tGj/wmLweNviBrwl5DHr5PWPYowXgjDHIMXds
         913A==
X-Gm-Message-State: AGRZ1gLg9FG912ztPLXMddWlwBKBPR9o2GCaLqXK7WkZ6sOGoKO3kxU6
        7YsKw+djVfSqmmnSS17jBK4=
X-Google-Smtp-Source: AJdET5fA/StKeC5/0igtPuThlH6fi5xFFBzShpo2u/Wbx9+sWkP9/FwgvwCW1XoTMujIiXW44XQ8JQ==
X-Received: by 2002:a1c:2cc5:: with SMTP id s188-v6mr2107239wms.52.1540910318010;
        Tue, 30 Oct 2018 07:38:38 -0700 (PDT)
Received: from picard ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id i204-v6sm27681924wmd.28.2018.10.30.07.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 07:38:37 -0700 (PDT)
Date:   Tue, 30 Oct 2018 14:38:36 +0000
From:   Dean Wallace <duffydack73@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mogens Jensen <mogens-jensen@protonmail.com>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Message-ID: <20181030143836.feo7zcxiestylxoo@picard>
References: <20181025232517.ywnw54qibemosjws@picard>
 <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
 <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
 <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
X-Info: Keep It Simple, Stupid.
X-Operating-System: Linux, kernel 4.19.0-arch1-1-max98090
X-Message-Flag: WARNING!! Outlook sucks
User-Agent: Every email client sucks, this one just sucks less.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-10-18, Hans de Goede wrote:
> Hi Dean,
> 
> Attached are 2 different attempts at fixing this.
> 
> When trying these patches do not forget to remove the revert of the
> "Stop-marking-clocks-as-CLK_IS_CRITICAL" commit.
> 
> Please first try the 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch
> patch I expect that one to do the trick indicating that the Swanky model
> uses a different pmc clk then which is normally used for the codec clock.
> 
> If that patch does not fix things, please give the other patch a try.
> 
> Regards,
> 
> Hans
> 
> 
> 
> On 29-10-18 23:03, Pierre-Louis Bossart wrote:
> > 
> > On 10/29/18 2:08 PM, Dean Wallace wrote:
> > > On 29-10-18, Andy Shevchenko wrote:
> > > > On Mon, Oct 29, 2018 at 7:52 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > Cc: Pierre as well.
> > > > > 
> > > > > On Mon, Oct 29, 2018 at 7:48 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > > > Quoting Dean Wallace (2018-10-25 16:25:17)
> > > > > > > I have found a regression in 4.18.15 that means I lose sound on my old
> > > > > > > Toshiba Chromebook 2 (Swanky).  My system details are:-
> > > > > > > 
> > > > > > > Toshiba Chromebook (Swanky)
> > > > > > > MrChromebox UEFI coreboot
> > > > > > > Arch Linux running latest alsa/pulseaudio
> > > > > > > 
> > > > > > > Upgraded kernel from 4.18.14 to 4.18.15 and lost all sound output.  By
> > > > > > > output I mean, the card is still detected, the module loaded, all apps
> > > > > > > showing sound is being playing, but no actual audible sound comes
> > > > > > > through.  Upgraded to 4.18.16 same issue.
> > > > > > > 
> > > > > > > Dug around and found Upstream commit 648e921888ad96ea3dc922739e96716ad3225d7f
> > > > > > > clk: x86: Stop marking clocks as CLK_IS_CRITICAL
> > > > > > > "This commit removes the CLK_IS_CRITICAL marking, fixing Cherry Trail
> > > > > > > devices not being able to reach S0i3 greatly decreasing their battery
> > > > > > > drain when suspended."
> > > > > > > 
> > > > > > > I reverted it and compiled 4.18.16 and have sound back again.  Could
> > > > > > > this be looked into, with possibility of fix.
> > > > > > > 
> > > > > > Thanks for the bug report. I'm adding some people involved in the commit
> > > > > > you mention is causing audio regressions. The best plan is to probably
> > > > > > revert the commit from the 4.18 linux stable tree. Or there may be
> > > > > > another patch missing that would be useful to make this backported patch
> > > > > > work. Hopefully Hans or Andy knows.
> > > > > Hans has been investigating S0ix issues on Baytrail and Cherrytrail machines.
> > > > > I have a feeling that the problem can be fixed by properly handling
> > > > > clock in ASoC driver(s). Perhaps Hans and Pierre can figure this out
> > > > > better than me.
> > > > Looking to sound/soc/intel/boards/cht_bsw_rt5672.c I see no
> > > > suspend-resume hooks. Perhaps, adding them like in the commit
> > > > ac8bd9e13be2 ("r8169: Disable clk during suspend / resume") would
> > > > help.
> > 
> > I missed this change while i was away. It's indeed the expectation that the audio mclk is handled by the firmware,
> 
> I believe that the statement "It's indeed the expectation that the
> audio mclk is handled by the firmware" is not correct for BYT/CHT
> platforms (and the commit causing the regression only affects BYT/CHT
> platforms). Various machine drivers under sound/soc/intel/boards have
> code to deal with the mclk themselves, like this:
> 
>         drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
> ...
> 
>         if (SND_SOC_DAPM_EVENT_ON(event)) {
>                 ret = clk_prepare_enable(ctx->mclk);
> 		...
>         } else {
>                 clk_disable_unprepare(ctx->mclk);
>         }
> 
> The above code is from sound/soc/intel/boards/cht_bsw_max98090_ti.c
> which is the machine driver used on the machines for which problems
> are now being reported.
> 
> And my commit introducing the problem is in essence a revert of:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=d31fd43c0f9a41e2678a1e78c0f22f0384c6edd3
> 
> Which is from 2017-07-14 and the ASoC code for BYT/CHT platforms is
> much older then that.
> 
> Also I asked Carlo why he wrote that patch and it was to fix a problem
> with ethernet on some laptops.
> 
> > not sure I understand why removing the CLK_IS_CRITICAL was necessary or what it has to do with S0ix.
> 
> It is necessary, because if it is set the clock never gets disabled and
> on x86 platforms using suspend2idle we are responsible for *all* the hardware
> power-management as OS. If we do not disable the clocks then we can only
> reach S0i1 instead of S0i3 when suspended leading to increased battery
> drain during suspend.
> 
> Also note that this patch is only causing problems on CHT + max98090 codec
> using machines. I've tested it on many other BYT/CHT machines myself and
> we've not had any other bug reports related to this.
> 
> So this clearly points to a problem with the clock management in the
> cht_bsw_max98090_ti.c machine driver.
> 
> I've some ideas how to fix this and I will prepare some patches to test.
> 
> Regards,
> 
> Hans

Excellent work Hans.  Compiled 4.19 with
0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch, sound
works as before.

for i in /sys/kernel/debug/clk/pmc_plt_clk_?; do echo -n "$i: "; cat $i/clk_flags; echo; done
/sys/kernel/debug/clk/pmc_plt_clk_0: 
/sys/kernel/debug/clk/pmc_plt_clk_1: 
/sys/kernel/debug/clk/pmc_plt_clk_2: 
/sys/kernel/debug/clk/pmc_plt_clk_3: 
/sys/kernel/debug/clk/pmc_plt_clk_4: 
/sys/kernel/debug/clk/pmc_plt_clk_5: 

Regards
-- 
Dean
