Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D94C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51452147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSUMi63y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbfA1Qy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:54:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53021 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733227AbfA1QRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:17:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so14626768wml.2;
        Mon, 28 Jan 2019 08:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m1WiVpso5x1xBVUxmLjH0VSxUW1HDcRaj1rhGSoI6JY=;
        b=aSUMi63yh2pX/jfsvS5/wXeZHl7Na+5pmQbmspgJ+TIEbezZpMNsJxQQboUuW7WQNe
         Itn1FjvVqV+u0Bn8YS6Ss/c42qsM75BoXHsg4+4eFGBhhjbKfQQcaz5FVMK+NVNRR9rd
         dVgOvrzgdKh/1AQutAS2/bqXVq/GmuDA4/F/VuCf2ZTIofzAmlGru2SqOHGlJbMT4e6l
         JNUHiB6SOhRB94vaHakDRMAHxZ1yBFPh1RmRw71h1vZvB5nbhtTeRXiGroxUEYo/jM2f
         if4eqMxyKiOJiuDM8nH3hgcviMuk1FLRsaTEbTBqN0E/iJYki6Y3qHYiMjQ+llOwLZOy
         sdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m1WiVpso5x1xBVUxmLjH0VSxUW1HDcRaj1rhGSoI6JY=;
        b=bpfSibc6MAfTSN41VvCDE7EgYi0SqPQUkSoSUwfMMjBRe5sLPYAnhOu6vyOqAoMcgF
         D+af78A5+qMgqfBhTUl5+K6XWT7QMxAl0v2FGMQssf4fW3860rrNImlcnT9R6XqilrxG
         JeoXWb2S9dAfbeC/TL9OB+6z2S10L5qNMwGIW3kjDwn7rHbqtjQT92Vus4Kxc8m1Sw++
         LdVhfYS/INeb8JvXpgjUA0s0yVeXV3QbCNH5YV0TefoUEoj1qRYGfEZT1nFIVLWWALCp
         gav1t+EMvJ0IYrjDt3pN5UEpK4AiTlaQ5yEmLFJj6oxCa1Z4ssVum7Qo5eZHSGjuLq0a
         i7qg==
X-Gm-Message-State: AJcUukcRiOz2V9tvJ9ocFIcTcOruFXHENKUczP4b/zjzBx7MyNaZI+l/
        taCUDHp/f0MGXowH2zaKRdg=
X-Google-Smtp-Source: ALg8bN4YOa0O7+ofIYVAMBz9v9LgWOVDM0yeL63AOhY/p6P8aMrjTRUdnCzoXoMUej1McfL+1LTyJg==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr18443201wmf.117.1548692268276;
        Mon, 28 Jan 2019 08:17:48 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id w18sm113601795wru.54.2019.01.28.08.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 08:17:47 -0800 (PST)
Date:   Mon, 28 Jan 2019 17:17:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Eugen.Hristev@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Nicolas.Ferre@microchip.com,
        Cristian.Birsan@microchip.com
Subject: Re: [PATCH v2 2/3] dt-bindings: drm/panel: simple: add support for
 PDA 91-00156-A0
Message-ID: <20190128161745.GH26200@ulmo>
References: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
 <1547458584-29548-3-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Content-Disposition: inline
In-Reply-To: <1547458584-29548-3-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 09:43:28AM +0000, Eugen.Hristev@microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
>=20
> PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
> This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
> AC320005-5).
> Adding Device Tree bindings for this panel.
>=20
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> [eugen.hristev@microchip.com]: specified backlight and supply bindings
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v2:
> - added binding explanations for required properties from simple-panel:
> backlight and power supply which are mandatory
>=20
>  .../devicetree/bindings/display/panel/pda,91-00156-a0.txt  | 14 ++++++++=
++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/pda,9=
1-00156-a0.txt

Applied to drm-misc-next, thanks.

Thierry

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPKykACgkQ3SOs138+
s6HlEQ//fZonuiZIonlMiwGhVPmzmd+XQNGGtRXIuqmjSUUoK++wYhFu8Ys0R/1+
eT0l6pdVmETBUIp+XIWWWhUqSUqBrG+DLQhDFtCxEFDWkV+qodcE0C4Ms+lz9GVf
RVE0v1efNCZXEsS5/YqoxTse91FXlm71MIpzmRf+NTh6zeSCM2hR0fdrRfLMvmCS
GiJn0MFqbvMPuZvG2sClOrAt7vrkoLsyAAY4DrYHvHksqPCQGnwizyeTo8flFOla
alT9hnrRbplwmIQ5yTFDhSQZQ1rsBlyuLVHwOOHabLCiwJYs/XoyVsAwEQ4617DP
W/mmHL6fTLkqWU8EcJ2mZVRPG10fqHkc//iKez6lta/uPy0ckKNEarS5x7Jd9SzC
UTLAGdBI4CMXQ1sfRY2CTj5IFZe+MiZ5ay66/jXbMob/fuloYBmDFtwECkKQZwzx
NG9iJo8plIISX2r+pKfLPAKGPKlIlzDUNFd9mZJNG+CnzMhwxudYJ9M2s4T+AZWu
7J80Xcka48F07VCiBHNfnRG/r8Z9r6zDpKVAPAcJMwo2Qi26nLaU35UTCosSLVrY
WYtS8YoEsnc7nMrJm6stpwEahNAE5vsXKeeMU22ziGkpRpgpnRA0049yhmU8V1jj
qItsaF2QrihE63oDhuJnOD+16Zje9ALV6ecum07EI8N0CPJ4YQM=
=rNwQ
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--
