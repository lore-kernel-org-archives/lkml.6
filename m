Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCA2ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857E920833
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="tCKWqKbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857E920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeKAP5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 11:57:42 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:22859 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeKAP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 11:57:42 -0400
Date:   Thu, 01 Nov 2018 06:55:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1541055358;
        bh=L7pjiLKAAkIotQ282W5/hBG97JL9XoWNivu+3AJESS8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=tCKWqKbMvh3ptrsJ1NaxTrePQz4gxNsdaPna4h3vK9i1d8NGXyQ0QJWpj2WjLLBOh
         I1G8I1wNXVQzuQTOvCrQxkpFFZ3Sa2874gLUF5Y3x36Pp6TsirTW04EZi1FNlauojp
         dSMfQsPb+c/SiDVZ2uDuA4j+tyeOImBxP4XoWqV0=
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
Message-ID: <3iO9ehQbZm_haTV0IuZ0qhsVHR0QLUbTgRJT8ZenGuRsnz2_uBvO93f0bHVYnsApibUT16JsJ0dgphLhUBd-u0t-lDBNsbvvlKWTgq8XOlw=@protonmail.com>
In-Reply-To: <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
References: <20181025232517.ywnw54qibemosjws@picard>
 <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <BaxBOBmUCld7THAnRIDXUpKq8uQ2oJ49EaNlq0mZ11gFjA5JjhbfhVouLZGc1q74PrQC6uGfddKklIP059D_DtQwBqK-sn9rd4xEPhW9E6s=@protonmail.com>
 <d53738e1-4ba5-640e-7ef7-1705ab205061@redhat.com>
 <kAuINEBUUnlS5_uJafGtvryMEJVkDO4pb_yLfClwMcTS1h3sB1gYPcXBvg9X3RINfp5Uch7kLXuhTRX_JtouTYxoS6xNr77_b46e-mugl3k=@protonmail.com>
 <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
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
On Wednesday, October 31, 2018 9:29 AM, Hans de Goede <hdegoede@redhat.com>=
 wrote:

> Hi,
>
> On 31-10-18 07:02, Mogens Jensen wrote:
>
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
> > On Tuesday, October 30, 2018 7:10 PM, Hans de Goede hdegoede@redhat.com=
 wrote:
> >
> > > Hi,
> > > On 30-10-18 19:56, Mogens Jensen wrote:
> > >
> > > > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Ori=
ginal Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=
=E2=80=90
> > > > On Tuesday, October 30, 2018 4:04 PM, Hans de Goede hdegoede@redhat=
.com wrote:
> > > >
> > > > > Hi,
> > > > > On 30-10-18 16:46, Hans de Goede wrote:
> > > > >
> > > > > > Hi,
> > > > > > On 30-10-18 16:04, Pierre-Louis Bossart wrote:
> > > > > >
> > > > > > > In addition I am not aware of any baytrail device using plt_c=
lk_0, so moving a common machine driver such a cht_bsw_max98090_ti to use p=
lt_clk0 only would break other devices (e.g. Rambi/Orco). Asking for both c=
locks to be on might work though,
> > > > > >
> > > > > > Ok, so we need to have a DMI based quirk for the Swanky and may=
be also
> > > > > > the clapper to use plt_clk_0 there. Asking for 2 clks if we onl=
y need
> > > > > > one does not seem like a good plan.
> > > > >
> > > > > Dean, Mogens,
> > > > > To write a proper patch for this I'm going to need DMI strings
> > > > > from your devices.
> > > > > Can you please run (as normal user):
> > > > > grep . /sys/class/dmi/id/* 2> /dev/null
> > > > > And reply with the output of this command?
> > > > > I have attached the output from a coreboot seabios based clapper.
> > >
> > > Thank you.
> > >
> > > > Should I still test 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt=
_clk_0-ins.patch with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH and asoundrc f=
rom Dean? There seems to have been some development in the case since that =
request was made.
> > >
> > > Yes please test that, I expect that to also fix things for the
> > > Clapper, but I need to have that confirmed before submitting a
> > > patch upstream adding a quirk for the Clapper to use pmc_plt_clk_0
> > > instead of pmc_plt_clk_3.
> > > Regards,
> > > Hans
> >
> > Unfortunately I only have access to longterm kernel 4.14 for building/r=
unning on this system, and 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_=
clk_0-ins.patch does not patch against 4.14.78. Can a test patch for 4.14 b=
e created?
>
> Can you run (as root):
>
> for i in /sys/kernel/debug/clk/pmc_plt_clk_?; do echo -n "$i: "; cat $i/c=
lk_flags; echo; done
>
> When running a kernel with working audio?
>
> Then I can confirm that the Clapper is also using pmc_plt_clk_0, so that =
I can
> fix this for the clapper for 4.18+
>
> I've just checked the 4.14 sources and in 4.14 the SND_SOC_INTEL_CHT_BSW_=
MAX98090_TI_MACH
> driver does not support mclk control yet, so for the 4.14 kernel the only=
 way to
> fix this is to revert the 648e921888ad ("clk: x86: Stop marking clocks as=
 CLK_IS_CRITICAL")
> commit.
>
> Regards,
>
> Hans
>
Here is the output from the Clapper with 4.14.78 and working sound:

/sys/kernel/debug/clk/pmc_plt_clk_0: 0x00000800
/sys/kernel/debug/clk/pmc_plt_clk_1: 0x00000000
/sys/kernel/debug/clk/pmc_plt_clk_2: 0x00000000
/sys/kernel/debug/clk/pmc_plt_clk_3: 0x00000000
/sys/kernel/debug/clk/pmc_plt_clk_4: 0x00000000
/sys/kernel/debug/clk/pmc_plt_clk_5: 0x00000000

Will 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL") be r=
everted upstream for 4.14?

Dean, Thank you, but I will see if I can change the build system to accept =
a newer kernel, if I get some time later today.
