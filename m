Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A8AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA3020C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551117940;
	bh=k+vmLvK+0++f+kWKz3J36/Su8BnPxbv98PYo9fdA//U=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=T0Dqp6PiCaeaHK5jxd+G1ue4njHewwnehlPb2ktkbH0X7w5ara9ZM84TPM35NofJB
	 A318UdEX4XpXaCyV9ACRYsrESqxDQFSR+C70Se0KYub+fjxBIIE8DhafZ5Yka8a6Pp
	 X3+wUvpAT1EL+AA/Qm2YULSDq2durZIb8Vpf6WH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfBYSFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfBYSFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:05:38 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 700752084D;
        Mon, 25 Feb 2019 18:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551117937;
        bh=k+vmLvK+0++f+kWKz3J36/Su8BnPxbv98PYo9fdA//U=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=XEU0juzihUj+xbQI6HAb0psTj7MEGhhpLFsIm4PQqlNqgEvA5FB/66LXvcRarxYpV
         MQ8WFsw4g+qFVHPtKinjMWP8lN0l1sT3X5ryuLike/di4PQb1qRfh8J6unwnigB5FK
         xmHQtoikSDkwRAulbsRTv3lyCxnuZULWCgHQHQP4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1550891845.20534.1@crapouillou.net>
User-Agent: alot/0.8
References: <20181212220922.18759-1-paul@crapouillou.net> <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com> <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net> <1548264353.3173.1@crapouillou.net> <20190123180155.GB9781@roeck-us.net> <154835808767.136743.14531363127962557756@swboyd.mtv.corp.google.com> <1548362788.3881.0@crapouillou.net> <154836998080.136743.17683029101430122926@swboyd.mtv.corp.google.com> <1548370388.3881.2@crapouillou.net> <1550891845.20534.1@crapouillou.net>
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
To:     Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx OST
Message-ID: <155111793658.191923.2540746255375959460@swboyd.mtv.corp.google.com>
Date:   Mon, 25 Feb 2019 10:05:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-02-22 19:17:25)
> Hi,
>=20
> Anything new on this? It still happens on 5.0-rc7.
> It probes with late_initcall, and not with device_initcall.
> I have no clue what's going on.
>=20

I'm not sure what's going on either. You'll probably have to debug when
the device is created and when it is probed by enabling the debug
printing in the driver core or by adding in extra debug prints to narrow
down the problem. For example, add a '#define DEBUG 1' at the top of
drivers/base/dd.c and see if that helps give some info on what's going
on with the drivers and devices.

