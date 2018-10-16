Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84BEC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7787920881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm0G0f16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7787920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeJPSk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:40:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34870 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeJPSk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:40:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id e187-v6so22842972wmf.0;
        Tue, 16 Oct 2018 03:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Z5omMibdhkfH61laQLlscE6KIVTzgE7HJTRMjCKg8k=;
        b=nm0G0f16j7oORkRqKVjHYAzJzp342iG3FTy18UyaYjomYYidEkHOoAiP+1hgsIABXY
         ql5K7JwFXhgN4AZI3RT1jCwowpTpdjq2vx/iOPTk6bXPptVLoHhWdHlvWF1BouAVcXPU
         XyUIv/CvnVFWDPhfQXFDOb/lcxFkliWwfR1bfi7Kkwrf+Bv0v/vSt5hzn7r8tDZtXw2R
         OusEu0wj0lH/Ih9SYs+cW4ngSkj1z9PwYZxeqNm20KHFAvHmBOVJa/6fzieejj5J8Vom
         K3cio/X4082up8p+42sadLX3hq/RCBNK00PbB6jmLmDcWHZkHx0Xaf6niNeUETB1HUiz
         YSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Z5omMibdhkfH61laQLlscE6KIVTzgE7HJTRMjCKg8k=;
        b=cHz5vEEZQM8KB9Iby5yMSvIQ27OyzFychkEJWBK2uWAqtiYCQbIzld3IXFw1n5P1Ve
         xWHV4Ba6cGFPlIU7hmyhFbV8J/lQ9NH3YU267pJwRtEdV4g4LFSbiCe1OxU8hbxupA5o
         B2soxwtyvyjeM3HG3C1RF8ce0ATiLRnCiif0StQah5T28bqw9QVgN57S1sWzx0XPV4c0
         7rObGeaCzkw3Rojd99auq+LGNaYYZn0OJ4wIHPRpt0ViPRMcnt0FBoT4dE3DUEn/ENOQ
         +VXaDVbm4XISrlaRwL/ve+hBAfZyX59b5rKzTK+LQWFiDOOBNyPbXdueOUHbH58+4ViD
         tAMA==
X-Gm-Message-State: ABuFfogYaJPEC45YaoERbM588aElpAivztNaX0zF4bg2CjrMBalyQpcw
        6i5EnxecFym2xaRpodWfPqY=
X-Google-Smtp-Source: ACcGV63h5e4swexgw4tqLtjM9NBNXXBvKOroWwOaU2VBUcgT6oRM36bsK2brTp9RgD43oitvkebPrw==
X-Received: by 2002:a1c:4406:: with SMTP id r6-v6mr17125727wma.4.1539687065393;
        Tue, 16 Oct 2018 03:51:05 -0700 (PDT)
Received: from localhost (pD9E5106D.dip0.t-ipconnect.de. [217.229.16.109])
        by smtp.gmail.com with ESMTPSA id a84-v6sm8809125wmf.46.2018.10.16.03.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 03:51:04 -0700 (PDT)
Date:   Tue, 16 Oct 2018 12:51:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Wesley Terpstra <wesley@sifive.com>, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        hch@infradead.org
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Message-ID: <20181016105103.GB8852@ulmo>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010135109.GE21134@ulmo>
 <ef19e79a-d975-bde4-1692-65389ead7c15@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <ef19e79a-d975-bde4-1692-65389ead7c15@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 03:45:46PM -0700, Atish Patra wrote:
> On 10/10/18 6:51 AM, Thierry Reding wrote:
> > On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
> > [...]
> > > +- interrupts: one interrupt per PWM channel (currently unused in the=
 driver)
> >=20
> > This should probably say what the interrupt is used for. And once you
> > have that, remove the comment about it being unused in the driver. DT
> > is OS agnostic, so "driver" is very unspecific and your claim may
> > actually be false.
> >=20
> > Thierry
> >=20
> As per my understanding, they are generated by hardware but no usage of p=
wm
> interrupts as of now.

It might be useful to say when they are generated. Are they generated
once per period? At the beginning or the end of the period? That kind
of thing.

> I am not sure if removing the entire entry is a good idea.
> What would be the best way to represent that information ?
>=20
> May be this ?
>=20
> +-interrupts: one interrupt per PWM channel. No usage in HiFive Unleashed
> SoC.

Why do you think you need to say that they are unused? If the hardware
generates these interrupts, then they are "used". If no driver currently
has a use for them, that's driver specific and doesn't belong in the DT
bindings.

Thierry

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvFwpcACgkQ3SOs138+
s6GQiQ//cUGJvtTzXfrt/nIdB6bUI2UeshHcJ0hyljO7U2HxZlpf8Du+EPvio9qJ
8Y5SiGyZ1McNwiKhIzk1cw4riC8ezQdCpjlvx9EKumzHSsrBm1IFrg8nm9yb8W1a
T918g96hSfN3uiSPJuVqg/uK41kO0ZHuY12Az+a5U0LAdoN5fx9H9eoWOjRzIOG/
lfZ+afy6GIC94imlKbUjYKhYihTRw7+Xvg1XIVcmNVKSCp8Peyrz6/Pvt34796gj
z4Us9bKUw3P2Z7Iqfn4b9LDKj5ap/pxMdwCd77hFx2UXKJlukVJjQbRsVAAxUi3/
2iSNTvT73JT6E6xoOcqKS8tJs91nWtbkHY44sFar9iy/fiqH59JcdV+r7f2EzH5g
2T8bkSGFw1IBW16QrJbWEqPNW45adFFZTju7kAjYdM9NcMGaoNZ1fxLxw0g+aD8Z
tC7zFStY1MOWNFsOHnUckDTaQp5twZvz5+MvQECU+XbKswcovGstIkNgXe+p+tNP
dL2Tl1UlH8LIjzopB/LwQ1Re+fjMlq+L+uuWCdKkzl4OkY6RgXtdm5kfbqIsGh6m
7XPU8OmUkUlMelHt372Tx/cjEaqLaYyBxtyunydIGaTGGdF8W+WMAw729IUMCQAH
9mBkVv4I+N1XvvZwN1d9RNbQmZoTWa/IBHxuAxVQ5VE/UEGUoBQ=
=f7GF
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
