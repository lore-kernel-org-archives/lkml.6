Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CE7C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A642147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4dMPgJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbfA1Rab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:30:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51801 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbfA1P6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:58:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so14568046wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yi7rQHvNAZ7zl9CjnPk305myXwwFLeIHuFnsIcYzH3M=;
        b=Q4dMPgJqsey2tWyNqRqKNE3tpkRVfMu/Z5t27wqZYQwfBjHJpE7SnwekSikc3SQBDA
         jMCED/Od6M6PaPg2MQbsG/ZkgkFH6XnXAaKh9B/X73XUqPXlvvEurNShv33nUvq+/0TG
         mxDb0HHsWVu3sigS2pyVXBQ5DWcLLTfQDAbuFL/haGGtEZquAeJlfelh14xgwvgc+arC
         ISox3yH7pXkYFxH7gcrIQj6CkAYrebc+1+2wyqXjp6fQmNPebnt8IVd2u8emSoEMjP4m
         Z4giWxnHMJKLGSyZBnq7Yi1Lb4IP7DyJcg//y40KSqljwmkMHzoJeV/0RdbCZphPsPvz
         bUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yi7rQHvNAZ7zl9CjnPk305myXwwFLeIHuFnsIcYzH3M=;
        b=Shuk9Z7ZGMDiDpU0XhvW79dXM8U1Rj63G77xdrKAmaqoRvG83SELnc1WYq3A2/uh6n
         bOUAGVszhGnkYMpo1pYM2Z4xwloF66CWoPrAUWc7sObmd/So40BFeyDdrcGgLfjyq4qn
         kaW7uyOV30RlmGqJmSEQmy+0NVAabAXbTaxFOBpxAeQ3Ohk9lZ4McHzLeLeiCDM+jQUY
         yGSxx0BDuZiAcZBA+MLh21TC2go0Z0QE67lfgqFqYoi4rRahVqSnX4Q8Ie+PCAMYtJTu
         fFrFVJOpQkykYDbmHH3cWhYHYjYBy8gr05HZlPcQe1O3pyUEf9SGaNgu1BM7wBQftR5u
         xCSw==
X-Gm-Message-State: AJcUukfUvRDpW1IyvzOmihJH8WoSYE7SkljfoUZW241np/dPG2Q/4CMU
        mi3WtGj4kgkmqSVXdTtrTYI=
X-Google-Smtp-Source: ALg8bN6absIZSNeU6GtPvj1phV6t4VUvxapvyJSnHO2Ns/qJbjLnibt+ylLihTp8uE5QsCqX+lRnnQ==
X-Received: by 2002:a1c:a6c2:: with SMTP id p185mr16013577wme.133.1548691130938;
        Mon, 28 Jan 2019 07:58:50 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id n20sm40312418wmi.11.2019.01.28.07.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 07:58:50 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:58:49 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        seanpaul@chromium.org, briannorris@chromium.org, hl@rock-chips.com,
        nickey.yang@rock-chips.com, p.zabel@pengutronix.de
Subject: Re: [PATCH v4 RESEND] drm/panel: add Kingdisplay kd097d04 panel
 driver
Message-ID: <20190128155849.GB26200@ulmo>
References: <20181030091528.28211-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <20181030091528.28211-1-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 10:15:28AM +0100, Heiko Stuebner wrote:
> From: Nickey Yang <nickey.yang@rock-chips.com>
>=20
> Support Kingdisplay kd097d04 9.7" 1536x2048 TFT LCD panel,
> it is a MIPI dual-DSI panel.
>=20
> v4-resend:
> - Thierry noted missing dt-bindings for v4 but forgot that he
>   already had applied them one kernel release back in
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Debc950fdff6d5f9250cd5a5a348af97f7d8508df
> v4:
> - address Philipp's comments
>   - real range for usleep_range and
>   - poweroff ordering in kingdisplay_panel_prepare
>   - return value beautification in panel_probe
> - update author naming for full name
> v3:
> - address Thierry's comments
>   - error handling for init dsi writes in init
>   - unconditionally remove the panel
>   - don't use drm_panel_detach
>   - a bit of variable signednes wiggling
> - I did talk to ChromeOS people and the delays really should be as short
>   as possible, so dropped the 100ms from the delay comments
> v2:
> - update timing + cmds from chromeos kernel
> - new backlight API including switch to devm_of_find_backlight
> - fix most of Sean Paul's comments
>   enable/prepare tracking seems something all panels do
> - document origins of the init sequence
> - lanes per dsi interface to 4 (two interfaces). Matches how tegra
>   and pending rockchip dual-dsi handle (dual-)dsi lanes
> - spdx header instead of license boilerplate
>=20
> Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |  11 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../drm/panel/panel-kingdisplay-kd097d04.c    | 473 ++++++++++++++++++
>  3 files changed, 485 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c

Applied to drm-misc-next, thanks.

Thierry

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPJrkACgkQ3SOs138+
s6FSVQ/9EalnmSwrQ9J3DGelxqDMa1ePu6Ad25W/00aZtvCaY+wHqMWT70N2cr+q
vPHjXDNbLuze3DuB7KGNTDd7iYt0Y6oYZBsG3zARfTenHrfMKNMRHl5oHkiImWAY
6ZtIKMuwPc+RHqX84iZ5ooBvoqPAlW4MW3Dt9POQ6hdxHDfcj2y8WM1Pj+6+5pxU
eB2jvgIuHVSRljVcZDU3J3I3PIxRRMMxd+CCenP4SnrKYayeET+rXFYWqKOn2BBF
9xjhoIA7I4+3jU8RmT1ImEVIuFnFFpJEy3x83zyMIh1mGdn9nkP34kBtXGGJpfST
1eAzMAcgqNtU+eKyR0UthhYTA/G1ybfoPK7NqKgM9vzxIxA02UO7TN5/8UEldoFp
KBXNK6sefbzL7iSK6X/aAC7rt0oMZCoxnvVNdB9Ouqyzm0aobQWzSQzvw27ynv6a
2JRD5tjFAYNPTPTF9vcqljqFUkYKJZz/6Pq8yU9LYHXWF3ImREww3BdEdxRc0P4R
gj89Ng0UiiSFjflxSd52Ei5Olezlt6DoWjB/VDj9SZtVWCzUT55QU0kEfQXnO4mD
lX5HnW2Dpj7DYdcqcLEa9BJKSgCrizyXM2ENNobZmr7ce1amhA/1UYN4SGkKk0ij
bv8lsn3Y5V/JtHNauWTwoar7MR++8gKPs2xXcE443aC5OKsUOdM=
=ozcE
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
