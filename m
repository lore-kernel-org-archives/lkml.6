Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070D3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF5C20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VQ1e/1Rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfAQF65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 00:58:57 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:19703 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfAQF6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 00:58:55 -0500
Date:   Thu, 17 Jan 2019 05:58:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1547704731;
        bh=i1VkpQwcMKdx7TXYZssic6HvDGJTyZCn+4K+pxJQPUg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=VQ1e/1Rtsxg5ilhohZbnpuvB/Ykb3ia8+k0KMo6u8RJFFcOOCUg4F/uOb+L5T6zVF
         l6UfCEixoaeJxTmJWaY8yeSYrflG9Abp/xKwnHbcjmPnnMb1NoyvVECjBDgDEWkoZa
         5NQ102VJn6p0F25DtnAjbX+6CyxwoR3fBXVPHIbA=
To:     Hans de Goede <hdegoede@redhat.com>
From:   Mogens Jensen <mogens-jensen@protonmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Dean Wallace <duffydack73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Mogens Jensen <mogens-jensen@protonmail.com>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Message-ID: <U9ny3qDg8fEQ-IaXWgwAmDf_U7yb1NZxpwoOvTorCbG86v8wUae3kWsa5omAv-ngu3VMaSONp6RdzmaI26Cz6uoyf5ddIiXuJQbzGf2MN3w=@protonmail.com>
In-Reply-To: <3e12e051-b874-187d-d4f5-e146f59c659b@redhat.com>
References: <20181025232517.ywnw54qibemosjws@picard>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <BaxBOBmUCld7THAnRIDXUpKq8uQ2oJ49EaNlq0mZ11gFjA5JjhbfhVouLZGc1q74PrQC6uGfddKklIP059D_DtQwBqK-sn9rd4xEPhW9E6s=@protonmail.com>
 <d53738e1-4ba5-640e-7ef7-1705ab205061@redhat.com>
 <kAuINEBUUnlS5_uJafGtvryMEJVkDO4pb_yLfClwMcTS1h3sB1gYPcXBvg9X3RINfp5Uch7kLXuhTRX_JtouTYxoS6xNr77_b46e-mugl3k=@protonmail.com>
 <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
 <3iO9ehQbZm_haTV0IuZ0qhsVHR0QLUbTgRJT8ZenGuRsnz2_uBvO93f0bHVYnsApibUT16JsJ0dgphLhUBd-u0t-lDBNsbvvlKWTgq8XOlw=@protonmail.com>
 <3e12e051-b874-187d-d4f5-e146f59c659b@redhat.com>
Feedback-ID: 4dFv7M8pOtP7CMTtfNdOwXARWpF2vcQYB4dRuX1h9mb-6008qkzO2MVweOzrAYHEdkjJ6P5PUdgJEubk4l9Lhg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Sunday, December 2, 2018 12:25 PM, Hans de Goede <hdegoede@redhat.com> w=
rote:

> Hi,
>
> On 01-11-18 07:55, Mogens Jensen wrote:
>
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
> > On Wednesday, October 31, 2018 9:29 AM, Hans de Goede hdegoede@redhat.c=
om wrote:
> >
> > > Hi,
> > > On 31-10-18 07:02, Mogens Jensen wrote:
> > >
> > > > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Ori=
ginal Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=
=E2=80=90
> > > > On Tuesday, October 30, 2018 7:10 PM, Hans de Goede hdegoede@redhat=
.com wrote:
> > > >
> > > > > Hi,
> > > > > On 30-10-18 19:56, Mogens Jensen wrote:
> > > > >
> > > > > > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90 Original Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90=E2=80=90
> > > > > > On Tuesday, October 30, 2018 4:04 PM, Hans de Goede hdegoede@re=
dhat.com wrote:
> > > > > >
> > > > > > > Hi,
> > > > > > > On 30-10-18 16:46, Hans de Goede wrote:
> > > > > > >
> > > > > > > > Hi,
> > > > > > > > On 30-10-18 16:04, Pierre-Louis Bossart wrote:
> > > > > > > >
> > > > > > > > > In addition I am not aware of any baytrail device using p=
lt_clk_0, so moving a common machine driver such a cht_bsw_max98090_ti to u=
se plt_clk0 only would break other devices (e.g. Rambi/Orco). Asking for bo=
th clocks to be on might work though,
> > > > > > > >
> > > > > > > > Ok, so we need to have a DMI based quirk for the Swanky and=
 maybe also
