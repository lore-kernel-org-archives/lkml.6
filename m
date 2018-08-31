Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211F8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C4E2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQ7V9zRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C4E2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeIADNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:13:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52289 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbeIADNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:13:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id y139-v6so6486497wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PBWdxRdCu/90y1MKnNFx/67m1eFKjp9PoijIw90ZlVU=;
        b=dQ7V9zRl9eS3j5NaKop2dbffTX7ptyZXG+qDNuipehTGR8jAju+b4iYAXP0mk97aQc
         3HvxP64BMRkiEEqNef24TdBJ32Ptbw7XhIxIOLpyXzmvK3sPfHJ8XS4GKyxY+wt9u5jb
         ONL66GUkse86Dgx+m7H7EoBfmLqbbApU+S3T/2ri5OO91+UmYbeEYl/98pp3R+yImgQo
         68yFkh6LTz6j02JrpggnEh5DJx79GdRrsz4cwxjlX3JDt+upvc1Wp/HeD/5zAgRsfcmW
         YsIOf8tXmYhnpzPWhudibCBe41F11IDYN5WPauGKd8XHw+JgrGC7ZGwU4SduSsMxWNw3
         hYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PBWdxRdCu/90y1MKnNFx/67m1eFKjp9PoijIw90ZlVU=;
        b=CEV8GDW+t7PLHOJgr/BQJUpYGpRGe+EKh/h8kwzWhGPzN/7H8tQJ5CzkOHAZwDoQEb
         Qa94nae//guniUWh+Od7uHPLtkZh2kc2/DTbeIrNdYxtBrqmpbswhTbFjXSptKiDpLkl
         x32JriFuy94xXE6uf6WXfNRxRmdDadfnseEQqLYl4jI+77Sc3p4ruOYZE/PgJNpXkDzH
         k3fVOIPi/d93qQX1KQa9DV7d9l+obL8aKEZJFkcaTXVDN3LNCqdzVTZKm/DO2QPOwEfZ
         OZe8hzz/t/0OqfMrg7DOKbFhh+P+0faHg4wni1Upv0UDS7Jv6kbFzDW6nMzeCY+Eh8m9
         y97A==
X-Gm-Message-State: APzg51DkCg5WhQ557l7xdMSNV9XTxf5QCgBInItUzj9y55HdAtwF7jgP
        7u4QrpfpU/U4JbwOAaw8oy1+zcbmrSg=
X-Google-Smtp-Source: ANB0VdbuxD2a+94asfgQFq1VgZNXQpIuO87tcZnbaaZm8j4d6grXtA14qvNrXR8I3PQZdcxBkDuCgA==
X-Received: by 2002:a1c:8e04:: with SMTP id q4-v6mr5960971wmd.150.1535756603723;
        Fri, 31 Aug 2018 16:03:23 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:23 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 18/20] staging:rtl8192u: Rename FirstSeg - Style
Date:   Sat,  1 Sep 2018 00:02:48 +0100
Message-Id: <20180831230250.16810-19-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable 'FirstSeg' to 'first_seg', this change
clears the checkpatch issue with CamelCase naming.

This is a simple coding style change and as such should not impact
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 672cbfa688f7..66efa59eabf0 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -163,7 +163,7 @@ struct tx_desc_819x_usb {
 	u8	reserved0:3;
 	u8	cmd_init:1;
 	u8	last_seg:1;
-	u8	FirstSeg:1;
+	u8	first_seg:1;
 	u8	LINIP:1;
 	u8	OWN:1;
 
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index dfbba1177470..a4d1b55a1117 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1556,7 +1556,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 	 * all of the descriptors
 	 */
 	/* DWORD 0 */
-	tx_desc->FirstSeg = 1;
+	tx_desc->first_seg = 1;
 	tx_desc->last_seg = 1;
 	tx_desc->OWN = 1;
 
-- 
2.18.0

