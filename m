Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5625C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400F920864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rU49X4Oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400F920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754577AbeFRD1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 23:27:17 -0400
Received: from ozlabs.org ([203.11.71.1]:37315 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754525AbeFRD1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 23:27:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418Gjs0cbXz9s31;
        Mon, 18 Jun 2018 13:27:13 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529292433;
        bh=gmEuRIHaOPGacHQgbXzy6g7lOMBfqAT72B3sx5zc4zk=;
        h=Date:From:To:Cc:Subject:From;
        b=rU49X4OaFOT8RxIhsG2Be4l+MJn1usm6mNHHtdvLjaYIWy4HSanAWETatzMhpbq7U
         Wg4e677pmsk4pKdToZOFRzi8NjpeoQ+pHROBgKL7U8zThu1erdb1rCoGP3bzfydo3N
         bb2EMHHCi0cWF1jo5+ZISt6lY0t+0WY8Np+my963P2GAOO6H+3Zfcck1TuvRy7vCCL
         8VNJJbzpJgDIJ1/kCxb9YW1D+2V1qRCmnq/LNm4dZBaJJqQmYnkcS5i+uFTa5kEzlp
         GCF2Ral6MKMPlt0vQtheBFVi+dYyh/7eOR3WEcAlaahKyQ0usPdpy3p6XziaubeSsX
         oU/0IMCFfsKgg==
Date:   Mon, 18 Jun 2018 13:27:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the xarray tree
Message-ID: <20180618132712.4b4eddc9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LsG.RDVAgR=GMWX/CY4I+EC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LsG.RDVAgR=GMWX/CY4I+EC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the xarray tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from arch/powerpc/include/asm/bug.h:128:0,
                 from include/linux/bug.h:5,
                 from arch/powerpc/include/asm/cmpxchg.h:9,
                 from arch/powerpc/include/asm/atomic.h:11,
                 from include/linux/atomic.h:5,
                 from fs/dax.c:17:
fs/dax.c: In function 'dax_lock_page':
fs/dax.c:392:21: error: implicit declaration of function 'radix_tree_except=
ional_entry'; did you mean 'radix_tree_exception'? [-Werror=3Dimplicit-func=
tion-declaration]
       WARN_ON_ONCE(!radix_tree_exceptional_entry(entry))) {
                     ^
include/asm-generic/bug.h:69:25: note: in definition of macro 'WARN_ON_ONCE'
  int __ret_warn_on =3D !!(condition);   \
                         ^~~~~~~~~
fs/dax.c:395:15: error: implicit declaration of function 'slot_locked'; did=
 you mean 'iget_locked'? [-Werror=3Dimplicit-function-declaration]
   } else if (!slot_locked(mapping, slot)) {
               ^~~~~~~~~~~
               iget_locked
fs/dax.c:396:4: error: implicit declaration of function 'lock_slot'; did yo=
u mean 'local_set'? [-Werror=3Dimplicit-function-declaration]
    lock_slot(mapping, slot);
    ^~~~~~~~~
    local_set
fs/dax.c:402:28: error: passing argument 1 of 'dax_entry_waitqueue' from in=
compatible pointer type [-Werror=3Dincompatible-pointer-types]
   wq =3D dax_entry_waitqueue(mapping, index, entry, &ewait.key);
                            ^~~~~~~
fs/dax.c:152:27: note: expected 'struct xa_state *' but argument is of type=
 'struct address_space *'
 static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
                           ^~~~~~~~~~~~~~~~~~~
fs/dax.c:402:37: warning: passing argument 2 of 'dax_entry_waitqueue' makes=
 pointer from integer without a cast [-Wint-conversion]
   wq =3D dax_entry_waitqueue(mapping, index, entry, &ewait.key);
                                     ^~~~~
fs/dax.c:152:27: note: expected 'void *' but argument is of type 'long unsi=
gned int'
 static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
                           ^~~~~~~~~~~~~~~~~~~
fs/dax.c:402:8: error: too many arguments to function 'dax_entry_waitqueue'
   wq =3D dax_entry_waitqueue(mapping, index, entry, &ewait.key);
        ^~~~~~~~~~~~~~~~~~~
fs/dax.c:152:27: note: declared here
 static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
                           ^~~~~~~~~~~~~~~~~~~
fs/dax.c: In function 'dax_unlock_page':
fs/dax.c:424:2: error: implicit declaration of function 'dax_unlock_mapping=
_entry'; did you mean 'dax_delete_mapping_entry'? [-Werror=3Dimplicit-funct=
ion-declaration]
  dax_unlock_mapping_entry(mapping, page->index);
  ^~~~~~~~~~~~~~~~~~~~~~~~
  dax_delete_mapping_entry

Caused by commits in the xarray tree interacting with commit

  9b3d53936caa ("filesystem-dax: Introduce dax_lock_page()")

from the nvdimm tree.

Willy thanks for the heads up about this.

