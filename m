Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AB8JxZoOGqgDv4aZZZP2soHDfVgqWYke7Iba9eoiE7LRYtXEa20JQIK7hKLHclXHI7NmVSMjRR3z
ARC-Seal: i=1; a=rsa-sha256; t=1525147806; cv=none;
        d=google.com; s=arc-20160816;
        b=WrB4N7tD0GWiMUzItiQi9bjNn9EMW9GCk+iuBKryPN9FBB+ymV1/DdNWXgz/310q3i
         xJbtgpern39qafdTzdMMP+slDA64JOMsjkjEMoJNtKHjAXp3ZdYwVmYH8thrValUduY4
         hMLXVqOWaqY9byxhzdeNznK2x4Bb2rlNsNMVV+frZ0x+mDy64SHZMlvfxMo4ja/QKlzF
         KwxmyZe9hNQKLVMt2y4rNygNUW7sAcHOcDFcAb/7wD5SCVBYo1v2eagCC85iAUrOmgVh
         tAqPLlaZoRIMYgAQJ4pIhU4olU+X4XQ4USFXHGvuEBhcJduPel8H/EYPMIPu1YPD99en
         nKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=8m0CJioZw72kGgtFcZ6Q1QIC/Vij8ySW8Vh1IFvkdxs=;
        b=PEScH0hE0qrE/qwJRMa7JPYCuQ9u7sZJDiLL2STR5mIYJNgnnXU1quJR5O23ky7azf
         Dj5TVqokOEkOp9/xm5Tguq11JA0PPWbDOVU5NfziWWi+e7JsZIoBaQaLizwJEqtu1aL1
         IK7VW9V0HqL5gJbPylUkJXkwWygjiwInajSFJhCYmjp+dSfZT9tpOOlOlc6Ieg4MfRjs
         kha+dBeWhWXB+cFJgqPte5xc54Sh+TM3HfziEAdkr3uSNeZ2PxwKt/ATw0rmMR40ON0x
         q/Eb2iYBfMz5mtlBQdEjabIiWneWeM9x8eaR07GsdYve6CcRQ3ZVHtGsMCAYxCe37jFz
         1jgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,349,1520924400";
   d="scan'208";a="50461062"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 02/10] staging: lustre: make struct
 lu_site_bkt_data private
Thread-Topic: [lustre-devel] [PATCH 02/10] staging: lustre: make struct
 lu_site_bkt_data private
Thread-Index: AQHT4P/vAkX5AxTof0OiF2F/tGycLqQat+eA
Date: Tue, 1 May 2018 04:10:05 +0000
Message-ID: <63144F32-1048-4922-B0B9-B92EA93C4D3D@intel.com>
References: <152514658325.17843.11455067361317157487.stgit@noble>
 <152514675889.17843.8198702967686860985.stgit@noble>
In-Reply-To: <152514675889.17843.8198702967686860985.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.137.157]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <910C672EF3DBC14A912B30465CB9BDDA@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232325950422032?=
X-GMAIL-MSGID: =?utf-8?q?1599233386122383341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Apr 30, 2018, at 21:52, NeilBrown <neilb@suse.com> wrote:
>=20
> This data structure only needs to be public so that
> various modules can access a wait queue to wait for object
> destruction.
> If we provide a function to get the wait queue, rather than the
> whole bucket, the structure can be made private.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>

