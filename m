Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1075BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF29820881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjK2kyYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF29820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeGJKk7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:40:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36576 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933169AbeGJKk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:40:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so23810774wmc.1;
        Tue, 10 Jul 2018 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+CCwBdi+FGVDBw56PLizRgHicxUvUaQxqPXaXTDvkUQ=;
        b=LjK2kyYkk55IV1GInsJb5x9ZcHNfevLRSGvo7EKTCv03yoDkUDtatgC1n+y2Eelt10
         O9/XPgWyVzK2D7LRZShyMlDAjjila7TceuF7ruLG2wJOeCKS4GLL1t+cqyAHgjOh25BB
         C93/gflSYNyGZ0PpjketIGzQJZ0ty6XAfblCWsljoGASOem8d4N0gW+QoNItTHNhR71/
         n+Rg0fI/F1w467Y4ucxkRv5a91CMY+RC3k9fppe9NTvt1UTz5I5/iH2WXex1N8Wk07jM
         jsdD35eVgqT+uicddz0MX2gFTTv8PGbxM1wkuhEvvbJ/Xjan4iDy6wUP3IkmQpz6Q1/1
         HMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+CCwBdi+FGVDBw56PLizRgHicxUvUaQxqPXaXTDvkUQ=;
        b=H71xhXaA8v9zVikqQjnKvQTSqWvG8KKrhmkHvY8GOjXjSgKR4QHjPL3J4OHD4Urkol
         olMUYpAiGzgp/e2MFQ2K2avpuQMgvyw3fnlg5TUWRRqwLsv+RfdLM58K4mThc+vUOy1+
         XAcBR+STc7AC8MPS9fmlrydMcQ95Lf4yDoMEHPF6P0Gs2qzB9t7erG1EJihu+uO/eFAu
         PanUeEg08+xaG3EA5Yw8qBynYqV8qqYl2VQikP9+xHupdALNvYELNdr02c9XU8LAyhLc
         OV6ki7dpXbewQWlf7ipiTk45CmgDKMOpTCXJXjfB4htdotfZTX8KNKdaV6QUFgIgLKNZ
         q5mQ==
X-Gm-Message-State: APt69E2T3HTFYCs2N8rDL/pU326GoAaCpH+WIK+r32Eh+xzLuKtA4rdq
        2CufGnFK5T9Xgplxkrv+k3U=
X-Google-Smtp-Source: AAOMgpduyD5rXirEBYEz4HVs57fk5hE3gFqXtkKSL4EYCkDye/VkGaKiXOYRrWAm0XqbiVOipUKKnw==
X-Received: by 2002:a1c:7d58:: with SMTP id y85-v6mr13915297wmc.91.1531219256353;
        Tue, 10 Jul 2018 03:40:56 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id b7-v6sm22017419wme.39.2018.07.10.03.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 03:40:55 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:40:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: simple: Add support for DataImage
 SCF0700C48GGU18
Message-ID: <20180710104054.GI1504@ulmo>
References: <1529930490-11874-1-git-send-email-michal.vokac@ysoft.com>
 <1529930490-11874-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Content-Disposition: inline
In-Reply-To: <1529930490-11874-2-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 02:41:30PM +0200, Michal Vok=C3=A1=C4=8D wrote:
> This adds support for the DataImage SCF0700C48GGU18 7.0" WVGA (800x480)
> TFT LCD panel. The panel has 24-bit parallel interface and can be
> supported by the simple panel driver.
>=20
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
>  .../display/panel/dataimage,scf0700c48ggu18.txt    |  8 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 29 ++++++++++++++++=
++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/datai=
mage,scf0700c48ggu18.txt

Applied, thanks.

Thierry

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEjTYACgkQ3SOs138+
s6HT5hAAmihXkLqsEB8gSfrSbIcFkJHceU/B0I0gnc4TPuzV/qL4St6H4mpdYOzW
k3DYlC0O/l0Qep91UrYWc3qc8GdfYERhYMtLdGa2MFuLKl5eDPjaq1LzAMl9N73u
TjsSAahca+VbKoAZPPKYMVaUYf+pqxmpvkDqP/0aPhQbx2qVtXZig0KsEMqmmWSt
+lt8+GlmlvTThGuJPrsP5+h9r8/gIgf89nTjqBiWkCSogDccAkJ4ueBBmufDg7l0
d69V0hexSde6K+AXeY/0fWs1R2k0y5PV9Y0tWisWCp9gr9jWFiPz6l3AXztbCbd2
+A/a0gN0mx9BGkhTRWWuz7Rsf3q9NLBWThegaIYzx2ncMEzsEQcWF0734LZ1ckpH
8KrAITYUDSJzygyQ5e07Wwr/lz7P4arq0BeYti/l0MG7x+1dOPdTc8TTVjfaa6Gs
UmakjdigJa8e1goD9dlp5HnzbKXGKjVqucGutdRsEtrAY/wT1K2mH9kwXRzyjJwn
m3XnYC7fj09O3l4G/SN9aOCZQsJu6jeBrYhU+7pgROuikVkW9njl+MjxDyt3bmBP
7b+fqBOTm6RoilPDNyOPbbQDX3kjHsHSIwJmfddy762z0NdHMCyQN9Aj9qeRyNO5
Vg2vK9DyB6Y7HMGUvi1M/8/qqvsylo9S1DPzm35KJV4RrUDIgRk=
=xiZK
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--
