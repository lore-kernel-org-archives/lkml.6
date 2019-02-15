Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33069C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8C82080A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="QmhBJECQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389410AbfBOHNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:13:15 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:57830 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731694AbfBOHNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6w+vFfVoNlU/XhcPPJ8lofA6a6B0rHWienMgz3TUnmI=; b=QmhBJECQktpiyoBlqH7x1MyyI
        nEW8lefC/jLJ/IOnaU3o+wpCeHoOomXKX+r5zVTJ3DdcGJVMi3eAMqYkhzxXIxE2JaAg8PpJMax5l
        8XUCrVLZbTfTfspyRVm6bQmSZjqB8nmPPIbMXfyo99dDZE1eehzWY5+3CVW0pVgxf3bT0=;
Received: from [2a02:790:ff:1019:7ee9:d3ff:fe1f:a246] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1guXgG-00024J-CR; Fri, 15 Feb 2019 08:13:04 +0100
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1guXgE-0004qi-KV; Fri, 15 Feb 2019 08:13:02 +0100
Date:   Fri, 15 Feb 2019 08:12:42 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <laurent.pinchart@ideasonboard.com>, <sre@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 0/2] drm/omap: panel-tpo-td028ttec1: add backlight
 support
Message-ID: <20190215081242.21cc9953@kemnade.info>
In-Reply-To: <a54e7427-ff84-d105-aab7-c5eab42e6df9@ti.com>
References: <20190205063813.14873-1-andreas@kemnade.info>
        <a54e7427-ff84-d105-aab7-c5eab42e6df9@ti.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CwJMaOvMR+688fpUkYv3koC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CwJMaOvMR+688fpUkYv3koC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 8 Feb 2019 11:13:33 +0200
Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> On 05/02/2019 08:38, Andreas Kemnade wrote:
> > This panel has a backlight, so add a property describing that and
> > add the code to use that.
> > This makes things like xset dpms force off
> > also turn off the backlight, so we do not need to rely on additional
> > userspace programs to do that.
> >=20
> > Andreas Kemnade (2):
> >   drm/omap: panel-tpo-td028ttec1: add backlight support
> >   dt-bindings: panel: td028ttec1: add backlight property
> >=20
> >  .../devicetree/bindings/display/panel/tpo,td028ttec1.txt       |  2 ++
> >  drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c        | 10 ++=
++++++++
> >  2 files changed, 12 insertions(+)
> >  =20
>=20
> Thanks, I'll pick these up.
>=20

hmm, that sounds like: patch accepted, will appear in linux-next soon.
I have not seen it there, or is it just in some branch not merged into
linux-next. Any new obstacles?

Regards,
Andreas

--Sig_/CwJMaOvMR+688fpUkYv3koC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxmZmoACgkQl4jFM1s/
ye9+8xAAqmwCufiIjNGhDbgZP4jQZyAq8wV/Mfq8XHJLGVThdnHzE/AoKrEwa1/Y
snw2s4+AcBHwLwqPbKTzAyY+hZoWlzuTDmRUepnoKxusJerbsSe3DBH0brqb2NR5
Wsjn7s0JHVv0XPo3cDQOw6igQ+ca/nJak8OweR9QZFs1raoqfDldUCVQH9zFGRkk
Ec5sBfd+/YWxpdmDpREB5QCYeW4CJsWWcDTzMSp8uY69IpXv2+uU0+eao3HSjAli
pdYaPMiaw52Rr31ERmG2icWiYkEQETH52xoPVe85yut5fIO9WjGd37UTW1QaeFLN
j02Jc9YWmjPgXmxqoLC1gD0ODuVMEVwFvQmzejtTYRWJYaz4MrYuGi4EL+LYW3gU
1w5FD0D80vxm55nRog/pWHD42IPPqQ+svj0SqKoUrjof3Pv13PnsvcGKV82dNPnP
MFTre8QnxpAlP6YjHDJaRGVqtMEMM1Ny2c0u3euTDCtzeYINx77Q4j576Ichb6K7
gi7zMBhPhvtVkcxnu1jYQYSTodjHD5aCkhxIqFkvxsN/oCZId7pekTOaalhdz97m
3em2ct49+LyYJU9POAxyOwzNPg7Ikwm/uNLV/rspwJQL4z58SBq3Uxq8+bmFt4oX
eWEOlH1NUhFcYTU19JJ+xeE9lJ6K98pxMntwgIHlvWX/LqGRL4g=
=85hg
-----END PGP SIGNATURE-----

--Sig_/CwJMaOvMR+688fpUkYv3koC--
