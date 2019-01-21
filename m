Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4A0C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A9521848
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="DXjMahvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfAUHMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:12:12 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:25158 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfAUHML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:12:11 -0500
Date:   Mon, 21 Jan 2019 05:55:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1548050125;
        bh=8NyUiMuMOSuPNT3VyL0sd2h28dm/gvfHneLqJwZhzQw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=DXjMahvgSF9UAKx+nhAS7rWBM8Zzuzd04CP+vah59N2wqo/HR09w25O9TifkaAF9f
         vphZdQYZlZyrasW+FmRhHLBQTC1qr+LyBT+2l7o9/EtP1eifEmpvlaAhvUgsWT0oon
         Qt7ZYUSXpCPXtGIqd8/35NZHcfkXw4D5rRxiKUdA=
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
Message-ID: <G5Oa_GRw3iClWMtIg1FeCwj1szJHRH6ToqQqCskS_HKzyNhpFFQ3sJndttzyvP3IHRJuHXvDsUC82dnw8r66OIroHCzyqTYbZoki5sSKPUE=@protonmail.com>
In-Reply-To: <983fb777-df22-1b53-acea-8bbcab23b260@redhat.com>
References: <20181025232517.ywnw54qibemosjws@picard>
 <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
 <3iO9ehQbZm_haTV0IuZ0qhsVHR0QLUbTgRJT8ZenGuRsnz2_uBvO93f0bHVYnsApibUT16JsJ0dgphLhUBd-u0t-lDBNsbvvlKWTgq8XOlw=@protonmail.com>
 <3e12e051-b874-187d-d4f5-e146f59c659b@redhat.com>
 <U9ny3qDg8fEQ-IaXWgwAmDf_U7yb1NZxpwoOvTorCbG86v8wUae3kWsa5omAv-ngu3VMaSONp6RdzmaI26Cz6uoyf5ddIiXuJQbzGf2MN3w=@protonmail.com>
 <20190117091214.7djttnpo4jjzi4su@spock>
 <c935552f-951f-ab9f-b41c-76c729c6d85c@redhat.com>
 <pozwYTgSVvWumpTgwwf_C-qvYFNnl7yl9gcq9M-LOUXQTvkSX5f8E_2d-HYNYV_ruL8kAURaIR3ItM_UmFJeV-e28eYy8b2MomlwHMbb-5U=@protonmail.com>
 <983fb777-df22-1b53-acea-8bbcab23b260@redhat.com>
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
On Friday, January 18, 2019 3:35 PM, Hans de Goede <hdegoede@redhat.com> wr=
ote:

> Hi,
>
> On 1/17/19 8:30 PM, Mogens Jensen wrote:
>
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
> > On Thursday, January 17, 2019 12:05 PM, Hans de Goede hdegoede@redhat.c=
om wrote:
> >
> > > Hi,
> > > On 17-01-19 10:12, Dean Wallace wrote:
> > >
> > > > Hi Hans, Mogens,
> > > > On 17-01-19, Mogens Jensen wrote:
> > > >
> > > > > Kernel is compiled with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH an=
d the quirk seems to have fixed the problem caused by commit 648e921888ad (=
"clk: x86: Stop marking clocks as CLK_IS_CRITICAL"), as sound is now workin=
g if running "speaker-test" on my system which is clean ALSA.
> > >
> > > Note being "clean ALSA" is really not a good thing now a days,
> > > for lots of things we depend on pulseaudio (like setting
> > > up UCM mixer profiles).
> >
> > I'm using UCM mixer profile from:
> > https://github.com/plbossart/UCM/tree/master/chtmax98090
> > This is enabled with:
> > alsaucm -c chtmax98090 set _verb HiFi set _enadev Speakers
> >
> > > > > Unfortunately, SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH driver is u=
nusable on Clapper Chromebooks as audio played from everything but "speaker=
-test" as video players or web browsers is extremly low and sounds like pla=
yed at 10x speed. At the same time kernel log is spammed with messages like=
 this:
> > > > > max98090 i2c-193C9890:00: PLL unlocked
> > > > > intel_sst_acpi 80860F28:00: FW Version 01.0c.00.01
> > > > > writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 =
00 00 00 ............U...
> > > > > writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 =
00 12 00 ............u...
> > > > > This is probably not related to the problem discussed in this thr=
ead, but the result is that I have to use the legacy driver SND_SOC_INTEL_B=
YT_MAX98090_MACH and therefore still has to revert commit 648e921888ad for =
sound to work.
> > > > > Is it possible to create a fix for SND_SOC_INTEL_BYT_MAX98090_MAC=
H on kernel 4.19? Kernel 4.19 is a long term release so it would be very ni=
ce to have fix for this version upstream.
> > > >
> > > > I have been reverting "clk: x86: Stop marking clocks as CLK_IS_CRIT=
ICAL"
> > > > and the patch that initially added the quirk for swanky because of =
sound
> > > > instability issues as you described. I'm compiling vanilla Archlinu=
x
> > > > kernel with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH, using pulseaudi=
o,
> > > > and have sound in all my apps.
> > > > Baytrail sound has always been a little touchy, especially using he=
adset
> > > > with mic, but since the clk patch breaking sound and the quirk patc=
h to
> > > > fix it, there is a lot more instability. Just running pavucontrol, =
or
> > > > plugging in headset sets it off. It's a head scratcher.
> > >
> > > Mogens, Dean, can you please try the SND_SOC_INTEL_CHT_BSW_MAX98090_T=
I_MACH
> > > driver, without reverting any patches, with the attached patch on top=
 and
> > > see if that helps?
> > > Thanks & Regards,
> > > Hans
> >
> > I have applied the patch to kernel 4.19.15 and unfortunately this has n=
ot solved the problems.
> > Audio generated from "speaker-test" is normal, but from everything else=
 is very low and played at 10x speed. However, I'm not seeing the "max98090=
 i2c-193C9890:00: PLL unlocked" message in kernel log anymore, but it's sti=
ll spammed with "writing to lpe: ...".
>
> Hmm, I've a feeling the problem is your using alsa directly, do you have
> dmix enabled ? You probably need dmix since the SST sound support
> only supports 48KHz AFAIK.
>
> Can you perhaps give things a try with pulseaudio ?
>
> Regards,
>
> Hans

You are absolutely correct, software mixing was apparently not enabled on m=
y system and this caused the audio problems. I thought that dmix was enable=
d by default if hardware mixing was not supported. Thank you very much.

I was completely wrong about "SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH driver=
 seems to be unusable on Clapper Chromebooks". Sorry about that.

To sum up, audio is working perfectly on my Clapper Chromebook running kern=
el 4.19.15 with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH + "0001-ASoC-intel-c=
ht_bsw_max98090_ti-Enable-codec-clock-on.patch", even better than before wi=
th the legacy driver.

The only minor annoyance I'm experiencing now, is a large amount of debug o=
utput from something in kernel log when audio is played on the system:

writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00  =
............U...
writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  =
............u...
...

Regards,

Mogens
