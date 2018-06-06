Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="Uy8JLtT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 602A8607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932256AbeFFPZd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:25:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53396 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932195AbeFFPZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:25:29 -0400
X-Google-Smtp-Source: ADUXVKJzMQQdFm9RKAa/efVp9ZD+TkRv5D3FFwi6EgC4AoKjWvmgoBjnWO5p7ld103yzlLH1R15bMA==
From: Roman Pen <roman.penyaev@profitbricks.com>
To: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@profitbricks.com>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/25] sysfs: export sysfs_remove_file_self()
Date: Wed,  6 Jun 2018 17:24:51 +0200
Message-Id: <20180606152515.25807-2-roman.penyaev@profitbricks.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20180606152515.25807-1-roman.penyaev@profitbricks.com>
References: <20180606152515.25807-1-roman.penyaev@profitbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function is going to be used in transport over RDMA module
in subsequent patches.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 fs/sysfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 5c13f29bfcdb..ff7443ac2aa7 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -444,6 +444,7 @@ bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *attr)
 	kernfs_put(kn);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(sysfs_remove_file_self);
 
 void sysfs_remove_files(struct kobject *kobj, const struct attribute **ptr)
 {
-- 
2.13.1
