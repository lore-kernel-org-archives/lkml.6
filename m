Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28D8C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C3B25834
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK/NPP6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C3B25834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966476AbeF0UBo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:01:44 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:45367 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964784AbeF0UBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:01:43 -0400
Received: by mail-qt0-f173.google.com with SMTP id i18-v6so2748673qtp.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=SEOXPnnqyu5hrhXbdBGAjQirdJ8WYC/v4ZkYrfTy4ZI=;
        b=SK/NPP6e2Rru87UoUrLTiCn4NPiYViNZSgyfNpc4Fcl5GQXrksvQ4OvDlKTvhYqTt6
         uGb7qbvY9Nqio3Z6wrPJIOO2pPqZKm8Kli6aU54wwFT4jBy5FkFmpq/aM1kZ5e6H+BZw
         eQldvSaySMBYJJ1oF86ATO7f9pjJ1VNVNHqdwQT2uSDT8poUJjhQgsl4KtpeYJ80vvBU
         bczCRvjXTaeH+9p+PzGAU4Xv281vQ+XQfBogLQ/Rt2kZv925TeqocTJhiqzL8HYDwBeN
         dQK7xYNk7kUa4krP65YDGv6nM8aXhN0z/EuxYzzYjkzTVjfB9Lt4QhZ4Yjc/uUGiAmd5
         KDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=SEOXPnnqyu5hrhXbdBGAjQirdJ8WYC/v4ZkYrfTy4ZI=;
        b=Mc6xMR+5bDR5BKdS5c4Z8MAnMoZ+Mxr/XsA85+T8EfxWr0qHo2UNoHyva/qpCm2lKh
         Uzr8MsTOI0LRXyiOWH7NH+4xF1GUwo8WPmCzIYYnn1mcWfeiqS22XgbPIIikOo4CmTOr
         qQHtPNcjPZfrHUoVKQ0yyLafT2S49zEKtwBekCFmEtiUVQoqnifLdaYEL+RyqPxvVBtK
         mx0CIhpPkQImp7nDOeeYCA63eMME7rjO6DCQcTaeihl8+JFiYL4JDm+kJbb9Y6u/N2W4
         ul1qWGO256lq4etAnEOG+viS/2fDEva4rGG15MSjswjBhDOp5byCWvrsSQ01YiMlzdFL
         7xjA==
X-Gm-Message-State: APt69E3Afq8cFPiWPbjGQEWcjZ7g+Vf2Ur86LEErbsoNKbL07x1YocCx
        oIwojUOtyuYUMhTkAdYMGKo=
X-Google-Smtp-Source: AAOMgpfd5CCVfXDjF+4HVv+6Ndav8v2+Cw+4aqi7wUsczPLdsnOc6N+eA2Oysu2ftGGwOa07umelfg==
X-Received: by 2002:ac8:19ab:: with SMTP id u40-v6mr6819432qtj.101.1530129702404;
        Wed, 27 Jun 2018 13:01:42 -0700 (PDT)
Received: from [192.168.1.11] ([138.117.48.222])
        by smtp.gmail.com with ESMTPSA id j5-v6sm3255563qte.57.2018.06.27.13.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 13:01:41 -0700 (PDT)
Subject: Re: [Qemu-devel] Linux kernel configurations for various Microblaze
 systems
To:     Guenter Roeck <linux@roeck-us.net>,
        Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
        "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        Alistair Francis <alistair@alistair23.me>,
        KONRAD Frederic <frederic.konrad@adacore.com>
References: <20180627185248.GA19743@roeck-us.net>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: id=FAABE75E12917221DCFD6BB2E3E32C2CDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <96809884-2f46-ed63-48fd-9fd4c5050e20@amsat.org>
Date:   Wed, 27 Jun 2018 17:01:34 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627185248.GA19743@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GKoJl1pe513oBNRhzBg9BGjgL9rk2IY2U"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GKoJl1pe513oBNRhzBg9BGjgL9rk2IY2U
Content-Type: multipart/mixed; boundary="HYyfoapThNT0nHt12rCm0Iv4WsAzgzk98";
 protected-headers="v1"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Guenter Roeck <linux@roeck-us.net>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: Michal Simek <monstr@monstr.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <96809884-2f46-ed63-48fd-9fd4c5050e20@amsat.org>
Subject: Re: [Qemu-devel] Linux kernel configurations for various Microblaze
 systems
References: <20180627185248.GA19743@roeck-us.net>
In-Reply-To: <20180627185248.GA19743@roeck-us.net>

--HYyfoapThNT0nHt12rCm0Iv4WsAzgzk98
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On 06/27/2018 03:52 PM, Guenter Roeck wrote:
> Hi,
>=20
> I would like to add Microblaze "petalogix-ml605" and "xlnx-zynqmp-pmu"
> to my list of qemu boot tests of upstream and stable release kernels.

Do you mind sharing your tests on this thread?

"Who is running QEMU automated tests, and when?"
http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg04695.html

> Unfortunately I have been unable to locate working kernel configuration=
s
> for the those systems, nor working qemu command lines. I found a few li=
nks,
> but they are all dead.

I got more lucky using the Xilinx downstream code from:
https://github.com/Xilinx

In particular using their downstream DeviceTree:

https://github.com/Xilinx/device-tree-xlnx

I also used those links:

http://www.wiki.xilinx.com/MicroBlaze
http://www.wiki.xilinx.com/Build%20kernel

Regards,

Phil.


--HYyfoapThNT0nHt12rCm0Iv4WsAzgzk98--

--GKoJl1pe513oBNRhzBg9BGjgL9rk2IY2U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsz7R4ACgkQ4+MsLN6t
wN4TvA//XsXWZlOt2Bkh1UMktwEyz0AxNojvVk4VCo8jJaPOiY6h1JmN2LbR9Bua
jYdFbtcxLtTVZJfG+hZbzz8hmUGJ20XrYRMjE9MEpJtae/0Jbeh1HQO5uBuSCRbH
5fcklq7MN2dw3bjdrsFxHxTLikJYWk0xWvo02tSyaK4IJKSlRc+NtGXoWywU19hh
eLK6ohpbgAM9hQjBGbaezf7fDi27vp3gucXYI3hoyiu3GCyq5CysLt+vPSTkW4JN
AwcTOe/sdj1ZSXWGC0Cd8RYpuEqAyxVB+ZDK7D7tA5ge21ROTfT2RK3Z8BEGMdXV
9SLxJeYxmiPYbICFF8AWF5Uac8IMKKyaOb15wh/RwwY8kZ2uy6iK8pW2wk0c+RX5
g7HFXyVyfb/CRLaEo4oD+al434WoBMt/JMzEFmK5vhak47QcD/E+UGoqD++eq69z
9/MTINg5ICxFQXFt3ZYdBhOSKLcflmAKAyOfF22ivT8ssS/UV+4bKNI+AnV5cpfY
avEsWJIm6z2mmyJbUAtzBw4gLjxVGJBSWqVfErt9AWlvmG7neh/iM9ulOKssF40o
CjA+Abn2lAbpvUajh9lzy5O2Fr4AdNFB+Lej5wxC94HexCA16NOTzFtpQ0uo4xxM
Ht+DcucvYiOmcbyzOlsbUOn0Zdf8/gbC7JsSyeA2gsxHgHDX42E=
=8/xw
-----END PGP SIGNATURE-----

--GKoJl1pe513oBNRhzBg9BGjgL9rk2IY2U--
