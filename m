Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6E9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99E32089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsunix.de header.i=@tsunix.de header.b="Fm+KKmqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99E32089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=tsunix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeGNW4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 18:56:06 -0400
Received: from mail.tsunix.de ([45.77.140.229]:42757 "EHLO mail.tsunix.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731483AbeGNW4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 18:56:06 -0400
Received: from railgun.de (i59F5AC05.versanet.de [89.245.172.5])
        by mail.tsunix.de (Postfix) with ESMTPSA id 79F003EDBF;
        Sun, 15 Jul 2018 00:26:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.tsunix.de 79F003EDBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tsunix.de;
        s=default; t=1531607202;
        bh=gBi87n4qEKGo6on6LesSMiAj9TagnGBxY2nktLk7HO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fm+KKmqMqYOqTRHnMkKKsI8++kJvyyDCzbvdPBKs3lyutnOGsibOp+GjafeHcMbwc
         oTyFpC/bJ1fJg46oyb6LgApTyu+o0gPHMCR+2xA+nKwlfgUHVX9Pzzccm6vkhXwwiw
         gl5527++KCkqvT+RKceNPkQ/+rOxxI4Cboo1lbis=
From:   Cristian Kubis <cristian.kubis@tsunix.de>
Cc:     jfrederich@gmail.com, dsd@laptop.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        cristian.kubis@tsunix.de
Subject: [PATCH 2/2] staging: olpc_dcon: add missing identifier names
Date:   Sun, 15 Jul 2018 00:25:41 +0200
Message-Id: <20180714222541.2564-3-cristian.kubis@tsunix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180714222541.2564-1-cristian.kubis@tsunix.de>
References: <20180714222541.2564-1-cristian.kubis@tsunix.de>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing function argument identifier names as suggested by
checkpatch.pl.

Signed-off-by: Cristian Kubis <cristian.kubis@tsunix.de>
---
 drivers/staging/olpc_dcon/olpc_dcon.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.h b/drivers/staging/olpc_dcon/olpc_dcon.h
index fa89bb97c7b0..c987aaf894e7 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.h
+++ b/drivers/staging/olpc_dcon/olpc_dcon.h
@@ -91,10 +91,10 @@ struct dcon_priv {
 };
 
 struct dcon_platform_data {
-	int (*init)(struct dcon_priv *);
+	int (*init)(struct dcon_priv *dcon);
 	void (*bus_stabilize_wiggle)(void);
-	void (*set_dconload)(int);
-	int (*read_status)(u8 *);
+	void (*set_dconload)(int load);
+	int (*read_status)(u8 *status);
 };
 
 #include <linux/interrupt.h>
-- 
2.18.0

