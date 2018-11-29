Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13325C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06F4206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06F4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeK2NEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:04:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726872AbeK2NEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:04:24 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAT1rpiA133765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 21:00:42 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p26mdrrrr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 21:00:42 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sbobroff@linux.ibm.com>;
        Thu, 29 Nov 2018 02:00:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 29 Nov 2018 02:00:39 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAT20cBu51511304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 02:00:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 275F452052;
        Thu, 29 Nov 2018 02:00:38 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 784665204E;
        Thu, 29 Nov 2018 02:00:37 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2FA5EA0198;
        Thu, 29 Nov 2018 13:00:36 +1100 (AEDT)
Date:   Thu, 29 Nov 2018 13:00:35 +1100
From:   Sam Bobroff <sbobroff@linux.ibm.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Dave Airlie <airlied@redhat.com>, Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/ast: Fix connector leak during driver unload
References: <cover.1541397462.git.sbobroff@linux.ibm.com>
 <3350c5dd5ea08c71e4769ea3801290e7f9238a6c.1541397462.git.sbobroff@linux.ibm.com>
 <CAPM=9txRjd6E3DxdcM14mzWG1P-Cr70P61Eyce95bBhJtqfH7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <CAPM=9txRjd6E3DxdcM14mzWG1P-Cr70P61Eyce95bBhJtqfH7A@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 18112902-0016-0000-0000-0000022E45BD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112902-0017-0000-0000-00003286A624
Message-Id: <20181129020034.GA10328@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811290013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2018 at 09:40:53AM +1000, Dave Airlie wrote:
> On Mon, 5 Nov 2018 at 15:59, Sam Bobroff <sbobroff@linux.ibm.com> wrote:
> >
> > When unloading the ast driver, a warning message is printed by
> > drm_mode_config_cleanup() because a reference is still held to one of
> > the drm_connector structs.
> >
> > Correct this by calling drm_framebuffer_remove() in
> > ast_fbdev_destroy().
> >
> > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > ---
> >  drivers/gpu/drm/ast/ast_fb.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
> > index 0cd827e11fa2..655372ea81e9 100644
> > --- a/drivers/gpu/drm/ast/ast_fb.c
> > +++ b/drivers/gpu/drm/ast/ast_fb.c
> > @@ -263,6 +263,10 @@ static void ast_fbdev_destroy(struct drm_device *d=
ev,
> >  {
> >         struct ast_framebuffer *afb =3D &afbdev->afb;
> >
> > +       /* drm_framebuffer_remove() expects us to hold a ref, which it
> > +        * will drop, so take one: */
> > +       drm_framebuffer_get(&afb->base);
> > +       drm_framebuffer_remove(&afb->base);
>=20
> This doesn't seem corret, no other driver does this pattern, and I
> can't believe ast is special here.
>
> The get just doesn't make sense.

Thanks for having a look at this, as I said in the cover letter I was
concerned that it might not be a good fix.

But the AST driver does seem to be special (or just old?) because it
embeds the drm_framebuffer directly into ast_fbdev and (almost all)
other drivers dynamically allocate and reference count theirs.

The drm_framebuffer_get() certainly looks weird but it is there in order
to cause drm_framebuffer_remove() to call legacy_remove_fb(), which it
won't do unless the refcount is at least 2. (And because the
drm_framebuffer isn't dynamically allocated in this case we don't really
care about the reference count anyway.)

An alternative might be to call legacy_remove_fb() directly, but it's
declared static.  Do you think it would be better to expose it and call
it directly from the AST driver code? Or is there some other better way
to put the drm_connectors?

> Dave.

Cheers,
Sam.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlv/SDoACgkQMX8w6AQl
/iJoGAf9FQRdN5z13PVoWcgv/sZQqLDpv5MeRN0JyKIf3J4af4T+TgYpoJ2pjzEU
Fz9m5pSJCFoXp2ZQHhkVYu5bJ95gbNLf0m+LwSK/p/BVOVdbCMI6U+EwMGxFQf9a
05he/anVPdMLz+DJImv5W/znCn1zhVapO7EETjMq+mfCbEOu8gHhvvVDVL8tTNNe
zVgh4ytcI3dxkHaadKgenRaMTZ8UESqA1AgpvB/TkoDr3GdIWv+qPcrkZix7hpOo
Z+J6x0tqnvY1jm52mpV9HIJ7TKtzzLwHQdYfUGqiYdGDarEd3PmqvFRJ4QJP2kWo
JQgOodb2pTGbcPoarNhIaBiWFSC/3Q==
=MMgY
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

