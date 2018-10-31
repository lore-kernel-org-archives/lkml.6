Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1229C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0717620657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TKElGKBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0717620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeJaO7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:59:09 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:29367 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJaO7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:59:08 -0400
Date:   Wed, 31 Oct 2018 06:02:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1540965746;
        bh=/rpObqAfd6jNCf7Iq5dH4RBTcOnCeyy10dDhW3lHulk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=TKElGKBUkILDkL1/TbJ0ZgIRuYBezYAma+fa0JMr+1yMeG654F3L9xB3AyCQQ/DAr
         3gSm7K0LPs04ZhGjOuNJIKqk+rF7guDzYhTboLqjH0u+l9BDM6Enu9SuOUuWimGLkE
         JsHZcTCXAbD/qb/3gtX2QnRs8qyocDgcO1yT67jQ=
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
Message-ID: <kAuINEBUUnlS5_uJafGtvryMEJVkDO4pb_yLfClwMcTS1h3sB1gYPcXBvg9X3RINfp5Uch7kLXuhTRX_JtouTYxoS6xNr77_b46e-mugl3k=@protonmail.com>
In-Reply-To: <d53738e1-4ba5-640e-7ef7-1705ab205061@redhat.com>
References: <20181025232517.ywnw54qibemosjws@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <BaxBOBmUCld7THAnRIDXUpKq8uQ2oJ49EaNlq0mZ11gFjA5JjhbfhVouLZGc1q74PrQC6uGfddKklIP059D_DtQwBqK-sn9rd4xEPhW9E6s=@protonmail.com>
 <d53738e1-4ba5-640e-7ef7-1705ab205061@redhat.com>
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
On Tuesday, October 30, 2018 7:10 PM, Hans de Goede <hdegoede@redhat.com> w=
rote:

> Hi,
>
> On 30-10-18 19:56, Mogens Jensen wrote:
>
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
> > On Tuesday, October 30, 2018 4:04 PM, Hans de Goede hdegoede@redhat.com=
 wrote:
> >
> > > Hi,
> > > On 30-10-18 16:46, Hans de Goede wrote:
> > >
> > > > Hi,
> > > > On 30-10-18 16:04, Pierre-Louis Bossart wrote:
> > > >
> > > > > In addition I am not aware of any baytrail device using plt_clk_0=
, so moving a common machine driver such a cht_bsw_max98090_ti to use plt_c=
lk0 only would break other devices (e.g. Rambi/Orco). Asking for both clock=
s to be on might work though,
> > > >
> > > > Ok, so we need to have a DMI based quirk for the Swanky and maybe a=
lso
> > > > the clapper to use plt_clk_0 there. Asking for 2 clks if we only ne=
ed
> > > > one does not seem like a good plan.
> > >
> > > Dean, Mogens,
> > > To write a proper patch for this I'm going to need DMI strings
> > > from your devices.
> > > Can you please run (as normal user):
> > > grep . /sys/class/dmi/id/* 2> /dev/null
> > > And reply with the output of this command?
> > > I have attached the output from a coreboot seabios based clapper.
>
> Thank you.
>
> > Should I still test 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk=
_0-ins.patch with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH and asoundrc from =
Dean? There seems to have been some development in the case since that requ=
est was made.
>
> Yes please test that, I expect that to also fix things for the
> Clapper, but I need to have that confirmed before submitting a
> patch upstream adding a quirk for the Clapper to use pmc_plt_clk_0
> instead of pmc_plt_clk_3.
>
> Regards,
>
> Hans
>
Unfortunately I only have access to longterm kernel 4.14 for building/runni=
ng on this system, and 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_=
0-ins.patch does not patch against 4.14.78. Can a test patch for 4.14 be cr=
eated?

Regards,

Mogens
