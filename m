Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeEBWnG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 18:43:06 -0400
Received: from ozlabs.org ([203.11.71.1]:52605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeEBWnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 18:43:04 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 3 May 2018 08:42:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.cz>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [GIT PULL] f2fs update for 4.16-rc1
Message-ID: <20180503084259.4a3b68d6@canb.auug.org.au>
In-Reply-To: <20180403122919.3c503f74@canb.auug.org.au>
References: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
        <20180131095446.443670dc@canb.auug.org.au>
        <20180131002535.GD65489@jaegeuk-macbookpro.roam.corp.google.com>
        <20180201092551.759f32be@canb.auug.org.au>
        <20180314101704.51aaae7f@canb.auug.org.au>
        <20180403122919.3c503f74@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7+40bYuH5+CYHEyO95xgo8Q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7+40bYuH5+CYHEyO95xgo8Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 3 Apr 2018 12:29:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Ping?

Ping again ...

So has Chris gone missing?  Or should I just remove the btrfs tree from lin=
ux-next?

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

--=20
Cheers,
Stephen Rothwell

--Sig_/7+40bYuH5+CYHEyO95xgo8Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrqPvMACgkQAVBC80lX
0GxjoQf+MeuX0QO+mI86DcxIhpdGLS6nvAV882StMQ0mGP2vZ+zzudvCLtju3TNJ
dIbPD7zQhxFERyK1HcU7a5lAyJswg61hdVe3obdic6dTAPUPFdF+Hq8Bmm6Xud/W
ugpd81hybHGcEMTxDNMVIcWI6AInm4EwBlcn9MirRwiu/BzX82AeYYv5Jq/qEb4V
9AJtaElDFoFyq9vpq8V+4lAU57gOhpVvBES/HULsgCon3Mgww0t0+M6mV/msOzMA
Wzt1R3RIw2xTQik5xkZPF/sJkl7Jtf3MA6rpchuby8YGOcfvrnzshT3R9J4O7UeJ
8c5sspDXRJSscBSl8pT6dC1A22bRVw==
=HAdm
-----END PGP SIGNATURE-----

--Sig_/7+40bYuH5+CYHEyO95xgo8Q--
