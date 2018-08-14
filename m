Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293EBC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2C721731
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nUPRzbN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2C721731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbeHNLCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:02:53 -0400
Received: from m12-16.163.com ([220.181.12.16]:48412 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbeHNLCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=EZ9sz8F2HxOTxoQhJp
        7gDDmJ3f/eHxYbbKbG09Tdwe4=; b=nUPRzbN/HKFem/uZ1HR+qTS27uY1yCAYdl
        9oWydOiHsQTfWZIPXklMkwkzbi+k2CyDLZm64BNhOcJz/9UYfsYEXjeSjxlXfKB2
        3XysiTAxdn6OEcYlZDcybBYq0FnX8zL4CXXNkOIh1UX/eY3mjQpnvK0K8rJ+nG1M
        7D2k2NBv8=
Received: from localhost.localdomain (unknown [117.136.38.150])
        by smtp12 (Coremail) with SMTP id EMCowADnK23nj3Jbfgz+Bw--.40124S4;
        Tue, 14 Aug 2018 16:16:40 +0800 (CST)
From:   Dongbo Cao <cdbdyx@163.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dongbo Cao <cdbdyx@163.com>
Subject: [PATCH 2/2] bcache: add undef for macro in function
Date:   Tue, 14 Aug 2018 16:16:25 +0800
Message-Id: <20180814081625.12326-1-cdbdyx@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EMCowADnK23nj3Jbfgz+Bw--.40124S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUYSoXDUUUU
X-Originating-IP: [117.136.38.150]
X-CM-SenderInfo: xfgev5r06rljoofrz/1tbiNRKi3FrPL0JQPQAAsM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add undef for macro d_strtoul,d_strtoul_nonzero and d_strtoi_h

Signed-off-by: Dongbo Cao <cdbdyx@163.com>
---
 drivers/md/bcache/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 225b15aa..ed67a290 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -349,6 +349,9 @@ STORE(__cached_dev)
 	if (attr == &sysfs_stop)
 		bcache_device_stop(&dc->disk);
 
+#undef d_strtoul
+#undef d_strtoul_nonzero
+#undef d_strtoi_h
 	return size;
 }
 
-- 
2.17.1


