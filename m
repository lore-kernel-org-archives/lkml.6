Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E5BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A36C20877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvwOC/xW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A36C20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933443AbeGJJ5I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:57:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35632 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933169AbeGJJ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:57:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id v3-v6so20058746wmh.0;
        Tue, 10 Jul 2018 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oCTNGAnZRMbH2y2oelMei1wU6ZaDHB6uJjKMtXaMGcQ=;
        b=XvwOC/xWadQSR1Mn51uHoVMYgVY9w2C/hLBmlOtY5qRF17P8aTe4beJwL4bGfEIm+j
         iCFrEQmEW4m+I3RCYEMzyO88ce4UevVyaK2Tt3ft44yNwxSJ750tI98KmhQY47lyoukW
         w8VbdIZRr7uxhVx0uYH/q1kMXJ7ztbIF8F0J/eQi6evgpvlGzj9pQTw1Qe/3wkt+DXiI
         U2E6TGrLKBQcB+HuyF5n/jYYcNOd40oRBzBL88ERIipyrLGLQajSV3kIYKVv/8gejpZ7
         zIpUFovCWbCyttwpv+/4KQI96HsUC6F0bZAaO+Dlbtt4NTYltjkU3IUVKhsiD+C47Qtc
         OT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oCTNGAnZRMbH2y2oelMei1wU6ZaDHB6uJjKMtXaMGcQ=;
        b=QuMGdtTIxtKWUT5YAl5CRrLJ1b60T47x5BJlPRD7GvI/d3Fu9PEHOVB3OfeEj1gW+O
         xfesMnAlKhx242/jA+uIaw9kS0CWOVTcuWR6kWgkD9IMrOakpsA2VEq2iOZLelXDC4by
         /RVA7pvVf/gK2aS24ULL0gelV7R9dhybI7UJS49sXxIBXvyfQg12RBrOirPnmDTOvqbT
         JJcW/QzjfVJeudwuMGPORdifztGY95Jg2DVHtA0ux7uJi7Ci2Y66pszxXbDOWWMP48wD
         k3Mq0YGdEz6OaJudUJwu3ynIKH62jS9vuVqj0ioZS9+FAT87iJmjW9jVXi39ELcJ9+OM
         n0pQ==
X-Gm-Message-State: APt69E1+r/bjnrflfrcN4tQa5pnO0Ia/9ZiV8zequCZhu0yaEToOG0yL
        Y0lDmDFPXmcmxEdwmmxYeOI=
X-Google-Smtp-Source: AAOMgpeY3BfE7qIxDORP4DQA4WGw9HBVJIgqYk8PI8tLc39e4LZABoTD2xVlsPTXYosKf/vJTapXuA==
X-Received: by 2002:a1c:64d5:: with SMTP id y204-v6mr13989486wmb.14.1531216618602;
        Tue, 10 Jul 2018 02:56:58 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id g125-v6sm18012713wmf.16.2018.07.10.02.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 02:56:57 -0700 (PDT)
Date:   Tue, 10 Jul 2018 11:56:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Maciej Purski <m.purski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 4/9] dt-bindings: display: add DT bindings for BOE
 HV070WSA-100 panel
Message-ID: <20180710095656.GC1504@ulmo>
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
 <CGME20180619082000eucas1p1c5cc2b526583c3fd5e9fc13656ed4858@eucas1p1.samsung.com>
 <1529396370-18761-5-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <1529396370-18761-5-git-send-email-m.purski@samsung.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 10:19:25AM +0200, Maciej Purski wrote:
> From: Andrzej Hajda <a.hajda@samsung.com>
>=20
> The patch adds bindings to BOE HV070-WSA WSVGA panel.
> Bindings are compatible with simple panel bindings.
>=20
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  .../bindings/display/panel/boe,hv070wsa-100.txt    | 28 ++++++++++++++++=
++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,h=
v070wsa-100.txt

Applied with the fix as requested by Rob.

Thierry

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEguYACgkQ3SOs138+
s6HZrhAAwDrVJHDJbCjP2R/KXrA7cniY8jw6fAygWwoUlGECBeaWQu0VobHQ16ac
0qSlmbqOLtJFFSvctj6mROz91fD0wL6TvDp1rIfz3LTOChI9JzRxJ6LBFnsXixZi
t8g4FFZpBPwh1giklLHF1kUSoZJ/IYIm1mNYEPHUdYaTWVsF7GVpCmu6xCq1ob8a
Ov2nO2B6BpNPAuMgfj3bJk8PjeUsnodTuid8LINc4ImC1SQXa8P/UZ3kypYs+cQo
Pm31zMOGWK+vJDJ0pgSyXWLDyJWmUheozmqR7l+MipfosJ6n0sqWQrF4/kM0xMDr
xfG17jdDMVUGLxn9sk4L4JSrQgvALe5AUFWsjHjxfcg8aaztvZr5tv7MJ5fQCMNK
c9FuX1gNh3Bub8l55QnUxOjQLQac9A1FNHd5FaNHFkxRqn4or++e6+Z8DvYu/7xb
OrJI/PG8l3CEoWt99Seq9VRz+pu6USWAf4TMGvO81qeEoeKOEa22VoS2Ydod6f3W
A805C7y9kUpCjeuqsxOcgSoSntV+sSzealNMGK0Oqc932iIpi4SqXTla/XU8w24Z
HafIlMzviFvi8MMssCEuJGFLIr8u4QjnVCDWZVkDT+NpT7Y/E/VmhQWbAZiroufC
9g0Q5bVb06s1GQeuB6uoJu/U5xq+/gTSOyVrbXFmsNwhTSi2y9w=
=FB6J
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
