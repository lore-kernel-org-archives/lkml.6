Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43133C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDCA2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu94uCA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDCA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLDU6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:58:13 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44032 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDU6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:58:12 -0500
Received: by mail-wr1-f46.google.com with SMTP id z5so17428829wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=I3l1+ACt6/GhNj+Jlr5UHf5ETVSIQkk4e+NrHiufLi0=;
        b=Eu94uCA1z8o+lW1wtgwzqUNvnTd51tmfYqt5UJaXYjpPCpLEUPdZ3E8DuSiduwIekC
         MjyOAaHbC+yF3DiSF7Qbr7O4gkxY8lgcJljh1gIVKYtGnbw9vu2Hw2Jle4d2564h3JgR
         N7xxbyRQgzr3HPvA05uVvNXGH8vgOBQiHQvOcoOB0uJMUpCozA5e+JD6YfWYgZQNO3Mw
         wtYLgpkCmx9xh6npdlmHNSiQm5mZkstcAuwkJKmeXfWJmqrC4BIJrgOfaZwyTxZPO1t8
         VLA3JsffD+NPmM0xDS516+EcQONq1JSTeTipAjlNIF54gTlcYi0GZD/lC6PFuOLkmvhS
         mM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=I3l1+ACt6/GhNj+Jlr5UHf5ETVSIQkk4e+NrHiufLi0=;
        b=jg7zrCHBBnU9hAhR9psei2Fw9J8JQfO0REfTdNbkzZh3ygd+VW5BhOOOvRkRUGg336
         YiAywDAXHBXZ61KPcfbMK1I5UrjPaXs+mspXV2Hzy0Qs7z2pknC4wnrEfI1NZ8xy8c5p
         h2MHqJDr0Azl+EOJsnJym8yR1kRFoC5ac9SNL7cLNU0HOeGELAm1bqaQfYM5kTKu4BER
         +Ux43kxhinKKOM+dblsB6pr8ucgKJ+2mujOGirywTEIB0LTuaNS2Is15QF8EoKqJkFYA
         wd2tMF0wrLIuE2zJ7UktZwHYW89ZWPmlA5QECi1Bvikzjb8NqztTHzUj7nUeYCxgOWHd
         gkpw==
X-Gm-Message-State: AA+aEWbaAAu7t4vtr6KzYDEIOe6E1pKVXl2ilkGo66j572p+zp4E2rCS
        /UHdKguKbveXnzIrd4g0P8s=
X-Google-Smtp-Source: AFSGD/V9lUGgw90402OVDkCZ7bYEyg6RroYj4WScXO7j9c34m0x95Ur8fMCMgaJ0Ftb8WiNVEhj3sA==
X-Received: by 2002:adf:e383:: with SMTP id e3mr19074567wrm.31.1543957090754;
        Tue, 04 Dec 2018 12:58:10 -0800 (PST)
Received: from peano (host93-127-dynamic.50-79-r.retail.telecomitalia.it. [79.50.127.93])
        by smtp.gmail.com with ESMTPSA id d5sm15651149wrx.22.2018.12.04.12.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 12:58:10 -0800 (PST)
Date:   Tue, 4 Dec 2018 21:58:07 +0100
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Bryan O Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bryan O Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: greybus: Fix parameters alignment and strings
 concatenation
Message-ID: <cover.1543956271.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

First patch align some parameters with parenthesis.
Second patch will add some spaces between string.

Cristian Sicilia (2):
  staging: greybus: Align function call parameters to parenthesis
  staging: greybus: Added space between string concatenated

 drivers/staging/greybus/loopback.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--=20
2.7.4


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJcBupeAAoJEAnJ2Lo5pAXyTN4P/iXVunhp8c/FwsYvblKGjOE8
ETAoU8ZYn+pvjimWIiLmKjGLXFV45kPv4th4koE9gOdwhpsvcpn2H/OhrsOeueNC
P48UpdjNmFC0jX+jJ8WtuLIbVwHbBZeyLnZ94Nl/p0wsBuYZEFQE3/W1uwKjtQbF
us0kslxuzsO1svuNIaRHYbKDgAnwdpjn+l7AsYQa1vpVNVd69HRl+hiK2x4x/wTt
MPY6Ri52f6TgG/2/qMx0Kgmm3cANzcTxlinjppxm+yeEPxN3XUSMjGOys+p8mq8W
zxAoeJc7g066Y0N4W/EGvA/tXCs8/TGCOjFIDu9VPwI8a2NDZZCy23U8j9vPMyup
UuX9Z3lHHVs9bmHQE7RC+HpQYvn3Bag+QD3SeKE6+m4lbbTNfvGH75PaWVyQ3/ZH
hZDeMAgvcv/wVyJK895lu5TV/r+xk72utVmBgf+hGEN/4+iOHo3iDoYsRQxFMclx
ZIUBn8TPE4g8JJbvtV8G+EsebvF/9W10NhDKrF+0bItCHMVmRkEpmIAbEmmiEecx
HX5ULxgNA5IzKQ5QDWwbo60g9/wb4oORBawuoD+kfeR3fNSR/4dRNmCbekkeAk87
RRwdCb/ZTjrJY5pB7EN1TZ/eMDUxB+sKFXTg49IgH7WFRb6Q5ZzrC1Pg+qMgj2ZX
5ouypAD/LWuhqrXINnhb
=/4oE
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
