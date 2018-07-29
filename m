Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22757C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED5820857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odZdEkgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED5820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbeG2Whl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:37:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37266 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbeG2Whk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:37:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so10594064wrd.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BfMlzA8lhZqx3WnngFSF42M8fbLsyUqpJ1vXnveJ4Fk=;
        b=odZdEkgL1RB6gD+sgCBMEJza4m9Ghb6HjUU51Gh20vQGkrEfHgOJYL7nvHg5A3Qdpy
         OddW+tUhneNTmjm6Iv8JckUWjhqJxOJpYc4Po+UOLaj3sIS0Sten+Wm+bes+DgQPhSEm
         pJ0JeKy70h9p6Pv680yFCIjtV/Ptk6YM2Y9LITpgatWArHk17K0ogk05R6dCjsIV6IYl
         HSmZ8iytXnXPyKBast0SRrpgSqjo/ef3l9kQ5UIxca8Ez0FoAgz3RkHpagdurUYU9PoB
         6LOM/ViC4SWa0DdUMTbpIx4yTB1b0C16tTXWh1PXyhHaHfh3iW6OYke5KJCrwC3RPcWC
         tCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BfMlzA8lhZqx3WnngFSF42M8fbLsyUqpJ1vXnveJ4Fk=;
        b=MGmIk2Eus4QPQWay8JVeJ2E0AuK/eFxLNpeyZXLRNpeQd69uses5IK1Rw8ABBn2Ttm
         StTWnRMQGkJ8Jgn6rGvxweFWq2LpK07xvd1s7dzYdVAzbP3NVZPKTrcIIU0BoL93+5th
         zVk5POXSyhvqCK6qmWyIj0iHst2iafeEIia0i7OLfhRiWafHIHzhqMMlv0C61t/k4MFx
         ypMpWZoi1HJYq6944Rlwu1//b/mT/lv/Qw1PTM/MrYHPEfsxDUzNW5bwe5E4QPvIeo2+
         qu1hWMpOG02YOc/G4kjbhUlg/RktOOFdPI1Eb7fcxhPNj2bi2bt6zhmIsjXKDg05mK/Z
         /MqQ==
X-Gm-Message-State: AOUpUlFBh2n+5oU6O7LclfED5pjWtIbXtQoiPQMexWQnd56vsgvnALy6
        HCzKNj0/rQS0q8cl4L6+lvJf+m3LOGo=
X-Google-Smtp-Source: AAOMgpfgDRi7TKkYrm/a7Z/G8tJuGumHEE74TkoedtopZeeOjIL2nPSTY8Tgdhundenxj7dVPTLgQw==
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr15143592wrs.137.1532898349385;
        Sun, 29 Jul 2018 14:05:49 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id l19-v6sm10476876wmc.3.2018.07.29.14.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:05:48 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 03/15] staging:rtl8192u: Removed unused CMPK_RX_DBG_MSG_SIZE - Style
Date:   Sun, 29 Jul 2018 22:05:16 +0100
Message-Id: <20180729210534.10617-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210534.10617-1-johnfwhitmore@gmail.com>
References: <20180729210534.10617-1-johnfwhitmore@gmail.com>
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

