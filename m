Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2F4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBABB20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyhnRqds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfANUgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:36:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39530 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfANUgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:36:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id y8so986747wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lM5Pix3S8G5P2q0Akf04Mk8gPJNdqS9j0ZGAX4eS2jA=;
        b=kyhnRqdsoP7n7kNDrSsHrLGFP68L9hUA09Kp4FTWpHsTcG8HSWk2QxDceXIiKooauB
         BQgHmUKVdRT9ELsxIrEaMoXo1uc8QRTTpjo0pR1f+PE4jpJhFz+b/Jf8TuYsRCq/9eHC
         32qkuOVIEnX1Dl1uh826p4O7IVIYnJrjUd3wgPSDS8CE4KrR/mfrMFewqkk0TAemI5/U
         o2FjowRS1GA7tuy5U7IFztXwZm1CyOBpeaMJVIleEy0mRbcVaqFXrs3TPE9Ow3Jilyid
         +BCNT+O+8kZg6pGWrFmhP8PxqwXYdUAvJDDHGqf7oRPCXSZsGlNvYUw1AkTVdNaVVqh1
         eLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=lM5Pix3S8G5P2q0Akf04Mk8gPJNdqS9j0ZGAX4eS2jA=;
        b=S5dz4KLOdH8EXiUVh6MRiVhNkNyU6AOz9Az1KjFM0nWLIRbKvEKPxf5i7hM35lb0u7
         GgoCRcXC3tQzGL99+2zFipFaBzCcApFOqeI87OPsbId53uwgRkPA36KnPKFC9/yeww48
         fW9xvItUZa4bZpjVtdKGDaNZof7mUMQQbTGchHTeI9B00awcNAXiacGzV3YvPoQQAgHb
         tGdwAflV7tWaCuEbR0Gg8kP7X5z5MGV1hNPW3XGVx+FAQxiglWqm5Auio9j/yij13RVL
         sZEE7PQxSN5MtGofaQ4Re4z/P/piElApZKFZ9J/q37jJ+cT7bFbwgHFojoSKE8mKFJ3F
         WHWw==
X-Gm-Message-State: AJcUukf3vNw5F5F20FMBQCAX6F+ZLp2Bj/0nZpqxmE9Koz189fi4z1ZJ
        UIPoO58zY9PlBtz/yafv0s4=
X-Google-Smtp-Source: ALg8bN4NJA9vc5+lZHDr8HlVxAy72Ejypyr4KBbIimThc2mKOLjRSTb5/q5X1qJNBjIL47Pi/fVZSQ==
X-Received: by 2002:a1c:d14d:: with SMTP id i74mr648570wmg.100.1547498172039;
        Mon, 14 Jan 2019 12:36:12 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id 3sm32993075wmw.46.2019.01.14.12.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:36:11 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 7BD3711422AD; Mon, 14 Jan 2019 21:36:10 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ipc: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:36:08 +0100
Message-Id: <20190114203608.18218-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  ipc/sem.c:1683:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 ipc/sem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ipc/sem.c b/ipc/sem.c
index 745dc6187e84..0307012ab343 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1682,6 +1682,7 @@ long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg)
 	case IPC_SET:
 		if (copy_semid_from_user(&semid64, p, version))
 			return -EFAULT;
+		/* fall through */
 	case IPC_RMID:
 		return semctl_down(ns, semid, cmd, &semid64);
 	default:
-- 
2.19.2

