Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZoJrga5gUCsCe1c02KZqgGdRiKP8vaVlc/2QcHY+sH0UDkzaG7k5MwGLSHhm3Op6nNLuZF/
ARC-Seal: i=1; a=rsa-sha256; t=1525396538; cv=none;
        d=google.com; s=arc-20160816;
        b=dGK5bNWJr2tdCS0Kzo1ypnldh1DpICPTO3jO/S5ellQLttuU6ilpUe7jp7MJlhCKr6
         dgIZXP5VXKnQ6/RDgVxOOoifItfF7kG8gLes+ABEpexYsv9U342HufJMPjD/eyptBKYB
         q/Og0wmBl1tqJIhyHyv9YVhLQcKX8oCI1QGiSCX27xge17bT04e4kO6VD7ChFcko1zgo
         oPKfi7etjKvsa5opDwlGXk73IHYX4cDZCXm0HIoVhPmRKShqu5PM8TL/WgMU3VuXE0wC
         yhPv12bPycRWkTJtidhV0DG3NTEkzOS2mQQgpDluUZdnc5M/FmAGY4Pnimgw3LCZXHue
         3vfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=En7FB5riK/ZB+qja+u+Vs2whaWRqvrmLlVJpL50x1hY=;
        b=VKTMjtW9hWMlLg2I8NbP0MK/3OloXX0ytvRvC8adPBmZSTCrqwjqAMNKIH0X+WydVn
         Jny1Bz4g8f6zZyNpR7Pj5v1BqTgWHuOQcuR5m+SteigwdLQM7eEEKDa8BQ8F+RGn6MHk
         c3akRUkyi+DeH32AzDvs4zrJldGVqeIrQ9eS87C9GGCzBZjIXX4qjmn7v4mm8LOdLWSS
         hN9xt8spAFcLP7Vn9GekJ3Hl2gc3uaBsDfFmFTdQ/9Jn10spYAEniFQ9dCdHBFXs4jWb
         yL8trW9S+x0cQy2oxSGXUTyjZBwhkR7iP955W5iKVLFODunkPV/YI/urHLT/10bpg1J4
         XbJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>, Oleg Drokin <oleg.drokin@intel.com>, Lai Siyao <lai.siyao@intel.com>, Jinshan Xiong <jinshan.xiong@intel.com>
Date: Fri, 04 May 2018 11:15:27 +1000
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>, James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 4/4] staging: lustre: obdclass: change object lookup to no wait mode
In-Reply-To: <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org> <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
Message-ID: <876044fcgg.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599377578642480087?=
X-GMAIL-MSGID: =?utf-8?q?1599494200138601224?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, May 02 2018, James Simmons wrote:

> From: Lai Siyao <lai.siyao@intel.com>
>
> Currently we set LU_OBJECT_HEARD_BANSHEE on object when we want
> to remove object from cache, but this may lead to deadlock, because
> when other process lookup such object, it needs to wait for this
> object until release (done at last refcount put), while that process
> maybe already hold an LDLM lock.
>
> Now that current code can handle dying object correctly, we can just
> return such object in lookup, thus the above deadlock can be avoided.

I think one of the reasons that I didn't apply this to mainline myself
is that "Now that" comment.  When is the "now" that it is referring to?
Are were sure that all code in mainline "can handle dying objects
correctly"??


