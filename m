Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1334BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01EB2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F19jdRwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01EB2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbeKGADj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:03:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34639 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388659AbeKGADj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:03:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1-v6so5912150pgq.1;
        Tue, 06 Nov 2018 06:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HgzbVJ10//Db0t98DyG1jxW208nR3vJuD5ZB/R9alWY=;
        b=F19jdRwyjW7JlROX4GfIEjBYUR+utWk7pb3Y1YHQmmuiVR4JtF0FazpyCy/6A4skoW
         gcL1U6jhILj5eX0FSO7cYh4lC4sopQujoWCKUX0er4O31DmZbk5O8Z1d17iSVC+jhbxi
         hleUDeOqfpm8CFt9m7cF7yCJxgYRSeXrXTNX9OtiJSnUU1V86r/X6ssEBNfgC5WPLaCt
         +nkJ46F4J9w+XtLEiIiJLogaX0gJjL7BGMJx4gSc5HkWjrDUY//gZYmAZm3lnWHOi9L5
         zw4hhFmynlW7cMlj61M9puLJwEaWUQZJnsAAP5dR7dhqvyMI5A2o5RTyEkaAx7Ghl0+e
         +1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HgzbVJ10//Db0t98DyG1jxW208nR3vJuD5ZB/R9alWY=;
        b=s9NUi1GPBersx68sTTpZPbyvl+GTyhQkO7LZ/slZ1iecwDM/41X+NhYpHUiNEj4vvf
         XIpqfS5Ulxvf1/ZVuTzkL9xckOKhlzrypQAQzo54MNVA/RUp7MGzNfcslRkZFX64bgZv
         fcoL/nTuJaUqHJpmtMhSMQjYnK05EWsSVeS9ia9ccUe6UNkUiTGR0ngoYqu+ZQERWrMA
         9YIYqvtIEgGWzSCl/ELE4jy7NFOpYziqMAY/acZK/aoGDkYGkqv3ZO51nKp1fgzzVLd5
         dobWaGRhMK0tn0Li+OKnPF5BHo2qVdJvjeu1Uvq93911QAC9CkBhGILunoTPoqspD7X4
         OuKQ==
X-Gm-Message-State: AGRZ1gLSLB1eFXQpH/GIEVw/YfJsVyvtU6bim3G3YwNHN8RdeeqxCIe3
        iGG/Eg20uoPUbOmmI8CYTNYD2PUktug=
X-Google-Smtp-Source: AJdET5ckvKS5g6qUbfKHNi98il+9eXQcOQgZY4znxLv7bhVXCWaUi+To9Hr1/eNYb+sUqotX1LGAPQ==
X-Received: by 2002:a63:2849:: with SMTP id o70mr7018397pgo.155.1541515088324;
        Tue, 06 Nov 2018 06:38:08 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q134-v6sm10887854pfc.88.2018.11.06.06.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 06:38:07 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / QoS: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Tue,  6 Nov 2018 09:38:06 -0500
Message-Id: <20181106143806.8551-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/power/qos.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 86d72ffb811b..b7a82502857a 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -184,7 +184,7 @@ static inline void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
 	c->target_value = value;
 }
 
-static int pm_qos_dbg_show_requests(struct seq_file *s, void *unused)
+static int pm_qos_debug_show(struct seq_file *s, void *unused)
 {
 	struct pm_qos_object *qos = (struct pm_qos_object *)s->private;
 	struct pm_qos_constraints *c;
@@ -245,18 +245,7 @@ static int pm_qos_dbg_show_requests(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int pm_qos_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pm_qos_dbg_show_requests,
-			   inode->i_private);
-}
-
-static const struct file_operations pm_qos_debug_fops = {
-	.open           = pm_qos_dbg_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pm_qos_debug);
 
 /**
  * pm_qos_update_target - manages the constraints list and calls the notifiers
-- 
2.17.0

