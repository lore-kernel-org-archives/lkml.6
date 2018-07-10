Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E465C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4615C20883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U458PQd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4615C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933357AbeGJK6F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:58:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39576 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933278AbeGJK6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:58:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id h20-v6so7929621wmb.4;
        Tue, 10 Jul 2018 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C38k1zgpFMcYdcKIfmDku1gv8X32C6W02gEYQ0yANkk=;
        b=U458PQd9gxt4kLsORL3FkRf4EjgAkGBWifgrkteR+n/rTDb3qCvL4bGKb8JXAQTcc/
         v3FD3dpAOz4qGEQhKXaKjnBbCfYw4dfuoKNxVI5vdmAI93ss1zlHz0Go9CJGuHXCbIkL
         FZH9lyw4Y22xJ0eawE25WUaA0f6ODgrO5aHCJEcpkHkyXO3RhY4e+mIBl0V9WedqNvrH
         Ce2vJgWtns+uiXME7fEj02kpT8qLk0NSmuJq3CslKTfnbPw0a3R5U4xVui1MbVBWRgTy
         TEu5KcoGATQAPXL57qPS0pK5TL1uF1FtnrHCaQF4X4teXW2X+X7XtceZDiMp7SfQuI2z
         MWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C38k1zgpFMcYdcKIfmDku1gv8X32C6W02gEYQ0yANkk=;
        b=HvVaKvDwzwZ90bQ0ipuOZCNUCkTNSdFbCIdkFqv54GJtOb+TA9I6vRSs2hQKEDliIY
         ZEzerzahIqWZOSIMOUHVtVfMlJS5Qcl/rG7kuDHcnhACE7fZHN050hZtJfFpHY8xs5hP
         +OiGK0g3iGqp7jUq0ew/kBJBX46Mw5shPRfnG3YnPZYGVi/yWm8TdiyR29OFuzZz5Mpj
         EEgw+GseetbfcR7W1dlPaKaeBe5/O+8k+4aH4H/d2WBKbD7hL2pLDA+RZsotifMACISC
         uKAVBs2z3GtPUpYQTjuXZ33lnG7Le0xQm8eGobuWRJ4UPtSYBCtRd86LJ0midh4XApct
         /eqw==
X-Gm-Message-State: APt69E1eWmzaKXODeGSNClaoBxaCvQV+tVonx1zHrvZfytspdK9fd3eL
        06rw0ovbDEJMziz/51hiD4g=
X-Google-Smtp-Source: AAOMgpcxnNtud112FZo9sWzZT200eLdsZ10ih56dDN7SdA8rj7vnUyXe+woB1bxeTAS2Wr5pqg+Sqw==
X-Received: by 2002:a1c:369c:: with SMTP id y28-v6mr13674348wmh.34.1531220281341;
        Tue, 10 Jul 2018 03:58:01 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id y129-v6sm18488967wmy.4.2018.07.10.03.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 03:58:00 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:57:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        briannorris@chromium.org, hl@rock-chips.com,
        emil.l.velikov@gmail.com
Subject: Re: [PATCH v5 2/4] drm/panel: p079zca: add variable unprepare_delay
 properties
Message-ID: <20180710105759.GL1504@ulmo>
References: <20180702102721.3546-1-heiko@sntech.de>
 <20180702102721.3546-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DXIF1lRUlMsbZ3S1"
Content-Disposition: inline
In-Reply-To: <20180702102721.3546-3-heiko@sntech.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DXIF1lRUlMsbZ3S1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 12:27:19PM +0200, Heiko Stuebner wrote:
> From: Lin Huang <hl@rock-chips.com>
>=20
> When panel power down, p079zca need delay between reset and disable
> power supply, but p097pfg does not need it. Similarly p097zca needs
> a delay after entering panel sleep mode. So add two delay properties,
> so we can meet these two panel power down sequence.
>=20
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> [add sleep-mode delay]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--DXIF1lRUlMsbZ3S1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEkTcACgkQ3SOs138+
s6Eg/xAAj/r7Tcwuc3e/igSbvFj7YIgf7PSj1De7zroUTis3G1Gehl42mDM3dIMe
XzCqtj8JDznaq7+ydeX2Lp5b/aQ+K1RjphVK3RVS0KtUky+KrYdT0V+P6r+jCu3k
k0fI0Oronq2VkIn9xW5Up94/NQKKDpo+s15Dw/OzrVYxA4butVzIrv5wtGGQv8A+
ozqPbot3ji0oXhPm/YR7pick1eP4MYh3fmSnkZjgaWz5C1yr+ijZgZPp0bIPorkh
Kq0x8m89UJ6TmC6VqZ7FH/1nuxuUK2vnl9n/Zex2jZvzYDGjslomf7NGBn4bE0sR
e1lrffACsXPe9RFwzcxDY0eRFaHrCD1fSaQk1q3IBL6gAvnAbs3Vsr3fuSliYhIQ
p+A1qL4ABJbOzou3M3pYw4nU4rYK1jIlFIsalHgRtVPAgIRJt+KDehmjcQq1fztY
vRQDI+9QZ5oNWQgZYWaPsqsPVCdbLQYJs/fATtgcZPgBwWJx2UcH+dUGr5Jk+uj+
XHxasA5LFVavbRIf1GPo2rk7MZ4Mdrh5514ZGPGon0/tKw9M4ldTigFThdaK5Xxq
nmrEAv1d+zwzgvRmw9MGFgModHch/0tK8WNy9lH8hJG38AMvyPBTrkV8J/bnItiw
eYX6H/px+HpMgVSMoHKl5Lp8tgtdoXI+qPMihPOIJaJ7k3RMTc4=
=TuJv
-----END PGP SIGNATURE-----

--DXIF1lRUlMsbZ3S1--
