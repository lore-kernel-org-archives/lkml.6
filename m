Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pPpWF1twGlsRNAAAmS7hNA
	; Fri, 08 Jun 2018 12:02:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 502D6608B8; Fri,  8 Jun 2018 12:02:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 72C60607DC;
	Fri,  8 Jun 2018 12:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72C60607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeFHMCb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:02:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45169 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751220AbeFHMC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:02:27 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fRG64-0006TK-8k; Fri, 08 Jun 2018 13:02:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fRG5y-0001r0-CU; Fri, 08 Jun 2018 13:02:18 +0100
Message-ID: <6f16f7d9215d26fa11394a5fbdc016922a50d451.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 315/410] btrfs: use proper endianness accessors for
 super_copy
From: Ben Hutchings <ben@decadent.org.uk>
To: Anand Jain <anand.jain@oracle.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>
Date: Fri, 08 Jun 2018 13:02:13 +0100
In-Reply-To: <452bdbb9-5785-3f1f-59aa-c59024716d80@oracle.com>
References: <lsq.1528380321.739649291@decadent.org.uk>
         <452bdbb9-5785-3f1f-59aa-c59024716d80@oracle.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-hrO3RKSBQuG6jmo2sCsy"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hrO3RKSBQuG6jmo2sCsy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-08 at 04:02 +0800, Anand Jain wrote:
> Hi Ben,
>=20
>   This patch was reverted from the mainline and 4.14 stable as it only
>   added half of the endianness conversion and caused regression. This
>   patch should not be included.

Oh yes, sorry I didn't spot that.  I'll drop it.

Ben.

> On 06/07/2018 10:05 PM, Ben Hutchings wrote:
> > 3.16.57-rc1 review patch.  If anyone has any objections, please let me =
know.
> >=20
> > ------------------
> >=20
> > From: Anand Jain <anand.jain@oracle.com>
> >=20
> > commit 3c181c12c431fe33b669410d663beb9cceefcd1b upstream.
> >=20
> > The fs_info::super_copy is a byte copy of the on-disk structure and all
> > members must use the accessor macros/functions to obtain the right
> > value.  This was missing in update_super_roots and in sysfs readers.
> >=20
> > Moving between opposite endianness hosts will report bogus numbers in
> > sysfs, and mount may fail as the root will not be restored correctly. I=
f
> > the filesystem is always used on a same endian host, this will not be a
> > problem.
> >=20
> > Fix this by using the btrfs_set_super...() functions to set
> > fs_info::super_copy values, and for the sysfs, use the cached
> > fs_info::nodesize/sectorsize values.
> >=20
> > Fixes: df93589a17378 ("btrfs: export more from FS_INFO to sysfs")
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
> > Reviewed-by: David Sterba <dsterba@suse.com>
> > [ update changelog ]
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > [bwh: Backported to 3.16:
> >   - btrfs_fs_info doesn't have cached nodesize or sectorsize fields, so=
 use
> >     the accessor functions
> >   - Adjust context]
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -406,7 +406,7 @@ static ssize_t btrfs_nodesize_show(struc
> >   {
> >   	struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
> >  =20
> > -	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->nodesize=
);
> > +	return snprintf(buf, PAGE_SIZE, "%u\n", btrfs_super_nodesize(fs_info-=
>super_copy));
> >   }
> >  =20
> >   BTRFS_ATTR_RW(nodesize, 0444, btrfs_nodesize_show, btrfs_no_store);
> > @@ -416,7 +416,7 @@ static ssize_t btrfs_sectorsize_show(str
> >   {
> >   	struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
> >  =20
> > -	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->sectorsi=
ze);
> > +	return snprintf(buf, PAGE_SIZE, "%u\n", btrfs_super_sectorsize(fs_inf=
o->super_copy));
> >   }
> >  =20
> >   BTRFS_ATTR_RW(sectorsize, 0444, btrfs_sectorsize_show, btrfs_no_store=
);
> > @@ -426,7 +426,7 @@ static ssize_t btrfs_clone_alignment_sho
> >   {
> >   	struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
> >  =20
> > -	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->sectorsi=
ze);
> > +	return snprintf(buf, PAGE_SIZE, "%u\n", btrfs_super_sectorsize(fs_inf=
o->super_copy));
> >   }
> >  =20
> >   BTRFS_ATTR_RW(clone_alignment, 0444, btrfs_clone_alignment_show, btrf=
s_no_store);
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -1428,19 +1428,23 @@ static void update_super_roots(struct bt
> >  =20
> >   	super =3D root->fs_info->super_copy;
> >  =20
> > +	/* update latest btrfs_super_block::chunk_root refs */
> >   	root_item =3D &root->fs_info->chunk_root->root_item;
> > -	super->chunk_root =3D root_item->bytenr;
> > -	super->chunk_root_generation =3D root_item->generation;
> > -	super->chunk_root_level =3D root_item->level;
> > +	btrfs_set_super_chunk_root(super, root_item->bytenr);
> > +	btrfs_set_super_chunk_root_generation(super, root_item->generation);
> > +	btrfs_set_super_chunk_root_level(super, root_item->level);
> >  =20
> > +	/* update latest btrfs_super_block::root refs */
> >   	root_item =3D &root->fs_info->tree_root->root_item;
> > -	super->root =3D root_item->bytenr;
> > -	super->generation =3D root_item->generation;
> > -	super->root_level =3D root_item->level;
> > +	btrfs_set_super_root(super, root_item->bytenr);
> > +	btrfs_set_super_generation(super, root_item->generation);
> > +	btrfs_set_super_root_level(super, root_item->level);
> > +
> >   	if (btrfs_test_opt(root, SPACE_CACHE))
> > -		super->cache_generation =3D root_item->generation;
> > +		btrfs_set_super_cache_generation(super, root_item->generation);
> >   	if (root->fs_info->update_uuid_tree_gen)
> > -		super->uuid_tree_generation =3D root_item->generation;
> > +		btrfs_set_super_uuid_tree_generation(super,
> > +						     root_item->generation);
> >   }
> >  =20
> >   int btrfs_transaction_in_commit(struct btrfs_fs_info *info)
> >=20
--=20
Ben Hutchings
When in doubt, use brute force. - Ken Thompson


