Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AA6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD8B218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360595;
	bh=hTZEIgZM3Vbm7ipL4EHsz4IoNpixU2ZlAwInwzs2xdo=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=OJbidxp+Ar1PhjA5EiRyTt9SFpVdLcjuV8e6kTkPcwcanbRgMqpbL4eXOyH9t9GOU
	 TepJKAWwI66/4pLA3Rc+pIojvtKLKOoONVBLHFUF0C6HXklYxejzM147S5OA1DoP46
	 fCMTmNbLF5zzmxIiY243lp8mAc+zcyMyqQyOMhxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfAXUJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:09:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730894AbfAXT2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:28:09 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84FC5218A6;
        Thu, 24 Jan 2019 19:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358088;
        bh=hTZEIgZM3Vbm7ipL4EHsz4IoNpixU2ZlAwInwzs2xdo=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=nDFlj2pA2bJRLQdwghcy5zR+GJdEhClSuBj9z41SVgM86e9gIAAYfcdnQanT6hJBf
         kn7CYyAQLFI5EkUqzSOtFZg9bMcqVewuGcdNd+JwnY/a7suPN+VDoQx3gBQnNdeVIP
         1N2PahVo4KpH2yZWkALmPN2BAcBlCoYnA/mhkAA4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx OST
References: <20181212220922.18759-1-paul@crapouillou.net> <20181212220922.18759-6-paul@crapouillou.net> <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com> <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net> <1548264353.3173.1@crapouillou.net> <20190123180155.GB9781@roeck-us.net>
User-Agent: alot/0.8
Cc:     Mathieu Malaterre <malat@debian.org>,
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
In-Reply-To: <20190123180155.GB9781@roeck-us.net>
Message-ID: <154835808767.136743.14531363127962557756@swboyd.mtv.corp.google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Paul Cercueil <paul@crapouillou.net>
Date:   Thu, 24 Jan 2019 11:28:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guenter Roeck (2019-01-23 10:01:55)
> On Wed, Jan 23, 2019 at 02:25:53PM -0300, Paul Cercueil wrote:
> > Hi,
> >=20
> > Le mer. 23 janv. 2019 =C3=83=C2=A0 11:31, Guenter Roeck <linux@roeck-us=
.net> a =C3=83=C2=A9crit :
> > >On 1/23/19 4:58 AM, Mathieu Malaterre wrote:
> > >>On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil <paul@crapouillou.net>
> > >>wrote:
> > >>>
> > >>>From: Maarten ter Huurne <maarten@treewalker.org>
> > >>>
> > >>>OST is the OS Timer, a 64-bit timer/counter with buffered reading.
> > >>>
> > >>>SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
> > >>>JZ4780 have a 64-bit OST.
> > >>>
> > >>>This driver will register both a clocksource and a sched_clock to the
> > >>>system.
> > >>>
> > >>>Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> > >>>Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >>>---
> > >>>
> > >>>Notes:
> > >>>      v5: New patch
> > >>>
> > >>>      v6: - Get rid of SoC IDs; pass pointer to ingenic_ost_soc_info
> > >>>as
> > >>>            devicetree match data instead.
> > >>>          - Use device_get_match_data() instead of the of_* variant
> > >>>          - Handle error of dev_get_regmap() properly
> > >>>
> > >>>      v7: Fix section mismatch by using
> > >>>builtin_platform_driver_probe()
> > >>>
> > >>>      v8: builtin_platform_driver_probe() does not work anymore in
> > >>>          4.20-rc6? The probe function won't be called. Work around
> > >>>this
> > >>>          for now by using late_initcall.
> > >>>
> > >
> > >Did anyone notice this ? Either something is wrong with the driver, or
> > >with the kernel core. Hacking around it seems like the worst possible
> > >"solution".
> >=20
> > I can confirm it still happens on 5.0-rc3.
> >=20
> > Just to explain what I'm doing:
> >=20
> > My ingenic-timer driver probes with builtin_platform_driver_probe (this
> > works),
> > and then calls of_platform_populate to probe its children. This driver,
> > ingenic-ost, is one of them, and will fail to probe with
> > builtin_platform_driver_probe.
> >=20
>=20
> The big question is _why_ it fails to probe.
>=20

Are you sharing the device tree node between a 'normal' platform device
driver and something more low level DT that marks the device's backing
DT node as OF_POPULATED early on? That's my only guess why it's not
working.

