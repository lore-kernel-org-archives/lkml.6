Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeERNHi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:07:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37533 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbeERNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:05:29 -0400
X-Google-Smtp-Source: AB8JxZpyLeplvH3gfvAN0MJxrQj1twtHAsm5p6vM1/sxgRq+xruXlvWeZj9XkpF+XplnkYwbIhUWpw==
From: Roman Pen <roman.penyaev@profitbricks.com>
To: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Or Gerlitz <ogerlitz@mellanox.com>, Doug Ledford <dledford@redhat.com>,
        Swapnil Ingle <swapnil.ingle@profitbricks.com>,
        Danil Kipnis <danil.kipnis@profitbricks.com>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        Roman Pen <roman.penyaev@profitbricks.com>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/26] sysfs: export sysfs_remove_file_self()
Date: Fri, 18 May 2018 15:03:49 +0200
Message-Id: <20180518130413.16997-3-roman.penyaev@profitbricks.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
References: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function is going to be used in transport over RDMA module
in subsequent patches.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Tejun Heo <tj@kernel.org>
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
