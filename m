Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE9CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B63D21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FD2hRMDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbeLZFFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 00:05:48 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:38308 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeLZFFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 00:05:48 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 35381BC2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 05:05:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1a1UOB9HJHu2 for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 23:05:47 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 079F6BCD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 23:05:47 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id g7so18843252itg.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=C3cocMi+x63NbAfEzCRDGhWTk24D3gnrZUiQtTnLhXA=;
        b=FD2hRMDXkLugVPWz6VUrfMbGbzNX/i5shYUMLTsSrR/dwwq6R+Ok8NHn5aea1z3YaT
         HV3bqcvot13qTUQS7YGmnLv4s4kUi75KAe4julAqNd1VdjtS01jLvR3txbfy1cB75KjY
         cA9AtzqdSGF95QpbEih6Exw91HwA8+yRgOv4orW6vqrSWaerHXKv0mrzyADJODe/649O
         j/njIgnrIrFYI0h2Ifko+gkvoPjKMVA/hI8SzgKBm5gKdRoo/OnnrBQmH9pE1UHIgI0E
         Bw2XTEUzM5P7OsHRflxksiNK92AEj39wvq68gvn1Sc8ja3+QogAN5OXTuA4n3ZKWGN++
         2wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C3cocMi+x63NbAfEzCRDGhWTk24D3gnrZUiQtTnLhXA=;
        b=DHRRWPv4UutK6PdhN/DwGPp+U6PZm09+9+SzndO6+t/9+0jG5q5RGdWv+N4pNCk+Zr
         TOwgCCwniMHf63prqKhus5KRTJtMG32BHMf989pHKdKwIW+i49mgEFwAoyu7GBHzFHt/
         r8FakC4aHQKqy2X7038NQLUyM7flMgHHzXFxegfCvSoPc+yJB4aidKBppeotwMUDwGwS
         tMy3e7OofSPuC+9A+keSfmn2bYlPaDfO8wbTCPrqSiBTZ8vbhm3hRFG/P2H08luSxuXM
         A6DlR9HiQFxqufJhMjjG66ojqURfCeCqcUqLiT2MGvT8y3/e8q3z6Vnq6u+J9XfljTa7
         0+hQ==
X-Gm-Message-State: AA+aEWZ3zqDnyu0bL7XVef90EB1u2tCzNeFRpul8+XqApEoYyzUJfyUu
        PVB6Zu+pLAATqAzhdpwwS8qqsph2NXzNP2+o4HDkMx2bHXqWk21hsQsk7QN/jQq1Jb46D056Cn7
        uMli8DmvuuFPVkNAMnlwBZ1bCVFO8
X-Received: by 2002:a24:3e43:: with SMTP id s64mr12828837its.111.1545800746618;
        Tue, 25 Dec 2018 21:05:46 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UnxhXYno057KakaGHPtxkrhlqKxOrXjYlHfRfxrWDBF3GLN519htI7y+o94xp86D+5DQn0rw==
X-Received: by 2002:a24:3e43:: with SMTP id s64mr12828830its.111.1545800746318;
        Tue, 25 Dec 2018 21:05:46 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id u9sm15070984iol.77.2018.12.25.21.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 21:05:45 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: sfc: checks status of efx_mcdi_rpc
Date:   Tue, 25 Dec 2018 23:05:17 -0600
Message-Id: <20181226050517.74381-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

efx_mcdi_rpc() could fail. The fix checks its status and issues an error
message if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/sfc/mcdi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
index dfad93fca0a6..9486e6534dea 100644
--- a/drivers/net/ethernet/sfc/mcdi.c
+++ b/drivers/net/ethernet/sfc/mcdi.c
@@ -1819,6 +1819,9 @@ void efx_mcdi_set_id_led(struct efx_nic *efx, enum efx_led_mode mode)
 
 	rc = efx_mcdi_rpc(efx, MC_CMD_SET_ID_LED, inbuf, sizeof(inbuf),
 			  NULL, 0, NULL);
+	if (rc)
+		netif_err(efx, hw, efx->net_dev, "%s: failed rc=%d\n",
+				__func__, rc);
 }
 
 static int efx_mcdi_reset_func(struct efx_nic *efx)
-- 
2.17.2 (Apple Git-113)

