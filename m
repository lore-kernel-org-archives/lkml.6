Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADF5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E294208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E294208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeKKVUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:20:20 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44307 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeKKVUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:20:20 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 06188806D3; Sun, 11 Nov 2018 12:31:55 +0100 (CET)
Date:   Sun, 11 Nov 2018 12:31:57 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Subject: Re: [PATCH 03/24] leds: dt-bindings: Add LED_FUNCTION definitions
Message-ID: <20181111113157.GK27666@amd>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dxRQSzdsN/lOP445"
Content-Disposition: inline
In-Reply-To: <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dxRQSzdsN/lOP445
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add common LED function definitions for use in Device Tree.
> The function names were extracted from existing dts files
> after eliminating oddities.

Thanks for doing this.

> diff --git a/include/dt-bindings/leds/functions.h b/include/dt-bindings/l=
eds/functions.h
> new file mode 100644
> index 0000000..3f94e09
> --- /dev/null
> +++ b/include/dt-bindings/leds/functions.h
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +

> +#define LED_FUNCTION_2G "2g"
> +#define LED_FUNCTION_ACTIVITY "activity"
> +#define LED_FUNCTION_ADSL "adsl"
> +#define LED_FUNCTION_ALARM "alarm"
> +#define LED_FUNCTION_ALIVE "alive"
> +#define LED_FUNCTION_ALL "all"
> +#define LED_FUNCTION_APP "app"
> +#define LED_FUNCTION_AUX "aux"
> +#define LED_FUNCTION_BACKUP "backup"
> +#define LED_FUNCTION_BACKLIGHT "backlight"
> +#define LED_FUNCTION_BACKLIGHT_CLUSTER "backlight_cluster"

Sounds like one of backlight and backlight_cluster should be deprecated?

> +#define LED_FUNCTION_BEEP "beep"
> +#define LED_FUNCTION_BLUETOOTH "bluetooth"
> +#define LED_FUNCTION_BOOT "boot"
> +#define LED_FUNCTION_BOTTOM "bottom"

I believe some of these should get comments. For example what does
"all" and "bottom" LEDs do?

> +#define LED_FUNCTION_BRICK_STATUS "brick-status"
> +#define LED_FUNCTION_CEL "cel"
> +#define LED_FUNCTION_CEL_PWR "cel-pwr"
> +#define LED_FUNCTION_CEL_RESET "cel-reset"
> +#define LED_FUNCTION_CHRG "chrg"
> +#define LED_FUNCTION_COM "com"
> +#define LED_FUNCTION_COPY "copy"
> +#define LED_FUNCTION_CPU "cpu"
> +#define LED_FUNCTION_DEBUG "debug"
> +#define LED_FUNCTION_DIA "dia"

What does this one do?

> +#define LED_FUNCTION_DISK "disk"

We have disk, hd, hdd and sata. Deprecate some?

> +#define LED_FUNCTION_DISPLAY_CLUSTER "display_cluster"
> +#define LED_FUNCTION_DOWN "down"
> +#define LED_FUNCTION_DSL "dsl"
> +#define LED_FUNCTION_ENOCEAN "enocean"
> +#define LED_FUNCTION_ENTER "enter"
> +#define LED_FUNCTION_ERROR "error"
> +#define LED_FUNCTION_ESATA "esata"
> +#define LED_FUNCTION_ETHERNET_STATUS "ethernet-status"
> +#define LED_FUNCTION_FAIL "fail"
> +#define LED_FUNCTION_FAULT "fault"
> +#define LED_FUNCTION_FLASH "flash"
> +#define LED_FUNCTION_FRONT "front"
> +#define LED_FUNCTION_FUNC "func"
> +#define LED_FUNCTION_GPIO "gpio"
> +#define LED_FUNCTION_GSM "gsm"

> +#define LED_FUNCTION_HD "hd"
> +#define LED_FUNCTION_HDD "hdd"
> +#define LED_FUNCTION_HDDERR "hdderr"

Ok, I'll=20

> +#define LED_FUNCTION_HEALTH "health"
> +#define LED_FUNCTION_HEARTBEAT "heartbeat"

Sounds same as alive, deprecate alive?

> +#define LED_FUNCTION_WIFI "wifi"
> +#define LED_FUNCTION_WIRELESS "wireless"
> +#define LED_FUNCTION_WLAN "wlan"

Same as wifi and wireless, I guess, deprecate some?

I'll touch same subject in another email.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dxRQSzdsN/lOP445
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvoEy0ACgkQMOfwapXb+vLcPgCfSdAPmPF1vQHCin0P6SxODnBf
+oYAmwf01SzTh3B3m8G5SedfY7FUHm9Q
=oMq+
-----END PGP SIGNATURE-----

--dxRQSzdsN/lOP445--
