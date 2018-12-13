Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5293C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964D020880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VI3Yup4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964D020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbeLMODY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:03:24 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:34004 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbeLMODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:03:24 -0500
Date:   Thu, 13 Dec 2018 15:03:15 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me
Message-Id: <1544709795.18952.1@crapouillou.net>
In-Reply-To: <20181213092409.ml4wpnzow2nnszkd@pengutronix.de>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <20181212220922.18759-16-paul@crapouillou.net>
        <20181213092409.ml4wpnzow2nnszkd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544709800; bh=frmtz49k6LA14hTn2E0zYZw2txe+WryAadRkNe7b+oU=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=VI3Yup4AKeBMFaGvEAJZCyvc/aSWXerVaXml+CznEDTeyPODJZ0a0B+IRGz2o1KeX/OodV3dPUtCdIpVwc5HlYIuSiqZvEcL/976hytp2WLxwT2sGDSKIARKgUZ4a4R/IyXMK48U6wGEMl5W8BYX6kXtWK5mAmtXb+4D3zWAZIo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu. 13 d=E9c. 2018 =E0 10:24, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello,
>=20
> On Wed, Dec 12, 2018 at 11:09:10PM +0100, Paul Cercueil wrote:
>>  The PWM in the JZ4725B works the same as in the JZ4740, except that=20
>> it
>>  only has 6 channels available instead of 8.
>=20
> this driver is probed only from device tree? If yes, it might be
> sensible to specify the number of PWMs there and get it from there.
> There doesn't seem to be a generic binding for that, but there are
> several drivers that could benefit from it. (This is a bigger project
> though and shouldn't stop your patch. Still more as it already got
> Thierry's ack.)

I think there needs to be a proper guideline, as there doesn't seem to=20
be
a consensus about this. I learned from emails with Rob and Linus=20
(Walleij)
that I should not have in devicetree what I can deduce from the=20
compatible
string.

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |
=