> > > > > > > > the clapper to use plt_clk_0 there. Asking for 2 clks if we=
 only need
> > > > > > > > one does not seem like a good plan.
> > > > > > >
> > > > > > > Dean, Mogens,
> > > > > > > To write a proper patch for this I'm going to need DMI string=
s
> > > > > > > from your devices.
> > > > > > > Can you please run (as normal user):
> > > > > > > grep . /sys/class/dmi/id/* 2> /dev/null
> > > > > > > And reply with the output of this command?
> > > > > > > I have attached the output from a coreboot seabios based clap=
per.
> > > > >
> > > > > Thank you.
> > > > >
> > > > > > Should I still test 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc=
_plt_clk_0-ins.patch with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH and asound=
rc from Dean? There seems to have been some development in the case since t=
hat request was made.
> > > > >
> > > > > Yes please test that, I expect that to also fix things for the
> > > > > Clapper, but I need to have that confirmed before submitting a
> > > > > patch upstream adding a quirk for the Clapper to use pmc_plt_clk_=
0
> > > > > instead of pmc_plt_clk_3.
> > > > > Regards,
> > > > > Hans
> > > >
> > > > Unfortunately I only have access to longterm kernel 4.14 for buildi=
ng/running on this system, and 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_=
plt_clk_0-ins.patch does not patch against 4.14.78. Can a test patch for 4.=
14 be created?
> > >
> > > Can you run (as root):
> > > for i in /sys/kernel/debug/clk/pmc_plt_clk_?; do echo -n "$i: "; cat =
$i/clk_flags; echo; done
> > > When running a kernel with working audio?
> > > Then I can confirm that the Clapper is also using pmc_plt_clk_0, so t=
hat I can
> > > fix this for the clapper for 4.18+
> > > I've just checked the 4.14 sources and in 4.14 the SND_SOC_INTEL_CHT_=
BSW_MAX98090_TI_MACH
> > > driver does not support mclk control yet, so for the 4.14 kernel the =
only way to
> > > fix this is to revert the 648e921888ad ("clk: x86: Stop marking clock=
s as CLK_IS_CRITICAL")
> > > commit.
> > > Regards,
> > > Hans
> >
> > Here is the output from the Clapper with 4.14.78 and working sound:
> > /sys/kernel/debug/clk/pmc_plt_clk_0: 0x00000800
> > /sys/kernel/debug/clk/pmc_plt_clk_1: 0x00000000
> > /sys/kernel/debug/clk/pmc_plt_clk_2: 0x00000000
> > /sys/kernel/debug/clk/pmc_plt_clk_3: 0x00000000
> > /sys/kernel/debug/clk/pmc_plt_clk_4: 0x00000000
> > /sys/kernel/debug/clk/pmc_plt_clk_5: 0x00000000
>
> Ok, so your Clapper model indeed is also using clk 0 and not clk 3 as
> expected. I've just submitted a patch upstream adding a quirk for this.
>
> As for what the plan is with 4.14, I don't know. I believe that
> reverting the commit causing the issue there is fine.
>
> Regards,
>
> Hans

Hi,

I have now tried the recently released kernel 4.19.14 on my Chromebook Clap=
per as this version now contains the DMI quirk (commit 984bfb398a3af6fa9b7e=
80165e524933b0616686 upstream).

Kernel is compiled with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH and the quir=
k seems to have fixed the problem caused by commit 648e921888ad ("clk: x86:=
 Stop marking clocks as CLK_IS_CRITICAL"), as sound is now working if runni=
ng "speaker-test" on my system which is clean ALSA.

Unfortunately, SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH driver is unusable on=
 Clapper Chromebooks as audio played from everything but "speaker-test" as =
video players or web browsers is extremly low and sounds like played at 10x=
 speed. At the same time kernel log is spammed with messages like this:

max98090 i2c-193C9890:00: PLL unlocked
intel_sst_acpi 80860F28:00: FW Version 01.0c.00.01
writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00  =
............U...
writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  =
............u...

This is probably not related to the problem discussed in this thread, but t=
he result is that I have to use the legacy driver SND_SOC_INTEL_BYT_MAX9809=
0_MACH and therefore still has to revert commit 648e921888ad for sound to w=
ork.

Is it possible to create a fix for SND_SOC_INTEL_BYT_MAX98090_MACH on kerne=
l 4.19? Kernel 4.19 is a long term release so it would be very nice to have=
 fix for this version upstream.

Regards,

Mogens
