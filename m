Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E73C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AB321205
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmhMzS3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AB321205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934561AbeGFS6I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:58:08 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32871 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934201AbeGFS6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:58:05 -0400
Received: by mail-lf0-f68.google.com with SMTP id u14-v6so10575978lfu.0;
        Fri, 06 Jul 2018 11:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/dNaNow9t9A0wc5MQPkGUqrxck+YG2ay7kRSU34033Y=;
        b=ZmhMzS3TxUeYY7sNYGXphdXAEhOZgbkjY1dnDVFd61JFK0f4td2RhgZSOvsEfM4FP+
         dOf3VTlffCIan6JFzEMxV+epFCH7UqErb2S02LaesPmWYmtUBRso/zhgUHkwErXYBPjb
         UeyGi0h+Q+Yt9fxbx2gWpymyB8y3PkLQEsmW4k/Ekkh5UFq/QVwXIdeXDBO6KAGZz+Wc
         ErFtE/l2Jlne2zQ4SUA18DnimMk9T44WIzRgp25r7z2zUCwjAHNa7fdxOsr423SzgAMb
         IHdSTPU9WlG1YZmqnYYT39gLu07HPocn1+w0Wm/bTGJk/LQz+DTPbD4OsNlqHkGORP24
         7CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/dNaNow9t9A0wc5MQPkGUqrxck+YG2ay7kRSU34033Y=;
        b=VhyOWm/lPiTRclnAD/IWtsq/PHFTIfdjsAltW9KfSMgiu0ief0bZQG8BFHEJkptJPS
         ly0Ofh4usfNbK/K9sCwNUdoqraqEpmVhr1BjLPgJM6Y55IpL3gZ8H2HQ/xJGNfufHrEB
         IusyUHhT2ZA3GEQCerAuVSUfypbCnf4VBg9V6+GQlBaGhIxO/XyRw5q22GyD9cwKMBgz
         jXNhC1h3Bj6FYBEQ/6dtp6A/EjKynw/lWbsDg64SygeahO/KKccTBOw8FXIpCut5U7WM
         vLaRQyoPK3RNjDFQDmGDwkRUrjXTxdVRCv1xkS+SE761MnuSWE99cQJ4eNiB2Oiz5uxm
         kcBw==
X-Gm-Message-State: APt69E021uhtPGXxkBeVMckFZ3nxp11xZFmiVcMlfZ1RJawqxDKeqt8t
        6KDgPm4rFo9w09onmRI9dlo=
X-Google-Smtp-Source: AAOMgpciWgSUm32wMgf/fuK2q/iYstUknA0CbbbkfmokqCxIhP7IkbAsgxLGg+tfjnNqN9DnxUmA6w==
X-Received: by 2002:a19:2207:: with SMTP id i7-v6mr7839860lfi.69.1530903483552;
        Fri, 06 Jul 2018 11:58:03 -0700 (PDT)
Received: from z50.localnet ([31.0.83.69])
        by smtp.gmail.com with ESMTPSA id w4-v6sm1378276ljj.58.2018.07.06.11.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 11:58:02 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Phil Reid <preid@electromag.com.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Peter Rosin <peda@axentia.se>, patches@opensource.cirrus.com,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] gpiolib: Defer on non-DT find_chip_by_name() failure
Date:   Fri, 06 Jul 2018 20:58:34 +0200
Message-ID: <1956873.bHDVU2PRcn@z50>
In-Reply-To: <4ecc2072-3ec3-6e9b-576f-fd05559e7634@opensource.cirrus.com>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com> <1579112.qQSMXVQn9s@z50> <4ecc2072-3ec3-6e9b-576f-fd05559e7634@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> On Wed, 04 Jul 2018, Janusz Krzysztofik wrote:
> >>> On Tuesday, July 3, 2018 7:31:41 PM CEST Boris Brezillon wrote:
> >>>> On Tue,  3 Jul 2018 19:26:35 +0200 Janusz Krzysztofik wrote:
> >>>>>   		chip =3D find_chip_by_name(p->chip_label);
> >>>>>   		if (!chip) {
> >>>>> -			dev_err(dev, "cannot find GPIO chip %s\n",
> >>>>> -				p->chip_label);
> >>>>> -			return ERR_PTR(-ENODEV);
> >>>>> +			/*
> >>>>> +			 * As the lookup table indicates a chip with
> >>>>> +			 * p->chip_label should exist, assume it may
> >>>>> +			 * still appear latar and let the interested
> >>>>> +			 * consumer be probed again or let the Deferred
> >>>>> +			 * Probe infrastructure handle the error.
> >>>>> +			 */
> >>>>> +			dev_warn(dev, "cannot find GPIO chip %s, deferring\n",
> >>>>> +				 p->chip_label);
> >>>>> +			return ERR_PTR(-EPROBE_DEFER);
> >>>>>   		}
> >>>>=20
> >>>> Looks good otherwise. Let's hope we're not breaking implementations
> >>>> testing for -ENODEV...
> >>>=20
> >>> I've reviewed them all and found two which I think may be affected:
> >>> - drivers/mfd/arizona-core.c,
> >>> - drivers/i2c/busses/i2c-imx.c.

On Thursday, July 5, 2018 7:23:46 AM CEST Uwe Kleine-K=F6nig wrote:
> TL;DR: Either I don't understand the implication for
> drivers/i2c/busses/i2c-imx.c or everything is fine.
> ...
> So if a patch changes devm_gpiod_get() to return -EPROBE_DEFER in more
> cases that doesn't seem to hurt. Moreover TTBOMK this driver should only
> be used by dt-machines today such that changing gpio* for non-DT users
> shouldn't affect it.

On Friday, July 6, 2018 11:03:53 AM CEST Richard Fitzgerald wrote:
> The intention is that if the DT node is missing, the Arizona driver can r=
un
> using only soft reset, though there are limitations in that mode.
> This should return -ENOENT so that the Arizona driver will continue witho=
ut
> a GPIO.
>=20
> If the DT defines a GPIO it is effectively saying that this GPIO is requi=
red
> so it is valid for the Arizona driver never to come up if the GPIO it is
> defined to depend on doesn't come up.

Uwe, Richard, thanks for clarifications.

I think we can assume the change is safe for all current implementations.

Thanks,
Janusz



