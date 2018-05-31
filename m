Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932722AbeEaBtT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 21:49:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44416 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932593AbeEaBtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 21:49:16 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] nvmet: fix a typo in nvmet_file_ns_enable()
Date: Thu, 31 May 2018 01:55:58 +0000
Message-ID: <1527731758-142629-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in nvmet_file_ns_enable().

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/nvme/target/io-cmd-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index ca1ccf8..9cff553 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -34,7 +34,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 			O_RDWR | O_LARGEFILE | O_DIRECT, 0);
 	if (IS_ERR(ns->file)) {
 		pr_err("failed to open file %s: (%ld)\n",
-				ns->device_path, PTR_ERR(ns->bdev));
+				ns->device_path, PTR_ERR(ns->file));
 		return PTR_ERR(ns->file);
 	}
