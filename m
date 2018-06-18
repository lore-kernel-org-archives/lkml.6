Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B087AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CF3208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EexptU5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CF3208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932475AbeFRDiX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 23:38:23 -0400
Received: from ozlabs.org ([203.11.71.1]:41875 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754550AbeFRDiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 23:38:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418Gyf0fPFz9s0W;
        Mon, 18 Jun 2018 13:38:18 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529293099;
        bh=Sh0OH+G7x96aXb5dZC8pV/Rf4kXVzlLHmZ9RnHL/RFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EexptU5i7hNOObWitlvlBXOWp+5hrOp8Pgh3MuWtNet6+C9f5RHAaI0tfciuQPSds
         y6/pqF2hhMRxeRPTopnwVR3zfyem3NOlQVWFQM7SECdCGY80Qx5Xqt7XEvxmtY4Sm2
         2daAeZkt5PRHRD8EqggAgHknhkBunNF+lycKVEqRqjhWUyuBD7Qf+fgIEzr+BV92t5
         RcjLWYR/m5LuYBNGvZt90iNcuFvYVIfX1O/hg9OHyjEdNHZQDi95eYs2Nb9nmSv8EB
         MGb4Y/u4Pae/tvXURBKvyKArc5kNKVHkbnBmhoCB0R+M3iSpjTwaQ0ebtknRnxYE7O
         T2FBJtIr5henA==
Date:   Mon, 18 Jun 2018 13:38:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>, Tejun Heo <tj@kernel.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [GIT PULL] f2fs update for 4.16-rc1
Message-ID: <20180618133817.6faba27e@canb.auug.org.au>
In-Reply-To: <20180403122919.3c503f74@canb.auug.org.au>
References: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
        <20180131095446.443670dc@canb.auug.org.au>
        <20180131002535.GD65489@jaegeuk-macbookpro.roam.corp.google.com>
        <20180201092551.759f32be@canb.auug.org.au>
        <20180314101704.51aaae7f@canb.auug.org.au>
        <20180403122919.3c503f74@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lqihSEbz3Vi4iT6k5.T6NlI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lqihSEbz3Vi4iT6k5.T6NlI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Tue, 3 Apr 2018 12:29:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Ping?
>=20
> On Wed, 14 Mar 2018 10:17:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Thu, 1 Feb 2018 09:25:51 +1100 Stephen Rothwell <sfr@canb.auug.org.a=
u> wrote: =20
> > >
> > > On Tue, 30 Jan 2018 16:25:35 -0800 Jaegeuk Kim <jaegeuk@kernel.org> w=
rote:   =20
> > > >
> > > > On 01/31, Stephen Rothwell wrote:     =20
> > > > >=20
> > > > > On Tue, 30 Jan 2018 14:32:20 -0800 Jaegeuk Kim <jaegeuk@kernel.or=
g> wrote:       =20
> > > > > >
> > > > > > Could you please consider the below pull request?
> > > > > >=20
> > > > > > Thanks,
> > > > > >=20
> > > > > > The following changes since commit ace52288edf0cb5e7a52b681f057=
f86224c49c27:
> > > > > >=20
> > > > > >   Merge tag 'for-linus-20171218' of git://git.infradead.org/lin=
ux-mtd (2017-12-18 16:18:01 -0800)
> > > > > >=20
> > > > > > are available in the Git repository at:
> > > > > >=20
> > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.gi=
t tags/f2fs-for-4.16-rc1
> > > > > >=20
> > > > > > for you to fetch changes up to 1c1d35df71104c76a4a2e25862926f22=
c334c9d6:
> > > > > >=20
> > > > > >   f2fs: support inode creation time (2018-01-25 14:10:39 -0800)=
       =20
> > > > >=20
> > > > > This has an interesting conflict with the btrfs tree:
> > > > >=20
> > > > > -----------------------------------------------------------------=
------
> > > > > After merging the f2fs tree, today's linux-next build (x86_64
> > > > > allmodconfig) failed like this:
> > > > >=20
> > > > > /home/sfr/next/next/fs/f2fs/super.c: In function 'f2fs_fill_super=
':
> > > > > /home/sfr/next/next/fs/f2fs/super.c:2563:18: error: 'SB_I_CGROUPW=
B' undeclared (first use in this function); did you mean 'S_CGROUPWB'?
> > > > >   sb->s_iflags |=3D SB_I_CGROUPWB;
> > > > >                   ^~~~~~~~~~~~~
> > > > >                   S_CGROUPWB
> > > > >=20
> > > > > Caused by commit
> > > > >=20
> > > > >   578c647879f7 ("f2fs: implement cgroup writeback support")
> > > > >=20
> > > > > interacting with commit
> > > > >=20
> > > > >   34934189a3dd ("cgroup, writeback: replace SB_I_CGROUPWB with pe=
r-inode S_CGROUPWB"
> > > > >=20
> > > > > from the btrfs tree.
> > > > >=20
> > > > > I have reverted the f2fs tree commit for today, but a better reso=
lution
> > > > > would be appreciated.
> > > > > -----------------------------------------------------------------=
------
> > > > >=20
> > > > > I have seen no response to the above email and have been revertin=
g that
> > > > > commit since Jan 18.       =20
> > > >=20
> > > > I think this can be addressed by:
> > > >=20
> > > > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > > > index 89c838bfb067..c743b73976d0 100644
> > > > --- a/fs/f2fs/inode.c
> > > > +++ b/fs/f2fs/inode.c
> > > > @@ -48,9 +48,10 @@ void f2fs_set_inode_flags(struct inode *inode)
> > > >                 new_fl |=3D S_DIRSYNC;
> > > >         if (f2fs_encrypted_inode(inode))
> > > >                 new_fl |=3D S_ENCRYPTED;
> > > > +       new_fl |=3D S_CGROUPWB;
> > > >         inode_set_flags(inode, new_fl,
> > > >                         S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIR=
SYNC|
> > > > -                       S_ENCRYPTED);
> > > > +                       S_ENCRYPTED|S_CGROUPWB);
> > > >  }
> > > >=20
> > > >  static void __get_inode_rdev(struct inode *inode, struct f2fs_inod=
e *ri)
> > > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > > index 8173ae688814..ebcd58476fc7 100644
> > > > --- a/fs/f2fs/super.c
> > > > +++ b/fs/f2fs/super.c
> > > > @@ -2560,7 +2560,6 @@ static int f2fs_fill_super(struct super_block=
 *sb, void *data, int silent)
