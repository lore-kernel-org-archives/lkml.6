Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AE6C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995C02177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zibri.org header.i=@zibri.org header.b="LKos+R9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfBHMGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:06:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42155 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfBHMGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:06:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so3278239wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zibri.org; s=google;
        h=message-id:subject:from:to:date:mime-version;
        bh=tcyamRdkgm7FefziTMpfCQq9CAWG2biREtnfnH8MDfU=;
        b=LKos+R9J7a8AB+g5RH0ygdRXO7Is13KEuoFOCOYM30wpLRgsqb6CRT1Vvyrr3CfbqA
         lhyiTddB2XyHhSog4WDIlqJCs1g2QXJcjvqQQi7WTVv6GZQeCoeMvXRwl2uQinQsbz+a
         s98JPFD5k2DLfFKOT3ck9dzJw5ktKTMNEoKaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version;
        bh=tcyamRdkgm7FefziTMpfCQq9CAWG2biREtnfnH8MDfU=;
        b=H5G8RC8H70H9jdMhs+bNIJBCtR3N15YJ6UHjH3kIYA5wuiMAu2tpSUJIgHXtwLMmqX
         pRy4+L2MNHarD6cSgWgzAZkB/UBP020riNJElNzgtMNK6tFKxQHge7yl+hT3Qjv8l6oW
         SJ3K/pQKizqaG80oRoUedGOqPVkT5auoidudx7oXLYpgNiYwMs+ydQJ2NGK4RPRfZSVk
         o7YRJVf3EnIUnmE4klqk9L1Wlp2pUVr85x+ywD2xDmmO6oI8HCTO3etvMqmTdeaZxdQU
         ZtMb4QucgbZqaL63N7ZCj8HiY9TmQb6LymJj4+MxKappsAWdqYqcf5dr8eROLj5Wutqv
         3jKQ==
X-Gm-Message-State: AHQUAuZZqui5vYluUrMDHjLBqG+nIcfLmQ8AnmtSyp8dWelNOw53s8rT
        gFrzXIMOQKk5xpy077HAKqPwgz2cJk0=
X-Google-Smtp-Source: AHgI3Iaon00nHCgbo9nrUcYyKfueHJ6TXev8UyYVU9ziU9+v8qgneVXjho/HyMftcGgenIX1ipHaqQ==
X-Received: by 2002:adf:84e4:: with SMTP id 91mr16213935wrg.237.1549627593842;
        Fri, 08 Feb 2019 04:06:33 -0800 (PST)
Received: from zibrixnb ([156.184.112.7])
        by smtp.googlemail.com with ESMTPSA id k3sm1637706wrm.7.2019.02.08.04.06.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 04:06:33 -0800 (PST)
Message-ID: <1549627591.455.7.camel@zibri.org>
Subject: Unremovable kernel module with one line of code.
From:   Zibri <zibri@zibri.org>
To:     linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 14:06:31 +0200
X-Priority: 1
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BT/f2VrxBTr8y/gJQ1za"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BT/f2VrxBTr8y/gJQ1za
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

All is needed in a kernel module to make it unremovable without a
reboot is a single line of code. This should not be possible IMHO.

#include <linux/module.h>	/* Needed by all modules */
#include <linux/kernel.h>	/* Needed for KERN_INFO */

int init_module(void)
{
	printk(KERN_INFO "Hello world.\n");
	THIS_MODULE->name[0]=3D0x41; //or any other character than "h"
	return 0;
}

void cleanup_module(void)
{
	printk(KERN_INFO "Goodbye world.\n");
}

After the modue "hello.ko" is loaded, changing the first letter of the
module name to anything different than the original first letter of the
module names causes it to be unremovable by using rmmod or modprobe -r.
The only way I found so far is (obviously) a reboot.

Solution:
when installing a module, the kernel should assign it an unchangeable
ID. Afterwards, it should always be possible to remove it using that id
and not the name.

--=-BT/f2VrxBTr8y/gJQ1za
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJcXXDHAAoJEDBjm9gw5ym9lOkH/2VYeHstWWty9Pv7QFgEP/Dd
NqdzjkwFa7nDBIgkWvu/pmEXfLl9MKtVoJUjcZoOW5Hu/XPWgXlftB/hO3i9dwMQ
+NKPZuvDq8L9/kG571EyYms9v22sCXfbmfw3M9j9B7y7M1MTSS7bp2PXOmsgEps5
SvxqYY04n+y/NWZrZyvbU0SnivXhhI2n7nTIMioTLIRJ4vLQKQp6ESrGMRUbMfbM
TYn4FpnMSwUNL40AChsU5kW/hDY/NRhgd2MKN6GWzKyIxxLIyrKb0fKejd7Tf2Wn
9E+eEIUakUrV13wWprrCKP1pt6bzNhIis7LFZjgi1+nCDrEijdYk29pvKgnaqoY=
=F26J
-----END PGP SIGNATURE-----

--=-BT/f2VrxBTr8y/gJQ1za--

