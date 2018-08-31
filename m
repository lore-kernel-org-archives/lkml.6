Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD91C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A172083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmis8Zw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A172083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeIADNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:13:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54968 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbeIADND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:13:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so6529864wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=23CyIVezXkX9KeXsCKTj4ty0nMV2yjdI6nzEQwIeK5g=;
        b=lmis8Zw2IgcCuffpT2bruAOXR72qUBdLO1fW6hSRQ/2fP7CbYbJtUYLQ0uY90nwIsR
         3x1I1+AiOPUWVpo1rCMnVIwzzqz+IQLLE/gwQ7Klws3LUmWOVOoVSMhbLWMlpKH0yDdi
         XyRdY18ytuc8EVRDyclZze4qlqLkvUxEQ0SBhtEaXJhsnajMOXxhJM66/h2NnF5Cz/d+
         2ZWpGiW48xOwkK4EOZWDdzfXof9j+p5Ejc2yAmDg8tVrRjhcGvPQhYorD2nJF/4RFfl0
         GU6pJcX8zJh2JrkmoAOmlaX3QLpSe7OYFa/EKPcGKrzlurRMuNLwJxWml81AGzjHEdNe
         Mvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=23CyIVezXkX9KeXsCKTj4ty0nMV2yjdI6nzEQwIeK5g=;
        b=iM2ZusBFiLMA2jyHq+q+kc8P1C7kEQepLQu2dYziR5OtOdQS+cPnjTPuelBuflpuMp
         MIMv2s7Pl0cuimraDg2IkJoFBkRyzU/R54j3LVc684tDTPCXOp8OD/eFPgXVEMUQj4Zl
         zQvlry9Ra0/8Uy88WO0CDgPMC1fDJ/Syy3a8l0c6l3JrHw8r8LZirkL4/Yhjp1ui2Kpa
         9rj84StPJH5watQahOYIoSLZozKgLkheOavW2x2Taw+V3wGNK65A+n7ep5r9BG3brdAP
         xhKKUwGqIz3Qsi0misNtUnaKmUFMfETYYcx5yCMiJChyZ39XEMo4I3yKAdHtUVHeOmfb
         yN7A==
X-Gm-Message-State: APzg51Dtl3lEB9TYIzb+RPFAnsjJAlLuwBMGY+tnT7BJ29PW8v8sUYvm
        tkwHWy4ImySdZqC2Z/mgb/93UPu948Y=
X-Google-Smtp-Source: ANB0VdbzjBfmQyLLb3K7U1NLj4peWcb/8FnLiQoXgY9f37YSg4MBbOpX8mXOw7tx6MpwJhCsPxcIrQ==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr6212635wmf.114.1535756601096;
        Fri, 31 Aug 2018 16:03:21 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:20 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 16/20] staging:rtl8192u: Rename CmdInit - Style
Date:   Sat,  1 Sep 2018 00:02:46 +0100
Message-Id: <20180831230250.16810-17-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable 'CmdInit, to 'cmd_init', this change
clears the checkpatch issue with CamelCase naming.

This is a simple coding style change which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 5d643870a1e3..4d29b7427a0e 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -161,7 +161,7 @@ struct tx_desc_819x_usb {
 	u16	pkt_size;
 	u8	offset;
 	u8	reserved0:3;
-	u8	CmdInit:1;
+	u8	cmd_init:1;
 	u8	LastSeg:1;
 	u8	FirstSeg:1;
 	u8	LINIP:1;
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index d4af6cc01fc6..b385c686370b 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1515,7 +1515,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 	memset(tx_desc, 0, sizeof(struct tx_desc_819x_usb));
 	/* DWORD 0 */
 	tx_desc->LINIP = 0;
-	tx_desc->CmdInit = 1;
+	tx_desc->cmd_init = 1;
 	tx_desc->offset =  sizeof(struct tx_fwinfo_819x_usb) + 8;
 	tx_desc->pkt_size = (skb->len - TX_PACKET_SHIFT_BYTES) & 0xffff;
 
-- 
2.18.0

