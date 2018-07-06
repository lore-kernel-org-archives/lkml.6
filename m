Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA82C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A7223E47
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A7223E47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933083AbeGFMik (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:38:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41356 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932776AbeGFMig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:38:36 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w66CSqHs001842;
        Fri, 6 Jul 2018 14:38:34 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k0dnx6ca1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 06 Jul 2018 14:38:34 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AB5A434;
        Fri,  6 Jul 2018 12:38:33 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F6924DFE;
        Fri,  6 Jul 2018 12:38:33 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 6 Jul 2018 14:38:33
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH 1/1] remoteproc: replace "%p" with "%pK"
Date:   Fri, 6 Jul 2018 14:38:27 +0200
Message-ID: <1530880707-29333-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

This patch proposes changes for remoteproc core only.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c    | 6 +++---
 drivers/remoteproc/remoteproc_debugfs.c | 4 ++--
 drivers/remoteproc/remoteproc_virtio.c  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index a9609d9..c597f0c 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -241,7 +241,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	if (notifyid > rproc->max_notifyid)
 		rproc->max_notifyid = notifyid;
 
-	dev_dbg(dev, "vring%d: va %p dma %pad size 0x%x idr %d\n",
+	dev_dbg(dev, "vring%d: va %pK dma %pad size 0x%x idr %d\n",
 		i, va, &dma, size, notifyid);
 
 	rvring->va = va;
@@ -497,7 +497,7 @@ static int rproc_handle_trace(struct rproc *rproc, struct fw_rsc_trace *rsc,
 
 	rproc->num_traces++;
 
-	dev_dbg(dev, "%s added: va %p, da 0x%x, len 0x%x\n",
+	dev_dbg(dev, "%s added: va %pK, da 0x%x, len 0x%x\n",
 		name, ptr, rsc->da, rsc->len);
 
 	return 0;
@@ -635,7 +635,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
 		goto free_carv;
 	}
 
-	dev_dbg(dev, "carveout va %p, dma %pad, len 0x%x\n",
+	dev_dbg(dev, "carveout va %pK, dma %pad, len 0x%x\n",
 		va, &dma, rsc->len);
 
 	/*
diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index a204883..a5c29f2 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -231,7 +231,7 @@ static int rproc_rsc_table_show(struct seq_file *seq, void *p)
 			}
 			break;
 		default:
-			seq_printf(seq, "Unknown resource type found: %d [hdr: %p]\n",
+			seq_printf(seq, "Unknown resource type found: %d [hdr: %pK]\n",
 				   hdr->type, hdr);
 			break;
 		}
@@ -260,7 +260,7 @@ static int rproc_carveouts_show(struct seq_file *seq, void *p)
 
 	list_for_each_entry(carveout, &rproc->carveouts, node) {
 		seq_puts(seq, "Carveout memory entry:\n");
-		seq_printf(seq, "\tVirtual address: %p\n", carveout->va);
+		seq_printf(seq, "\tVirtual address: %pK\n", carveout->va);
 		seq_printf(seq, "\tDMA address: %pad\n", &carveout->dma);
 		seq_printf(seq, "\tDevice address: 0x%x\n", carveout->da);
 		seq_printf(seq, "\tLength: 0x%x Bytes\n\n", carveout->len);
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index b0633fd..bbecd44 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -96,7 +96,7 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 	size = vring_size(len, rvring->align);
 	memset(addr, 0, size);
 
-	dev_dbg(dev, "vring%d: va %p qsz %d notifyid %d\n",
+	dev_dbg(dev, "vring%d: va %pK qsz %d notifyid %d\n",
 		id, addr, len, rvring->notifyid);
 
 	/*
-- 
1.9.1

