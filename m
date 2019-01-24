Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F480C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C57218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548369986;
	bh=SH37JvbWip4YXcy8FElM3pjTVuI6JEUaAhoqBcNMiIw=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=fxCOvDU32SyJttYpBHZskb8NZFetyct2FO/N2RavP02LswcAvxq6MHbpb1qkprs+W
	 XH8ILD4uSKUcQ2/RxV4cZQdz4bHZH0hh4z2P7nLUqJEo3n+GzUInPhamp1xmUYppJI
	 n/X+XEGUGR1mIoUuxZqwXQX7GtE3AmOC8z+ECbbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfAXWqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:46:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfAXWqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 17:46:23 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F87218D2;
        Thu, 24 Jan 2019 22:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548369981;
        bh=SH37JvbWip4YXcy8FElM3pjTVuI6JEUaAhoqBcNMiIw=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=G4htXPFFwrUBFkXVjYniNCZX7fYPzqG58P1gQmpRwTua/9+eYNxq0eh+S8+xwo5Lz
         AD6gxqJew9Aq9ZL5pXqlDvO/xAjBTGYuIyemKgkxNDBsmB+4kHx2RBh09KWhLxGNbK
         IcP8xRKtxrMQRH2J4MupN1yNS1YQRhNQgiAIT4SU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx OST
References: <20181212220922.18759-1-paul@crapouillou.net> <20181212220922.18759-6-paul@crapouillou.net> <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com> <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net> <1548264353.3173.1@crapouillou.net> <20190123180155.GB9781@roeck-us.net> <154835808767.136743.14531363127962557756@swboyd.mtv.corp.google.com> <1548362788.3881.0@crapouillou.net>
User-Agent: alot/0.8
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Mathieu Malaterre <malat@debian.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me,
        Maarten ter Huurne <maarten@treewalker.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548362788.3881.0@crapouillou.net>
Message-ID: <154836998080.136743.17683029101430122926@swboyd.mtv.corp.google.com>
To:     Paul Cercueil <paul@crapouillou.net>
Date:   Thu, 24 Jan 2019 14:46:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-01-24 12:46:28)
>=20
>=20
> Le jeu. 24 janv. 2019 =C3=A0 16:28, Stephen Boyd <sboyd@kernel.org> a=20
> =C3=A9crit :
> > Quoting Guenter Roeck (2019-01-23 10:01:55)
> >>  On Wed, Jan 23, 2019 at 02:25:53PM -0300, Paul Cercueil wrote:
> >>  > Hi,
> >>  >
> >>  > Le mer. 23 janv. 2019 =C3=83  11:31, Guenter Roeck=20
> >> <linux@roeck-us.net> a =C3=83=C2=A9crit :
> >>  > >On 1/23/19 4:58 AM, Mathieu Malaterre wrote:
> >>  > >>On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil=20
> >> <paul@crapouillou.net>
> >>  > >>wrote:
> >>  > >>>
> >>  > >>>From: Maarten ter Huurne <maarten@treewalker.org>
> >>  > >>>
> >>  > >>>OST is the OS Timer, a 64-bit timer/counter with buffered=20
> >> reading.
> >>  > >>>
> >>  > >>>SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770=20
> >> and
> >>  > >>>JZ4780 have a 64-bit OST.
> >>  > >>>
> >>  > >>>This driver will register both a clocksource and a sched_clock=20
> >> to the
> >>  > >>>system.
> >>  > >>>
> >>  > >>>Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> >>  > >>>Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  > >>>---
> >>  > >>>
> >>  > >>>Notes:
> >>  > >>>      v5: New patch
> >>  > >>>
> >>  > >>>      v6: - Get rid of SoC IDs; pass pointer to=20
> >> ingenic_ost_soc_info
> >>  > >>>as
> >>  > >>>            devicetree match data instead.
> >>  > >>>          - Use device_get_match_data() instead of the of_*=20
> >> variant
> >>  > >>>          - Handle error of dev_get_regmap() properly
> >>  > >>>
> >>  > >>>      v7: Fix section mismatch by using
> >>  > >>>builtin_platform_driver_probe()
> >>  > >>>
> >>  > >>>      v8: builtin_platform_driver_probe() does not work=20
> >> anymore in
> >>  > >>>          4.20-rc6? The probe function won't be called. Work=20
> >> around
> >>  > >>>this
> >>  > >>>          for now by using late_initcall.
> >>  > >>>
> >>  > >
> >>  > >Did anyone notice this ? Either something is wrong with the=20
> >> driver, or
> >>  > >with the kernel core. Hacking around it seems like the worst=20
> >> possible
> >>  > >"solution".
> >>  >
> >>  > I can confirm it still happens on 5.0-rc3.
> >>  >
> >>  > Just to explain what I'm doing:
> >>  >
> >>  > My ingenic-timer driver probes with builtin_platform_driver_probe=20
> >> (this
> >>  > works),
> >>  > and then calls of_platform_populate to probe its children. This=20
> >> driver,
> >>  > ingenic-ost, is one of them, and will fail to probe with
> >>  > builtin_platform_driver_probe.
> >>  >
> >>=20
> >>  The big question is _why_ it fails to probe.
> >>=20
> >=20
> > Are you sharing the device tree node between a 'normal' platform=20
> > device
> > driver and something more low level DT that marks the device's backing
> > DT node as OF_POPULATED early on? That's my only guess why it's not
> > working.
>=20
> I do, but I clear the OF_POPULATED flag so that it is then probed as a
> normal platform device, and it's not on this driver's node but its=20
> parent.
>=20

Where do you clear the OF_POPULATED flag?

