Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE4EC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE810222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GmnSyPkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbfBMAdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:33:36 -0500
Received: from ozlabs.org ([203.11.71.1]:52311 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732880AbfBMAde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:33:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zgVf3sKyz9sDr;
        Wed, 13 Feb 2019 11:33:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550018010;
        bh=23iUg4XCeuy8WCWE2wMs2zNYjBEKCjs0bGGlX9oE1Kk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GmnSyPkB+qEt9lrn3gzBVPAIewOT5RXWf+bXRrF0cB5VGaFo/Jae9tMHPhAsCSL81
         2ybI7U5h539JbHrAquENzEjIfmHoYS1G3ANQVeeSOlaURqH9vSYlgjFX4dR67M1AgM
         3RnjsWvmOU9hWL5Cyarmaq1+Xg1qtK11EjcuFFxlc8TP20/PnFwuJc5joKgweXRiU1
         KuDWYBGscpnXAuMxWxmt3D01T4FNTVTYMYPD2PqME/qMx3+tJKSdMS0LJ/pyiSUY/W
         RH1uWtpTtRsljy1MSgXgU3tj691WwE4azhvsCqSyRnimgWnPPFQCM0Ilob6QKx1q/h
         m8+4CEiBqm81w==
Date:   Wed, 13 Feb 2019 11:33:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20190213113327.78a7ceac@canb.auug.org.au>
In-Reply-To: <20190213111325.30cfc931@canb.auug.org.au>
References: <20190213111325.30cfc931@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6ZgmXHY6zflD8dOhO0L_Ve_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6ZgmXHY6zflD8dOhO0L_Ve_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 13 Feb 2019 11:13:25 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   net/sched/cls_tcindex.c
>=20
> between commits:
>=20
>   8015d93ebd27 ("net_sched: fix a race condition in tcindex_destroy()")
>   033b228e7f26 ("net_sched: fix a memory leak in cls_tcindex")
>=20
> from the net tree and commit:
>=20
>   12db03b65c2b ("net: sched: extend proto ops to support unlocked classif=
iers")
>=20
> from the net-next tree.
>=20
> I fixed it up (see the final resolution when linux-next is published)
> and can carry the fix as necessary. This is now fixed as far as
> linux-next is concerned, but any non trivial conflicts should be
> mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.

Actually, see the below resolution.

--=20
Cheers,
Stephen Rothwell

diff --cc net/sched/cls_tcindex.c
index 38bb882bb958,14d6b4058045..e6cf20bc8e80
--- a/net/sched/cls_tcindex.c
+++ b/net/sched/cls_tcindex.c
@@@ -559,34 -563,15 +560,34 @@@ static void tcindex_destroy(struct tcf_
  			    struct netlink_ext_ack *extack)
  {
  	struct tcindex_data *p =3D rtnl_dereference(tp->root);
 -	struct tcf_walker walker;
 +	int i;
 =20
  	pr_debug("tcindex_destroy(tp %p),p %p\n", tp, p);
 -	walker.count =3D 0;
 -	walker.skip =3D 0;
 -	walker.fn =3D tcindex_destroy_element;
 -	tcindex_walk(tp, &walker, true);
 =20
 -	call_rcu(&p->rcu, __tcindex_destroy);
 +	if (p->perfect) {
 +		for (i =3D 0; i < p->hash; i++) {
 +			struct tcindex_filter_result *r =3D p->perfect + i;
 +
 +			tcf_unbind_filter(tp, &r->res);
 +			if (tcf_exts_get_net(&r->exts))
 +				tcf_queue_work(&r->rwork,
 +					       tcindex_destroy_rexts_work);
 +			else
 +				__tcindex_destroy_rexts(r);
 +		}
 +	}
 +
 +	for (i =3D 0; p->h && i < p->hash; i++) {
 +		struct tcindex_filter *f, *next;
 +		bool last;
 +
 +		for (f =3D rtnl_dereference(p->h[i]); f; f =3D next) {
 +			next =3D rtnl_dereference(f->next);
- 			tcindex_delete(tp, &f->result, &last, NULL);
++			tcindex_delete(tp, &f->result, &last, false, NULL);
 +		}
 +	}
 +
 +	tcf_queue_work(&p->rwork, tcindex_destroy_work);
  }
 =20
 =20

--Sig_/6ZgmXHY6zflD8dOhO0L_Ve_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjZdcACgkQAVBC80lX
0GzwXwf+P/P0Pvg5DWt7UC+QZRPFZyQHcozuS3V7I0ubGDP+KUp6vR4QWGmTE8PK
NC0tm4ZE4z9tfjtnHFP3SRDOQpn26KbwCVHgZlKU7/Ws28ep89lgOmTt1/fa8iLg
DsVKmhfj+DcZ4VPIocXYKNFn+no0/6wjOuMJOHWnFD498a4l3ZQ3asbWqQ/6uBS+
BCVRxa6TRBLA3DM+Djy2PpEqI13wB3MAQp+JvCkOBztdBR4UOQnVy4pNDpF4OmOs
ujG22TNcq+km/2zmjuZap0gn779F8D8Y8aprbhHY9A+AWWH1S95Sdp0U5AxRQKW3
N6R+qcUBCpyrIvNBV4+MjuFDEE8jJQ==
=+ZAS
-----END PGP SIGNATURE-----

--Sig_/6ZgmXHY6zflD8dOhO0L_Ve_--
