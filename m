Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E909C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4718E20881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/dKCDiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4718E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeGJKmG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:42:06 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:47003 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933176AbeGJKmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:42:04 -0400
Received: by mail-wr1-f50.google.com with SMTP id s11-v6so14060738wra.13;
        Tue, 10 Jul 2018 03:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ne+O81f1J+IZg7qyHGqxRyYQPwwIPtY84sR1wh8QDiY=;
        b=V/dKCDiqK3BHdi1CUzQu0L4eHkDk2OCs8gVXmMudIljcMwxOQRov1Y8Vg8/ER7kOX1
         1g9g8hYd7U0+4X/wZO4EAdIuqSMoCxds9drmLHnMGXLoCfRk2jV3J/c9TfI7ausRyhlZ
         zAcgAK4JFk9q+0NwT4YXNedRw4vw+FMpdA1WS26d+VfJpvlV3rCUtsmgITh85D83gN77
         JotAErx93BDm3PXKicdSRUZ5hbmlET0sRH2RaKqe0YdhuYdO8GWTWsNkQeR3ojXsvhii
         njnd5+lRwpVQTnugleY2tB+FslkOhlwWxgT4A0OtJPthUS8XYNzpwclwmpi2Kk7pwAK3
         QP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ne+O81f1J+IZg7qyHGqxRyYQPwwIPtY84sR1wh8QDiY=;
        b=TzixRP5B4kfgO6kTxbteBX0YlTdGBtAbKHxpJGO1JYYMUjUfEm/c+swJ90ZxDzGnBD
         ob7ERV0V1SSvHOeTd7erG1kX1CifWIylbnYHhSZXTDEiJbeuzg0Zn982i7jb06EDlEuL
         9FmufSTx295Wv5XuHPJKXdUI+R/d+uJXRalUQKRnwgmlW6wtkxmq/vf7iFkvwLTgTkcU
         2Cjf6daWG7dZk+nn9yaZGXLAKnngufDojmzg9rjhio9+r6A+98X/RzVXu/1zjV/53OI2
         wG/nW2UkRMt21Aof+F3Ee4ghNmQxCT872KivcSP4pRnyFFj3AVJ6IHXOop8NVRfLnYLn
         qxXw==
X-Gm-Message-State: APt69E00rImweQqNxdLG0lVU+DMZebEfjdOfIuW6Ze67BeccF+TtpWVV
        vPBDcP8sdN9SZsThmU91Uls=
X-Google-Smtp-Source: AAOMgpcpsSoXFZwMegkfI4l6v7L9tg+KIk+nYaGwL9P2tthjernjEjmB15vMnTj59ptyOS5D3k8eOA==
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr16796745wrp.161.1531219323392;
        Tue, 10 Jul 2018 03:42:03 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id m136-v6sm12979447wma.32.2018.07.10.03.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 03:42:02 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:42:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/panel: ILI9881c: fix missing assignment to
 error return ret
Message-ID: <20180710104201.GJ1504@ulmo>
References: <20180626160354.1363-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcccYpVZDxQ8hzPO"
Content-Disposition: inline
In-Reply-To: <20180626160354.1363-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcccYpVZDxQ8hzPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 05:03:54PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently, ret is being checked for an error condition however it
> is not being assigned in the previous statement on the call of
> function mipi_dsi_dcs_exit_sleep_mode.  Add in the missing assignment
> of ret.
>=20
> Detected by CoverityScan, CID#1470174, 1470178 ("Unchecked return value")
>=20
> Fixes: 26aec25593c2 ("drm/panel: Add Ilitek ILI9881c panel driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--HcccYpVZDxQ8hzPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEjXkACgkQ3SOs138+
s6HLFRAAp0RfH9dXdPIBTsFKGhAnjEGXIByABT4ePuVE48uwunerFYt8UCeBkRTR
RxQjfMEij4yRhOK18BM7yFNYZHTrFfN6C0TlUGxqA0HmIew1X0XCLh1AEZTwfz2b
ZSQhkIW4nCMnyCSNkz2e50sKhhBw/rUyggOtdInj9HJHprFBGU6NCAIbwPdHQYG/
+pJaXVdQq8X1ZuRx/tLy5+BMuLua/0swCU5Tqd9JsbL1kpWtoiX/wjYuDLEj3zUf
4uBoWmm+kAFlZg2722Am3UmonLavdpl0Uh9Q2Suq6zSpAUqnNmVqgBNXgroDbOsF
74Prk+pDtP7RLZYJ/ParuvonR6yZv3aYU+SpJw5fBHcrKv7AHrqUoGwvX/SZsKPM
hPJ79rFK+8Ob5lGEbGFb5zebvnRFJ3KP/RTb/1WPBUJYUILwEZR9VXdu0vVXMvel
RYvlS9ITDBLsSVr4ktJrWxP9ONlo746+6EHhtlsnFFaab3D2BYrpSrZ1IQCdnZu3
k+pgTKtdnXsavBqliE3FVA8ijQ+dDpeQkJMKWZTj9OjNjLxCIzL3nauoHSdpGvjY
i9jg7BYbREZmhOJhvR5ISWuVXY5DyEjZ2fHF++BAJyu5Z+dE+Vrn+cKr+Z6EHRjY
UteLVk8HQEwRjFEiXbMjUSVZhhkIedA9LMeVn6U19suUjDW2LTg=
=kp2D
-----END PGP SIGNATURE-----

--HcccYpVZDxQ8hzPO--
