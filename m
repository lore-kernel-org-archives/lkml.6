Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZplh282RAjVq998akWpiOuPx1RyJoeGm/oJ4GwKyyD85uHuk4Hyl9rUdWQbx3HoLgtFqJZu
ARC-Seal: i=1; a=rsa-sha256; t=1526356397; cv=none;
        d=google.com; s=arc-20160816;
        b=fuwxD/vWdzVt+DqMjJXU8mhr+26XiVH72k5IX3oGpe5m5lV5AqiDiTahjyOArZ3VbZ
         rxKrIPoWPfLolEXwKyalwPJT1lOJh86DmR3ays9bxRMsUO+XXoPcAD9uW/Sm/JoxKsBK
         NmnPo2RO2p8tS40bRkuftuUCQX5SjpRtNrAK7mP0cmaoT2/zf5IULXvbJ3k7IM896sUA
         KHzZIHok9PfQVlQGgrRc0qjNIlkzjsM2WOYXbM6IfaJ7f0o8tjlZQB/VGKqIFbXSuNQX
         zlp6MuEP592oUJc1ZuxC4OsL0Xsopkam/vuvXMeLdnPZ9NT2x7gukhW+6wlbQuIMyfzx
         ZWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=tLiZVH9SG+2MbSFavUzyx/RPSK1bqqk70O6XDWVj8hs=;
        b=NY4xiiSHbu8unXAGg5UfG0Im+bI7PNYK7hPKjUmF0/ZoUElbV7GZKmZdmjQfOvsDue
         NYQmYOSqhz21Idqy/8F2cb9GEsam/6nuuvtT25NcK3Du/SeB2u0mjVFLol+3m4L1kGQ5
         5vlFKlXXJyN26I6dUWL4snJ8Es4taFUBG2/is9PvgwNS5wztW0597+iSmA5ieREcRoXM
         xHOQWcN9FBNYINPaaAbyNRH/jighiHIborkdP5XEi6u4zYhPIivUWVwN3e6nyK4NgSJY
         i5qVNmjVSerQ2mKnblU50PVvpEjgTfKcnGmJy4/dnbzOACus/jDLYCd7LL+SYOXnYZuu
         8Q/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>, Oleg Drokin <oleg.drokin@intel.com>
Date: Tue, 15 May 2018 13:53:02 +1000
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>, Dmitry Eremin <dmitry.eremin@intel.com>, "John L. Hammond" <john.hammond@intel.com>, James Simmons <uja.ornl@yahoo.com>, James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH v2 1/5] staging: lustre: llite: add support set_acl method in inode operations
In-Reply-To: <1526350623-4616-2-git-send-email-jsimmons@infradead.org>
References: <1526350623-4616-1-git-send-email-jsimmons@infradead.org> <1526350623-4616-2-git-send-email-jsimmons@infradead.org>
Message-ID: <878t8l7ext.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600494636679443882?=
X-GMAIL-MSGID: =?utf-8?q?1600500685930940378?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, May 14 2018, James Simmons wrote:

> From: Dmitry Eremin <dmitry.eremin@intel.com>
>
> Linux kernel v3.14 adds set_acl method to inode operations.
> This patch adds support to Lustre for proper acl management.
>
> Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
> Signed-off-by: John L. Hammond <john.hammond@intel.com>
> Signed-off-by: James Simmons <uja.ornl@yahoo.com>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9183
> Reviewed-on: https://review.whamcloud.com/25965
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10541
> Reviewed-on: https://review.whamcloud.com/31588
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10926
> Reviewed-on: https://review.whamcloud.com/32045
> Reviewed-by: Bob Glossman <bob.glossman@intel.com>
> Reviewed-by: James Simmons <uja.ornl@yahoo.com>
> Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
> Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
> Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
> Signed-off-by: James Simmons <jsimmons@infradead.org>
> ---
> Changelog:
>
> v1) Initial patch ported to staging tree
> v2) Fixed up goto handling and avoid BUG() when calling
>     forget_cached_acl()with invalid type as pointed out by Dan Carpenter
>
>  drivers/staging/lustre/lustre/llite/file.c         | 62 ++++++++++++++++=
++++++
>  .../staging/lustre/lustre/llite/llite_internal.h   |  4 ++
>  drivers/staging/lustre/lustre/llite/namei.c        | 10 +++-
>  3 files changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/lustre/lustre/llite/file.c b/drivers/staging=
/lustre/lustre/llite/file.c
> index 0026fde..64a5698 100644
> --- a/drivers/staging/lustre/lustre/llite/file.c
> +++ b/drivers/staging/lustre/lustre/llite/file.c
> @@ -3030,6 +3030,7 @@ static int ll_fiemap(struct inode *inode, struct fi=
emap_extent_info *fieinfo,
>  	return rc;
>  }
>=20=20
> +#ifdef CONFIG_FS_POSIX_ACL