--=-hrO3RKSBQuG6jmo2sCsy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlsacEUACgkQ57/I7JWG
EQlEvBAA1QEZ10QUWSIlIsRwXLlwmmufhZk2DSGhsEowbIh9ZE5bTPvcujzfcvlB
dnde+VQx0QPm43SPL3tLvrZHvkAPkOEpSftuy4pf0SZWl4HaTg7jfkxzUN50vkB3
k7iYBardu1acltkBbz8cdUwNJHc971fhGDb9z8GK3r9BOyvLfjOEMeHg50v9yfsR
57T+7ThxRSLHKlbABYWpRtk7EAnRD6EPvV+U9HnJFGshy1/hmJo4501N5bVVL7hV
9HCpWOp2XwSS4LalzRvJdlbRj+tNa0xWzPvitBiBb0AyYpvF44O6gYqSnXfCeTjN
CnChxcipoqaPuD1z0Li/3Q+ch+6JnAQmHjU7wH0BMZt/cltaz6rUJSgled0TNOey
UkJ2QenPcAZsTIW3LcV/fk419RnFoEwFcpqLzA1AOcdJ7VMK3aiSzGxj9xwaqsvX
33pCdE9DX2wl+6qGnURPNeQCCQcVkyQ2lQ7SMBlnbA3nYwpZD9af+YUdmWnrF/DV
GR1VE0mYR08qHiFfYfgNRssnsWk0ghmIkmgdF3bkYKdVq+Qkx/6QUhY3S7w0BPbP
s6OLhKGl/05ycoUqaBO96iVGaHqdFGElTPizMcv2jBdKxJEBm7fqMrzErPHY6Foi
ZFXKR+NRpxBG667dShnB4v8R7bqQFDahoQLrEw+W1C6JgoGdhR4=
=4aJ2
-----END PGP SIGNATURE-----

--=-hrO3RKSBQuG6jmo2sCsy--
