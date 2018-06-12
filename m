Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6C606C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E75208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="kfvru/5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E75208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754380AbeFLKal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:30:41 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39613 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754100AbeFLKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:30:38 -0400
Received: by mail-lf0-f66.google.com with SMTP id t134-v6so35197973lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=seVdsKj0EQqMOF4CwT0aE9lpFmK2oc2WEb1GlFRmp/w=;
        b=kfvru/5eFh3HH50kPj1Q3ZaJHW0/PUE3dV5WJJ/XbvNqzmJx64N9kM5R6Cx1sjO3Cn
         RZ5+S432OPanaEwHLfOjnG9R2zz/QRNvPGXppF6VBY4QGvXcckztD3vheSAEhnaviCU5
         qCHRzdpcGOIhRVQw2KU7YamR/z8ILcnQeRYR0iGErCrXCdsqc8UMVkhugAbvWinyoKxW
         W9uxHMaqnE1k5i/T/+sfEXlNObAzVLoGecMoZKtoVKLwQpunTkMF7jCHaG8WXq64nZVD
         2U/ChbGpI8s5xtaXP09B91T2xZ7lu6671eKzJCB0Eynd9UIqvoUaYXbdLtzIpvrE4JEX
         pqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=seVdsKj0EQqMOF4CwT0aE9lpFmK2oc2WEb1GlFRmp/w=;
        b=quMUtrgy6zcoVG6Juxol+bOVCmDzXDyra5J8hJ8Y5LVRQWkxL/OrF+kfAXLbf6Wev2
         PwscA+vFuIsiASPiptlcl/wBknSwH3OEjv4rcDSgkFj6nd4sWoiKM5CA5UdOBP+7FXcs
         z2NZFEHYN8JmUXaxLGvHEqxLAsMZokBY3abAwID8VV5WvWuNQxp/WPMTx2gzAyZ7rs5J
         E9OeBkgmG7Z/+DxHmDuU1ZvWrYxUYVQDYbc1/CQC81gxKrGbhb1F71X7UGqHO/MIOKA7
         10uzZWfMw8Ku4N6LZ+3tqDt1gukr1WPlHHlTk1LN4SU1IW7X0FzRdSA469KfpAaGrie5
         esrQ==
X-Gm-Message-State: APt69E3j6v2hI6oOsSowNfIeNWYzOVkNcHfj7r59n/1GJIi2byzK5fy0
        hjGQZOJBgf4ORYNDQCe0CbRbKg==
X-Google-Smtp-Source: ADUXVKKsNvUn99+ld/27T7eJE+tis6jZ6hHbZ0A/7pC9heWUx51QVgHsPTzFZWuFuK7XhsTv+KqmjA==
X-Received: by 2002:a2e:330b:: with SMTP id d11-v6mr1932969ljc.67.1528799437622;
        Tue, 12 Jun 2018 03:30:37 -0700 (PDT)
Received: from Macroninja.cnexlabs.com (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id f63-v6sm142211lje.79.2018.06.12.03.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 03:30:36 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: limit get chk meta request size
Date:   Tue, 12 Jun 2018 12:30:08 +0200
Message-Id: <20180612103008.19436-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For devices that does not specify a limit on its transfer size, the
get_chk_meta command may send down a single I/O retrieving the full
chunk metadata table. Resulting in large 2-4MB I/O requests. Instead,
split up the I/Os to a maximum of 256KB and issue them separately to
improve I/O latency.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index b9989717418d..3b644b0e9713 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -583,7 +583,13 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	struct ppa_addr ppa;
 	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
 	size_t log_pos, offset, len;
-	int ret, i;
+	int ret, i, max_len;
+
+	/*
+	 * limit requests to maximum 256K to avoid issuing arbitrary large
+	 * requests when the device does not specific a maximum transfer size.
+	 */
+	max_len = min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * 1024);
 
 	/* Normalize lba address space to obtain log offset */
 	ppa.ppa = slba;
@@ -596,7 +602,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	offset = log_pos * sizeof(struct nvme_nvm_chk_meta);
 
 	while (left) {
-		len = min_t(unsigned int, left, ctrl->max_hw_sectors << 9);
+		len = min_t(unsigned int, left, max_len);
 
 		ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK,
 				dev_meta, len, offset);
-- 
2.11.0

