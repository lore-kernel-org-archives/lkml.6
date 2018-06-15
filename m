Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE44AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F54B208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F54B208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966131AbeFOQgX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:36:23 -0400
Received: from osg.samsung.com ([64.30.133.232]:55718 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965947AbeFOQbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:31:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 62FE222BDB;
        Fri, 15 Jun 2018 09:31:08 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VdbcdVqFeU5L; Fri, 15 Jun 2018 09:31:07 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.114.220.dynamic.adsl.gvt.net.br [177.41.114.220])
        by osg.samsung.com (Postfix) with ESMTPSA id AB48A22B54;
        Fri, 15 Jun 2018 09:30:58 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fTrcm-00084M-GD; Fri, 15 Jun 2018 13:30:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/26] kernel-parameters.txt: fix pointers to sound parameters
Date:   Fri, 15 Jun 2018 13:30:46 -0300
Message-Id: <dbaad50b8fb1c6cd8f9d3b07fa3b7fcb21e27769.1529079120.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alsa parameters file was renamed to alsa-configuration.rst.

With regards to OSS, it got retired as a hole by  at changeset
727dede0ba8a ("sound: Retire OSS"). So, it doesn't make sense
to keep mentioning it at kernel-parameters.txt.

Fixes: 727dede0ba8a ("sound: Retire OSS")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6fa3f31ed2a5..efc7aa7a0670 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -256,7 +256,7 @@
 				(may crash computer or cause data corruption)
 
 	ALSA		[HW,ALSA]
-			See Documentation/sound/alsa/alsa-parameters.txt
+			See Documentation/sound/alsa-configuration.rst
 
 	alignment=	[KNL,ARM]
 			Allow the default userspace alignment fault handler
@@ -2926,9 +2926,6 @@
 			This will also cause panics on machine check exceptions.
 			Useful together with panic=30 to trigger a reboot.
 
-	OSS		[HW,OSS]
-			See Documentation/sound/oss/oss-parameters.txt
-
 	page_owner=	[KNL] Boot-time page_owner enabling option.
 			Storage of the information about who allocated
 			each page is disabled in default. With this switch,
-- 
2.17.1

