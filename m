Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x227AzFRpzUaW0ULEYFoYwBgplQVUGCxD59mvaGM4P/9CDkVgngdBK/xZmL0DlirvBV4q+aWd
ARC-Seal: i=1; a=rsa-sha256; t=1519159351; cv=none;
        d=google.com; s=arc-20160816;
        b=XqirHKwH1c3iy+Jxyur5NNrvUeCElvtrDIs3zWCyB+JXM4T11HMu7b7mnDZj5wvsyo
         7FnKc2V/pdizt+LcTJCh2DnSs8XO3Zrg7as+/3mwydZSRIi5NO4v2Y3+p+NEVhPfSZIG
         fNiJH0J5yg+y/L6QUilBcPEDNDd8pwj16MpRkGIcdOngCMdGnGz9ZZOgo6u0n0G2ocKS
         iwaeTVxx11iMtQV7myI5G285SOLrY9jL+21/QxGgN/oPP8/ong3llg1l/Y5hKk00Ng45
         ECu6K0tWg9SSbSUPGWYaL5OH6lx0UP5OZ4hLf0MiolLVy/KVtoZquwgVAUNisYs55eo3
         1Qeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=FpuAKBMc5WtQZv/Oqp/rqkZpMGTTg9jeG+h3XUoGYH0=;
        b=RpVl26s5crMytzDnC9AZe065bA4FvN1utJ0SGjPnU8ScO8PpdskY5bXStmCVRyGF73
         DCDy3gNQXOuGo2rgHDZcQNTWpY+CyQ28Yb+8HFCIdukDAzW+7BPr5JMby8eQXWmsjakF
         //PPtaeXFM03uAoPp9JgnGef2Q1Ej9kKfnbAPZPXPyz39DqNKJGBMscXg2v9ARSX2lJf
         5KqlfM+o2S8VIrSs8o3Hs6UmZZNmSuWZeR/YManB+ma0FiKXkRmgsHx0UQhGeaN9TWws
         fPAQKbmHK6tKf7X94QrIC15r4KnJfOwOR6IG7TJmizWpQ65xEdk8KEThQgrqgXC9URfd
         YReQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>, Andreas Dilger <andreas.dilger@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 21 Feb 2018 07:42:20 +1100
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>,
	Eremin@suse.com, Dmitry <dmitry.eremin@intel.com>
Subject: [PATCH 14/21 - v2] staging: lustre: fix assorted checkpatch errors
In-Reply-To: <151909341801.25814.16760126077741712102.stgit@noble>
References: <151909308778.25814.9912662268627044409.stgit@noble> <151909341801.25814.16760126077741712102.stgit@noble>
Message-ID: <87d10zjsur.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592885047375416179?=
X-GMAIL-MSGID: =?utf-8?q?1592954035497482514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Possibly the most interesting is the for-loop with no body.
Rearranging and initializing end_dirent on each iteration of
the outer while, makes the intent clearer.

Reviewed-by: "Eremin, Dmitry" <dmitry.eremin@intel.com>
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

This version has a correct conversion for that for loop with not body,
thanks Dmitry!

 drivers/staging/lustre/lnet/klnds/socklnd/socklnd_lib.c |  2 +-
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c    |  2 +-
 drivers/staging/lustre/lustre/include/obd_class.h       |  8 ++++----
 drivers/staging/lustre/lustre/include/obd_support.h     |  2 +-
 drivers/staging/lustre/lustre/llite/dcache.c            |  2 +-
 drivers/staging/lustre/lustre/llite/llite_lib.c         |  2 +-
 drivers/staging/lustre/lustre/lov/lov_request.c         |  2 +-
 drivers/staging/lustre/lustre/mdc/mdc_request.c         | 11 ++++++-----
 drivers/staging/lustre/lustre/ptlrpc/layout.c           |  2 +-
 drivers/staging/lustre/lustre/ptlrpc/recover.c          |  2 +-
 drivers/staging/lustre/lustre/ptlrpc/service.c          |  2 +-
 11 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_lib.c b/driv=
ers/staging/lustre/lnet/klnds/socklnd/socklnd_lib.c
index cb28dd2baf2f..7941cfa526bc 100644
=2D-- a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_lib.c
+++ b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_lib.c
@@ -189,7 +189,7 @@ ksocknal_lib_recv(struct ksock_conn *conn)
 	if (!(conn->ksnc_rx_to.type & ITER_BVEC) &&
 	     conn->ksnc_proto !=3D &ksocknal_protocol_v2x)
 		return rc;
=2D=09=09
+
 	/* accumulate checksum */
 	conn->ksnc_msg.ksm_csum =3D 0;
 	iov_iter_for_each_range(&conn->ksnc_rx_to, rc, lustre_csum, conn);
diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers=
/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index c07165e0ad95..388521e4e354 100644
=2D-- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -743,7 +743,7 @@ cfs_cpt_table_create(int ncpt)
 		goto failed;
 	}