> > > >         sb->s_flags =3D (sb->s_flags & ~SB_POSIXACL) |
> > > >                 (test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
> > > >         memcpy(&sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid=
));
> > > > -       sb->s_iflags |=3D SB_I_CGROUPWB;
> > > >=20
> > > >         /* init f2fs-specific super block info */
> > > >         sbi->valid_super_block =3D valid_super_block;
> > > >      =20
> > >=20
> > > I have applied that (by hand) as a merge fix patch for the merge of t=
eh
> > > btrfs tree for today.  Thanks for the resolution.   =20
> >=20
> > I am still applying this to the merge of the btrfs tree every day ...
> >=20
> > Commit
> >   578c647879f7 ("f2fs: implement cgroup writeback support")
> > was merged into Linus' tree on Jan 31.
> >=20
> > Here is the actual merge fix patch:
> >=20
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Thu, 1 Feb 2018 09:21:06 +1100
> > Subject: [PATCH] f2fs: fixup for cgroup/writeback change
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  fs/f2fs/inode.c | 3 ++-
> >  fs/f2fs/super.c | 1 -
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 205add3d0f3a..f34652c4288f 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -48,9 +48,10 @@ void f2fs_set_inode_flags(struct inode *inode)
> >  		new_fl |=3D S_DIRSYNC;
> >  	if (f2fs_encrypted_inode(inode))
> >  		new_fl |=3D S_ENCRYPTED;
> > +	new_fl |=3D S_CGROUPWB;
> >  	inode_set_flags(inode, new_fl,
> >  			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|
> > -			S_ENCRYPTED);
> > +			S_ENCRYPTED|S_CGROUPWB);
> >  }
> > =20
> >  static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *r=
i)
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 8173ae688814..ebcd58476fc7 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -2560,7 +2560,6 @@ static int f2fs_fill_super(struct super_block *sb=
, void *data, int silent)
> >  	sb->s_flags =3D (sb->s_flags & ~SB_POSIXACL) |
> >  		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
> >  	memcpy(&sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
> > -	sb->s_iflags |=3D SB_I_CGROUPWB;
> > =20
> >  	/* init f2fs-specific super block info */
> >  	sbi->valid_super_block =3D valid_super_block;
> > --=20
> > 2.15.1 =20

Another merge window has passed and I am still holding this tree and its
merge fixes ...  Tomorrow I will drop the btrfs tree and rename the
btrfs-kdave tree to btrfs.  OK?
--=20
Cheers,
Stephen Rothwell

--Sig_/lqihSEbz3Vi4iT6k5.T6NlI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsnKSkACgkQAVBC80lX
0Gz2pQf8CwiIWv1DfNT94kiVhiQAKEcxxiHgC8sB9O+N7PVUsejdk+xZOLLG8Lb1
uy8+Hbx7U3VmayvSt1DIoFw9WvuImgLsyFFMt4/EXEeY0Dfwx45IfULB7fUozIL6
aYSLqJKv6MgpUTkUzSHY3BCRk5IpQ/YCWtUMf9pKQpGHdtVCwaiuFn22CwkTmcgy
f5U/OPt3KdfJdLxBrWcEswOYpNN+eAlXSgylxfxCy2XLei0TqpALGHaKGOk6KOIm
OOVB3KvO/z/Lj//jghz66H/FcFCtjgh+xLFlhO+v4HKudOwUR+gDT5wiA3Ftw/lQ
NbpSXnxvCx3MqDQMuefSh6gtsGzBIg==
=yEb9
-----END PGP SIGNATURE-----

--Sig_/lqihSEbz3Vi4iT6k5.T6NlI--
