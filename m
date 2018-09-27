Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DD0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD3321714
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="n5OmVUnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD3321714
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeI1Cr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:47:27 -0400
Received: from sonic316-21.consmr.mail.ne1.yahoo.com ([66.163.187.147]:34893
        "EHLO sonic316-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727389AbeI1Cr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1538080041; bh=gIneU/dzQhuezwAjGtFUv/uuI9eLjn06Oz2Tg7/K6eU=; h=Date:From:Subject:To:Cc:From:Subject; b=n5OmVUnQblo/fs8jKd0eInaWjruIXOSWViybKFaMPyQaD0AcIiUrUlMv7FwOSKiwgezRA56hWFtjNLvOo9NccUSPpU0g3Y5J4qe95d9o8AO0n0bA+4fUZLXxhntGV7+C90juHPI2dghIAX0OhTCn+hFXzHjQc7Y+B0Nwe48E02tIRXEfqWqv7XFEn4JzVj7l1sBSXdc/Bi5Po5KyP0Wj17btWfydPbkVZ3LJSdiuJZDkfuj+nI0JAb/qcLUjo2aFZ8J4O9fkFObYQXNEhvdHr4XSajxfRlJ8hl4k8CFQ5FBFTN5p+OAQCT70YxcIIf0IhxerlaFZbm1c/T8CpjYFXw==
X-YMail-OSG: t0_gF3sVM1n9co6J8PEqzeWVxjLIkOV3t0g0eeAlIeOuKNx6zvNjDOf7062mUlW
 GCUy7wRZn4eTnnrCJ.G_zwUADQSfmpWu9V44aRESLZy4v05YUaBHvEnbSS9A0AKLFVpf3CLcUCoY
 k4f7j7Fso0JQPrva8Tz81xfxDpeeFUvtpJC0GlZxwUH32_8pyT1Fvd2ioDMIOOyLjN0ECncvLPsJ
 Pc9vRqNloqX2Fjluc0CBQ8tFn0uA1pkc.so9Df8GnxboqymA0lT_0inZZIANGP.QQg3uv15QG3TX
 lisdZuDnFqcxhn.54dlGNzGid.10oYkNYMlynxT5FLGayES3n2RUqLkmeBn_z91aF.FORFDBDnpY
 TNlbc6vIATHQLJgv28ZCK6jSFCgaIf7p5osNHuAQwJ.ijWrjudHeTcL2_ridiwIy3dEt_kX3pHvh
 Rga.2A3WeeehXjsneDY6WjkiXq7xA5mhnrwVrR5oVMjp.QUgRv1UFrkDtG0hRUPGCHKlPNa1E3EL
 XGiJ3cIRhXrpMy2L30vTpr1xqwntGgmJvmp0iHVfd1IFfBH9jhcFFayWuecnG45iL_efTwOJKZiB
 ofu4C_HICMHLFxkicLdTIIOh1qPuKCsd3VvE9weFzg07okjtdfOMy0hVh4f6v9h5CncTtfZ8A7c_
 CY00PsRxflFfVQRguR8Tq0NXoH_6WKjfwhuZsNSMLfevi2Ic5n7ZEqjw46JYQBpiMnV_auJ4hJQ2
 Kr5WUV.oiVs.edZwOc5bT3ZtTVbMZppgkleI.kfE8M.7i10hOEciuKZL28Uzbk7SrPHcmPdB1zCU
 oqwHcGgVygMEw_2OnPniYhLakTASYc4aQJ9vntEaNW_Ww5eBeuipimMS4Da9QuuFj4hECWF4Z4m.
 QCNd7ta53T.WaEYapxr4ZsV975WA1fhs69fjyu5Q0yN4rXrlpgf2b.kNSIiXl_J7GLcMJ3roYwT3
 RD5y8QLSh8pIjHDps1aNIF0_8iO5TU8qvCiT5GZ_Mpdi9drHSYUzB6nOKxLcVyXds4Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Sep 2018 20:27:21 +0000
Received: from pink.alxu.ca (EHLO localhost) ([198.98.62.56])
          by smtp418.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c87d8e9a43fcfc4d244e7731ae0e3424;
          Thu, 27 Sep 2018 20:27:18 +0000 (UTC)
Date:   Thu, 27 Sep 2018 16:27:12 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH] mm: fix z3fold warnings on CONFIG_SMP=n
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     ddstreet@ieee.org
User-Agent: astroid/0.13.0 (https://github.com/astroidmail/astroid)
Message-Id: <1538079759.qxp8zh3nwh.astroid@alex-archsus.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spinlocks are always lockable on UP systems, even if they were just
locked.

Cc: Dan Streetman <ddstreet@ieee.org>
Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---
 mm/z3fold.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 4b366d181..4e6ad2de4 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -202,6 +202,13 @@ static inline void z3fold_page_lock(struct z3fold_head=
er *zhdr)
 	spin_lock(&zhdr->page_lock);
 }
=20
+static inline void z3fold_page_ensure_locked(struct z3fold_header *zhdr)
+{
+#ifdef CONFIG_SMP
+	WARN_ON(z3fold_page_trylock(zhdr));
+#endif
+}
+
 /* Try to lock a z3fold page */
 static inline int z3fold_page_trylock(struct z3fold_header *zhdr)
 {
@@ -277,7 +284,7 @@ static void release_z3fold_page_locked(struct kref *ref=
)
 {
 	struct z3fold_header *zhdr =3D container_of(ref, struct z3fold_header,
 						refcount);
-	WARN_ON(z3fold_page_trylock(zhdr));
+	z3fold_page_ensure_locked(zhdr);
 	__release_z3fold_page(zhdr, true);
 }
=20
@@ -289,7 +296,7 @@ static void release_z3fold_page_locked_list(struct kref=
 *ref)
 	list_del_init(&zhdr->buddy);
 	spin_unlock(&zhdr->pool->lock);
=20
-	WARN_ON(z3fold_page_trylock(zhdr));
+	z3fold_page_ensure_locked(zhdr);
 	__release_z3fold_page(zhdr, true);
 }
=20
@@ -403,7 +410,7 @@ static void do_compact_page(struct z3fold_header *zhdr,=
 bool locked)
=20
 	page =3D virt_to_page(zhdr);
 	if (locked)
-		WARN_ON(z3fold_page_trylock(zhdr));
+		z3fold_page_ensure_locked(zhdr);
 	else
 		z3fold_page_lock(zhdr);
 	if (WARN_ON(!test_and_clear_bit(NEEDS_COMPACTING, &page->private))) {
--=20
2.19.0

=
