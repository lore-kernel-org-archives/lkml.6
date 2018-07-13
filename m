Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6209ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D9520875
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UOXUElO2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fCfHdSBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D9520875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeGMNuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:50:54 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39353 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729680AbeGMNuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:50:54 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jul 2018 09:50:53 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 04D91223F9;
        Fri, 13 Jul 2018 09:30:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 13 Jul 2018 09:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Q5mpZ1qMtAAzhNCWzQiOlHTbcCc1JSFTLzMu8RnFh
        a8=; b=UOXUElO2OFwZbGJ/38hfRFnm/FkN3ssPyS5/0B8oIes3QD5fCksP9ByF/
        pgVTo2/7m2UnpIfWvlWWcxqghj91YnUL8LlunJXIDf8U6Uf0DE5uJPBQ/YEgGcVB
        IDST18xQD8Sx2vCKvB52TChOceVTvuO1luN2mmROheNb2rNINHgldGYX6Gria6T6
        F3qpvHKq8zqZ8EVwI9rcx9+RSGwUaLsU1LjUym0b7CrpHZ+49xa1H0l/LRJEweQH
        sdZZv1JwZduyDbrVISGxwRVYr9Np2NPxBIbO4NJ/mBfIJEm4sN6bbwe9lZ9GnJSK
        OYBjxPtt6n+6rctXZg1TWzwrO4x8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Q5mpZ1qMtAAzhNCWz
        QiOlHTbcCc1JSFTLzMu8RnFha8=; b=fCfHdSBTlRaJnDsCGLszkWu5DFkVlHB+N
        1eagW7OkREnlQRyZ+le447zrzTu551kzPE1ixWs2J5PhZKaPp6Je6S1c9izJ/IDe
        iITH5qRGT/iccUZAeWSMgEabSqjRkl5G4oywsGYDVBSpEvEgj7TX+J02iyzqq9v6
        I2LsV8rkYVYwYvr5Rq5emJ7e4lgsm4xOPPKrQwNtEo/13VfACbFiDksp0/xR0/bp
        XU8//unMuT/q89JuXjjryufZ6uyKHyqJ1RT2huZFPiBZUh4jaenlZdF0dercNPUC
        aNnd4zBuD3QUffXOI2WZFSdCXmvYqPJVm8VuVDne5NcQq2rw3B89A==
X-ME-Proxy: <xmx:WalIW-4zKLdeLoGRNGtMsShNqJgscgf2GlrwtmORsUwJT3MJeICTCA>
    <xmx:WalIWy-XIsSDFz4hpMExJgOCFP9lKnl5HO4bdfanFu8bGvlFOZa14w>
    <xmx:WalIW1goZ5Fc3Jd92cfj4WhQAw6UkPe1wDy27eQjwp-NzvOkul1IvQ>
    <xmx:WalIW9Z2s8QIYo385Lup3eoewHjXP40slvj2RHctEkyB5EPcXiRuew>
    <xmx:WalIW4Ncx6z0SZbin2NYu39zwNRAzG9vE9JqczB6hG6OK-0q-_cTiQ>
    <xmx:WalIW76aNj1h3tYsqtsK1uwtcm5ndfpiAklY_q37mxrE2OTteQsaWg>
X-ME-Sender: <xms:WalIW76EU1OpQioNkd14qQQIwxHcap8nsMes5S4rrmD76l-WhR5CAQ>
Received: from apu2 (x4db33058.dyn.telefonica.de [77.179.48.88])
        by mail.messagingengine.com (Postfix) with ESMTPA id CCC2E1025C;
        Fri, 13 Jul 2018 09:30:00 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by apu2 (OpenSMTPD) with ESMTPSA id fc742fd6 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 13 Jul 2018 13:29:59 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Patrick Steinhardt <ps@pks.im>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Date:   Fri, 13 Jul 2018 15:29:57 +0200
Message-Id: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When power management for SCSI is enabled and if a device uses blk-mq,
it is possible to trigger a `NULL` pointer exception when resuming that
device. The NPE is triggered when trying to dereference the `request_fn`
function pointer of the device's `request_queue`:

    __blk_run_queue_uncond:470
    __blk_run_queue:490
    blk_post_runtime_resume:3889
    sdev_runtime_resume:263
    scsi_runtime_resume:275

When the SCSI device is being allocated by `scsi_alloc_sdev`, the
device's request queue will either be initialized via
`scsi_mq_alloc_queue` or `scsi_old_alloc_queue`. But the `request_fn`
member of the request queue is in fact only being set in
`scsi_old_alloc_queue`, which will then later cause the mentioned NPE.

Fix the issue by checking whether the `request_fn` is set in
`__blk_run_queue_uncond`. In case it is unset, we'll silently return and
not try to invoke the callback, thus fixing the NPE.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Since at least v4.14, I am easily able to trigger above NPE by
unplugging USB mass storage devices on my computer (Skylake, ASUS
Z170I) with CONFIG_SCSI_MQ_DEFAULT=y. The attached patch fixes
the issue, but keep in mind that this is my first patch, so the
proposed fix may not be appropriate at all. Feedback would be
highly appreciated.

 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f84a9b7b6f5a..0a2041660cd9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -456,7 +456,7 @@ inline void __blk_run_queue_uncond(struct request_queue *q)
 	lockdep_assert_held(q->queue_lock);
 	WARN_ON_ONCE(q->mq_ops);
 
-	if (unlikely(blk_queue_dead(q)))
+	if (unlikely(!q->request_fn) || unlikely(blk_queue_dead(q)))
 		return;
 
 	/*
-- 
2.18.0

