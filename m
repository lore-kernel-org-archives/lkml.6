Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23580C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A62214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSA1HXLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A62214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeIZVKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:10:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33849 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeIZVKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:10:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id t15so19453123wrx.1;
        Wed, 26 Sep 2018 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rJgWHZOEgZ+3yjH7Ok2uihEHIRVQuA21uePike8hE5Y=;
        b=KSA1HXLM9cLvTQCSQmBU7NxVbAsHCgE5rQ44DpOKgpwaA2A3n5hqgo0If2ba1mIjrX
         DCDT8M4se/qwhKoQMSTUP8Oh5LJmKTStwptdkpQfXHFTGrS5VK8rH4CQ/FlIDxCZhSdU
         dI7vhSpuV1noqMlbWVBqgpAbWGiPIvGpzif/UvbgYhzcDgdewc2JtCnmAWypYMJX9/5K
         wxRpMkeQ6Te/wYU6Quj33zZEQJROYkUP3c5gR0da6pL+9VQ3lMMhYAQQgzQRb/T6J9ps
         2qnmvF87zMqs9OO+xLCfHVoYn6O+PHnRJLGfL3SvuT2+Oug6N0XQaFnYYN/g0Nrh+ojv
         ge9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rJgWHZOEgZ+3yjH7Ok2uihEHIRVQuA21uePike8hE5Y=;
        b=McLqL5qqpxWX6hLGSpNOdSJBc1G7sBWdwoO2iWS84Kqe6QQkoAoatvv4PH0z42+Eh8
         pBc7EE5lk64wcUqO41Uzxc1gnEeyLJDKwJsLbMs0N4tQnIJHjmjyBnK+kljzQPyYGjN5
         KNFWohb+cz/eb1WykxtVJEBLfj5QXGY6IOG/KbCR5IO7/F1ZW+Z/CII8PFO/N0Dnl0yY
         glUWJHFvgT+9/4nkva7Glvt8CwKHnoWe5rBCpkQiXAeoCDZyw3+EpyVXNfZFCKaI5tDm
         uYwLrRvRJYcnfrpmNIvMcxDQ/xEiGLSuRGMlCaojmUOPpLu/9Wa4NLaT1LMnYyexU1by
         4Jlg==
X-Gm-Message-State: ABuFfoiVotATcFVCV1JzIirjhPCOvOl3y4s0lEyAnIBHk8onWUiu0Kjt
        rF3VY4WcBiuq+8VFO5KexpUUSchl
X-Google-Smtp-Source: ACcGV63tzsa5d6P1uFiUdkixlhVO4YXedu/33wz+Z/hzHei/rCjgkdUKTLmXpLvJYgiEwyzKSwsK7g==
X-Received: by 2002:adf:9285:: with SMTP id 5-v6mr2779154wrn.69.1537973808347;
        Wed, 26 Sep 2018 07:56:48 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id z14-v6sm4946852wma.18.2018.09.26.07.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 07:56:47 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:56:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 00/37] ARM: dts: tegra: colibri_t20: major revamp
 incl. eval board support
