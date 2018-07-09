Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07390C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EDB208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1WEv09Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EDB208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933703AbeGIR12 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:27:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43154 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933425AbeGIR1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:27:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so11817985wrv.10;
        Mon, 09 Jul 2018 10:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hXjNvM4xi5fyMgmDaQPlXMMrE7sO+kgWrhkdZyARxrY=;
        b=d1WEv09Z7qr0PnnaP+TqEOT7L61VZA5Som3b2+NgF0tFeCTQzMzvG2e5svuH1QpalV
         X7oJQPsMjloZHMRUJsnPIPCDpF4ddRS1Gp+c5atLyKr4OlGTYxR6eYtWZ8ez4gocZv6m
         oXgh+J0s9XihURkUI3u4PzsQh3MhVH4fD/hx2o2uSK5VaTiHBIz0S6sXZC8eBwJdh6BI
         zl3jLqmzu29eX/wqHV+yyLn8FnVVdMwJnyPMmslr0vrFMBqLWISc5kodktPrckVJ6BQ6
         9ewAu1rh/A1dwbqCRU2Yr6qulGQwCMR+ksXF5hExyfP5SxSyoEs6K6ZQQi2omxrjNsin
         BYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hXjNvM4xi5fyMgmDaQPlXMMrE7sO+kgWrhkdZyARxrY=;
        b=OSpXycXOP32EAhPl0yG5bCVeqwoegIa67QCkLHoNsctmUcebrrXQktNTTPR0B7Ix3R
         TLqulEn40BaWr7oyniYTr9v+SYtpOzBBiDF+UqWznKsoTMRIak+Y/ZMzaxly8hbPuSUM
         h+oSwoHyqc7OCE9WLSKbeGxM3z2O6eWdPXyw0GyTQe+KnaiOMbfU4xhQEHseyPDr7jr7
         sZnSQZMsTjeit9DGBsgtKY/3kOpdW4pWwuIkV+ma470VVWbgGBFEOhgFkVJhn7l/Hv1c
         biwjHGlNCXqJ89r9Y+cIZS/RrSQtwRwNgHXui9nV7Si0jWhSJejT5dLoGoSuiUoQa9ji
         bmRg==
X-Gm-Message-State: APt69E2QfTCJKItr61h88oew92hFn2QK4+Zn9aMvMlXTxkoFlKN3Edqg
        GQ6mSvA8aEaYiEOKV7k3quvrWQ==
X-Google-Smtp-Source: AAOMgpe0+TEeEl4ppecxGi136HPtj6mjtvRFlbecWVs9x38cFBbRYtdlfReTjWDUQUIJssrL/t/B2g==
X-Received: by 2002:adf:adc9:: with SMTP id w67-v6mr14780553wrc.135.1531157244547;
        Mon, 09 Jul 2018 10:27:24 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id t184-v6sm11201154wmf.18.2018.07.09.10.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 10:27:23 -0700 (PDT)
Date:   Mon, 9 Jul 2018 19:27:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     jan.tuerk@emtrion.com
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: Document the EDT et* displays
 in one file.
Message-ID: <20180709172722.GH26651@ulmo>
References: <20180427132445.3458-2-jan.tuerk@emtrion.com>
 <20180619095546.24445-1-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e5bfZ/T2xnjpUIbw"
Content-Disposition: inline
In-Reply-To: <20180619095546.24445-1-jan.tuerk@emtrion.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 11:55:43AM +0200, jan.tuerk@emtrion.com wrote:
> From: Jan Tuerk <jan.tuerk@emtrion.com>
>=20
> Document the Emerging Display Technology Corp. (EDT) using the
> simple-panel binding in one single file.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> ---
>  .../bindings/display/panel/edt,et-series.txt  | 39 +++++++++++++++++++
>  .../display/panel/edt,et057090dhu.txt         |  7 ----
>  .../display/panel/edt,et070080dh6.txt         | 10 -----
>  .../display/panel/edt,etm0700g0dh6.txt        | 10 -----
>  4 files changed, 39 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/edt,e=
t-series.txt
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,e=
t057090dhu.txt
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,e=
t070080dh6.txt
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,e=
tm0700g0dh6.txt
>=20
> [Changes from v4 of emCON patch-series]=20
>  - rebased to mainline/master
>  - split as requested by Shawn Guo
>=20
> As requested by Sha

All three patches applied, thanks.

Thierry

--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDmvgACgkQ3SOs138+
s6GotBAArv++juALZcgUolPimsi98L6/1vFrIO3DWnUFL+TPr8eRUdjFJkxMjN0A
8APTSjoBja5w2baNx7ehDYkVYwJ7S8zod7FtouU1kU0QfRWqCIm0raCiJyIiF/ni
ks/rRyUxMUFXuBbMPEZVegonVMxcQu6Id5xjXTpM800C5PemcgadEfmV3QZZKYqt
ioosmqhzMjaKBJW0HilGqw+to3HiDm2AlcR8zLaZzkwAvHYI+LYsJ4aTqZc5U6ve
Ug07oNVjCVDCntwSsryeB6UG63bmDaCFTn4XSU6Qqs9wSpcyx74msWtnvju3SMqb
zjVoKk79VpUFFo1uFxffUZbH3dhyT8QKs+niQYIaDwUvziwBmH9u3mhzTUCDArnj
gigHtoK62zWCj6m7ytN43jHPClQuv6kXG3n7rqR1G1S9bquUF1k2tBHYHaaJ9NAK
3i1u0PPTxMUZ56xxOrr3J7BQ7pWYMuyaB3wJr2Fejhfd0U9AlwzHi8a9rRq+ymHz
l6JpPPJHtefCe6jW/oUDeUZDs1ovVH5W+Tvhu3c3qhHpbqzXZDysh25FtKDgwRL+
NXDj9bAA4eH7T1zYrc67woS9hgWQX9le13W4/ixguoXiXymWdsYjb+kVjs5cMqaJ
LKWE7eBz3xUsSoTEJqukq1qa29mEIx769wgKnRqhH72tuoRmd/Y=
=ZAa+
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--
