Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0064C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9D320859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="QDmSszFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfAQTax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:30:53 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:46731 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfAQTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:30:52 -0500
Date:   Thu, 17 Jan 2019 19:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1547753448;
        bh=HJBKZ8PtqxY+VcQp4wvvTxv0AeJJfjPihAJvQvXbFJ4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=QDmSszFILA5oT5phVVPaNnP7z7h7fMNDjX8+qFGL6fi7LPHlTJ9RaLytNgDAn7CWB
         1LgSm7Fyqg8UzrD8f6iLP6omi8lWaJuxeO6HWtdaTLvHesWw5eBW1evoQCKmMHjEL/
         er5qwHsSmruJs69y7V+Q4UoAWbLnLThHkinhqQSw=
To:     Hans de Goede <hdegoede@redhat.com>
From:   Mogens Jensen <mogens-jensen@protonmail.com>
Cc:     Dean Wallace <duffydack73@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
Message-ID: <pozwYTgSVvWumpTgwwf_C-qvYFNnl7yl9gcq9M-LOUXQTvkSX5f8E_2d-HYNYV_ruL8kAURaIR3ItM_UmFJeV-e28eYy8b2MomlwHMbb-5U=@protonmail.com>
In-Reply-To: <c935552f-951f-ab9f-b41c-76c729c6d85c@redhat.com>
References: <20181025232517.ywnw54qibemosjws@picard>
 <d53738e1-4ba5-640e-7ef7-1705ab205061@redhat.com>
 <kAuINEBUUnlS5_uJafGtvryMEJVkDO4pb_yLfClwMcTS1h3sB1gYPcXBvg9X3RINfp5Uch7kLXuhTRX_JtouTYxoS6xNr77_b46e-mugl3k=@protonmail.com>
 <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
 <3iO9ehQbZm_haTV0IuZ0qhsVHR0QLUbTgRJT8ZenGuRsnz2_uBvO93f0bHVYnsApibUT16JsJ0dgphLhUBd-u0t-lDBNsbvvlKWTgq8XOlw=@protonmail.com>
 <3e12e051-b874-187d-d4f5-e146f59c659b@redhat.com>
 <U9ny3qDg8fEQ-IaXWgwAmDf_U7yb1NZxpwoOvTorCbG86v8wUae3kWsa5omAv-ngu3VMaSONp6RdzmaI26Cz6uoyf5ddIiXuJQbzGf2MN3w=@protonmail.com>
 <20190117091214.7djttnpo4jjzi4su@spock>
 <c935552f-951f-ab9f-b41c-76c729c6d85c@redhat.com>
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
On Thursday, January 17, 2019 12:05 PM, Hans de Goede <hdegoede@redhat.com>=
 wrote:

> Hi,
>
> On 17-01-19 10:12, Dean Wallace wrote:
>
> > Hi Hans, Mogens,
> > On 17-01-19, Mogens Jensen wrote:
> >
> > > Kernel is compiled with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH and th=
e quirk seems to have fixed the problem caused by commit 648e921888ad ("clk=
: x86: Stop marking clocks as CLK_IS_CRITICAL"), as sound is now working if=
 running "speaker-test" on my system which is clean ALSA.
>
> Note being "clean ALSA" is really not a good thing now a days,
> for lots of things we depend on pulseaudio (like setting
> up UCM mixer profiles).
>
I'm using UCM mixer profile from:

https://github.com/plbossart/UCM/tree/master/chtmax98090

This is enabled with:

alsaucm -c chtmax98090 set _verb HiFi set _enadev Speakers

> > > Unfortunately, SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH driver is unusa=
ble on Clapper Chromebooks as audio played from everything but "speaker-tes=
t" as video players or web browsers is extremly low and sounds like played =
at 10x speed. At the same time kernel log is spammed with messages like thi=
s:
> > > max98090 i2c-193C9890:00: PLL unlocked
> > > intel_sst_acpi 80860F28:00: FW Version 01.0c.00.01
> > > writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 0=
0 00 ............U...
> > > writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 1=
2 00 ............u...
> > > This is probably not related to the problem discussed in this thread,=
 but the result is that I have to use the legacy driver SND_SOC_INTEL_BYT_M=
AX98090_MACH and therefore still has to revert commit 648e921888ad for soun=
d to work.
> > > Is it possible to create a fix for SND_SOC_INTEL_BYT_MAX98090_MACH on=
 kernel 4.19? Kernel 4.19 is a long term release so it would be very nice t=
o have fix for this version upstream.
> >
> > I have been reverting "clk: x86: Stop marking clocks as CLK_IS_CRITICAL=
"
> > and the patch that initially added the quirk for swanky because of soun=
d
> > instability issues as you described. I'm compiling vanilla Archlinux
> > kernel with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH, using pulseaudio,
> > and have sound in all my apps.
> > Baytrail sound has always been a little touchy, especially using headse=
t
> > with mic, but since the clk patch breaking sound and the quirk patch to
> > fix it, there is a lot more instability. Just running pavucontrol, or
> > plugging in headset sets it off. It's a head scratcher.
>
> Mogens, Dean, can you please try the SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MA=
CH
> driver, without reverting any patches, with the attached patch on top and
> see if that helps?
>
> Thanks & Regards,
>
> Hans

I have applied the patch to kernel 4.19.15 and unfortunately this has not s=
olved the problems.

Audio generated from "speaker-test" is normal, but from everything else is =
very low and played at 10x speed. However, I'm not seeing the "max98090 i2c=
-193C9890:00: PLL unlocked" message in kernel log anymore, but it's still s=
pammed with "writing to lpe: ...".

Regards,

Mogens
