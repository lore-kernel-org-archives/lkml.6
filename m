Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E951C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA3120652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbfAPWei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:34:38 -0500
Received: from ms.lwn.net ([45.79.88.28]:52788 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732911AbfAPWei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:34:38 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CDF81300;
        Wed, 16 Jan 2019 22:34:37 +0000 (UTC)
Date:   Wed, 16 Jan 2019 15:34:36 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] dma-buf: Fix kerneldoc comment for struct dma_fence_array
Message-ID: <20190116153436.3b244cda@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kerneldoc comment for struct dma_fence_array lacks a description
of the "work" member, leading to this docs-build warning:

  ./include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'

Add a description and make the warning go away.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
Hopefully I've sent this to the right place; perhaps this file needs to be
added to the MAINTAINERS entry?

 include/linux/dma-fence-array.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/dma-fence-array.h b/include/linux/dma-fence-array.h
index bc8940ca280d..c0ff417b4770 100644
--- a/include/linux/dma-fence-array.h
+++ b/include/linux/dma-fence-array.h
@@ -40,6 +40,7 @@ struct dma_fence_array_cb {
  * @num_fences: number of fences in the array
  * @num_pending: fences in the array still pending
  * @fences: array of the fences
+ * @work: internal irq_work function
  */
 struct dma_fence_array {
 	struct dma_fence base;
-- 
2.20.1

