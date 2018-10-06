Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_SPAM,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AC8C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 08:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B01E21473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 08:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kd8no3LA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B01E21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeJFPkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 11:40:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40233 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeJFPkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 11:40:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id z204-v6so3873314wmc.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F23FbKDxtERZJqloGXLzSJPaSQBEf72fkrvzUz01Drw=;
        b=Kd8no3LAI+9EbgMRFSRjWkBaWi6ryiZfJeha281wsoiw1P5gNjZ5fn0csc6h1y3Xjh
         UF3PplpeZkOeYwHgz/IeTolYIpuYszqWDvtOVz6Ubnd78YpXkX9mkYczmajT98bfTiTD
         DzFjZD/8A0+wEg+guXCNJWgwHZciByNEJWLLg/yxhPZEqHR2oC3gVhoiREeU3A/RfQDN
         JK7ID/g6CnzLC+jwpfj4isWAnhhDA4cX13KqJFOM1E1b7yDLSKJtbs3rvEl/Agpbmdvz
         glhV4Qz0keJG/j60xVHjxGijaFyu/6Vwh7cSkb4AgjD5FbO7+uUH4aeqAUlyeXacenWO
         SObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F23FbKDxtERZJqloGXLzSJPaSQBEf72fkrvzUz01Drw=;
        b=ZQkQ0EfqqfO0LMYhWhjRkG9Q/wzanb84Q93/8hGbEe7Slu2zV1E+STxzzsEld9pFNA
         ax3JtzPhyfWqGVMLQljfHZFW8kOha6jX1KbAels5r1NDTeFmzvcmKwY4WUH71pToEzt7
         dsBzCaH2HLXar/5r0NsT7ogr+vtQ3xesr/scrRicyDuUkufmwmACqZmwzn4rKvhyq+gs
         2nrHRK4OcQL6KwHukplt2jrtIyww705OohCZF4cNNxgXnUHeT7iInqFcQu0TcZXTrCTY
         R6GvdMHcZzu14Ld4PUIBG/E0EKEDhrSfWpXO/IfwaUOfSvV4+1wplTbAajg9K8JEAWJk
         Uiyw==
X-Gm-Message-State: ABuFfogNj3iQnSz8JOoBRgFIeNxgqZRZowLaGZf+JG7v1UK8TEVkCIGw
        xM2zaJf9pFZ+QCYxC2if9Rw=
X-Google-Smtp-Source: ACcGV6109xGviIlMsQR7taRoTWHAeK0NkA0VHqYFSN+zv8XjuGNQVigY2m8roUbrGkfqIFC1DToBTQ==
X-Received: by 2002:a1c:3383:: with SMTP id z125-v6mr9914518wmz.56.1538815070273;
        Sat, 06 Oct 2018 01:37:50 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c8-v6sm13843870wrb.6.2018.10.06.01.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 01:37:49 -0700 (PDT)
Date:   Sat, 6 Oct 2018 10:37:48 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     "chen.chenchacha" <chen.chenchacha@qq.com>
Cc:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH 1/2] Add FAT_IOCTL_GET_VOLUME_LABEL in fat_generic_ioctl()
Message-ID: <20181006083748.h34r65j4drwri3vg@pali>
References: <20181004172101.15525-1-chen.chenchacha@foxmail.com>
 <20181004172101.15525-2-chen.chenchacha@foxmail.com>
 <20181004173347.kmymtmiilo7lrxmy@pali>
 <5bb8734a.1c69fb81.9fdf4.0461SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5w7jon3zpbgs7tuj"
Content-Disposition: inline
In-Reply-To: <5bb8734a.1c69fb81.9fdf4.0461SMTPIN_ADDED_BROKEN@mx.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5w7jon3zpbgs7tuj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 06 October 2018 16:33:10 chen.chenchacha wrote:
> On Thu, 2018-10-04 at 19:33 +0200, Pali Roh=C3=A1r wrote:
> > On Friday 05 October 2018 01:21:00 chenchacha wrote:
> > > Signed-off-by: chenchacha <chen.chenchacha@foxmail.com>
> > > ---
> > >  fs/fat/file.c                 | 22 ++++++++++++++++++++++
> > >  include/uapi/linux/msdos_fs.h |  1 +
> > >  2 files changed, 23 insertions(+)
> > >=20
> > > diff --git a/fs/fat/file.c b/fs/fat/file.c
> > > index 4724cc9ad650..56db0b5a8df1 100644
> > > --- a/fs/fat/file.c
> > > +++ b/fs/fat/file.c
> > > @@ -121,10 +121,30 @@ static int fat_ioctl_get_volume_id(struct
> > > inode *inode, u32 __user *user_attr)
> > >  	return put_user(sbi->vol_id, user_attr);
> > >  }
> > > =20
> > > +static int fat_ioctl_get_volume_label(struct inode *inode, u8
> > > __user *label)
> > > +{
> > > +	struct super_block *sb =3D inode->i_sb;
> > > +	struct inode *root_inode =3D d_inode(sb->s_root);
> > > +	struct buffer_head *bh =3D NULL;
> > > +	struct msdos_dir_entry *de;
> > > +	int err;
> > > +
> > > +	inode_lock_shared(root_inode);
> > > +	err =3D fat_get_root_entry(root_inode, &bh, &de);
> > > +	if (err =3D=3D 0) {
> > > +		if (copy_to_user(label, de->name, MSDOS_NAME))
> >=20
> > You need to convert entry name from 8.3 format to label in correct
> > encoding specified by codepage mount option. Plus needs to handle
> > leading 0x03 byte.
> >=20
> I think it might be better to put the decoder/encoder on the
> application layter.

I do not think so. On all other places in msdos.ko and vfat.ko driver
which communicate with userspace is that decoder/encoder active and user
does not see raw bytes.

It is really bad to mix encodings and API of different calls.

If in mount option I specified that I want to use XYZ encoding, why
driver does not going to respect it?

> Similarly, the handle leading 0x03 byte is in the
> write function. And make read operation pure, just to carry the volume
> label in root directory to the user.
>=20
> What do you think, Pali?
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--5w7jon3zpbgs7tuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCW7h0WgAKCRCL8Mk9A+RD
UtiRAJ0fh6+stHMXX1RVRd40qxet0DDGBwCeLXwbZkbEY/AVCi1Ew32O8p+yjh8=
=emA7
-----END PGP SIGNATURE-----

--5w7jon3zpbgs7tuj--