Message-ID: <20180926145646.GG12980@ulmo>
References: <20180902100906.25792-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Content-Disposition: inline
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 02, 2018 at 12:08:29PM +0200, Marcel Ziswiler wrote:
> This series is a major overhaul and adds support for the Colibri
> Evaluation Board device tree.
>=20
> Changes in v2:
> - Fix commit message which was mixed up between "[PATCH 03/31] ARM:
>   tegra: colibri_t20: iris: annotate i2c busses" and "[PATCH 04/31] ARM:
>   tegra: colibri_t20: iris: add missing aliases".
> - Also replace underscores in node names with dashes.
> - Also reflect this change in the Iris device tree.
> - Also reflect this change in the device tree bindings documentation.
> - New patch as suggested by Rob.
> - New patch.
> - Get rid of fake clocks simple bus as suggested by Rob.
> - Updated evaluation board device tree with all applicable previous
>   fixes.
> - Also reflect this addition in the device tree bindings documentation.
>=20
> Marcel Ziswiler (37):
>   ARM: tegra: colibri_t20: move aliases from module to carrier board
>   ARM: tegra: colibri_t20: iris: integrate i2c real time clock support
>   ARM: tegra: colibri_t20: iris: add missing aliases
>   ARM: tegra: colibri_t20: iris: annotate i2c busses
>   ARM: tegra: colibri_t20: add local-mac-address property
>   ARM: tegra: colibri_t20: reorder host1x/hdmi properties
>   ARM: tegra: colibri_t20: iris: use no-1-8-v
>   ARM: tegra: colibri_t20: regulator clean-up
>   ARM: tegra: colibri_t20: add missing regulators
>   ARM: tegra: colibri_t20: annotate usb ehci instances
>   ARM: tegra: colibri_t20: remove phy-reset-gpio from controller node
>   ARM: tegra: colibri_t20: indentation/line-feed/white-space clean-up
>   ARM: tegra: colibri_t20: update sound nvidia,model
>   ARM: tegra: colibri_t20: pinmux clean-up
>   ARM: tegra: colibri_t20: add missing pinmux
>   ARM: tegra: colibri_t20: iris: display controller rgb panel support
>   ARM: tegra: colibri_t20: iris: annotate uarts
>   ARM: tegra: colibri_t20: iris: add uart-c
>   ARM: tegra: colibri_t20: use high speed uart driver
>   ARM: tegra: colibri_t20: iris: add gpio wakeup key
>   ARM: tegra: colibri_t20: iris: add dr_mode property
>   ARM: tegra: colibri_t20: annotate/rename lm95245 temperature sensor
>   ARM: tegra: colibri_t20: add i2c-thermtrip
>   ARM: tegra: colibri_t20: add gpio hog to unreset usb ethernet chip
>   ARM: tegra: colibri_t20: add gpio hogs for gmi_wr_n buffers
>   ARM: tegra: colibri_t20: annotate/move sd card detect
>   ARM: tegra: colibri_t20: add compatibility comment
>   ARM: tegra: colibri_t20: simplify model and compatible properties
>   ARM: tegra: colibri_t20: iris: simplify model and compatible
>     properties
>   ARM: tegra: colibri_t20: iris: add colibri ssp support
>   ARM: tegra: colibri_t20: drop module level model and compatible
>   ARM: tegra: colibri_t20: rename i2c_ddc to hdmi_ddc
>   ARM: tegra: colibri_t20: iris: drop unused i2c_ddc label
>   ARM: tegra: colibri_t20: rename tps6586x@34 and drop unused pmic label
>   ARM: tegra: colibri_t20: get rid of fake clocks simple bus
>   ARM: tegra: colibri_t20: rename ac97 label to tegra_ac97
>   ARM: tegra: colibri_t20: add eval board device tree
>=20
>  Documentation/devicetree/bindings/arm/tegra.txt |   5 +-
>  arch/arm/boot/dts/Makefile                      |   1 +
>  arch/arm/boot/dts/tegra20-colibri-eval-v3.dts   | 262 ++++++++++
>  arch/arm/boot/dts/tegra20-colibri-iris.dts      | 200 ++++++--
>  arch/arm/boot/dts/tegra20-colibri.dtsi          | 655 ++++++++++++++++--=
------
>  5 files changed, 866 insertions(+), 257 deletions(-)
>  create mode 100644 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts

Applied, thanks. All of these series together have got to be some kind
of a record.

Thierry

--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlurni4ACgkQ3SOs138+
s6ET2RAAsam+ERwqoS+mt3Uq24gI1WE8T1QZTaHFCsKhRcaRxR9g1CEAySYuJjAO
KYGoZhOk9DWZAX/dmcUHQFUyiVOXN+ump0rLiVVhxTLZ8bMCXZQBtAbvxuAk6JFF
qVaC55+h1OC5fMhEyU2TZm960GXOij+iMaZiCfIXMCferM/Kaz+rvxf7KJ3DPsf1
TgAbc80xFabjOtOnG29nwwxRj53tEwVPVfnYku77zu8h+0NOblucp6AcyyaaEdVm
s3P1XiLwqFTBlzD7z2r+P7HN+khzpUICgcwx/JNYiyevMhHTks78XukAiFhZ80m5
Cz9jQwBVR2m/csHswxSPBBG8dp85tdM5BcvLj23nja7fxwOtJvdvA+4FP/hC5Uf9
gRvVuJQ6ppzjvVri9/ZvUy0md33qTKwil6XqNROjz7u2zK0T8RNN1SK0mAAXgsoR
wOyNU9ZyCOSNUD2zeHay8DNmpxqa7DkzrquJyWxpD1GcLiVVDemijlNEFz9f308H
fgmnfaHKqpt0H39Oju3Jxm6O6/DLK+QIQM27iOeC+lOajBsATXrNX4dM55hUaNNN
LSAdAWiH45EAR3lIIZU59ziLMmxKXbegYF5dF8qRCDlbUVMoHay1/Ki6qSxhYr6r
8jQdvhR8GbJyXWtCKH3RdfUcTHbGKGab5oBqPkuWDHTLUHVIkLY=
=ftqN
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--
