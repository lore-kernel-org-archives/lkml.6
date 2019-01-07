Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B46C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AFF20838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CWLt5BfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfAGCtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:49:19 -0500
Received: from m50-132.163.com ([123.125.50.132]:51395 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbfAGCtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:49:18 -0500
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jan 2019 21:49:13 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=XKUKZzKAvAGz+z/1pu
        SQxK89fmHaJu6IwArdSK08sE4=; b=CWLt5BfCYidjYX7UREZNtYnFmIRTHwiiYT
        dHbrqcJEM6uXefUvmWtruT/yOhXgwjh6Ve+Dg/JM1QDiJOhfTcNiNWP0CjQBlvJ1
        au4QAG6G09vpd0FB32KdQZHaMv23wkeWkS9aD6xwz2Gwj9KU7uE5ftHqw9AJHt1r
        sClOx137g=
Received: from localhost.localdomain.localdomain (unknown [111.205.43.247])
        by smtp2 (Coremail) with SMTP id DNGowACXzyuAujJcPOxpAw--.944S3;
        Mon, 07 Jan 2019 10:33:39 +0800 (CST)
From:   Xiaochun Lee <lixiaochun.2888@163.com>
To:     linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, rjw@rjwysocki.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        Xiaochun Lee <lixc17@lenovo.com>
Subject: [PATCH] ACPI/nfit: delete the redundant header file
Date:   Mon,  7 Jan 2019 10:33:36 +0800
Message-Id: <1546828416-3040-2-git-send-email-lixiaochun.2888@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1546828416-3040-1-git-send-email-lixiaochun.2888@163.com>
References: <1546828416-3040-1-git-send-email-lixiaochun.2888@163.com>
X-CM-TRANSID: DNGowACXzyuAujJcPOxpAw--.944S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUfnYwUUUUU
X-Originating-IP: [111.205.43.247]
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/xtbBZwQ1QFetsqgvmwAAsC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaochun Lee <lixc17@lenovo.com>

The header file "intel.h" is repeated here, So delete one.

Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
---
 drivers/acpi/nfit/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 011d3db..328e464 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -26,7 +26,6 @@
 #include <acpi/nfit.h>
 #include "intel.h"
 #include "nfit.h"
-#include "intel.h"
 
 /*
  * For readq() and writeq() on 32-bit builds, the hi-lo, lo-hi order is
-- 
1.8.3.1


