Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAD7C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFEB20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="JwtPo8l/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFEB20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeJaDuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:50:50 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:57574 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeJaDut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:50:49 -0400
Date:   Tue, 30 Oct 2018 18:56:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1540925765;
        bh=4u+c6mhmAw0/UTd6udXLO9yic4Z8AJ3oip3NXi+3dro=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=JwtPo8l/G2Ldz92FqOiY38VL80I0yq5i8gQ4eVaOl57r9k5QWIgJCJvRH2l2eDSgT
         58/mll2wWIzoDj0pWohor2HbxtNW2M/2Iy3krAAilhCoXnImMvU5+G/utAap/7P57Y
         /iONwkF1Mp1faBnSqVc+WsPdcvNpeKQuzCCA0BTM=
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
Message-ID: <BaxBOBmUCld7THAnRIDXUpKq8uQ2oJ49EaNlq0mZ11gFjA5JjhbfhVouLZGc1q74PrQC6uGfddKklIP059D_DtQwBqK-sn9rd4xEPhW9E6s=@protonmail.com>
In-Reply-To: <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
References: <20181025232517.ywnw54qibemosjws@picard>
 <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
Feedback-ID: 4dFv7M8pOtP7CMTtfNdOwXARWpF2vcQYB4dRuX1h9mb-6008qkzO2MVweOzrAYHEdkjJ6P5PUdgJEubk4l9Lhg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="b1_200e3efcb88cb1b28db041a66b2c6fc3"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--b1_200e3efcb88cb1b28db041a66b2c6fc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, October 30, 2018 4:04 PM, Hans de Goede <hdegoede@redhat.com> w=
rote:

> Hi,
>
> On 30-10-18 16:46, Hans de Goede wrote:
>
> > Hi,
> > On 30-10-18 16:04, Pierre-Louis Bossart wrote:
> >
> > > In addition I am not aware of any baytrail device using plt_clk_0, so=
 moving a common machine driver such a cht_bsw_max98090_ti to use plt_clk0 =
only would break other devices (e.g. Rambi/Orco). Asking for both clocks to=
 be on might work though,
> >
> > Ok, so we need to have a DMI based quirk for the Swanky and maybe also
> > the clapper to use plt_clk_0 there. Asking for 2 clks if we only need
> > one does not seem like a good plan.
>
> Dean, Mogens,
>
> To write a proper patch for this I'm going to need DMI strings
> from your devices.
>
> Can you please run (as normal user):
>
> grep . /sys/class/dmi/id/* 2> /dev/null
>
> And reply with the output of this command?
I have attached the output from a coreboot seabios based clapper.

Should I still test 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-i=
ns.patch with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH and asoundrc from Dean=
? There seems to have been some development in the case since that request =
was made.


--b1_200e3efcb88cb1b28db041a66b2c6fc3
Content-Type: text/plain; name="mogens-clapper-dmi.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=mogens-clapper-dmi.txt

L3N5cy9jbGFzcy9kbWkvaWQvYmlvc19kYXRlOjA4LzIyLzIwMTQKL3N5cy9jbGFzcy9kbWkvaWQv
Ymlvc192ZW5kb3I6Y29yZWJvb3QKL3N5cy9jbGFzcy9kbWkvaWQvY2hhc3Npc190eXBlOjMKL3N5
cy9jbGFzcy9kbWkvaWQvY2hhc3Npc192ZW5kb3I6R09PR0xFCi9zeXMvY2xhc3MvZG1pL2lkL21v
ZGFsaWFzOmRtaTpidm5jb3JlYm9vdDpidnI6YmQwOC8yMi8yMDE0OnN2bkdPT0dMRTpwbkNsYXBw
ZXI6cHZyMS4wOmN2bkdPT0dMRTpjdDM6Y3ZyOgovc3lzL2NsYXNzL2RtaS9pZC9wcm9kdWN0X25h
bWU6Q2xhcHBlcgovc3lzL2NsYXNzL2RtaS9pZC9wcm9kdWN0X3ZlcnNpb246MS4wCi9zeXMvY2xh
c3MvZG1pL2lkL3N5c192ZW5kb3I6R09PR0xFCi9zeXMvY2xhc3MvZG1pL2lkL3VldmVudDpNT0RB
TElBUz1kbWk6YnZuY29yZWJvb3Q6YnZyOmJkMDgvMjIvMjAxNDpzdm5HT09HTEU6cG5DbGFwcGVy
OnB2cjEuMDpjdm5HT09HTEU6Y3QzOmN2cjoK


--b1_200e3efcb88cb1b28db041a66b2c6fc3--

