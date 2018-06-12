Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 030F0C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C88F208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGBI6MhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C88F208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933307AbeFLDqd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:46:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34438 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932460AbeFLDqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:46:31 -0400
Received: by mail-pl0-f68.google.com with SMTP id g20-v6so13559066plq.1;
        Mon, 11 Jun 2018 20:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x7I56ELwwevdipu2gQ2jZ0MqSh/U5Nq/u+3Tv6XMrIk=;
        b=ZGBI6MhUSCmN4U9KPF8qhYDTKjTpYoa7XYk6mp7oztHY8iuU3Ol1qW44ttGeI6XQX3
         hDW1H3Jef5vL0A84cVZmLbyO5rU4DIdWxXA8gUZRS+nDQtcH7e4aeGJw5XRGfhER7T47
         fnWvDdUeEtQI8DI1g74Fh0ZOytNtXJzRLPrzcjVK4S/jhD7MX579uMmLGUaGbIyEr1mF
         ZkX9C0HcDclUkKuv0UZxJM0ux96tbV1udAEXh+inXygsaaoAnslimWNeFOrn2E+9NBG3
         J09U2J6YezxM3AlD0+Qr+pjTjjMxbIK3W1a/uSg9z7OGQ7mWtc9kTf3CIm4PJHCkQF+l
         MaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x7I56ELwwevdipu2gQ2jZ0MqSh/U5Nq/u+3Tv6XMrIk=;
        b=Y8ZsLaC8s/mYYH+tvZ+NgKeU9JygUm8rYvgGev/j+60C36ufGxb8e59EZwqcm37HQS
         fwUsJFiZDLuTkGrp/A6jV2gtSExaGIcmCAzsW4P1Rk0+8AnXVQbSXsHk8F88jI4hLhD0
         DfC7IPcLN1hWOTO6fJ3kcO0i3m6DtWcefDxXgIUQT1/a2VysyELceqnZMbM4Y3GXt8hN
         GfNR5hH6NkSFIMbkXWYqV2D2StNhI0kaX9f+0h2zNW/hFd9/v4xhN/XG1jFm5nXyMPcg
         E8meCBJJi1L2csU9Td7W2eeJV3cKynbI/iwZUaPpc6RaRTsb5upWRcCTcHy7BfAWQ0bj
         u7Qg==
X-Gm-Message-State: APt69E2vQNW+91kqtf5ZcgbNHXVVkvv8ll/6WNmzGfP64eAc56Kh4jl7
        M202Y1cu0VtkJONluQIV1zg=
X-Google-Smtp-Source: ADUXVKJ0+LEa3Nlb+k6vom7aLjEeNImsenJoJopAwRPFjbrQaxX/qrv6IlckdoUiECxQqUYN879/UQ==
X-Received: by 2002:a17:902:b611:: with SMTP id b17-v6mr2069734pls.284.1528775191021;
        Mon, 11 Jun 2018 20:46:31 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id e189-v6sm33100393pfc.134.2018.06.11.20.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:46:30 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xen/scsiback: add error handling for xenbus_printf
Date:   Tue, 12 Jun 2018 11:46:25 +0800
Message-Id: <1528775185-39467-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
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
 drivers/xen/xen-scsiback.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 7bc88fd..13ab54c 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1027,8 +1027,9 @@ static void scsiback_do_add_lun(struct vscsibk_info *info, const char *state,
 			scsiback_del_translation_entry(info, vir);
 		}
 	} else if (!try) {
-		xenbus_printf(XBT_NIL, info->dev->nodename, state,
-			      "%d", XenbusStateClosed);
+		if (xenbus_printf(XBT_NIL, info->dev->nodename, state,
+			      "%d", XenbusStateClosed))
+			pr_err("xenbus_printf error %s\n", state);
 	}
 }
 
@@ -1067,8 +1068,9 @@ static void scsiback_do_1lun_hotplug(struct vscsibk_info *info, int op,
 	snprintf(str, sizeof(str), "vscsi-devs/%s/p-dev", ent);
 	val = xenbus_read(XBT_NIL, dev->nodename, str, NULL);
 	if (IS_ERR(val)) {
-		xenbus_printf(XBT_NIL, dev->nodename, state,
-			      "%d", XenbusStateClosed);
+		if (xenbus_printf(XBT_NIL, dev->nodename, state,
+			      "%d", XenbusStateClosed))
+			pr_err("xenbus_printf error %s\n", state);
 		return;
 	}
 	strlcpy(phy, val, VSCSI_NAMELEN);
@@ -1079,8 +1081,9 @@ static void scsiback_do_1lun_hotplug(struct vscsibk_info *info, int op,
 	err = xenbus_scanf(XBT_NIL, dev->nodename, str, "%u:%u:%u:%u",
 			   &vir.hst, &vir.chn, &vir.tgt, &vir.lun);
 	if (XENBUS_EXIST_ERR(err)) {
-		xenbus_printf(XBT_NIL, dev->nodename, state,
-			      "%d", XenbusStateClosed);
+		if (xenbus_printf(XBT_NIL, dev->nodename, state,
+			      "%d", XenbusStateClosed))
+			pr_err("xenbus_printf error %s\n", state);
 		return;
 	}
 
-- 
2.7.4

