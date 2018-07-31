Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CEEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD26F20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wrc2eDB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD26F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbeGaWmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:42:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44920 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeGaWmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id f23-v6so5843304edr.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Eb1znSJzqTIOdt5Ldoze1FhnwuuM0nKpMOYMobazQk=;
        b=Wrc2eDB4d+FKRwHu0xG1Ze0QKVtxphX/uPYs2TgimPmlQFeykXhRuUQyE6Z5DR6y3S
         /y7TanWfTCsMgSFMoLNCFVsFvE/ZIdqnLaTZyL43B3LMTOgtipy+QcEl0m7vG1p3xdos
         D6TVwtxu/pF4XmxG35ny9bgSf922lSIiDBCb0aWFiTshoJH/NnVbbLo67E3PUL3z0WrT
         JNwfA4Vtij1Jmq1JKJ+CG4jyhaAcJxLH0QxXQfzA+ojTNWjJ34Vw7QLQpdGzysLEzXJ5
         WJ8w0T50e6C/sMwzVp0onalxzSwoIU7HnfPZfoTdJrsdxFBHrvmal9EWW+yGCZtISkbG
         2yWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Eb1znSJzqTIOdt5Ldoze1FhnwuuM0nKpMOYMobazQk=;
        b=t+OeWRCTccn+EbFz5FHd5pVLaG5pHJ0u2JNmEwykzE4FNkcitxRtBQ3r+k/UWclR6g
         S48E8CZeHXRjLLtD0C6psA/Tw/EvY6iemYjVusQVSAx/tUKr3MRJjoAu8qSf2rS8RIO4
         jGgYr0qTlp4s1irkLsHwpMgwevG6xDCkfRSOxXnsO9EbwNhuxUgsXmDTlr67DISTKtxH
         +riRh5CZkEbLBOpxyqEk3Dsq2g3TLuJVfUQb1latBNEimTY7YAekpWofrmR8ak9ADqUG
         eLInOmuvhLGG8JrrVIZ4r/eTFu5oUm0vgMdOJajEBFUws0KEc847decQEW7vbXYbRrx4
         O/NA==
X-Gm-Message-State: AOUpUlEQ3gRZEjeFWVq8Z1Ljzahwk6F13wOLAsUf1RgtZomf5C/BEqLN
        07HFpOTAccX9Nw91MXwGahIwqjsT
X-Google-Smtp-Source: AAOMgpdbiOZK6CNCInI3MHf38/+TDTrAapfDc7ufkKgUui39nChjC87nMEz2RMkrScmh09ysAvRgiA==
X-Received: by 2002:a50:de03:: with SMTP id z3-v6mr1069338edk.245.1533070830129;
        Tue, 31 Jul 2018 14:00:30 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:29 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/14] staging:rtl8192u: Clean cmpk_counttxstatistic() comments - Style
Date:   Tue, 31 Jul 2018 21:59:52 +0100
Message-Id: <20180731210005.17452-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only useful piece of information in the header comment of this
static function was the name of the function and parameters. That
is not useful information, given that they are in the C Source of
the function declaration, a few lines below the comment. The block
comment has been removed.

This is a coding style change, there should be no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
index d2293a335ed1..900f7866d381 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -60,24 +60,6 @@ rt_status SendTxCommandPacket(struct net_device *dev, void *pData, u32 DataLen)
 	return RT_STATUS_SUCCESS;
 }
 
-/*-----------------------------------------------------------------------------
- * Function:    cmpk_counttxstatistic()
- *
- * Overview:
- *
- * Input:       PADAPTER	pAdapter
- *              STRUCT CMD_PKT_TX_FEEDBACK	*psTx_FB
- *
- * Output:      NONE
- *
- * Return:      NONE
- *
- * Revised History:
- *  When		Who	Remark
- *  05/12/2008		amy	Create Version 0 porting from windows code.
- *
- *---------------------------------------------------------------------------
- */
 static void cmpk_count_txstatistic(struct net_device *dev, struct cmd_pkt_tx_feedback *pstx_fb)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
-- 
2.18.0

