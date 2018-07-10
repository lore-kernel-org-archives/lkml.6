Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A618C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4DB20877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdJOvZoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4DB20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933457AbeGJJ5a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:57:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39135 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933169AbeGJJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:57:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so13910575wre.6;
        Tue, 10 Jul 2018 02:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2HdE4dQpArm/zOb/BW2HCt1i4q/coEoJ6mHvYSTXQ7k=;
        b=QdJOvZoZ01Rw0xw+R8uDZWqAHsAsaxRP1Xk4ILnPOH0T7sbeFNBl29RD2LTAA9bJv2
         uB5IaK2kLj0dJ61yKeIoF25rNCws0p++oDRiKAVzY59wDsoU+TyQ5YJ1Eml5MzrmySWy
         3fgYum0g1KOpau25h5iMRme/pwlurJzrxuFpt8utKSuMf/vCLanzCNKxDOJ/LiR3qC2v
         PiuZ4MbUX/QJw6AtLrhCMQX28lEsmSqMccrEm/ccN0WejeOG7MKfrmeAjFnGZsWSehXA
         i4cMGo9Q16vwxQdS4cHG8NG0OH2AzCanxGaf7ZvE7D90Y6gPBxDwMzbiMGP8umM9yJyK
         L/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2HdE4dQpArm/zOb/BW2HCt1i4q/coEoJ6mHvYSTXQ7k=;
        b=D/2G7JijGJLX0JbhGXeUiL6ubFKQLTwwv9l5reCK8nBIeby74uKqpB+8stUBfz6o4A
         cfl45wr0jlCMUQ3TuCaDKn/TnmXJOUUMatdHED687XzPFCiscSE/I8SdesnskkgYhJ5Y
         Vzi5AyGfXd0HPjuIUEZMRE47UCAW35oof/lb3YjjdYxQsy3rEC6JqH5hL1lXhHjGyGEO
         LplAKIwvLQaGZhz9z+xirjk9peq+S6EWYPQUBi1O0T9RVl/iYgRwdqmthUFDiGw7UFoA
         G+DT8H96svA6f1AwusY3FdNLzfmpH4Ksrl8BCCH5lQsUIeGZi7SCETDZWRMxU8evy6Pm
         7eeA==
X-Gm-Message-State: APt69E2zQJt7j+HjukevJe2kxGJigUUBBwTaEi0FocH4Q1IiKrH+nMg4
        cyDmlK/xuU426sIOwphPwmc=
X-Google-Smtp-Source: AAOMgpdj+8pN5om3Olbv7+wceFuajPfAhm8+AwfNgzcENV26VjGs9ot1t5KTPyEmrAib4zlaiBnA9Q==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr17707711wrc.93.1531216645639;
        Tue, 10 Jul 2018 02:57:25 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id b15-v6sm16738704wrs.96.2018.07.10.02.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 02:57:24 -0700 (PDT)
Date:   Tue, 10 Jul 2018 11:57:23 +0200
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
Subject: Re: [PATCH v3 5/9] drm/panel: add support for BOE HV070WSA-100 panel
 to simple-panel
Message-ID: <20180710095723.GD1504@ulmo>
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
 <CGME20180619082000eucas1p1ed44d7aea857b12ce2c92c240be4dedd@eucas1p1.samsung.com>
 <1529396370-18761-6-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <1529396370-18761-6-git-send-email-m.purski@samsung.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 10:19:26AM +0200, Maciej Purski wrote:
> From: Andrzej Hajda <a.hajda@samsung.com>
>=20
> The patch adds support for BOE HV070WSA-100 WSVGA 7.01 inch panel
> in panel-simple driver. The panel is used in Exynos5250-arndale boards.
>=20
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Applied, thanks.

Thierry

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEgwMACgkQ3SOs138+
s6FJ+A//R3kB2aIQR/0l2UYT1W9bP/NUjtwBs1aAT9jkyxzVI3XtGJOxEWWBue8w
HH3lEbE1ybBOCQZPuuJ/RDou/NNJDFB/9ES1IkTse1CEC2bzvfgl7yl/hb/NOpZc
UrL88wC048OxM5B/3MHlDt4KFFELOc9SQyiqTdTqDd+rLjdlrSELsWAkGrFfnUa5
PMA5CTG27yMyYBIkZjw3M/C9VTfvXoLx2dtMmiwlGPuOlNHpZBSLK/1Dn6MRInAL
OaNjYCuuPSbeCSEEOpeIZ6tCMdgA459vqVTowyxPYPKB+TC4HM5Y/efdoGKbcVFl
lUwOk53X/1FHMsRq9AFYlTgoUzJJDgpJ7vN/tb8J4cy1NBw93Fs1ifof+N/tlx/E
OhrhxsdiRLDU6/RLCrLAUcJXIlcscYEfZVXO1NfHewNN9o0kXRKQf8KMRUIyTqxd
40V3TqLtkuScq/0sSZ/XsZsGAHRFtTemg015IfQPVabMgANKnVduOV+kEjQLAZos
vFo8BiFoJ87euUco0My9WSgoP5S4Lr4P0fXxeL7VeO4uSgRh6s6sXk7RCAixDPeq
hxoOQdrI55bZZ2ZvNpE9Avrn8Zaqj/izG46ahQ2/C0G0ai7w7vo1kb0HZqyUhYAs
zO2nVxl5fVuySfQKkClAVSleorVfF4N5ZgN5Hp/PzSVHx4+4qAY=
=uHWE
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