Nice cleanup.

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lustre/include/lu_object.h  |   36 +-------------
> drivers/staging/lustre/lustre/llite/lcommon_cl.c   |    8 ++-
> drivers/staging/lustre/lustre/lov/lov_object.c     |    8 ++-
> drivers/staging/lustre/lustre/obdclass/lu_object.c |   50 +++++++++++++++=
++---
> 4 files changed, 54 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/include/lu_object.h b/drivers/=
staging/lustre/lustre/include/lu_object.h
> index c3b0ed518819..f29bbca5af65 100644
> --- a/drivers/staging/lustre/lustre/include/lu_object.h
> +++ b/drivers/staging/lustre/lustre/include/lu_object.h
> @@ -549,31 +549,7 @@ struct lu_object_header {
> };
>=20
> struct fld;
> -
> -struct lu_site_bkt_data {
> -	/**
> -	 * number of object in this bucket on the lsb_lru list.
> -	 */
> -	long			lsb_lru_len;
> -	/**
> -	 * LRU list, updated on each access to object. Protected by
> -	 * bucket lock of lu_site::ls_obj_hash.
> -	 *
> -	 * "Cold" end of LRU is lu_site::ls_lru.next. Accessed object are
> -	 * moved to the lu_site::ls_lru.prev (this is due to the non-existence
> -	 * of list_for_each_entry_safe_reverse()).
> -	 */
> -	struct list_head		lsb_lru;
> -	/**
> -	 * Wait-queue signaled when an object in this site is ultimately
> -	 * destroyed (lu_object_free()). It is used by lu_object_find() to
> -	 * wait before re-trying when object in the process of destruction is
> -	 * found in the hash table.
> -	 *
> -	 * \see htable_lookup().
> -	 */
> -	wait_queue_head_t	       lsb_marche_funebre;
> -};
> +struct lu_site_bkt_data;
>=20
> enum {
> 	LU_SS_CREATED	 =3D 0,
> @@ -642,14 +618,8 @@ struct lu_site {
> 	struct percpu_counter	 ls_lru_len_counter;
> };
>=20
> -static inline struct lu_site_bkt_data *
> -lu_site_bkt_from_fid(struct lu_site *site, struct lu_fid *fid)
> -{
> -	struct cfs_hash_bd bd;
> -
> -	cfs_hash_bd_get(site->ls_obj_hash, fid, &bd);
> -	return cfs_hash_bd_extra_get(site->ls_obj_hash, &bd);
> -}
> +wait_queue_head_t *
> +lu_site_wq_from_fid(struct lu_site *site, struct lu_fid *fid);
>=20
> static inline struct seq_server_site *lu_site2seq(const struct lu_site *s=
)
> {
> diff --git a/drivers/staging/lustre/lustre/llite/lcommon_cl.c b/drivers/s=
taging/lustre/lustre/llite/lcommon_cl.c
> index df5c0c0ae703..d5b42fb1d601 100644
> --- a/drivers/staging/lustre/lustre/llite/lcommon_cl.c
> +++ b/drivers/staging/lustre/lustre/llite/lcommon_cl.c
> @@ -211,12 +211,12 @@ static void cl_object_put_last(struct lu_env *env, =
struct cl_object *obj)
>=20
> 	if (unlikely(atomic_read(&header->loh_ref) !=3D 1)) {
> 		struct lu_site *site =3D obj->co_lu.lo_dev->ld_site;
> -		struct lu_site_bkt_data *bkt;
> +		wait_queue_head_t *wq;
>=20
> -		bkt =3D lu_site_bkt_from_fid(site, &header->loh_fid);
> +		wq =3D lu_site_wq_from_fid(site, &header->loh_fid);
>=20
> 		init_waitqueue_entry(&waiter, current);
> -		add_wait_queue(&bkt->lsb_marche_funebre, &waiter);
> +		add_wait_queue(wq, &waiter);
>=20
> 		while (1) {
> 			set_current_state(TASK_UNINTERRUPTIBLE);
> @@ -226,7 +226,7 @@ static void cl_object_put_last(struct lu_env *env, st=
ruct cl_object *obj)
> 		}
>=20
> 		set_current_state(TASK_RUNNING);
> -		remove_wait_queue(&bkt->lsb_marche_funebre, &waiter);
> +		remove_wait_queue(wq, &waiter);
> 	}
>=20
> 	cl_object_put(env, obj);
> diff --git a/drivers/staging/lustre/lustre/lov/lov_object.c b/drivers/sta=
ging/lustre/lustre/lov/lov_object.c
> index f7c69680cb7d..adc90f310fd7 100644
> --- a/drivers/staging/lustre/lustre/lov/lov_object.c
> +++ b/drivers/staging/lustre/lustre/lov/lov_object.c
> @@ -370,7 +370,7 @@ static void lov_subobject_kill(const struct lu_env *e=
nv, struct lov_object *lov,
> 	struct cl_object	*sub;
> 	struct lov_layout_raid0 *r0;
> 	struct lu_site	  *site;
> -	struct lu_site_bkt_data *bkt;
> +	wait_queue_head_t *wq;
> 	wait_queue_entry_t	  *waiter;
>=20
> 	r0  =3D &lov->u.raid0;
> @@ -378,7 +378,7 @@ static void lov_subobject_kill(const struct lu_env *e=
nv, struct lov_object *lov,
>=20
> 	sub  =3D lovsub2cl(los);
> 	site =3D sub->co_lu.lo_dev->ld_site;
> -	bkt  =3D lu_site_bkt_from_fid(site, &sub->co_lu.lo_header->loh_fid);
> +	wq   =3D lu_site_wq_from_fid(site, &sub->co_lu.lo_header->loh_fid);
>=20
> 	cl_object_kill(env, sub);
> 	/* release a reference to the sub-object and ... */
> @@ -391,7 +391,7 @@ static void lov_subobject_kill(const struct lu_env *e=
nv, struct lov_object *lov,
> 	if (r0->lo_sub[idx] =3D=3D los) {
> 		waiter =3D &lov_env_info(env)->lti_waiter;
> 		init_waitqueue_entry(waiter, current);
> -		add_wait_queue(&bkt->lsb_marche_funebre, waiter);
> +		add_wait_queue(wq, waiter);
> 		set_current_state(TASK_UNINTERRUPTIBLE);
> 		while (1) {
> 			/* this wait-queue is signaled at the end of
> @@ -408,7 +408,7 @@ static void lov_subobject_kill(const struct lu_env *e=
nv, struct lov_object *lov,
> 				break;
> 			}
> 		}
> -		remove_wait_queue(&bkt->lsb_marche_funebre, waiter);
> +		remove_wait_queue(wq, waiter);
> 	}
> 	LASSERT(!r0->lo_sub[idx]);
> }
> diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers=
/staging/lustre/lustre/obdclass/lu_object.c
> index 3de7dc0497c4..2a8a25d6edb5 100644
> --- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
> +++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
> @@ -56,6 +56,31 @@
> #include <lu_ref.h>
> #include <linux/list.h>
>=20
> +struct lu_site_bkt_data {
> +	/**
> +	 * number of object in this bucket on the lsb_lru list.
> +	 */
> +	long			lsb_lru_len;
> +	/**
> +	 * LRU list, updated on each access to object. Protected by
> +	 * bucket lock of lu_site::ls_obj_hash.
> +	 *
> +	 * "Cold" end of LRU is lu_site::ls_lru.next. Accessed object are
> +	 * moved to the lu_site::ls_lru.prev (this is due to the non-existence
> +	 * of list_for_each_entry_safe_reverse()).
> +	 */
> +	struct list_head		lsb_lru;
> +	/**
> +	 * Wait-queue signaled when an object in this site is ultimately
> +	 * destroyed (lu_object_free()). It is used by lu_object_find() to
> +	 * wait before re-trying when object in the process of destruction is
> +	 * found in the hash table.
> +	 *
> +	 * \see htable_lookup().
> +	 */
> +	wait_queue_head_t	       lsb_marche_funebre;
> +};
> +
> enum {
> 	LU_CACHE_PERCENT_MAX	 =3D 50,
> 	LU_CACHE_PERCENT_DEFAULT =3D 20
> @@ -88,6 +113,17 @@ MODULE_PARM_DESC(lu_cache_nr, "Maximum number of obje=
cts in lu_object cache");
> static void lu_object_free(const struct lu_env *env, struct lu_object *o)=
;
> static __u32 ls_stats_read(struct lprocfs_stats *stats, int idx);
>=20
> +wait_queue_head_t *
> +lu_site_wq_from_fid(struct lu_site *site, struct lu_fid *fid)
> +{
> +	struct cfs_hash_bd bd;
> +	struct lu_site_bkt_data *bkt;
> +
> +	cfs_hash_bd_get(site->ls_obj_hash, fid, &bd);
> +	bkt =3D cfs_hash_bd_extra_get(site->ls_obj_hash, &bd);
> +	return &bkt->lsb_marche_funebre;
> +}
> +
> /**
>  * Decrease reference counter on object. If last reference is freed, retu=
rn
>  * object to the cache, unless lu_object_is_dying(o) holds. In the latter
> @@ -288,7 +324,7 @@ static struct lu_object *lu_object_alloc(const struct=
 lu_env *env,
>  */
> static void lu_object_free(const struct lu_env *env, struct lu_object *o)
> {
> -	struct lu_site_bkt_data *bkt;
> +	wait_queue_head_t *wq;
> 	struct lu_site	  *site;
> 	struct lu_object	*scan;
> 	struct list_head	      *layers;
> @@ -296,7 +332,7 @@ static void lu_object_free(const struct lu_env *env, =
struct lu_object *o)
>=20
> 	site   =3D o->lo_dev->ld_site;
> 	layers =3D &o->lo_header->loh_layers;
> -	bkt    =3D lu_site_bkt_from_fid(site, &o->lo_header->loh_fid);
> +	wq     =3D lu_site_wq_from_fid(site, &o->lo_header->loh_fid);
> 	/*
> 	 * First call ->loo_object_delete() method to release all resources.
> 	 */
> @@ -324,8 +360,8 @@ static void lu_object_free(const struct lu_env *env, =
struct lu_object *o)
> 		o->lo_ops->loo_object_free(env, o);
> 	}
>=20
> -	if (waitqueue_active(&bkt->lsb_marche_funebre))
> -		wake_up_all(&bkt->lsb_marche_funebre);
> +	if (waitqueue_active(wq))
> +		wake_up_all(wq);
> }
>=20
> /**
> @@ -749,7 +785,7 @@ struct lu_object *lu_object_find_at(const struct lu_e=
nv *env,
> 				    const struct lu_fid *f,
> 				    const struct lu_object_conf *conf)
> {
> -	struct lu_site_bkt_data *bkt;
> +	wait_queue_head_t	*wq;
> 	struct lu_object	*obj;
> 	wait_queue_entry_t	   wait;
>=20
> @@ -762,8 +798,8 @@ struct lu_object *lu_object_find_at(const struct lu_e=
nv *env,
> 		 * wait queue.
> 		 */
> 		schedule();
> -		bkt =3D lu_site_bkt_from_fid(dev->ld_site, (void *)f);
> -		remove_wait_queue(&bkt->lsb_marche_funebre, &wait);
> +		wq =3D lu_site_wq_from_fid(dev->ld_site, (void *)f);
> +		remove_wait_queue(wq, &wait);
> 	}
> }
> EXPORT_SYMBOL(lu_object_find_at);
>=20
>=20
> _______________________________________________
> lustre-devel mailing list
> lustre-devel@lists.lustre.org
> http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