Using #ifdef in  .c files is generally discouraged.
The "standard" approach here is:
=2D put the acl code in a separate file (acl.c)
=2D optionally include it via the Make file
     lustre-$(CONFIG_FS_POSIX_ACL) +=3D acl.o

=2D in the header where ll_get_acl and ll_set_acl are declared have
 #ifdef CONFIG_FS_POSIX_ACL
   declare the functions
 #else
 #define ll_get_acl NULL
 #define ll_set_acl NULL
 #endif

Now as this is staging and that is (presumably) an upstream patch
lightly improved it is probably fine to include the patch as-is,
but in that case we will probably want to fix it up later.

Thanks,
NeilBrown

>  struct posix_acl *ll_get_acl(struct inode *inode, int type)
>  {
>  	struct ll_inode_info *lli =3D ll_i2info(inode);
> @@ -3043,6 +3044,64 @@ struct posix_acl *ll_get_acl(struct inode *inode, =
int type)
>  	return acl;
>  }
>=20=20
> +int ll_set_acl(struct inode *inode, struct posix_acl *acl, int type)
> +{
> +	struct ll_sb_info *sbi =3D ll_i2sbi(inode);
> +	struct ptlrpc_request *req =3D NULL;
> +	const char *name =3D NULL;
> +	size_t value_size =3D 0;
> +	char *value =3D NULL;
> +	int rc;
> +
> +	switch (type) {
> +	case ACL_TYPE_ACCESS:
> +		name =3D XATTR_NAME_POSIX_ACL_ACCESS;
> +		if (acl)
> +			rc =3D posix_acl_update_mode(inode, &inode->i_mode, &acl);
> +		break;
> +
> +	case ACL_TYPE_DEFAULT:
> +		name =3D XATTR_NAME_POSIX_ACL_DEFAULT;
> +		if (!S_ISDIR(inode->i_mode))
> +			rc =3D acl ? -EACCES : 0;
> +		break;
> +
> +	default:
> +		rc =3D -EINVAL;
> +		break;
> +	}
> +	if (rc)
> +		return rc;
> +
> +	if (acl) {
> +		value_size =3D posix_acl_xattr_size(acl->a_count);
> +		value =3D kmalloc(value_size, GFP_NOFS);
> +		if (!value) {
> +			rc =3D -ENOMEM;
> +			goto out;
> +		}
> +
> +		rc =3D posix_acl_to_xattr(&init_user_ns, acl, value, value_size);
> +		if (rc < 0)
> +			goto out_value;
> +	}
> +
> +	rc =3D md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode),
> +			 value ? OBD_MD_FLXATTR : OBD_MD_FLXATTRRM,
> +			 name, value, value_size, 0, 0, 0, &req);
> +
> +	ptlrpc_req_finished(req);
> +out_value:
> +	kfree(value);
> +out:
> +	if (rc)
> +		forget_cached_acl(inode, type);
> +	else
> +		set_cached_acl(inode, type, acl);
> +	return rc;
> +}
> +#endif /* CONFIG_FS_POSIX_ACL */
> +
>  int ll_inode_permission(struct inode *inode, int mask)
>  {
>  	struct ll_sb_info *sbi;
> @@ -3164,7 +3223,10 @@ int ll_inode_permission(struct inode *inode, int m=
ask)
>  	.permission	=3D ll_inode_permission,
>  	.listxattr	=3D ll_listxattr,
>  	.fiemap		=3D ll_fiemap,
> +#ifdef CONFIG_FS_POSIX_ACL
>  	.get_acl	=3D ll_get_acl,
> +	.set_acl	=3D ll_set_acl,
> +#endif
>  };
>=20=20
>  /* dynamic ioctl number support routines */
> diff --git a/drivers/staging/lustre/lustre/llite/llite_internal.h b/drive=
rs/staging/lustre/lustre/llite/llite_internal.h
> index 6504850..2280327 100644
> --- a/drivers/staging/lustre/lustre/llite/llite_internal.h
> +++ b/drivers/staging/lustre/lustre/llite/llite_internal.h
> @@ -754,7 +754,11 @@ enum ldlm_mode ll_take_md_lock(struct inode *inode, =
__u64 bits,
>  int ll_md_real_close(struct inode *inode, fmode_t fmode);
>  int ll_getattr(const struct path *path, struct kstat *stat,
>  	       u32 request_mask, unsigned int flags);
> +#ifdef CONFIG_FS_POSIX_ACL
>  struct posix_acl *ll_get_acl(struct inode *inode, int type);
> +int ll_set_acl(struct inode *inode, struct posix_acl *acl, int type);
> +#endif /* CONFIG_FS_POSIX_ACL */
> +
>  int ll_migrate(struct inode *parent, struct file *file, int mdtidx,
>  	       const char *name, int namelen);
>  int ll_get_fid_by_name(struct inode *parent, const char *name,
> diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/stagin=
g/lustre/lustre/llite/namei.c
> index 9ac7f09..b41f189 100644
> --- a/drivers/staging/lustre/lustre/llite/namei.c
> +++ b/drivers/staging/lustre/lustre/llite/namei.c
> @@ -1195,7 +1195,10 @@ static int ll_rename(struct inode *src, struct den=
try *src_dchild,
>  	.getattr	    =3D ll_getattr,
>  	.permission	 =3D ll_inode_permission,
>  	.listxattr	  =3D ll_listxattr,
> -	.get_acl	    =3D ll_get_acl,
> +#ifdef CONFIG_FS_POSIX_ACL
> +	.get_acl	=3D ll_get_acl,
> +	.set_acl	=3D ll_set_acl,
> +#endif
>  };
>=20=20
>  const struct inode_operations ll_special_inode_operations =3D {
> @@ -1203,5 +1206,8 @@ static int ll_rename(struct inode *src, struct dent=
ry *src_dchild,
>  	.getattr	=3D ll_getattr,
>  	.permission     =3D ll_inode_permission,
>  	.listxattr      =3D ll_listxattr,
> -	.get_acl	    =3D ll_get_acl,
> +#ifdef CONFIG_FS_POSIX_ACL
> +	.get_acl	=3D ll_get_acl,
> +	.set_acl	=3D ll_set_acl,
> +#endif
>  };
> --=20
> 1.8.3.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlr6WZ8ACgkQOeye3VZi
gbmzvQ/+ON7IEtnIV9NNNSIghmxznyHwNQX8LacHnpYqSMhYEmls+yGDyYCvXlYD
lgzLHAfUYzK9/lxy8kLabz3omTtOGZO8MV6mATtMU1E5GCDR4mmNMQBbn0GAlQGa
vuOWfXR/wARliahBETixNUaDfJMdlOTg/C/jCCwl4J6JykObi2DGa3FrwahXL2Bc
1Xg1RcwRGIAujexGjhhu7ntPZJapWLtcoUWpgRPCwqVFVeU/RVJ0+JHznCAYKp+M
SRut5vWkFuPCof9DKA+fKXWLDG6QCQxBwzL76Abbr7INzMbklgkk1DICCU81/Qho
Uw8ssIDt4UNCjSZ4StdIBLLnMnF4v/5UE7sf9hmzHqVjYp9C7swgv9l16j7yZefm
Ttt4V4zdxPZ3IUEfgUA6pTN6kAg8PyiRxasEk362nVwY+SVYwlTqESnPvtrqnX2+
ZpkORnDSv/d4buLsfBb9hbDkiRkwcHdqmQcrDYaKLMjcA3aoh0cWDjE+FmCFPBsu
N9VjGjrBDWmUSxpLC9iogYYp59N1u0Z+FV0i1RyyCMNqsuc5uxkTb+A7xWiyubDv
sDdpk8sOF6P+UwQTUyEoXyXYZiWVaBq/HWwmHLDgI/3dfTRz+uqt1p3rV3VoO/Vj
mKYNBUEg+isMGp1hbIRyG6tAcka7jK1D150WTVsy48bUG9LdVZg=
=to7S
-----END PGP SIGNATURE-----
--=-=-=--
