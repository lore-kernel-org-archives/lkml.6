Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD01C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FD7218FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Y+7EavdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeLZGoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:44:03 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:58854 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeLZGoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 01:44:02 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id ABF2E937
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 06:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eG-vnZCrVT8s for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 00:44:00 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 16740940
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 00:43:57 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id h7so18815188iof.19
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LEca6Xts+zVHh0AgI4asPdaU8TuXEc059b4qJWAorB4=;
        b=Y+7EavdBCRELfYQN1c34errcdtuvEj7OXXdKe6cI7C9epiN94sbChz2W43sYLAmzEX
         Znt5TeBDsKPaWHWBjF2pz77wzo7Y4vwTrjSLjEr/7FDrOQjSzhr5AKIo5Czr7eNy/l+k
         7WQjItZ0ApUatcqCUbwt2TbGfVp8uxeRea8fKqsJDly0xEYZOGoYjZjc1tGSuloOkMoO
         BLd8yFHPFotPiOIljKBZGqClburbceSntq1icM9eoq7jYZ2z3FS8GhZlg/DJU+aSXtPo
         FSMWDmu1DlLTBJQCBba3+D6ZWz6GPzYw3NKFAFwklpYFod1y9nAi0mhhgLtHCm/M8Jh8
         Ob0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LEca6Xts+zVHh0AgI4asPdaU8TuXEc059b4qJWAorB4=;
        b=oOpA7wY4sthcOI8WnjN8oLnk4x3qBqgR4y6t+z9xVVG1vypHK1Eytk2etJAc1nHqo9
         Q7hdNCf4QgaEsRzT9d/GzzrXFHA5jj5GbdBTYa5RZ9YINqbAbi9pAmw5xDxjXZN8tURT
         ufMSol5zdBzrUV7YS/m9xyePFxwYC3tGXCFm9R3xhsQLoO3TPepAe7Ha5PzrvSva3Co9
         N/813PiKbtkDUdMBPZ0ifA6ZLmFKRMgVXksUl7RpRVsUTjSkHwBFF2/mPu3Z/YjUV6rw
         lKn+MtdjmhtwaOt0O1rYvR9dTj7+FDSYWI2lEh0RwVH1FjrLOeyTG7YFqGm2nUIm359q
         s0CQ==
X-Gm-Message-State: AJcUukfOXUsHmPN4ixBc26nYeqsCCrdrLXF5skIamamw0M8+sNi7SR+B
        mnSxMaQBNNFW2GjrIjr6Lx5uWMwSkM+cbkSrHAJxNrmy6EOct2WIa2r9JyuzqUMMS32dTIk7Kro
        H9ySUzDJCwe1OFLg74pXv9DWXSNgR
X-Received: by 2002:a6b:ed05:: with SMTP id n5mr6538836iog.212.1545806636463;
        Tue, 25 Dec 2018 22:43:56 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5S/eg+sG2rlpmZfjzmo0Wcv3S9JrKzU1Oj9d8l+u879YVJHVg1CoqHHqLmrDoYdH9u7oKRpA==
X-Received: by 2002:a6b:ed05:: with SMTP id n5mr6538829iog.212.1545806636226;
        Tue, 25 Dec 2018 22:43:56 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id k18sm15704049ioa.39.2018.12.25.22.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 22:43:55 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] wireless: ath: return error code upstream
Date:   Wed, 26 Dec 2018 00:43:28 -0600
Message-Id: <20181226064328.75897-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ath6kl_wmi_cmd_send could fail, so let's return its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/wireless/ath/ath6kl/wmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index 777acc564ac9..1f3cead3180b 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -776,10 +776,8 @@ int ath6kl_wmi_set_roam_lrssi_cmd(struct wmi *wmi, u8 lrssi)
 	cmd->info.params.roam_rssi_floor = DEF_LRSSI_ROAM_FLOOR;
 	cmd->roam_ctrl = WMI_SET_LRSSI_SCAN_PARAMS;
 
-	ath6kl_wmi_cmd_send(wmi, 0, skb, WMI_SET_ROAM_CTRL_CMDID,
+	return ath6kl_wmi_cmd_send(wmi, 0, skb, WMI_SET_ROAM_CTRL_CMDID,
 			    NO_SYNC_WMIFLAG);
-
-	return 0;
 }
 
 int ath6kl_wmi_force_roam_cmd(struct wmi *wmi, const u8 *bssid)
-- 
2.17.2 (Apple Git-113)

