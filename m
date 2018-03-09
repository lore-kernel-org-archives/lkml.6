Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-872320-1520610544-2-16904347891429175558
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='fr',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520610543; b=SbstSrCjoPZ8uQoHTV7WWLtMKQtHdGTEP4p7WplO2OqkFV5
    3vKBR1BxQnFo5a5U7stpPAcWZ7m1X6+CP5DGdolDE/l0ShEl7JPbBgGDus6TzTSQ
    ocYp3XZaYmaPrFTS8q0SigK6qnOJ0sbF2HTV1sYzbykY8W8+kvvTZohoU+2fLngb
    dkrgslSvSdrCl7RpfsFbaoIv+7fEaVnBphHjIUdu8JJzWVKHgvfFP/rDM0z7iAw0
    HZAoaDxtFc+RfQwwgKdTxQ0v+e/gesYM/R8v7jsGp0iPLMuIwk2qBPQhnWspEyeo
    U2MSc/hFA4YKDOGuG3GVAQP67aNSxBesljwOlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:from:subject:to:cc:date:sender
    :list-id; s=arctest; t=1520610543; bh=ZBtggGLznW62gTdKm8NyduNNvM
    3rzZ6B9uB48hPRIdQ=; b=vhcSZDlv5svuTvWNvg9SPO2p+lkKdYIuRlO8jLBToe
    7HHghOQG0JJp2+LKiURXV43Csx/e2wwxCaa7T1fgd6V1VHZ/KZ0pSCBlVrkXyy4g
    GmaMQj9Ip+e8fm1Rn7jj+COvlXEvtlcW5kV9rIxGqDxsy26XREKtvbyT4JSdxhJI
    YuOCdoGctWygrfUHv+pKg02K6RGMUx8tzXRz5oiPGVVybAutGDJ0hf16hTln2vXj
    PAZAItUtB0DV0FjenWO1pOHNimIf/OIokhbl4kPJnQ3ntw0kxdqKnG7kqmevEEDs
    1q8aGyk8pzIFiVMmQthOt1Pg8VbRfm+g2SDx1V9Dmj9A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbeCIPtC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 10:49:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:34765 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbeCIPtB (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Mar 2018 10:49:01 -0500
Message-Id: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4.14 1/4] powerpc/mm/slice: Remove intermediate bitmap copy
To: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  9 Mar 2018 16:48:59 +0100 (CET)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Upstream 326691ad4f179e6edc7eb1271e618dd673e4736d

bitmap_or() and bitmap_andnot() can work properly with dst identical
to src1 or src2. There is no need of an intermediate result bitmap
that is copied back to dst in a second step.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/slice.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 45f6740dd407..a7ac600f71c6 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -379,21 +379,17 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 
 static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
 {
-	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
-
 	dst->low_slices |= src->low_slices;
-	bitmap_or(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
-	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
+	bitmap_or(dst->high_slices, dst->high_slices, src->high_slices,
+		  SLICE_NUM_HIGH);
 }
 
 static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *src)
 {
-	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
-
 	dst->low_slices &= ~src->low_slices;
 
-	bitmap_andnot(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
-	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
+	bitmap_andnot(dst->high_slices, dst->high_slices, src->high_slices,
+		      SLICE_NUM_HIGH);
 }
 
 #ifdef CONFIG_PPC_64K_PAGES
-- 
2.13.3