=20
=2D	if (!zalloc_cpumask_var(&mask, GFP_NOFS)){
+	if (!zalloc_cpumask_var(&mask, GFP_NOFS)) {
 		CERROR("Failed to allocate scratch cpumask\n");
 		goto failed;
 	}
diff --git a/drivers/staging/lustre/lustre/include/obd_class.h b/drivers/st=
aging/lustre/lustre/include/obd_class.h
index 531e8ddfa9e5..f24dd74ffa09 100644
=2D-- a/drivers/staging/lustre/lustre/include/obd_class.h
+++ b/drivers/staging/lustre/lustre/include/obd_class.h
@@ -294,10 +294,10 @@ struct obdo;
=20
 void obdo_to_ioobj(const struct obdo *oa, struct obd_ioobj *ioobj);
=20
=2D#define OBT(dev)	(dev)->obd_type
=2D#define OBP(dev, op)    (dev)->obd_type->typ_dt_ops->op
=2D#define MDP(dev, op)    (dev)->obd_type->typ_md_ops->op
=2D#define CTXTP(ctxt, op) (ctxt)->loc_logops->lop_##op
+#define OBT(dev)	((dev)->obd_type)
+#define OBP(dev, op)    ((dev)->obd_type->typ_dt_ops->op)
+#define MDP(dev, op)    ((dev)->obd_type->typ_md_ops->op)
+#define CTXTP(ctxt, op) ((ctxt)->loc_logops->lop_##op)
=20
 /*
  * Ensure obd_setup: used for cleanup which must be called
diff --git a/drivers/staging/lustre/lustre/include/obd_support.h b/drivers/=
staging/lustre/lustre/include/obd_support.h
index 3f4fe290f6ea..8595091b8b86 100644
=2D-- a/drivers/staging/lustre/lustre/include/obd_support.h
+++ b/drivers/staging/lustre/lustre/include/obd_support.h
@@ -516,7 +516,7 @@ extern char obd_jobid_var[];
 #define POISON_PTR(ptr)  ((void)0)
 #else
 #define POISON(ptr, c, s) memset(ptr, c, s)
=2D#define POISON_PTR(ptr)  (ptr) =3D (void *)0xdeadbeef
+#define POISON_PTR(ptr)  ((ptr) =3D (void *)0xdeadbeef)
 #endif
=20
 #ifdef POISON_BULK
diff --git a/drivers/staging/lustre/lustre/llite/dcache.c b/drivers/staging=
/lustre/lustre/llite/dcache.c
index dc30b4582234..3e768f997172 100644
=2D-- a/drivers/staging/lustre/lustre/llite/dcache.c
+++ b/drivers/staging/lustre/lustre/llite/dcache.c
@@ -100,7 +100,7 @@ static int ll_dcompare(const struct dentry *dentry,
 		return 0;
=20
 	/* ensure exclusion against parallel lookup of the same name */
=2D	if (d_in_lookup((struct dentry*)dentry))
+	if (d_in_lookup((struct dentry *)dentry))
 		return 0;
=20
 	if (d_lustre_invalid(dentry))
diff --git a/drivers/staging/lustre/lustre/llite/llite_lib.c b/drivers/stag=
ing/lustre/lustre/llite/llite_lib.c
index efbd551e7842..844182ad7dd7 100644
=2D-- a/drivers/staging/lustre/lustre/llite/llite_lib.c
+++ b/drivers/staging/lustre/lustre/llite/llite_lib.c
@@ -2022,7 +2022,7 @@ void ll_umount_begin(struct super_block *sb)
 	 */
 	while (cnt < 10 && !may_umount(sbi->ll_mnt.mnt)) {
 		schedule_timeout_uninterruptible(HZ);
=2D		cnt ++;
+		cnt++;
 	}
=20
 	schedule();
diff --git a/drivers/staging/lustre/lustre/lov/lov_request.c b/drivers/stag=
ing/lustre/lustre/lov/lov_request.c
index c1e58fcc30b3..051450d67524 100644
=2D-- a/drivers/staging/lustre/lustre/lov/lov_request.c
+++ b/drivers/staging/lustre/lustre/lov/lov_request.c
@@ -126,7 +126,7 @@ static int lov_check_and_wait_active(struct lov_obd *lo=
v, int ost_idx)
=20
 	while (cnt < obd_timeout && !lov_check_set(lov, ost_idx)) {
 		schedule_timeout_uninterruptible(HZ);
=2D		cnt ++;
+		cnt++;
 	}
 	if (tgt->ltd_active)
 		return 1;
diff --git a/drivers/staging/lustre/lustre/mdc/mdc_request.c b/drivers/stag=
ing/lustre/lustre/mdc/mdc_request.c
index ab48746ce433..3b1c8e5a3053 100644
=2D-- a/drivers/staging/lustre/lustre/mdc/mdc_request.c
+++ b/drivers/staging/lustre/lustre/mdc/mdc_request.c
@@ -1055,13 +1055,14 @@ static void mdc_adjust_dirpages(struct page **pages=
, int cfs_pgs, int lu_pgs)
 		__u64 hash_end =3D le64_to_cpu(dp->ldp_hash_end);
 		__u32 flags =3D le32_to_cpu(dp->ldp_flags);
 		struct lu_dirpage *first =3D dp;
=2D		struct lu_dirent *end_dirent =3D NULL;
=2D		struct lu_dirent *ent;
=20
 		while (--lu_pgs > 0) {
=2D			ent =3D lu_dirent_start(dp);
=2D			for (end_dirent =3D ent; ent;
=2D			     end_dirent =3D ent, ent =3D lu_dirent_next(ent));
+			struct lu_dirent *end_dirent =3D NULL;
+			struct lu_dirent *ent;
+
+			for (ent =3D lu_dirent_start(dp); ent;
+			     ent =3D lu_dirent_next(ent))
+				end_dirent =3D ent;
=20
 			/* Advance dp to next lu_dirpage. */
 			dp =3D (struct lu_dirpage *)((char *)dp + LU_PAGE_SIZE);
diff --git a/drivers/staging/lustre/lustre/ptlrpc/layout.c b/drivers/stagin=
g/lustre/lustre/ptlrpc/layout.c
index 18769d335751..2855f38c8190 100644
=2D-- a/drivers/staging/lustre/lustre/ptlrpc/layout.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/layout.c
@@ -1555,7 +1555,7 @@ struct req_format RQF_OST_GET_INFO_FIEMAP =3D
 EXPORT_SYMBOL(RQF_OST_GET_INFO_FIEMAP);
=20
 /* Convenience macro */
=2D#define FMT_FIELD(fmt, i, j) (fmt)->rf_fields[(i)].d[(j)]
+#define FMT_FIELD(fmt, i, j) ((fmt)->rf_fields[(i)].d[(j)])
=20
 /**
  * Initializes the capsule abstraction by computing and setting the \a rf_=
idx
diff --git a/drivers/staging/lustre/lustre/ptlrpc/recover.c b/drivers/stagi=
ng/lustre/lustre/ptlrpc/recover.c
index 7b5f2429d144..5bb9f9fe91d8 100644
=2D-- a/drivers/staging/lustre/lustre/ptlrpc/recover.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/recover.c
@@ -354,7 +354,7 @@ int ptlrpc_recover_import(struct obd_import *imp, char =
*new_uuid, int async)
 					     obd_timeout * HZ);
 		CDEBUG(D_HA, "%s: recovery finished\n",
 		       obd2cli_tgt(imp->imp_obd));
=2D		rc =3D rc? 0 : -ETIMEDOUT;
+		rc =3D rc ? 0 : -ETIMEDOUT;
 	}
=20
 out:
diff --git a/drivers/staging/lustre/lustre/ptlrpc/service.c b/drivers/stagi=
ng/lustre/lustre/ptlrpc/service.c
index 79d9f3860022..99aeb291f3f2 100644
=2D-- a/drivers/staging/lustre/lustre/ptlrpc/service.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/service.c
@@ -2670,7 +2670,7 @@ ptlrpc_service_unlink_rqbd(struct ptlrpc_service *svc)
 			       (rc =3D wait_event_idle_timeout(svcpt->scp_waitq,
 							     svcpt->scp_nrqbds_posted =3D=3D 0,
 							     HZ)) =3D=3D 0)
=2D				cnt ++;
+				cnt++;
 			if (rc =3D=3D 0) {
 				CWARN("Service %s waiting for request buffers\n",
 				      svcpt->scp_service->srv_name);
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqMiCwACgkQOeye3VZi
gbl1/g//f05vxiu/Bzn4Ei6yOQ3j+pf1RyM3zPG8AALYDakEgLL0Vn6Q0Yg9mYQy
+x1sSQbF1sFYblYdXuOCHAgYGAzCqGVcUSYLX2IHW4Utq/m1tsD/YfPW5O2hfzGS
bg3T4ASapg+WD5mIKK+spLAS5i44gw/nZC9EQTmyS1A4rPU+Ln8zPXnLOWqDLIOr
cc2HWWl/9VUasqkHjlbSAM3fa7GgIsrTR0zl0tB3CdEiWVRhQEZY1VrmMCAqNXa8
xHJcAj3hY5A/p5icvaL2RGTrS5nLPS8KOlHWL+wghMKfI832IeEnkDB5awFvb0QH
kce1wAVlbhvrmNmwHYrveHt2F97v6EoRTw1Y1YlCpCU0YJ/SEXjMMZCfJjI6goWG
wiPXN7fFujuv9XrMcoN+7n1W78tC8XpPl32NUhQUCf7r7iMTLl5see/FWLc3xh8R
Jz1dfEKaEOTmizDSJNHzVpJcSAHs2Waxq4e8gGJSFU9hO5P9IeED/g/wYEnaR09h
VJbnx7cBB3UBS22bWgYgII48yL/UWF6eYdsXGCroKRhJkeGIsx7txuC1P/LILi6H
ICF1WjqGcrSm/ILwRS2ovMePQ1+owmf7ZR7Jo9doBItztXnoISxI49aYg+kxtgVa
dhcJU4HzHZq8UGCvar0kuHdmIWsAr0YfguAlap5KkBLJRifqvFs=
=Z8Sn
-----END PGP SIGNATURE-----
--=-=-=--
