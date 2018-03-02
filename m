Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519988280-2-7235458405412434905
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519988279; b=EUWmZdihOcp5rJELtI6MFTpasjnn+7NK0GIhRiGn2PZp+SR
    SunB1g9yi+veqZbPiJOdZmVR1L7fe1OrpOVp+OWzMNonXY94k949wLD4M47X32nF
    ne8oL/b/T0f5iuJmPMkWqp6D+doSnXl0GboBJZHooslZKJli6Ublg/+VJFa/g1BC
    7N2rgRoPb/HS7aY0adKQRW1ywiuqBYXpOQtDVv35ub/NYc+VeCW8WxKJ3F77Yer3
    TsLXdR0v/EzP93Fh5+MiK5KLY4GoTqAwYrJlV3e7ikaKhNKTLfgG4Zlu7EpD9OP/
    avWL8eWkQTQ/SE5IzxFzdlhJpSdvHEWy0b9v3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519988279; bh=92YiDD5ShZ+Qncy3W+ZPH9RxGv
    eo3TCUBuYYe8ZIjRU=; b=iU+C8NtOlk9mA0VLZrtJCyPgPcc6UIoIEcY7HJ/wlt
    2kwk2qYX1vWgZ4fv+HqqgCLWj5q7JVWM0YxHqheUMYjZRFj2xBdDPjetlDJBxJNB
    lWq5RdolZrEKGd6ijzxW/h/cb3IebbsOxeQxSqblOCi399wufXH45Eh3RKYxHjbU
    jfcWK3Q5qmuFLLF0UQlj+XHT8qRCu9s+j1itfsRwlPFSEaJ/VofvSv2TMauIC/bF
    hmrIIjtDgr9mPnqrw+je0wo3sWQRoIbR3WqBTmbtlUKQH8LV4uDhjJLpmKGLLnkx
    8LtWm6Z/FIFthS4BWk0n8NkBvugotwxZqdcxnddKE73Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=STRXvXXw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U17A0k83;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=STRXvXXw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U17A0k83;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426738AbeCBK53 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 05:57:29 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37992 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423941AbeCBK5X (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 05:57:23 -0500
X-Google-Smtp-Source: AG47ELsWXC+1aO9aU1MbnYW0pnrRmzoUd5jDXYpDAI/DuSt02WfUcIS6RBCNXM+Y2098IJ2xkpZhhQ==
Date: Fri, 2 Mar 2018 11:57:19 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Zhi Mao <zhi.mao@mediatek.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH v3] pwm: mediatek: fix up PWM4 and PWM5 malfunction on
 MT7623
Message-ID: <20180302105719.GC27178@ulmo>
References: <051f401bcca48ece188023ccf10b2cedc7a25a64.1519891948.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <051f401bcca48ece188023ccf10b2cedc7a25a64.1519891948.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 04:19:12PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
> control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
> programming on PWM hardware causes waveform cannot be output as expected.
> Thus, the patch adds the extra condition for fixing up the weird case to
> let PWM4 or PWM5 able to work on MT7623.
>=20
> v1 -> v2: use pwm45_fixup naming instead of pwm45_quirk
> v2 -> v3: add more tags for Reviewed-by, Fixes, and Cc stable
>=20
> Cc: stable@vger.kernel.org
> Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Zhi Mao <zhi.mao@mediatek.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
[...]
> @@ -151,9 +156,18 @@ static int mtk_pwm_config(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  		return -EINVAL;
>  	}
> =20
> +	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
> +		/*
> +		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
> +		 * from the other PWMs on MT7623.
> +		 */
> +		reg_width =3D PWM45DWIDTH_FIXUP;
> +		reg_thres =3D PWM45THRES_FIXUP;
> +	}

I don't understand this. According to the condition above the above
would also use the PWM[4,5] "fixup" register offsets with PWM[3]. Should
the condition be pwm->hwpwm > 3?

Thierry

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqZLgwACgkQ3SOs138+
s6FX2w//SIhj+docsdzcwMIo27Gc2qmUL1sMCZXhB8dEGZ8CDXRDRyGsNE/eCkkD
5bZrN3ie7XkkcoLjDqhJZM5PvsiqR4367yRlWg5N/PsCwlji0wZ/1ZfV0bxBxa7G
k9A9aJt4PdRAzT6gJh7IQmbnlMvbHN1NpkSli5HYrGtEO7t0MewAPRjJ8/KIcscI
IlXX6ESptOP3+3xbu21dOzxV3T2zmlPKQmUIfDLH9PkcC4RYOuANbkWb0em9hpeq
dJtLSqqwXh3WSMjRgJpKIT5qiKhuuiQRoWJyUkImQfjU5kH8QC89/yVNUXcNo3pT
NvZ5cqihFktL+dLd+qS+nIxh2VQDF+NLHD0G8OBlYtSe/X44NkPtS+gOMBYDSKLJ
L3g0REZRfQXK2QtWZ818acUnd/MC9E5x2O3C0VVh/YzIEzUr6qKTstk33+QX7xUc
6kLWtO5ctV180OdiyWW0qE/v8ZoioY/KTeNQU5Mgfz1YMEkhSP8wSLLRBMknJ4+n
n7CE172HhAUGsbhYA2/eRG9e8vnTyk4fdWrcjryRoxtjGGsG2JTOkOj5x0M5XR3o
b6O2JQXS8hGJXBzjK7/PtKnbXc8hMjRFT1HcZ4z4ztNnaSufCEdKPWlXRLZQs0ix
2PAvnqATUdF3IegKJZSmWJ5joIT/kJu7JmmzXM2GoOM9FAUNZ18=
=4k2G
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
