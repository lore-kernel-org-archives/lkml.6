Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC227C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94090208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikBfV8wY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94090208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936475AbeFPAOq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 20:14:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41646 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbeFPAOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 20:14:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so5563787pff.8;
        Fri, 15 Jun 2018 17:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ju1u1ikPZT2py6toXT5Gyu117RYqw+67N669AlM5If4=;
        b=ikBfV8wYRvzToR5YrS8pC23qvxrqrRhDGbTv3TU8IBttWvqptsQaW5TyoxLdUkkGhI
         ZurCDhuBkwx17bLyK2HSTql23CXSBu2Kj5b8ktlmVAT62cxU04TuXwuZ4zf5XdGZWVI1
         sx8X0joSo5RMi2poZH8gSJc0yVgtm8qHHEq+u1jkKf33XehS/y5Hrk72PL+7SK5LNE76
         bCP9s4HOGJpCf7oroEtg/7RkZ3nL2zhmjpt06PRwksD0c9DGZfYh1+UgAo1mcl0y7JPQ
         EoAuTcIsZNKF3GtUVc098GKamj9l5W9CjD844+6vzPZZNanz72dPfd8trrd+3WjY2i+A
         VslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ju1u1ikPZT2py6toXT5Gyu117RYqw+67N669AlM5If4=;
        b=XUjZ+ouEWDNvuKhf9/5DKrjf2aACx1C3Bl7XI5evyzpF/9gJ9jXs6SPZ8GLbD0H/9l
         dpg6GSDWncO228r24YNoEZXs9WSKFYV8rOZMuitLzTeDLBo1cjiXMoYId4HJ53V84SwI
         /5M1v1SEwWojr56/67za/Hzvr1rBWCZPNCTykW7gkMr3GcVnm5S8UmmiLDlxVb7N/52O
         3mBhn3Vr5/HdOC38S7lbzweJreZCzHEYBTZTY+aJFy/vDJm9oPppiekRBOtUV98RrA4s
         yvKcjLNbUKHMbhUiWalATzXi2rcMctY8bAga57zLHNd2O4pKm/ECM3w5kBa204Z+T7Dw
         50Gw==
X-Gm-Message-State: APt69E21hvC+cF3QhsoRnjN+fWqWvMhrHn1yXGDgAdvSO5UGkVAuaMqM
        /FuZ/+QluYB03wdbv3V0rF8=
X-Google-Smtp-Source: ADUXVKK/zmQwShYJtwKY24fKC2ubMzwtSr8+qPMD+Yd8mn4GaVezSza+TPkSuJvatL2JdnCdgLq97g==
X-Received: by 2002:a62:6710:: with SMTP id b16-v6mr4188020pfc.37.1529108083792;
        Fri, 15 Jun 2018 17:14:43 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id g4-v6sm16990002pfg.38.2018.06.15.17.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 17:14:43 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] xen/scsiback: add error handling for xenbus_printf
Date:   Sat, 16 Jun 2018 08:14:37 +0800
Message-Id: <1529108077-60035-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528775185-39467-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528775185-39467-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When xenbus_printf fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling xenbus_printf.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Use xenbus_dev_error to report errors.
v2->v3:
- Fix compilation errors.
---
 drivers/xen/xen-scsiback.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 7bc88fd..e2f3e8b 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1012,6 +1012,7 @@ static void scsiback_do_add_lun(struct vscsibk_info *info, const char *state,
 {
 	struct v2p_entry *entry;
 	unsigned long flags;
+	int err;
 
 	if (try) {
 		spin_lock_irqsave(&info->v2p_lock, flags);
@@ -1027,8 +1028,11 @@ static void scsiback_do_add_lun(struct vscsibk_info *info, const char *state,
 			scsiback_del_translation_entry(info, vir);
 		}
 	} else if (!try) {
-		xenbus_printf(XBT_NIL, info->dev->nodename, state,
+		err = xenbus_printf(XBT_NIL, info->dev->nodename, state,
 			      "%d", XenbusStateClosed);
+		if (err)
+			xenbus_dev_error(info->dev, err,
+				"%s: writing %s", __func__, state);
 	}
 }
 
@@ -1067,8 +1071,11 @@ static void scsiback_do_1lun_hotplug(struct vscsibk_info *info, int op,
 	snprintf(str, sizeof(str), "vscsi-devs/%s/p-dev", ent);
 	val = xenbus_read(XBT_NIL, dev->nodename, str, NULL);
 	if (IS_ERR(val)) {
-		xenbus_printf(XBT_NIL, dev->nodename, state,
+		err = xenbus_printf(XBT_NIL, dev->nodename, state,
 			      "%d", XenbusStateClosed);
+		if (err)
+			xenbus_dev_error(info->dev, err,
+				"%s: writing %s", __func__, state);
 		return;
 	}
 	strlcpy(phy, val, VSCSI_NAMELEN);
@@ -1079,8 +1086,11 @@ static void scsiback_do_1lun_hotplug(struct vscsibk_info *info, int op,
 	err = xenbus_scanf(XBT_NIL, dev->nodename, str, "%u:%u:%u:%u",
 			   &vir.hst, &vir.chn, &vir.tgt, &vir.lun);
 	if (XENBUS_EXIST_ERR(err)) {
-		xenbus_printf(XBT_NIL, dev->nodename, state,
+		err = xenbus_printf(XBT_NIL, dev->nodename, state,
 			      "%d", XenbusStateClosed);
+		if (err)
+			xenbus_dev_error(info->dev, err,
+				"%s: writing %s", __func__, state);
 		return;
 	}
 
-- 
2.7.4

