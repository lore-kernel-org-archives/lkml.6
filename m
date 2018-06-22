Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A567FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596BE23C5E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j/HGKhu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596BE23C5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934309AbeFVC1X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:27:23 -0400
Received: from ozlabs.org ([203.11.71.1]:42587 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933864AbeFVC1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:27:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41BjBt38g4z9s01;
        Fri, 22 Jun 2018 12:27:18 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529634438;
        bh=sAy/dfwiODDhn3kdDZpzq7y+bRQHwBQgENFUX7whL5M=;
        h=Date:From:To:Cc:Subject:From;
        b=j/HGKhu26F6x3Uj/T9DDcPJbcCk7JoNuMADuPLEx2gDuHZRB4qMGsD1sVyUAiILm/
         IkQA+kyD4uvVX7y7lMnQuptDsKvfbblsRNln2gjhdkVBaXi0+TcMreGryMgEwQHcO2
         GHEgbKVM6i8ng0+BTOnUzPJJnVvWI3D+WLNKUoCBcHfJjCahZ5YBbZbZiSJfLglGnz
         qSNZ1ES5VuhNeXJ+/03o+jzycxtnKUwJbpOI5bcAvk3le7IQe+VePzDZ5FqAggRKva
         gxa4q/t4ZogSBXaf2C29eJ7TsK2OooeCweiVQpyx6+KfWqEjKHU3eiPAjCQmumwnfc
         2XW9jY0bWiEHw==
Date:   Fri, 22 Jun 2018 12:27:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the rcu tree with the tip tree
Message-ID: <20180622122717.5f475829@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gRiojqRRqDt/R+sn+bWvhHC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gRiojqRRqDt/R+sn+bWvhHC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  kernel/rcu/tree_plugin.h

between commit:

  b3dae109fa89 ("sched/swait: Rename to exclusive")

from the tip tree and commit:

  57ada0a7f942 ("rcu: Convert grace-period requests to ->gp_seq")

from the rcu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/rcu/tree_plugin.h
index ad53d133f709,2cc9bf0d363a..000000000000
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@@ -2082,9 -2159,9 +2159,9 @@@ static void rcu_nocb_wait_gp(struct rcu
  	 */
  	trace_rcu_this_gp(rnp, rdp, c, TPS("StartWait"));
  	for (;;) {
 -		swait_event_interruptible(
 +		swait_event_interruptible_exclusive(
- 			rnp->nocb_gp_wq[c & 0x1],
- 			(d =3D ULONG_CMP_GE(READ_ONCE(rnp->completed), c)));
+ 			rnp->nocb_gp_wq[rcu_seq_ctr(c) & 0x1],
+ 			(d =3D rcu_seq_done(&rnp->gp_seq, c)));
  		if (likely(d))
  			break;
  		WARN_ON(signal_pending(current));

--Sig_/gRiojqRRqDt/R+sn+bWvhHC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlssXoYACgkQAVBC80lX
0GzsQAf/eE3UwZOlUHOWVtJE78DCUkEUU7ugTJm8X8ZreGWsujngUytKdVYEb9rd
bmDyF4AZNj5boDgKuBygw8dSv6GYcpHgF+m1IqbDbw2Au/OnMixe+3ZP+9JekfhQ
LNYW6p1FBfBjOcIcixThNT+mugAIFkaTgKr1akdqW7PuCkCH14Bk2F/7kdNWnGoV
JJhm5ZO4fTTCro4q2LU+F0Crer0f8eHHFVpRoJuI6c1uWK5uFQJR7EMQ9WeLMH6A
RC7+b2L/JzCdLJhXTRPrn+gpbydQBLOVYlZCTlaiRnYQsMtHBqcg2pq67zdFQyeH
FqbrdQ4OfgwzmoqpQukdlqSzMV5b4A==
=nCEk
-----END PGP SIGNATURE-----

--Sig_/gRiojqRRqDt/R+sn+bWvhHC--
