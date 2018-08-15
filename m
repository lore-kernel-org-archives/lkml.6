Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BD9C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E7E2170A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M/MVjW/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E7E2170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeHOElf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:41:35 -0400
Received: from ozlabs.org ([203.11.71.1]:60181 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeHOElf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:41:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qsrh29Ysz9sCR;
        Wed, 15 Aug 2018 11:51:31 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534297894;
        bh=PDm98TnG4THewardWEPH0o6fqvTFw1I+tqwH4413PZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M/MVjW/AyIUdlOxYgMXLWZ5OpIDdfyGYsqZxLPidyD4Bqn0sE1SvSx7v20zYa9Nix
         0Z7Dr+2h9+9aG1S9k8LVjnsRszj+JCsxTgwYPn7umYSeb6TESWntfwqlPphphLpkBy
         d+K125bI443VaKt9149DKGr0oU5UednmVB4lgkiPgu9dLKuoHZuTTSg0PQC0rCYHPI
         XzzWbBKydBpTPmhx6MSC7+VxzFs/1ACEsHDBKAos5tz2k51nEdFBnH2Mu1bQP/RSOu
         DN545LrNcq9dGq4hNKJ8+XkspyItkoNIf/+Ox+RA9WVmLUD2scH0Ks4+u5MiCkRx4p
         dHIAuGu5Qx6Qw==
Date:   Wed, 15 Aug 2018 11:51:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: manual merge of the tip tree with the rdma tree
Message-ID: <20180815115130.03dbbbce@canb.auug.org.au>
In-Reply-To: <20180806145331.68538a0b@canb.auug.org.au>
References: <20180806145331.68538a0b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zOcmKmKGd1wbzSdKd=XJ8pm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zOcmKmKGd1wbzSdKd=XJ8pm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 6 Aug 2018 14:53:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the tip tree got a conflict in:
>=20
>   drivers/infiniband/core/rdma_core.c
>=20
> between commit:
>=20
>   9867f5c6695f ("IB/uverbs: Convert 'bool exclusive' into an enum")
>=20
> from the rdma tree and commit:
>=20
>   bfc18e389c7a ("atomics/treewide: Rename __atomic_add_unless() =3D> atom=
ic_fetch_add_unless()")
>=20
> from the tip tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/infiniband/core/rdma_core.c
> index 4235b9ddc2ad,475910ffbcb6..000000000000
> --- a/drivers/infiniband/core/rdma_core.c
> +++ b/drivers/infiniband/core/rdma_core.c
> @@@ -122,206 -120,19 +122,206 @@@ static int uverbs_try_lock_object(struc
>   	 * concurrently, setting the counter to zero is enough for releasing
>   	 * this lock.
>   	 */
>  -	if (!exclusive)
>  +	switch (mode) {
>  +	case UVERBS_LOOKUP_READ:
> - 		return __atomic_add_unless(&uobj->usecnt, 1, -1) =3D=3D -1 ?
> + 		return atomic_fetch_add_unless(&uobj->usecnt, 1, -1) =3D=3D -1 ?
>   			-EBUSY : 0;
>  +	case UVERBS_LOOKUP_WRITE:
>  +		/* lock is exclusive */
>  +		return atomic_cmpxchg(&uobj->usecnt, 0, -1) =3D=3D 0 ? 0 : -EBUSY;
>  +	case UVERBS_LOOKUP_DESTROY:
>  +		return 0;
>  +	}
>  +	return 0;
>  +}
>  +
>  +static void assert_uverbs_usecnt(struct ib_uobject *uobj,
>  +				 enum rdma_lookup_mode mode)
>  +{
>  +#ifdef CONFIG_LOCKDEP
>  +	switch (mode) {
>  +	case UVERBS_LOOKUP_READ:
>  +		WARN_ON(atomic_read(&uobj->usecnt) <=3D 0);
>  +		break;
>  +	case UVERBS_LOOKUP_WRITE:
>  +		WARN_ON(atomic_read(&uobj->usecnt) !=3D -1);
>  +		break;
>  +	case UVERBS_LOOKUP_DESTROY:
>  +		break;
>  +	}
>  +#endif
>  +}
>  +
>  +/*
>  + * This must be called with the hw_destroy_rwsem locked for read or wri=
te,
>  + * also the uobject itself must be locked for write.
>  + *
>  + * Upon return the HW object is guaranteed to be destroyed.
>  + *
>  + * For RDMA_REMOVE_ABORT, the hw_destroy_rwsem is not required to be he=
ld,
>  + * however the type's allocat_commit function cannot have been called a=
nd the
>  + * uobject cannot be on the uobjects_lists
>  + *
>  + * For RDMA_REMOVE_DESTROY the caller shold be holding a kref (eg via
>  + * rdma_lookup_get_uobject) and the object is left in a state where the=
 caller
>  + * needs to call rdma_lookup_put_uobject.
>  + *
>  + * For all other destroy modes this function internally unlocks the uob=
ject
>  + * and consumes the kref on the uobj.
>  + */
>  +static int uverbs_destroy_uobject(struct ib_uobject *uobj,
>  +				  enum rdma_remove_reason reason)
>  +{
>  +	struct ib_uverbs_file *ufile =3D uobj->ufile;
>  +	unsigned long flags;
>  +	int ret;
>  +
>  +	lockdep_assert_held(&ufile->hw_destroy_rwsem);
>  +	assert_uverbs_usecnt(uobj, UVERBS_LOOKUP_WRITE);
>  +
>  +	if (uobj->object) {
>  +		ret =3D uobj->type->type_class->destroy_hw(uobj, reason);
>  +		if (ret) {
>  +			if (ib_is_destroy_retryable(ret, reason, uobj))
>  +				return ret;
>  +
>  +			/* Nothing to be done, dangle the memory and move on */
>  +			WARN(true,
>  +			     "ib_uverbs: failed to remove uobject id %d, driver err=3D%d",
>  +			     uobj->id, ret);
>  +		}
>  +
>  +		uobj->object =3D NULL;
>  +	}
>  +
>  +	if (reason =3D=3D RDMA_REMOVE_ABORT) {
>  +		WARN_ON(!list_empty(&uobj->list));
>  +		WARN_ON(!uobj->context);
>  +		uobj->type->type_class->alloc_abort(uobj);
>  +	}
>  +
>  +	uobj->context =3D NULL;
>  +
>  +	/*
>  +	 * For DESTROY the usecnt is held write locked, the caller is expected
>  +	 * to put it unlock and put the object when done with it. Only DESTROY
>  +	 * can remove the IDR handle.
>  +	 */
>  +	if (reason !=3D RDMA_REMOVE_DESTROY)
>  +		atomic_set(&uobj->usecnt, 0);
>  +	else
>  +		uobj->type->type_class->remove_handle(uobj);
>  +
>  +	if (!list_empty(&uobj->list)) {
>  +		spin_lock_irqsave(&ufile->uobjects_lock, flags);
>  +		list_del_init(&uobj->list);
>  +		spin_unlock_irqrestore(&ufile->uobjects_lock, flags);
>  +
>  +		/*
>  +		 * Pairs with the get in rdma_alloc_commit_uobject(), could
>  +		 * destroy uobj.
>  +		 */
>  +		uverbs_uobject_put(uobj);
>  +	}
>  =20
>  -	/* lock is either WRITE or DESTROY - should be exclusive */
>  -	return atomic_cmpxchg(&uobj->usecnt, 0, -1) =3D=3D 0 ? 0 : -EBUSY;
>  +	/*
>  +	 * When aborting the stack kref remains owned by the core code, and is
>  +	 * not transferred into the type. Pairs with the get in alloc_uobj
>  +	 */
>  +	if (reason =3D=3D RDMA_REMOVE_ABORT)
>  +		uverbs_uobject_put(uobj);
>  +
>  +	return 0;
>   }
>  =20
>  -static struct ib_uobject *alloc_uobj(struct ib_ucontext *context,
>  +/*
>  + * This calls uverbs_destroy_uobject() using the RDMA_REMOVE_DESTROY
>  + * sequence. It should only be used from command callbacks. On success =
the
>  + * caller must pair this with rdma_lookup_put_uobject(LOOKUP_WRITE). Th=
is
>  + * version requires the caller to have already obtained an
>  + * LOOKUP_DESTROY uobject kref.
>  + */
>  +int uobj_destroy(struct ib_uobject *uobj)
>  +{
>  +	struct ib_uverbs_file *ufile =3D uobj->ufile;
>  +	int ret;
>  +
>  +	down_read(&ufile->hw_destroy_rwsem);
>  +
>  +	ret =3D uverbs_try_lock_object(uobj, UVERBS_LOOKUP_WRITE);
>  +	if (ret)
>  +		goto out_unlock;
>  +
>  +	ret =3D uverbs_destroy_uobject(uobj, RDMA_REMOVE_DESTROY);
>  +	if (ret) {
>  +		atomic_set(&uobj->usecnt, 0);
>  +		goto out_unlock;
>  +	}
>  +
>  +out_unlock:
>  +	up_read(&ufile->hw_destroy_rwsem);
>  +	return ret;
>  +}
>  +
>  +/*
>  + * uobj_get_destroy destroys the HW object and returns a handle to the =
uobj
>  + * with a NULL object pointer. The caller must pair this with
>  + * uverbs_put_destroy.
>  + */
>  +struct ib_uobject *__uobj_get_destroy(const struct uverbs_obj_type *typ=
e,
>  +				      u32 id, struct ib_uverbs_file *ufile)
>  +{
>  +	struct ib_uobject *uobj;
>  +	int ret;
>  +
>  +	uobj =3D rdma_lookup_get_uobject(type, ufile, id, UVERBS_LOOKUP_DESTRO=
Y);
>  +	if (IS_ERR(uobj))
>  +		return uobj;
>  +
>  +	ret =3D uobj_destroy(uobj);
>  +	if (ret) {
>  +		rdma_lookup_put_uobject(uobj, UVERBS_LOOKUP_DESTROY);
>  +		return ERR_PTR(ret);
>  +	}
>  +
>  +	return uobj;
>  +}
>  +
>  +/*
>  + * Does both uobj_get_destroy() and uobj_put_destroy().  Returns succes=
s_res
>  + * on success (negative errno on failure). For use by callers that do n=
ot need
>  + * the uobj.
>  + */
>  +int __uobj_perform_destroy(const struct uverbs_obj_type *type, u32 id,
>  +			   struct ib_uverbs_file *ufile, int success_res)
>  +{
>  +	struct ib_uobject *uobj;
>  +
>  +	uobj =3D __uobj_get_destroy(type, id, ufile);
>  +	if (IS_ERR(uobj))
>  +		return PTR_ERR(uobj);
>  +
>  +	/*
>  +	 * FIXME: After destroy this is not safe. We no longer hold the rwsem
>  +	 * so disassociation could have completed and unloaded the module that
>  +	 * backs the uobj->type pointer.
>  +	 */
>  +	rdma_lookup_put_uobject(uobj, UVERBS_LOOKUP_WRITE);
>  +	return success_res;
>  +}
>  +
>  +/* alloc_uobj must be undone by uverbs_destroy_uobject() */
>  +static struct ib_uobject *alloc_uobj(struct ib_uverbs_file *ufile,
>   				     const struct uverbs_obj_type *type)
>   {
>  -	struct ib_uobject *uobj =3D kzalloc(type->obj_size, GFP_KERNEL);
>  +	struct ib_uobject *uobj;
>  +	struct ib_ucontext *ucontext;
>  +
>  +	ucontext =3D ib_uverbs_get_ucontext(ufile);
>  +	if (IS_ERR(ucontext))
>  +		return ERR_CAST(ucontext);
>  =20
>  +	uobj =3D kzalloc(type->obj_size, GFP_KERNEL);
>   	if (!uobj)
>   		return ERR_PTR(-ENOMEM);
>   	/*

This is now a conflict between Linus' tree and the rdma tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/zOcmKmKGd1wbzSdKd=XJ8pm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzhyIACgkQAVBC80lX
0Gyg+Af+Lv18Y1xa+/ba6R2Kw8jzz62Ym3xr0x45z0tt2pC3khexKtuQBxLosWGA
Oo8KGdWvVil8vo0S6TSQ7Dh+zewYtSB3NEye7NQ9AFNAyBJwwSmiUwyvZo/mkNgj
KU6KdBHx3ANADrATnIuJK56RHJkOvtbD4KuczffiP3VZGLpLYMwuFp3mONEYrU1w
lu3IOkzjDxrzzJyBK3f8OInH6iUyoMAshu/Is7zE/pAfu/bH9LLBFn2Mu3UYsnqY
5vD76/GYHnRgdAHwS34+UrXeCyRBWR2cpP052j4DdlnOtCCIOrJ3NFRpq0ykcrFR
4ydAAPxjEjkgcEjRQlMdFloFNQqvJg==
=ocjY
-----END PGP SIGNATURE-----

--Sig_/zOcmKmKGd1wbzSdKd=XJ8pm--
