Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87222C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D87208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxOze8zX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D87208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbeGaNO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:14:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47050 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbeGaNO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:14:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so16274704wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 04:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cnkrYTmYlAJD9ngigCnsIaZgem3YqrbN0ULxW7ANfAs=;
        b=OxOze8zXOUNP/ykuSPfM/ULNgNyhcFi1bns33YV0+OatiavPxDiG+IzY5rD/jv5q/m
         +uc15HdNZhSsxLBHKzWLPXO61z2Zg9ivXs1zkbWNdG26UWX8NSaCTlQ4YNm611lnsnxT
         tsEr1GEIQ3YlZz30LXyYdXkOzlkx5BlmH6OLSazM0pNTc7nZ9EP2pF24LFH8q48XK69h
         60/7oMq+9te0gAxCpimwS2NRQKwYdyReIk3Lt6J74dRb50D117wFnBusVvMLhbZ7O+ww
         ysxpA1tURGwIUbyO7YrnXPTMJEXSM2TxrK9mV73jBEkaJZuMVdzSDXi7Az7u6csGzwpV
         XIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cnkrYTmYlAJD9ngigCnsIaZgem3YqrbN0ULxW7ANfAs=;
        b=iT7SYVSnDzmZJL/jLmrW4ljDwAZYFA85BXXUWcx0zOi2nmLRvLvpjBBm0MEDhPUyBZ
         B8Zq3ZP3bO5gHs//EYHiDPxWXlbhA1912a2QaMCbU25sE6q1VbBsFsLRTYww294DVWhO
         yKY33mOFDIjsF0LNdcGNK37z3zFapi3A4EA8giWpxBGhkwhH1L7PePBJ5GtETQQ5jvH8
         jh6+kgASAi5Wm55U6D8S6BU54T4Jc7FEb21RgDkSNjJ26b1YLYQwobdADIjRCofvhm0O
         Gq+yp311urKkZ4nqWHXCvH2d7YNIzO44BIvzRONsOS0byq3VTbFWhPgdl1LnxsbfTvM/
         WFGg==
X-Gm-Message-State: AOUpUlE5WUJ3knYX4r2fdTnoPH/msEuvV68JX26xdCNKE0Q3b0qe0LwC
        nYm09rowVIkBt2G6oEAiCqQ=
X-Google-Smtp-Source: AAOMgpfVZvJ0wAgS+sZf3c/l9pIdmNFE0BQwTSjnxg78Aior9+s5ft4Oa1zh3b3EK2Di8IQYWFXHPQ==
X-Received: by 2002:adf:cd82:: with SMTP id q2-v6mr21213633wrj.118.1533036871654;
        Tue, 31 Jul 2018 04:34:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id f17-v6sm16513137wrs.1.2018.07.31.04.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 04:34:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/7] staging: rtl8188eu: remove unnecessary parentheses - style
Date:   Tue, 31 Jul 2018 13:34:12 +0200
Message-Id: <20180731113415.1500-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731113415.1500-1-straube.linux@gmail.com>
References: <20180731113415.1500-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses to improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index a59eb017227f..5ddfc2ead127 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -436,14 +436,14 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
 		return _FAIL;
 	}
 
-	if ((!precvbuf->reuse) || (!precvbuf->pskb)) {
+	if (!precvbuf->reuse || !precvbuf->pskb) {
 		precvbuf->pskb = skb_dequeue(&precvpriv->free_recv_skb_queue);
 		if (precvbuf->pskb)
 			precvbuf->reuse = true;
 	}
 
 	/* re-assign for linux based on skb */
-	if ((!precvbuf->reuse) || (!precvbuf->pskb)) {
+	if (!precvbuf->reuse || !precvbuf->pskb) {
 		precvbuf->pskb = netdev_alloc_skb(adapter->pnetdev, MAX_RECVBUF_SZ);
 		if (!precvbuf->pskb) {
 			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("init_recvbuf(): alloc_skb fail!\n"));
-- 
2.18.0

