Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B58C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D42206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHOkUFD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfAIOaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:30:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42668 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbfAIOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:30:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so3380516pga.9;
        Wed, 09 Jan 2019 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1YivmbWvmWM/5PddXyPutTYxXpKE7Quk/Mg5cc5dBjY=;
        b=jHOkUFD6sc6OVAqYjnP4gda8biXKSn62rDMeoUillDjWY/jkwDA8SLnrGeJl5rhjmH
         lujSIRHXgYFCUcbfKsC6xknaTxDRSM1MuoFSKUwYMFZV5aVahjHtRKHrIOhwwRZOFaWp
         ODRzDx1UYe6zCRw8W32vX6MFbHhLPfZG35UFIIJp5ghE0U7g0wfHEZuaC09Er8Awcp8V
         mYXeh70xrpBCfgemEoG/ZLM+5V1taLEbPleLu5EeXUS6qvEWsodtalc6WVsRleIqN68Q
         0jgw5DoOGZNr66fjCV1PJpJ0NX3jfhN0Gmg6S4iQP0Q9dYNeg1IqC/LYCp939/UH3NLv
         nXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1YivmbWvmWM/5PddXyPutTYxXpKE7Quk/Mg5cc5dBjY=;
        b=jDZt7XSfqH9XsxoZPuoToT5Ywb67FJXTyI3GnzDuZyceP7aqh7aBXrUcJZMAhQlAu2
         KGMmWifqRAXtIwtS6US7ryau/kGi8xLUOK3poiO3n203fKW+z1NiFG5y58h+xhLRFbod
         nORp84AzR03w2JftQWdd66RNlgm3ImbYI/KtWtb+iW/zX3D08VZ4RhN03X3qsG1sNgdi
         5k4zKE5Lanzmh06Yo2Zri48y98geI4baQLXGfZl0VJOqU+8K2pxif4HzpMIO6Z1PAD4T
         KdYRD8h6BXA3vctDsWVFlkV8uIfaunqhAJn+1hpkQZzVrDkuukvv8FEI/Qy9slN+BR0e
         psvQ==
X-Gm-Message-State: AJcUukfWAj/ykRhFRyAVWoQL3ADDN31T6oz7jj+dQsDeWq0vsSaUi3hj
        FyiKV+GfzcCiSmm4AiRMYJg=
X-Google-Smtp-Source: ALg8bN5hxKdJWmBwrsMdKL4Ad5YJ3LYmwT7oudxkUagK34Sol4Lr7qODWYpuTSv3Rm9RgriMTL59RQ==
X-Received: by 2002:a62:1f9d:: with SMTP id l29mr6177338pfj.14.1547044204874;
        Wed, 09 Jan 2019 06:30:04 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2405:204:4099:c05a:9503:102e:b683:299f])
        by smtp.gmail.com with ESMTPSA id 24sm306612693pfl.32.2019.01.09.06.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 06:30:04 -0800 (PST)
Date:   Wed, 9 Jan 2019 19:59:59 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     jrdr.linux@gmail.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH] remoteproc/qcom_sysmon.c: Remove duplicate header
Message-ID: <20190109142959.GA29659@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/notifier.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/remoteproc/qcom_sysmon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index e976a602b015..603b813151f2 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -7,7 +7,6 @@
 #include <linux/notifier.h>
 #include <linux/slab.h>
 #include <linux/io.h>
-#include <linux/notifier.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc/qcom_rproc.h>
-- 
2.17.1