>
> Signed-off-by: Lai Siyao <lai.siyao@intel.com>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9049
> Reviewed-on: https://review.whamcloud.com/26965
> Reviewed-by: Alex Zhuravlev <alexey.zhuravlev@intel.com>
> Tested-by: Cliff White <cliff.white@intel.com>
> Reviewed-by: Fan Yong <fan.yong@intel.com>
> Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
> Signed-off-by: James Simmons <jsimmons@infradead.org>
> ---
>  drivers/staging/lustre/lustre/include/lu_object.h  |  2 +-
>  drivers/staging/lustre/lustre/obdclass/lu_object.c | 82 +++++++++-------=
------
>  2 files changed, 36 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/staging/lustre/lustre/include/lu_object.h b/drivers/=
staging/lustre/lustre/include/lu_object.h
> index f29bbca..232063a 100644
> --- a/drivers/staging/lustre/lustre/include/lu_object.h
> +++ b/drivers/staging/lustre/lustre/include/lu_object.h
> @@ -673,7 +673,7 @@ static inline void lu_object_get(struct lu_object *o)
>  }
>=20=20
>  /**
> - * Return true of object will not be cached after last reference to it is
> + * Return true if object will not be cached after last reference to it is
>   * released.
>   */
>  static inline int lu_object_is_dying(const struct lu_object_header *h)
> diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers=
/staging/lustre/lustre/obdclass/lu_object.c
> index 8b507f1..9311703 100644
> --- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
> +++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
> @@ -589,19 +589,13 @@ static struct lu_object *htable_lookup(struct lu_si=
te *s,
>  				       const struct lu_fid *f,
>  				       __u64 *version)
>  {
> -	struct cfs_hash		*hs =3D s->ls_obj_hash;
>  	struct lu_site_bkt_data *bkt;
>  	struct lu_object_header *h;
>  	struct hlist_node	*hnode;
> -	__u64 ver;
> -	wait_queue_entry_t waiter;
> +	u64 ver =3D cfs_hash_bd_version_get(bd);
>=20=20
> -retry:
> -	ver =3D cfs_hash_bd_version_get(bd);
> -
> -	if (*version =3D=3D ver) {
> +	if (*version =3D=3D ver)
>  		return ERR_PTR(-ENOENT);
> -	}
>=20=20
>  	*version =3D ver;
>  	bkt =3D cfs_hash_bd_extra_get(s->ls_obj_hash, bd);
> @@ -615,31 +609,13 @@ static struct lu_object *htable_lookup(struct lu_si=
te *s,
>  	}
>=20=20
>  	h =3D container_of(hnode, struct lu_object_header, loh_hash);
> -	if (likely(!lu_object_is_dying(h))) {
> -		cfs_hash_get(s->ls_obj_hash, hnode);
> -		lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_HIT);
> -		if (!list_empty(&h->loh_lru)) {
> -			list_del_init(&h->loh_lru);
> -			percpu_counter_dec(&s->ls_lru_len_counter);
> -		}
> -		return lu_object_top(h);
> +	cfs_hash_get(s->ls_obj_hash, hnode);
> +	lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_HIT);
> +	if (!list_empty(&h->loh_lru)) {
> +		list_del_init(&h->loh_lru);
> +		percpu_counter_dec(&s->ls_lru_len_counter);
>  	}
> -
> -	/*
> -	 * Lookup found an object being destroyed this object cannot be
> -	 * returned (to assure that references to dying objects are eventually
> -	 * drained), and moreover, lookup has to wait until object is freed.
> -	 */
> -
> -	init_waitqueue_entry(&waiter, current);
> -	add_wait_queue(&bkt->lsb_marche_funebre, &waiter);
> -	set_current_state(TASK_UNINTERRUPTIBLE);
> -	lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_DEATH_RACE);
> -	cfs_hash_bd_unlock(hs, bd, 1);
> -	schedule();
> -	remove_wait_queue(&bkt->lsb_marche_funebre, &waiter);
> -	cfs_hash_bd_lock(hs, bd, 1);
> -	goto retry;
> +	return lu_object_top(h);
>  }
>=20=20
>  /**
> @@ -680,6 +656,8 @@ static void lu_object_limit(const struct lu_env *env,=
 struct lu_device *dev)
>  }
>=20=20
>  /**
> + * Core logic of lu_object_find*() functions.
> + *
>   * Much like lu_object_find(), but top level device of object is specifi=
cally
>   * \a dev rather than top level device of the site. This interface allows
>   * objects of different "stacking" to be created within the same site.
> @@ -713,36 +691,46 @@ struct lu_object *lu_object_find_at(const struct lu=
_env *env,
>  	 * It is unnecessary to perform lookup-alloc-lookup-insert, instead,
>  	 * just alloc and insert directly.
>  	 *
> +	 * If dying object is found during index search, add @waiter to the
> +	 * site wait-queue and return ERR_PTR(-EAGAIN).

It seems odd to add this comment here, when it seems to describe code
that is being removed.
I can see that this comment is added by the upstream patch
Commit: fa14bdf6b648 ("LU-9049 obdclass: change object lookup to no wait mo=
de")
but I cannot see what it refers to.

Otherwise that patch looks good.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrrtDAACgkQOeye3VZi
gbnAwg//RI2S/96ieXXyccQfphIHk+d9BM5I1nL8oNns7/9OmfY+8tJt2TPqzz20
qIbVqUBpV6EIuO38VJhSrAIdsRyT/xxW3lTpjRmzzEi6QFV1TyYoNduO3YJjHha6
CKNyGMg79unlETHwTGTVcjRH9FwVRb6XJ/7H70C17QaolNjQ4du5iaHxym0KVEDe
cH4+QTQgZnhAbsB2F1RanilP7UkIkPcpS3tA6+bCIPdIp+oKLQ1HwlI4nhY2yxjZ
bi/t6670HVEMf0dvfGW5za525vnz27P1elIMuqMd4I7CvrXsh+VH2Hhp3Z+iOAdp
558VwWIVpqQ5Wx7uOrtLzCR5m6lKwv+kBMORNvujkyrER3Of9M8mpub0/4a4ewC4
hxTaf+eM55A4xe1O1Mht3EkKQ+AVO9FTHHflrh8vmhMwAHL5CEy260qQWVTYV6f+
dvw1WWmN2C813pR561vJZfhwdjpxX/UYePKKMdcvXKF+Lq949v4G0MwCLMVm9rKv
eWW7CBwIU4DViddTkuV0/QKO5XjsygbC/d/Movu4HBZ1XOgy7WqBkKBIoVfxJ2/i
gmya7AF68pGxPXF1UF2VrgjFNMcvATlzakrnPhe0LWbGwOxeZPFKn2ey0MNfWaS6
iaCqBT3xsWODHzQKycHq5idJyDzSlAbbP79IrYoAD3aTZYQoFT8=
=s97p
-----END PGP SIGNATURE-----
--=-=-=--