I have applied the following merge fix patch (taken from the diff between
the -next tree at this point and the xarray-20180615 branch from the
xarray tree) for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 18 Jun 2018 13:17:15 +1000
Subject: [PATCH] filesystem-dax: fixups for xaarray changes

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/dax.c | 75 +++++++++++++++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 579088945add..91f7bce6ce64 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -350,78 +350,71 @@ static struct page *dax_busy_page(void *entry)
=20
 struct page *dax_lock_page(unsigned long pfn)
 {
-	pgoff_t index;
-	struct inode *inode;
-	wait_queue_head_t *wq;
-	void *entry =3D NULL, **slot;
+	struct page *page =3D pfn_to_page(pfn);
+	XA_STATE(xas, NULL, 0);
+	void *entry;
 	struct address_space *mapping;
-	struct wait_exceptional_entry_queue ewait;
-	struct page *ret =3D NULL, *page =3D pfn_to_page(pfn);
=20
-	rcu_read_lock();
 	for (;;) {
+		rcu_read_lock();
 		mapping =3D READ_ONCE(page->mapping);
=20
-		if (!mapping || !IS_DAX(mapping->host))
+		if (!mapping || !IS_DAX(mapping->host)) {
+			page =3D NULL;
 			break;
+		}
=20
 		/*
 		 * In the device-dax case there's no need to lock, a
 		 * struct dev_pagemap pin is sufficient to keep the
 		 * inode alive.
 		 */
-		inode =3D mapping->host;
-		if (S_ISCHR(inode->i_mode)) {
-			ret =3D page;
+		if (S_ISCHR(mapping->host->i_mode))
 			break;
-		}
=20
-		xa_lock_irq(&mapping->i_pages);
+		xas.xa =3D &mapping->i_pages;
+		xas_lock_irq(&xas);
+		rcu_read_unlock();
 		if (mapping !=3D page->mapping) {
 			xa_unlock_irq(&mapping->i_pages);
 			continue;
 		}
-		index =3D page->index;
-
-		init_wait(&ewait.wait);
-		ewait.wait.func =3D wake_exceptional_entry_func;
-
-		entry =3D __radix_tree_lookup(&mapping->i_pages, index, NULL,
-				&slot);
-		if (!entry ||
-		    WARN_ON_ONCE(!radix_tree_exceptional_entry(entry))) {
-			xa_unlock_irq(&mapping->i_pages);
-			break;
-		} else if (!slot_locked(mapping, slot)) {
-			lock_slot(mapping, slot);
-			ret =3D page;
-			xa_unlock_irq(&mapping->i_pages);
-			break;
+		xas_set(&xas, page->index);
+		entry =3D xas_load(&xas);
+		if (dax_is_locked(entry)) {
+			entry =3D get_unlocked_entry(&xas);
+			/* Did the page move while we slept? */
+			if (dax_to_pfn(entry) !=3D pfn) {
+				xas_unlock_irq(&xas);
+				continue;
+			}
 		}
-
-		wq =3D dax_entry_waitqueue(mapping, index, entry, &ewait.key);
-		prepare_to_wait_exclusive(wq, &ewait.wait,
-				TASK_UNINTERRUPTIBLE);
-		xa_unlock_irq(&mapping->i_pages);
-		rcu_read_unlock();
-		schedule();
-		finish_wait(wq, &ewait.wait);
-		rcu_read_lock();
+		dax_lock_entry(&xas, entry);
+		xas_unlock_irq(&xas);
+		goto out;
 	}
 	rcu_read_unlock();
=20
+out:
 	return page;
 }
=20
 void dax_unlock_page(struct page *page)
 {
 	struct address_space *mapping =3D page->mapping;
-	struct inode *inode =3D mapping->host;
+	XA_STATE(xas, &mapping->i_pages, page->index);
+	void *entry;
=20
-	if (S_ISCHR(inode->i_mode))
+	if (S_ISCHR(mapping->host->i_mode))
 		return;
=20
-	dax_unlock_mapping_entry(mapping, page->index);
+	xas_lock_irq(&xas);
+	entry =3D xas_load(&xas);
+	BUG_ON(!dax_is_locked(entry));
+	entry =3D dax_make_page_entry(page, entry);
+	xas_store(&xas, entry);
+	dax_wake_entry(&xas, entry, false);
+	xas_unlock_irq(&xas);
 }
=20
 /*
--=20
2.17.1

--=20
Cheers,
Stephen Rothwell

--Sig_/LsG.RDVAgR=GMWX/CY4I+EC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsnJpAACgkQAVBC80lX
0GwCZgf+Pnd2wWJRageqnxL3MDL78KoOt37qxCR3fUgrx7cpCcQBXnaGWgw7F0Qp
Yz3RCaF+7XXHq3YMmEO1uDtXgdFsZJhQjOxmknu7lsacRPX8YL+Fej0ue48C0pqj
PiKmRFutfzXO7nzp5Krad8KmI8pHIPAVrOTazGKknuE+44PBO/Q58QgJHV6dUJIP
HS+EgZSrzqIXXkBdGR4ti+3fYy87dzfxE250KtDGwn+D+ttB2Q11UpvFvgukPISg
mwsy/gaB+nCp/sPui8EYgg2PCtgLjkZpIg23FflVrQXh245c9olTcUcSttTUegK+
3YmJIGBkt0nRURfsxqRBbzQVm5ONRA==
=C/pL
-----END PGP SIGNATURE-----

--Sig_/LsG.RDVAgR=GMWX/CY4I+EC--
