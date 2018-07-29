Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B30C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291EF208A1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djAw9TJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291EF208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbeG2WkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56284 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbeG2WkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so10933817wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BfMlzA8lhZqx3WnngFSF42M8fbLsyUqpJ1vXnveJ4Fk=;
        b=djAw9TJc++YfYlcXnGOquoOr2WaOlF53BhEVE1uwYdP44Zxi0Tp47qboMDjOBYAKMx
         TOHWkAcvvJQTlh0BZH5Yp4c2hQT8XYfDi1ILamDHk4q8WX1DyVpRBavVotSdEQlFrq0J
         kq4nPyeYFBNGaq0ECAViwxsmzq2c2v8V1xiMlpho9UaD0So6V/rgKe9TUYYXODhm/B3m
         +O6Xe8iOY+xx0usvHBUSGwKNiTU8tPv0VluNsOqk5KOzF/9zBGd0JwzSfZUqNevqsBka
         0OMLyqVUBtEC+sK32/dybtYHiQnNdd2zy6s0j/S8X8Z2a+xd5rxOKA4ta/7uu7qvv1Rl
         EM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BfMlzA8lhZqx3WnngFSF42M8fbLsyUqpJ1vXnveJ4Fk=;
        b=Gpurvh/Lbqb1I/9gbft+d97ExmqDBvBbd4qhtH1LTIiXIcOTp8FhkTO9mRBVqw51O2
         DMoQAjPayFieL35f99mzonQNnD0ga3IzshQjxHF5VF4KoZrP+KUgi63g06AN1nJHlgla
         zrtKfQaYx1cdb/p+AgiGsWNQbQ7XYEzt6LrYJut2h9yvKT2ZBioXwEsZE6ri5YHLQtlI
         8rZSDKpFwQ6LVekTm+w5J5rTWaeF8GstwGu61jH2Gjtxoc7YjCqaf2m/xmrlTFadp0Qt
         N+5UIfW73E6xk7ZI4eLOm08B+tXa8Q+MKCq1MFGfs0X2JKJylMceV0J2Hzqhs79GSbpK
         zExg==
X-Gm-Message-State: AOUpUlH0Jv2FQnOzUEAgEhmAn31fuTOx5mfwejH7b13YjQRMx2V/deYL
        gvADdrw8UtYptU0mAEPhgTGEJDSVaeI=
X-Google-Smtp-Source: AAOMgpcD/x/aarMY8ENRtXrpu3XJ4p7IBFAC+gC5PFh0oQfZZnJs53GdPLGxqhJU4UBj8lEWkKcd0w==
X-Received: by 2002:a1c:1a02:: with SMTP id a2-v6mr13580092wma.52.1532898506022;
        Sun, 29 Jul 2018 14:08:26 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:25 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 03/15] staging:rtl8192u: Removed unused CMPK_RX_DBG_MSG_SIZE - Style
Date:   Sun, 29 Jul 2018 22:07:35 +0100
Message-Id: <20180729210747.10803-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused macro definition CMPK_RX_DBG_MSG_SIZE. This is a
coding style change which should have no impact on runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index fab982668b44..50218d9a406b 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -5,7 +5,6 @@
 #define		CMPK_RX_TX_FB_SIZE		sizeof(struct cmd_pkt_tx_feedback)	/* 20 */
 #define		CMPK_BOTH_QUERY_CONFIG_SIZE	sizeof(cmpk_set_cfg_t)	/* 16 */
 #define		CMPK_RX_TX_STS_SIZE		sizeof(cmpk_tx_status_t)
-#define		CMPK_RX_DBG_MSG_SIZE		sizeof(cmpk_rx_dbginfo_t)
 #define		CMPK_TX_RAHIS_SIZE		sizeof(cmpk_tx_rahis_t)
 
 /* 2008/05/08 amy For USB constant. */
-- 
2.18.0

