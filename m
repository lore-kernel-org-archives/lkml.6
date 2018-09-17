Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DD5ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B1A2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8IGhvPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B1A2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeIQSHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:07:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36560 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbeIQSHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:07:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so7516582pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KC3PdfmgH0ZMOrLJHcQpbROB9hoqev3XLFUCQ2iDNRk=;
        b=R8IGhvPsHm3jIIvP4DE1nzp76IE9xiOQqrDpHTGGGbWVzBWzLXbuBo37FS8gdNA/Ow
         E2gBptYqT+lBfzDBwnm+BINQ/GDv8bxe4NDAso0SBC3Zwmk+qJ0DEWPhaQ9wVtl93zDN
         KznSQDEaGb2DM6yEYkOXRMBh7mmcJMXQWBcmbJyN/iaWJxX0Ol/pcQmsMkRqyzgrYSSQ
         tiRHQTHwVniOTTTiOaoNV/pbXYLwdZz7yNzpZKoNyghYqMBNPBmO5f5P4/2GGCx8W5au
         X7ZNfi9NiIp+08/vsoQjdj1y5PpGaV9eBHWZlL2LWdwTy6FBRxV0R15d//bWIVy7ZaTB
         rmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KC3PdfmgH0ZMOrLJHcQpbROB9hoqev3XLFUCQ2iDNRk=;
        b=m0bqLicY0LytQWwy2A8CkPcNkEFEGs7LVYNhRQN6prKy3DLMy1loxa+KqdwNat5BSj
         6Y2aPnlMVuLIva98Ztdtzki8/EaB0QLujGRsnbVlPlNzf1oaJU4g5DR8E+mnNzPJo4Yp
         5/26xpQBkftiLDAgxoCdlHz6MX7ZeUpdDekIcAyCX4bRL/wPzhdMu0LbnaB97QqAVILv
         aegvKRgh2byBiOjcYxjw+qILOsfTYmorvqVGPHlJqoVCtbfb5phOEns4Jj/1IHiwi2Uw
         N8Xb3IbrXwFur3XhxDrwLMEDuax+3+jc3dHcTxI4+30PoC7nwMVThgK8YY1QiBDYyv9S
         7NAQ==
X-Gm-Message-State: APzg51ASimWr9lkhLWvDq/EksFl7rjoYs5RzKXO0b4EdUhotf/4El/0c
        b/70zukRiTBHG3J6EKAywYA=
X-Google-Smtp-Source: ANB0VdaREtA+0di9lXPtl/cYVMMlKSG2jHawHYEtGpP970Q44RM5Ye7lUUtk3XdJC+PkCo8kzrz8dw==
X-Received: by 2002:a63:4306:: with SMTP id q6-v6mr23813643pga.181.1537187990564;
        Mon, 17 Sep 2018 05:39:50 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id v22-v6sm26960020pfi.60.2018.09.17.05.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 05:39:49 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 06/10] staging: gasket: page_table: don't unmap coherent pages
Date:   Mon, 17 Sep 2018 05:39:01 -0700
Message-Id: <20180917123905.213639-7-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917123905.213639-1-toddpoynor@gmail.com>
References: <20180917123905.213639-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

Only call dma_unmap_page if there was an associated dma_map_page call.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 8fe27e7d1b53c..33d98043953a5 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -610,7 +610,7 @@ static void gasket_perform_unmapping(struct gasket_page_table *pg_tbl,
 
 		/* release the address from the driver, */
 		if (ptes[i].status == PTE_INUSE) {
-			if (ptes[i].dma_addr) {
+			if (ptes[i].page && ptes[i].dma_addr) {
 				dma_unmap_page(pg_tbl->device, ptes[i].dma_addr,
 					       PAGE_SIZE, DMA_BIDIRECTIONAL);
 			}
-- 
2.19.0.397.gdd90340f6a-goog

