Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320BDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CEF2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpvARHkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfAHDJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:09:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33361 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfAHDJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:09:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so1157221plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 19:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ew2wNgFvbLIz4YKqHPkR7qa5yqA7zyiirOjkBk6eK8U=;
        b=bpvARHkzVqJUTUZz+NrCBl+ZpxISKgOxqjPW9dcBB88G+hReMvjgs7R0d5B8hlbTpl
         ZzAOpsovn7Ic1fngD4un6dL8fLm8COy9MJKRj6JRmiSsXHJsMsFulGJvhfX3IR+lBCXM
         u1DUUjBSKmfEtSMW18oZpNUwNtoX3x3BzdznFMHVht4U4ORyK4aPMTgN973jtg1Hx2Pz
         05IcFIHYiDYXVZMmf/vbiML+E5ijZmxdPLZqGxRbqyLm+vYSPZcrR5/iS/2U0i7/j8HB
         MsunU5hjxRtXvr+ZJHGtkKvkJFaFsB9LsidP72VhOqBiVezIYFV+BLnhQYsvAme1zsPg
         s7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ew2wNgFvbLIz4YKqHPkR7qa5yqA7zyiirOjkBk6eK8U=;
        b=NCaWaEq6nntnkNnQwC3POLQxJ1NtIjd2DrnSVrZcad9K070NxJbG4af/2wtfJyj8g+
         bGMFmV1F76cczLdkmkISOcRHg6pPDL51ym+rXzmsD+suQB9EkY3hvx/BZQiTp9XsRbci
         DdIuLyDg5pQJ14xNKBJ4cK9Jq8xpDKezutR9rhO0uMQbTVsVVTlnay3JNQMHxPdumJvT
         diJ1knZM/E/wytggMuMMoS+js4Ty8Rurp4VjuF6z6m1Abb2FPXiQFwqgXumvqs5sJ8O7
         tMmQ+7JNM7rMZtQ5wi22sxnXzmTxKHBGi7ixCsbabmbBFGvB6P0P/Qg7MK+/un+QBToo
         xltA==
X-Gm-Message-State: AJcUukfpMjrT9McCVFKeXDC/w9KVE+q/2tREkm+7G0XrXMPeNAzAJhAH
        uqgvf4dionDbXJSwBXgUxUU=
X-Google-Smtp-Source: ALg8bN5EtC1yv7Y+q2j+ub0lb7Sf9fBuAilj2eSqjH8k0+5Jw4PyZm3Pnc9XxsFYp3WPKx5w+rflaQ==
X-Received: by 2002:a17:902:7848:: with SMTP id e8mr73719pln.100.1546916940168;
        Mon, 07 Jan 2019 19:09:00 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i21sm111995569pgm.17.2019.01.07.19.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 19:08:59 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-nvme@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-core: don't initlialize ctrl->cntlid twice
Date:   Mon,  7 Jan 2019 19:08:49 -0800
Message-Id: <20190108030849.12870-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ctrl->cntlid will already be initialized from id->cntlid for
non-NVME_F_FABRICS controllers few lines below. For NVME_F_FABRICS
controllers this field should already be initialized, otherwise the
check

	if (ctrl->cntlid != le16_to_cpu(id->cntlid))

below will always be a no-op.

Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

I created this patch just from readying NVMe code. Appologies for the
noise if I misread/misinterpreted things and this assignment is
actually necessary.

Thanks,
Andrey Smirnov

 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2e65be8b1387..1ec87b30fad1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2397,7 +2397,6 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->oaes = le32_to_cpu(id->oaes);
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
-	ctrl->cntlid = le16_to_cpup(&id->cntlid);
 	if (id->mdts)
 		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
 	else
-- 
2.20.1

