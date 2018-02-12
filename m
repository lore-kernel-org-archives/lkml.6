Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-911174-1518425332-2-16818301881519275436
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518425331; b=eLxfsivp5z3t1K1u6SyN1TXO0qSpoxqURqHtjw5Be/ZN/51
    g8qnt8IpBtfNWWbT68htgOduCObwpNksafpvnUt8r5XW6DxTH16PeeWwEfscjAUD
    Zii7XFBAtxtSF7dK/9I7wjn01v7tFEQ7K7bENi79TdudcXJGtIf8h7KiVEhhWI6D
    W6G/Zs3sWOTnOAR5kEtsNbWwGY7WcR4EHAa7S25jGF9OyePyxBheQwqu8cKW2ce9
    qzhT7ZkKYTNi2aRnvzyoMJVJplXfyEnxJ3vTUEXL3TXbANLPu5fjgZs8oBy3iqZf
    3BbRHSUbmCtBweaAG9HxcX5NC31MV9Lo9eNox5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1518425331; bh=3AD/IhJrnAqMQDKtGkj1nf91iHpGsTF9Be9DoH
    CsNjo=; b=hvCP/eu4eIt+anmvK+huTyr+Nj1nxxvx32uQ9WhRcKYVxh1YuM+kDf
    ZyNjfVN36vzS4aMz8Wk21XGcUPn46UtP6xi+6Rj0albRL+Fl1mh/65cOl2X4o+qR
    DCg3iAnI2Lmz2D65rov6A5zMkI++Ef1JKTNf4CnnLynHZdQ2osxnuZuDpavD3BwO
    Asvm2QZbddk1p3Q6/u3AzumZix+P/UGE1ODhrvYzi5IMS5UVxqd95q83zThUtAwC
    Yp3DHfu11BFOADPYJyq1icsX+2PW3vnXZ4+uxbrjy5VN9NKk68HK7KjyFEkiXyXJ
    MJzwvKxKuK+nF1KG9vUp/d2jsx33jCqg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933002AbeBLIsd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 03:48:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:43070 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932804AbeBLIsc (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 12 Feb 2018 03:48:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,501,1511856000";
   d="asc'?scan'208";a="17245660"
From: Felipe Balbi <balbi@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gregkh@linuxfoundation.org, bhumirks@gmail.com, leoyang.li@nxp.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 0/4] usb: gadget: fotg210-udc: Fixes and cleanup
In-Reply-To: <cover.1515791144.git.christophe.jaillet@wanadoo.fr>
References: <cover.1515791144.git.christophe.jaillet@wanadoo.fr>
Date: Mon, 12 Feb 2018 10:48:04 +0200
Message-ID: <871shqbnln.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:
> This serie aims to fix 2 issues. (path 2 & 4)
>
> The 2nd patch fixes a memory leak. It uses devm_ function a simplify the
> handling of the memory.
>
> The 4th patch fixes a potential invalid pointer dereference.
>
> The 2 other ones, are just clean-ups to remove useless code and add other
> uses of devm_ function to simplify code.
>
> I've left the request_irq/free_irq because I'm unsure of potential side
> effects if some other resources are freed while an IRQ can still be
> triggered. So I've preferred to leave it as-is.
>
> Christophe JAILLET (4):
>   usb: gadget: fotg210-udc: Remove a useless
>   usb: gadget: fotg210-udc: Fix a memory leak
>   usb: gadget: fotg210-udc: Simplify code
>   usb: gadget: fotg210-udc: Fix a potential invalid pointer dereference

you should NEVER make fixes depend on cleanups. It should be the other
way around :-) First fixes, then cleanups. The reason is that fixes can
get accepted during -rc cycle, but cleanups must wait until the next
merge window.

Please fix up your patches, otherwise I'll have to apply the entire
series for v4.17

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqBVMQACgkQzL64meEa
mQZQlQ/+M0CfPqushKipcO7SiVf+SgbJRb1EYgDd/UuJjTDk+PjicsI4X3CY9Edi
5RRia83bO6umVFFWl6iJFdGBNjxlnouPJbKioR1rW0CFcu17EsD0bbUMzrQ9v3b9
a3eU6X5yvOcdOHcIZDzsuOXmk24SG68HuIIPyYDKYBkrVI6LQVYOKYkYldahAJJ/
AxV1ebcCIhoeIG21V8NBC5xKTj+zP3S/Oz9vJ4ReD/iRLl7U5yQaK1p+sCE8yKFe
QiolaqDdPpATvv4Ppj37GWx2tJfFh6w/Tva9pXj/hzMjKJvaOTlWGO8i2Q2KL82F
ls6M/V9DnkMBEpbZWAhsfOryBuDDwY+TTWkgh5yg9xOU6VDRcWs9zhzyo3Eh3wgW
kbOjI6j0iKJW9RQM9YrZ+uva20grE+pO8aqRrlrhw2s3dt7k18KfToLNbnBYFl/v
Rcjp/v8GNl1xrV2cgJmKWFV98/Anc4X1C1OXgQItAYC8fxOw3NtdPHpIWelpFtB9
3uUIncVXYQe80iArV/dBYmLYVwRZtG+ghx+LMJXP4WhIgolpB7Mc7LSoHYDL7BSM
36vIP7A4fZvhD37DUBe6lPT8JeLIfPPhEmuBPdzW2iTxD9khF/8Q/he0Il8Dce5H
Bf+QqXGL4XyFBMcbY04nJENSHKEax3y3Qc/qHi6rbdQe2FERXEM=
=WDQL
-----END PGP SIGNATURE-----
--=-=-=--
