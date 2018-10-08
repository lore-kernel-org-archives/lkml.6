Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE80C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088B92075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="IQvmHzwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088B92075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeJHTKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:10:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33615 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeJHTKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:10:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id e4-v6so20548933wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=kEttI9DqBpEzCiX8HuqBjrpcDfxr7iT8ZpKlqnognH8=;
        b=IQvmHzwZfulf/wprwi1MB26tTIpLaaft69Y38IanWHK93ByYKsvcOxpM46CAwN8WhI
         Py8xepJIGKSCbf0c9PT/9nP5uxAI6MfjabdaYDnP0MBHjfZHy5W0UwFPdmVTbK3yLcCx
         psds9lqCQrXUWjn1N5oAVtDlXgksj4yNneG00QqvdQhqjTh+QEKgYY/B3INV1g8eB3NB
         WbfqW29ks8BfkcbYxEGOtL8k02HU3f4w+8KMbgYrRec90bC4WMHoTTfKwKjvjzbrRQje
         Q6MGEOY1EAGst9aWnX5eo+5nbW6UAElwdBwrHkfzFEGjLiXWRLjv/5z5/53btMpQuzO0
         Kheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=kEttI9DqBpEzCiX8HuqBjrpcDfxr7iT8ZpKlqnognH8=;
        b=su4YCbMjsCHs1n98RlG8BY9nkcD8j+djlHMRYyUo/iRHcVaAdtDEJNb8/cnAanXZJI
         cMFdzBroJ/CbqmMJtwGWOuEuS/ox4jJu4nnIAd5Dlz9UT29fjx+Xb6xK1drvk65BXBp3
         J6SYaQ3XxRuiT6jwoyiq9wosuYRFmJ+kAgF009n/4x6o4glvNiimMGGJDrBneePgyf0b
         SRpINCQ+ZI8qLdGjD7EDZAp5iJBQPYdp/yJWN2fEernGP96S87ZQYoITZ/CyuX4i0ymB
         0zwPS2LbGEwTQcvLSF4TWoPz/sE8lm+9lT5QqIhOauHkkJezcHap/Khx7q/z1O/hUeSu
         MvbA==
X-Gm-Message-State: ABuFfogWm+DIwe6njo2npSli27m9Gp0DBAU0vRQ1xqYNdwubJZZOLV2s
        PKli3OprC2f7INTIAsuRnPF6w94AE+lhXQ==
X-Google-Smtp-Source: ACcGV62CYS2MuVtuCEoVCMMQbxBeZnc5Lw3At/FFF2XR+ATbyi4+VfSFAwJIFFi1AKqTcEstlEAEbw==
X-Received: by 2002:adf:fa4e:: with SMTP id y14-v6mr16578699wrr.155.1538999929256;
        Mon, 08 Oct 2018 04:58:49 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q16-v6sm13351105wrn.41.2018.10.08.04.58.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Oct 2018 04:58:48 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gregkh@linuxfoundation.org, geert@linux-m68k.org,
        rdunlap@infradead.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2] of: base: Fix english spelling in of_alias_get_alias_list()
Date:   Mon,  8 Oct 2018 13:58:47 +0200
Message-Id: <1e4e9047636e94dc2bff62b915bd0261f334dd8a.1538999925.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix english spelling in of_alias_get_alias_list().

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: b1078c355d76 ("of: base: Introduce of_alias_get_alias_list() to check alias IDs")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Fix 2 more issues reported by Randy Dunlap
- Add fixed log sha1

Greg: Please apply it on the top of tty-next because patch is going via
your tree.

---
 drivers/of/base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 33011b88ed3f..908de45f966b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1948,7 +1948,7 @@ int of_alias_get_id(struct device_node *np, const char *stem)
  * @matches:	Array of OF device match structures to search in
  * @stem:	Alias stem of the given device_node
  * @bitmap:	Bitmap field pointer
- * @nbits:	Maximum number of alias ID which can be recorded it bitmap
+ * @nbits:	Maximum number of alias IDs which can be recorded in bitmap
  *
  * The function travels the lookup table to record alias ids for the given
  * device match structures and alias stem.
@@ -1971,7 +1971,7 @@ int of_alias_get_alias_list(const struct of_device_id *matches,
 			 __func__, app->stem, app->id);
 
 		if (strcmp(app->stem, stem) != 0) {
-			pr_debug("%s: stem comparison doesn't passed %s\n",
+			pr_debug("%s: stem comparison didn't pass %s\n",
 				 __func__, app->stem);
 			continue;
 		}
@@ -1986,7 +1986,7 @@ int of_alias_get_alias_list(const struct of_device_id *matches,
 			pr_debug("%s: Allocated ID %d\n", __func__, app->id);
 			set_bit(app->id, bitmap);
 		}
-		/* Alias exist but it not compatible with matches */
+		/* Alias exists but is not compatible with matches */
 	}
 	mutex_unlock(&of_mutex);
 
-- 
1.9.1

