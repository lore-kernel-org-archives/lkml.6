Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7DEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41732084C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEltSFDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41732084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeKPIfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:35:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55149 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeKPIfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:35:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so20382834wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=23LY6WuPP+2p80bqhM2jKxAXddCviLqJVVO7pCywEaY=;
        b=bEltSFDkYBjsBGVALw9UaQWXokyjEJVbwArmmLAnL/ylJO7I1C0R+0BfPDq8vpMqFx
         ic7dNMIipR5NjcWSOoHdicPDdeb7en+NxRc7OcAWQ2zQnvpMnhpfwFuK5o7a8mocxkmd
         oMsd/d03nr3K6XgxkodBW9OEAh7LfLZkYEc9rUbTIGa6n0RzziAsO3w3enw01ISANY05
         Nw31CGxYko+EmhYkg7vcc6cCdadTUjdJ/HyeyMsVgiygnjW4+SUDD+yQdf1WUyS1XhcZ
         KHy/XZXZACD4bD4YhhQB7UlV4V4TJcxdBrVdjsQyzbMrWRElN0/goqOCJKkzRcT1riUB
         NMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=23LY6WuPP+2p80bqhM2jKxAXddCviLqJVVO7pCywEaY=;
        b=ubs3gtttJb/59+TkhOR2pkOm8e0Wo3sQRC1pjmMSFGWDVLbQp+R5qGzBLePtj+EcS1
         QMWALDsOJP6JVKYJWlkL5xPwxY+B9xCJC9/4jPR9/VWoAqE5dWr5KfkGttJ08y8owqi8
         CyumxUC5/ItOkKlekVyueoTxPqYyRQqxEM7Z6BlpIvVjEGLNMaeKEcS9KlLazVkkk1US
         1LBnlrdtnza7pvM/wc73CDPuveBDELG3BU1m4VNXUB02kaAcyPKErWTY3bEX80vhgEqh
         4gofJ/F2UjMKNN93+YuJys40VPpaDpceDH8WrLXNP8cYoo1716zAl+0bNUdcbtYTVsi6
         K8Rw==
X-Gm-Message-State: AGRZ1gLoDyVJVvob55lTy11W38UFh+9gepPv9cZgYG496UvOkIq49KFB
        B/t1DKRD2JHGytxGOWgFKQ==
X-Google-Smtp-Source: AJdET5fg2r2lyiCtQpGaLmZRTtUyS43FbMCbWqALPsidqS6VkooTPpN6PV5WUo4xC7uXxlZY0SBsdQ==
X-Received: by 2002:a1c:1a48:: with SMTP id a69-v6mr6947703wma.9.1542320765191;
        Thu, 15 Nov 2018 14:26:05 -0800 (PST)
Received: from localhost.Home ([2a02:c7d:9b5c:9b00:1a75:ff25:fe7f:eaba])
        by smtp.gmail.com with ESMTPSA id a4-v6sm18900122wrr.71.2018.11.15.14.26.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 14:26:04 -0800 (PST)
From:   Garry McNulty <garrmcnu@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        Garry McNulty <garrmcnu@gmail.com>
Subject: [PATCH v2] ubifs: fix memory leak on error condition
Date:   Thu, 15 Nov 2018 22:25:58 +0000
Message-Id: <20181115222558.19189-1-garrmcnu@gmail.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the call to ubifs_read_nnode() fails in ubifs_lpt_calc_hash() an
error is returned without freeing the memory allocated to 'buf'.
Read and check the root node before allocating the buffer.

Detected by CoverityScan, CID 1441025 ("Resource leak")

Signed-off-by: Garry McNulty <garrmcnu@gmail.com>
---
 fs/ubifs/lpt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
index d1d5e96350dd..b0c5f06128b5 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -1675,6 +1675,12 @@ int ubifs_lpt_calc_hash(struct ubifs_info *c, u8 *hash)
 	if (!ubifs_authenticated(c))
 		return 0;
 
+	if (!c->nroot) {
+		err = ubifs_read_nnode(c, NULL, 0);
+		if (err)
+			return err;
+	}
+
 	desc = ubifs_hash_get_desc(c);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
@@ -1685,12 +1691,6 @@ int ubifs_lpt_calc_hash(struct ubifs_info *c, u8 *hash)
 		goto out;
 	}
 
-	if (!c->nroot) {
-		err = ubifs_read_nnode(c, NULL, 0);
-		if (err)
-			return err;
-	}
-
 	cnode = (struct ubifs_cnode *)c->nroot;
 
 	while (cnode) {
-- 
2.14.5

