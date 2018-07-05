Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F30BC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DB82401A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DB82401A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeGEXqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:46:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:46244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753123AbeGEXqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:46:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B25FAD4C;
        Thu,  5 Jul 2018 23:45:59 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Date:   Fri, 06 Jul 2018 09:45:48 +1000
Cc:     kiran.modukuri@gmail.com, carmark.dlut@gmail.com,
        vegard.nossum@gmail.com, linux-kernel@vger.kernel.org,
        aderobertis@metrics.net, dhowells@redhat.com, dja@axtens.net
Subject: Re: [PATCH 1/4] cachefiles: Fix assertion "6 == 5 is false" at fs/fscache/operation.c:494
In-Reply-To: <153080826773.5496.7106875523806885716.stgit@warthog.procyon.org.uk>
References: <153080826773.5496.7106875523806885716.stgit@warthog.procyon.org.uk>
Message-ID: <87601tz1oz.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05 2018, David Howells wrote:

> From: kiran modukuri <kiran.modukuri@gmail.com>
>
> There is a potential race in fscache operation enqueuing for reading and
> copying multiple pages from cachefiles to netfs.
> Under some heavy load system, it will happen very often.
>
> If this race occurs, an oops similar to the following is seen:
>
>  kernel BUG at fs/fscache/operation.c:69!
>  invalid opcode: 0000 [#1] SMP
>  ...
>  #0 [ffff883fff0838d8] machine_kexec at ffffffff81051beb
>  #1 [ffff883fff083938] crash_kexec at ffffffff810f2542
>  #2 [ffff883fff083a08] oops_end at ffffffff8163e1a8
>  #3 [ffff883fff083a30] die at ffffffff8101859b
>  #4 [ffff883fff083a60] do_trap at ffffffff8163d860
>  #5 [ffff883fff083ab0] do_invalid_op at ffffffff81015204
>  #6 [ffff883fff083b60] invalid_op at ffffffff8164701e
>     [exception RIP: fscache_enqueue_operation+246]
>     RIP: ffffffffa0b793c6  RSP: ffff883fff083c18  RFLAGS: 00010046
>     RAX: 0000000000000019  RBX: ffff8832ed1a9ec0  RCX: 0000000000000006
>     RDX: 0000000000000000  RSI: 0000000000000046  RDI: 0000000000000046
>     RBP: ffff883fff083c20   R8: 0000000000000086   R9: 000000000000178f
>     R10: ffffffff816aeb00  R11: ffff883fff08392e  R12: ffff8802f0525620
>     R13: ffff88407ffc01d8  R14: 0000000000000000  R15: 0000000000000003
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
>  #7 [ffff883fff083c10] fscache_enqueue_operation at ffffffffa0b793c6
>  #8 [ffff883fff083c28] cachefiles_read_waiter at ffffffffa0b15a48
>  #9 [ffff883fff083c48] __wake_up_common at ffffffff810af028
>
> Reported-by: Lei Xue <carmark.dlut@gmail.com>
> Reported-by: Vegard Nossum <vegard.nossum@gmail.com>
> Reported-by: Anthony DeRobertis <aderobertis@metrics.net>
> Reported-by: NeilBrown <neilb@suse.com>
> Reported-by: Daniel Axtens <dja@axtens.net>
> Reported-by: KiranKumar Modukuri <kiran.modukuri@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  fs/cachefiles/rdwr.c   |   17 ++++++++++++-----
>  fs/fscache/operation.c |    6 ++++--
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
> index 5082c8a49686..40f7595aad10 100644
> --- a/fs/cachefiles/rdwr.c
> +++ b/fs/cachefiles/rdwr.c
> @@ -27,6 +27,7 @@ static int cachefiles_read_waiter(wait_queue_entry_t *w=
ait, unsigned mode,
>  	struct cachefiles_one_read *monitor =3D
>  		container_of(wait, struct cachefiles_one_read, monitor);
>  	struct cachefiles_object *object;
> +	struct fscache_retrieval *op =3D monitor->op;
>  	struct wait_bit_key *key =3D _key;
>  	struct page *page =3D wait->private;
>=20=20
> @@ -51,16 +52,22 @@ static int cachefiles_read_waiter(wait_queue_entry_t =
*wait, unsigned mode,
>  	list_del(&wait->entry);
>=20=20
>  	/* move onto the action list and queue for FS-Cache thread pool */
> -	ASSERT(monitor->op);
> +	ASSERT(op);
>=20=20
> -	object =3D container_of(monitor->op->op.object,
> -			      struct cachefiles_object, fscache);
> +	/* We need to temporarily bump the usage count as we don't own a ref
> +	 * here otherwise cachefiles_read_copier() may free the op between the
> +	 * monitor being enqueued on the op->to_do list and the op getting
> +	 * enqueued on the work queue.
> +	 */
> +	fscache_get_retrieval(op);
>=20=20
> +	object =3D container_of(op->op.object, struct cachefiles_object, fscach=
e);
>  	spin_lock(&object->work_lock);
> -	list_add_tail(&monitor->op_link, &monitor->op->to_do);
> +	list_add_tail(&monitor->op_link, &op->to_do);
>  	spin_unlock(&object->work_lock);
>=20=20
> -	fscache_enqueue_retrieval(monitor->op);
> +	fscache_enqueue_retrieval(op);
> +	fscache_put_retrieval(op);
>  	return 0;
>  }

Thanks - I like this approach.  Taking the extra reference makes it a
lot more clear what is happening and why.

Thanks,
NeilBrown


>=20=20
> diff --git a/fs/fscache/operation.c b/fs/fscache/operation.c
> index e30c5975ea58..8d265790374c 100644
> --- a/fs/fscache/operation.c
> +++ b/fs/fscache/operation.c
> @@ -70,7 +70,8 @@ void fscache_enqueue_operation(struct fscache_operation=
 *op)
>  	ASSERT(op->processor !=3D NULL);
>  	ASSERT(fscache_object_is_available(op->object));
>  	ASSERTCMP(atomic_read(&op->usage), >, 0);
> -	ASSERTCMP(op->state, =3D=3D, FSCACHE_OP_ST_IN_PROGRESS);
> +	ASSERTIFCMP(op->state !=3D FSCACHE_OP_ST_IN_PROGRESS,
> +		    op->state, =3D=3D,  FSCACHE_OP_ST_CANCELLED);
>=20=20
>  	fscache_stat(&fscache_n_op_enqueue);
>  	switch (op->flags & FSCACHE_OP_TYPE) {
> @@ -499,7 +500,8 @@ void fscache_put_operation(struct fscache_operation *=
op)
>  	struct fscache_cache *cache;
>=20=20
>  	_enter("{OBJ%x OP%x,%d}",
> -	       op->object->debug_id, op->debug_id, atomic_read(&op->usage));
> +	       op->object ? op->object->debug_id : 0,
> +	       op->debug_id, atomic_read(&op->usage));
>=20=20
>  	ASSERTCMP(atomic_read(&op->usage), >, 0);
>=20=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAls+ra0ACgkQOeye3VZi
gbldlQ//e5bv4Szw+O7iNn8WeIa62faKoxb5sP6qXsRiz/O/vaE7cB0cqrP9YV3f
9rNnj1+oUj9ozMSUOiQG+2MbWwFkKWhzdIYIi2hnhDDV+1f9BmVXTouFu2Lprp0V
sT9Edh3UDGXCh2iPXVYgaUv5YuP2xt2LhNhKJpEnZDUnN+2Lp7rUzlUIEhvhv/xI
iemKg9QiP3/SX/3HirdjIGwXYe1ku9p0322uOsXMWFjs6CknnkC35LIu/74nBNKJ
YFV4rPEJSehy45UP6SH2Best4wRBiUCzb3DUSnd7JgY/aKIx1gfEdSDHIaZJSiSx
8tKwCQTmDWSBB8xIEdx27pan+gwt8E2V9CoS3tEqirW/A0Ensqe81Rz8B3dVipeA
kOkxnbdQtjsXqbuEsiAFk5bP4VHVbO3zsVXKKgCh9x9NHcX0Nt+PbF1Izro1V8ZX
V8DQ61NTGKRh+WRHt27H879pWWCHxsb+MQiaFFxyPhO25ORCkq1WUZu3/oXr4+YE
quYdIGuuc1BaUS37QgbV2SMa4G/XiGpjEbigSeC9nXIokItDRWGzNUhjkaSGhLYs
LeA4FTYioCqtiDw9chEtvauZhPWJy1INh8rdoIAOX6JDp117OxyI17j6L7XVrAJ3
EJKxrexNhpZaCze3avEmoZvVExsU9Fd1fXT8MFUvbvuOiF/Xis4=
=XSaj
-----END PGP SIGNATURE-----
--=-=-=--
