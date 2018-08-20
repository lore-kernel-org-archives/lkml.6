Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0048CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998DF2154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd9Jp1/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998DF2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeHTMqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:46:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54817 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeHTMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:46:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so13560354wmb.4;
        Mon, 20 Aug 2018 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aPrjL3lQBt10Kvr/3CicCqkkIkJnb04Py8pZ4izKnN8=;
        b=Xd9Jp1/89VJTEhHHwvBTxfrs1/sxtfV6M1KqRfUncBYU/fco14E214Gq1IUe/LTQ3W
         Ynnb5ZiftW3SaCqgvTtLbgwWW5gEKNdKkNNNO+yeeOe9d19t5i46+vUHLsMsBlvti+4f
         dxYarX6NM1mACvj7RyNeggVPENkbIdS22ZQDeCA3hGtwwb/AG4i0k32VgnIp1595Uftb
         w0U75pA4qqUbuT3IUMYnq4Ypa0kfoNp33e/KninG29du3zd2dOdyVFwOIx3MNpJzIpN3
         U5Rg0T4BF9BbuCDc7U3s8KPPwbxML3gasrjL9QmZnW/nx4firzBKMIS19NQEC52aeRpO
         AJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aPrjL3lQBt10Kvr/3CicCqkkIkJnb04Py8pZ4izKnN8=;
        b=KFWgKnubuHRShHBgSziT6MYPTwI57n+lY76qM+VcL6tu6xg/ti9RyH7axOOGw7drkz
         ZN6l3ZeH8dd15FSu0yRI0es0L3HcOEKLxNhKcJAl8XtKGZDfQ3wL5VpWIikwMakYcrKh
         805SyYy0vyQCkv54JJ4U1ZbA6wU2EAA8YLauLqzdatuVGqVCvwAv3mbEkifRx7BLN9KH
         0aty5kt+bhAqemILoJDwXszAYgF217hLUMpoFoPoLsCBWRO/+DAsKfFzsRLkHiz4I680
         TodzFwuY335w3D+NZJspCXxHxKP322LTrlv9gfvOtSzeuzErfL/9Bo8bAaER8ZjXMKU/
         cOgw==
X-Gm-Message-State: AOUpUlHnWYbNw1GdaZ+wYtmmX7JrwFO71yXMYnsVSbDz2lpFwXDkvjX8
        znCjlxyeMLGf4OITWExymsU=
X-Google-Smtp-Source: AA+uWPy8X1OWt2QcM2LL6cJ6h4PO0n+8k5N+wX5CaiVkpvMxH7m6qiDU/7AdnQgm3gDw2taaZL42vw==
X-Received: by 2002:a1c:7c0c:: with SMTP id x12-v6mr25372507wmc.58.1534757468435;
        Mon, 20 Aug 2018 02:31:08 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id g2-v6sm9375230wme.20.2018.08.20.02.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 02:31:07 -0700 (PDT)
Date:   Mon, 20 Aug 2018 11:31:06 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32-lp: Remove useless loop in
 stm32_pwm_lp_remove()
Message-ID: <20180820093106.GB8242@ulmo>
References: <1532070992-16831-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <1532070992-16831-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 20, 2018 at 09:16:32AM +0200, Fabrice Gasnier wrote:
> LPTimer has only one pwm channel (npwm =3D 1). Remove useless for loop
> in remove routine.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlt6iloACgkQ3SOs138+
s6GaqQ//aqTgISn0zsi04ptSNxWztxp5lpMjQYEt1wmsK/uSTWDFT0XWB5wLk6Mw
uAsXVkboX8mqMqsLZNYWpnPlAVjLL2Yg3T7rTHwlIS6EdFkWmNEODX4ueh+oE8SE
c2ks5BXgEdOiuwihF+Wj0LpLcaerexZ7TjXgfC2C+a7JMOHwdRoh4VcxD9ecJYqr
0QdzZTWn+WOkQpEYyX16X/lC7iT/wFJ9VrA8sf8JT3VWGyQSGv1k3il50iWOlxX+
NU6TlLR6vm15Hu3KtWEvZaDZ0wJgQaLJN2pm2yaB2xAzF/f6wedrX9F/wBvXm6mp
4Q2JK/4Mb5whm4Dd/hiNJc6l0zZ3BwJGUN3zuWk/77QcZXUerQmow8daHw3DHZs4
hK/OTXQXAQqfkk3nuZCnwcUCBxoq1e5QGX3HYOrsYu311maH8WYygoWbSSR1GrsP
QE0j1GoBBx07S+BEvQ437MtJVsAQlnWpw4BtRDVqBzeZrnaVN+Lo+8pBRZrMjGeH
gOkiPhDQlG1+hy4C9Zhu258cR6bQtou/PGIhnk1tkB+uldfzdkl8cMFBHt6CjSK5
lzc6YgmLXOkqGilbLebzKdhCC2x0DDmo/odKZeOr9raY2Jw+vSzN5RzGRyiTAI6T
eugMAbwH2t1LKPDSbG5l9SQs5CIt4YBumvEPN4kmh6GDdBakqXM=
=uyVX
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
