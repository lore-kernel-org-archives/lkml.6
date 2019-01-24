Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7440EC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A8E218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Hg5FfwzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfAXUq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:46:57 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:52230 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfAXUq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548362813; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6S8WqaR8jL4inlJRV8cYTRGRLMje5ISJrfQpJ6yoSXM=;
        b=Hg5FfwzGKF9kVKeamT12Dmllt4zC044UtiXjaNcdDL4QL0QwbK9xI3cUIZvQ8jf6ubG/GB
        6sCS8goRmMVntSdDE8JKhrP1C/2vex0wJdYYhWimiEJEH0ZRFi4Drd6t2w1j+bn7WT8mTt
        T6gL+ejH9KPq3VEnNDhJd+fA2lXu6F8=
Date:   Thu, 24 Jan 2019 17:46:28 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx
 OST
To:     Stephen Boyd <sboyd@kernel.org>
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
Message-Id: <1548362788.3881.0@crapouillou.net>
In-Reply-To: <154835808767.136743.14531363127962557756@swboyd.mtv.corp.google.com>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <20181212220922.18759-6-paul@crapouillou.net>
        <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
        <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net>
        <1548264353.3173.1@crapouillou.net> <20190123180155.GB9781@roeck-us.net>
        <154835808767.136743.14531363127962557756@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le jeu. 24 janv. 2019 =E0 16:28, Stephen Boyd <sboyd@kernel.org> a=20
=E9crit :
> Quoting Guenter Roeck (2019-01-23 10:01:55)
>>  On Wed, Jan 23, 2019 at 02:25:53PM -0300, Paul Cercueil wrote:
>>  > Hi,
>>  >
>>  > Le mer. 23 janv. 2019 =C3  11:31, Guenter Roeck=20
>> <linux@roeck-us.net> a =C3=A9crit :
>>  > >On 1/23/19 4:58 AM, Mathieu Malaterre wrote:
>>  > >>On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil=20
>> <paul@crapouillou.net>
>>  > >>wrote:
>>  > >>>
>>  > >>>From: Maarten ter Huurne <maarten@treewalker.org>
>>  > >>>
>>  > >>>OST is the OS Timer, a 64-bit timer/counter with buffered=20
>> reading.
>>  > >>>
>>  > >>>SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770=20
>> and
>>  > >>>JZ4780 have a 64-bit OST.
>>  > >>>
>>  > >>>This driver will register both a clocksource and a sched_clock=20
>> to the
>>  > >>>system.
>>  > >>>
>>  > >>>Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
>>  > >>>Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > >>>---
>>  > >>>
>>  > >>>Notes:
>>  > >>>      v5: New patch
>>  > >>>
>>  > >>>      v6: - Get rid of SoC IDs; pass pointer to=20
>> ingenic_ost_soc_info
>>  > >>>as
>>  > >>>            devicetree match data instead.
>>  > >>>          - Use device_get_match_data() instead of the of_*=20
>> variant
>>  > >>>          - Handle error of dev_get_regmap() properly
>>  > >>>
>>  > >>>      v7: Fix section mismatch by using
>>  > >>>builtin_platform_driver_probe()
>>  > >>>
>>  > >>>      v8: builtin_platform_driver_probe() does not work=20
>> anymore in
>>  > >>>          4.20-rc6? The probe function won't be called. Work=20
>> around
>>  > >>>this
>>  > >>>          for now by using late_initcall.
>>  > >>>
>>  > >
>>  > >Did anyone notice this ? Either something is wrong with the=20
>> driver, or
>>  > >with the kernel core. Hacking around it seems like the worst=20
>> possible
>>  > >"solution".
>>  >
>>  > I can confirm it still happens on 5.0-rc3.
>>  >
>>  > Just to explain what I'm doing:
>>  >
>>  > My ingenic-timer driver probes with builtin_platform_driver_probe=20
>> (this
>>  > works),
>>  > and then calls of_platform_populate to probe its children. This=20
>> driver,
>>  > ingenic-ost, is one of them, and will fail to probe with
>>  > builtin_platform_driver_probe.
>>  >
>>=20
>>  The big question is _why_ it fails to probe.
>>=20
>=20
> Are you sharing the device tree node between a 'normal' platform=20
> device
> driver and something more low level DT that marks the device's backing
> DT node as OF_POPULATED early on? That's my only guess why it's not
> working.

I do, but I clear the OF_POPULATED flag so that it is then probed as a
normal platform device, and it's not on this driver's node but its=20
parent.
=

