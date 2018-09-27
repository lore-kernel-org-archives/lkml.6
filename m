Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADFAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AF9216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="LoGVoJxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AF9216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeI1Dft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:35:49 -0400
Received: from sonic308-3.consmr.mail.bf2.yahoo.com ([74.6.130.42]:37877 "EHLO
        sonic308-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727331AbeI1Dft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1538082935; bh=BHUCGebeB0Kbn5Sr/q3u+Ga0rAk709Yak3bFRcDeCWE=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject; b=LoGVoJxfrxmEOqKBepeBcoRvYmLli1YkzSR0WadVyc/9J253j9SUowhkk4kyVUyIbl0wII5KBNrv49SLb0pmU/osRcluMx0J9zF2QtpY3bE3WlRmcrFXGYoA9i10ggCqeIkzVr+jRgj39okA3Wkv2lZuT6WHxaufyigutitKp/ccpOD+3dlgRMSxXOvwrAj7rZblR7CdGemqtaebFjrHxhJin5fEeWzz3EKb0+imqLmDUGp+8ZEJN/t05Z4tGwRiT9jt+7oipdjyKVadmE/+wXdF0MHAPGvZ7lazXSsAQF//HAXFxBp1Fkl67eiSD77AMXzoOWcUfeFwQA2c07x6/g==
X-YMail-OSG: A7cFwU8VM1lmI97hCYneR_2l1Q59PYukx4rxsp7PqU26b5l2ebHKcz7c4uOjNJ1
 j.4quA1OCdqRmojslr01rCi.NRKEKnVVSNJs1CaSb0VdSwUHJOAc7Dk45XUkxfHkoVxy75Q90GDM
 CLtjdihaWgCU1gDsblH.rFcPQJIup5n3s3FGLtgziFooCIxXhhnTkVmO6JYPNliPBsnxMLZUz_K_
 XLjsPWBrwBzw8YLDv8wLUhyehSs54vpycLE.IMgAR61jMQJT5oHKnxDupMMhcqEI5ih6jQUKtFU6
 6QvE3y38NYMpump0kOwUX.Uk2GVNf1QbH1b3nKV1FysyKAv2FOyrLzsu_Ef_fkw5l6R6a_EjqiJg
 J7OrX8NN2KsTncyfRlUeD6WzNeDgRrMBcCv13hrPOrk_9CzeEsexNVDIpZPGCdggGqbOitsviQSS
 bANJkzsRX.WgPHE76capOACIQtXkMi2CJxu2s75v_IsXWg.GYfOEYg4ej_FkeQdB9Cn3J3x.NlzS
 oQ.VGaHZCC0ptofFplP6miAs2MBI4VgQI1CPl3In2Xiae8X89sz_NQfYX_d3NbISJWRNR648yJ9V
 Oqu_cuhTQAIQyJq2h4VL8ZEqot7VCAIONyhl1yOBhBN59NHlbMOVj4QZRl_HVLjIIlUmL_FMFLYx
 027N5cBjJqoviuJN6t4d4uSn40hmDSJtOKdmlGtyU0H4dH9N6VjHuwe4v2gmLsdff52bzJOq3dJe
 w6YZP2vpOkI5iJj6vXBQFv_YOyjQ3MDoKEKyggvwhneT0Nv22dz95ie.ZmS8XMsEmPjnR3FY47rl
 i9Xu6CrG6d83NGnwilykKmWdoDNT07IhDYhik0y23E0RQyl7wwmF1AsAgPcoDIyPaDBled1RWqJv
 Sq2lCaKdecZuVAlqEo0HRlYtzUXRtqVZgxfqBhWRpifaNElUp.Dbai2A.LT2G3NYoi6xE2Jfsxi1
 bwpKGPBRZVsGAzYZY9UXqTt8L6zvqdqN42nvoTUulIC4etabbIj7e4Mnvg7V0Gig5t1CQhPjjpeO
 G9zSyyzzXMo85u7aG
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Thu, 27 Sep 2018 21:15:35 +0000
Received: from pink.alxu.ca (EHLO localhost) ([198.98.62.56])
          by smtp405.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 25f9d54bd857af37af9792a99e179ceb;
          Thu, 27 Sep 2018 21:15:32 +0000 (UTC)
Date:   Thu, 27 Sep 2018 17:15:27 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH v2] mm: fix z3fold warnings on CONFIG_SMP=n
To:     Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <1538079759.qxp8zh3nwh.astroid@alex-archsus.none>
        <CALZtONA9r6=gnK-5a++tjaReqEnRzrBb3hzYMTFNXZ13z+UOWQ@mail.gmail.com>
        <153808275043.724.15980761008814866300@pink.alxu.ca>
In-Reply-To: <153808275043.724.15980761008814866300@pink.alxu.ca>
User-Agent: astroid/0.13.0 (https://github.com/astroidmail/astroid)
Message-Id: <1538082779.246sm0vb2p.astroid@alex-archsus.none>
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
 mm/z3fold.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 4b366d181..2e8d268ac 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -277,7 +277,7 @@ static void release_z3fold_page_locked(struct kref *ref=
)
 {
 	struct z3fold_header *zhdr =3D container_of(ref, struct z3fold_header,
 						refcount);
-	WARN_ON(z3fold_page_trylock(zhdr));
+	WARN_ON_SMP(z3fold_page_trylock(zhdr));
 	__release_z3fold_page(zhdr, true);
 }
=20
@@ -289,7 +289,7 @@ static void release_z3fold_page_locked_list(struct kref=
 *ref)
 	list_del_init(&zhdr->buddy);
 	spin_unlock(&zhdr->pool->lock);
=20
-	WARN_ON(z3fold_page_trylock(zhdr));
+	WARN_ON_SMP(z3fold_page_trylock(zhdr));
 	__release_z3fold_page(zhdr, true);
 }
=20
@@ -403,7 +403,7 @@ static void do_compact_page(struct z3fold_header *zhdr,=
 bool locked)
=20
 	page =3D virt_to_page(zhdr);
 	if (locked)
-		WARN_ON(z3fold_page_trylock(zhdr));
+		WARN_ON_SMP(z3fold_page_trylock(zhdr));
 	else
 		z3fold_page_lock(zhdr);
 	if (WARN_ON(!test_and_clear_bit(NEEDS_COMPACTING, &page->private))) {
--=20
2.19.0

=
