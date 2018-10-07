Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED14C6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E72120882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU5lgDXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E72120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeJHEtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:49:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51094 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbeJHEs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:48:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id i8-v6so204323wmg.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pfAc82XgvXate5aZ0n8kjbBWGUp71xR/JS3MtC3Ay+s=;
        b=YU5lgDXGQQfnkfzTY3sd1SL19pQcnRAzPk1mtshFs+COLxxkuM11JcIMNnKJ64+NAn
         ZS//QMJak/bOzwjT4vfSeb+O8kayRu37Swl9qOrXgWj8y5ZS/u+aoFY2cVM96AiSTMgG
         iQ9TmDdnWXGshRrgZlQ/6yeh03J9X6c0Y79BdElp22gwaKXQHesjXHrq2reLJSklexLw
         KZCzpWfum5TOtfl2VBtfAYRx8r1otoGcHZ4AGEeCx+s8pAzgSPXVChHiWHccplGwN5Au
         IfCG1gkBXWyJeGQ05bKpuKEdtKqVkgjkD2ofU53WdytnccPshPpXCjAxmgcIwvQkTasl
         S3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pfAc82XgvXate5aZ0n8kjbBWGUp71xR/JS3MtC3Ay+s=;
        b=lrt2p6ef+U9OkIhdD2tUfL3Ef55XGxzNk7TtbLmDP3b+URBGMkERn6hbV18C8NLuFR
         eg7wbF7e/D6c4HEgHH8R7iIN1X2YAzceVDeAO7b1AtMEmoIZETDHSZaAq/cPgF8TGXPn
         irUl1S9riS+OGPwbK4Jz/v5WOcJNqRKFDr3S96SyRxLjy1SgRQgTP5asyHi8CokTddRI
         boFuZkPbb6xI0ZRl9iYS8rSapdTr92hlGoIW/Ztmhnu/lTenVBd3iFDDOzEPc3YCBESu
         GME6BpOfroVsTyFN9pKtqElgk5Ue2X1P/eMpdVCeYfdV/6HMpfFluuTxD3j+853mvX0O
         Wifw==
X-Gm-Message-State: ABuFfoiD8VRo8ufMZjhyQUXJoUgYES55VuLAnulcqXpElcigJOJlPFR/
        LA0g2Rq/xjMV64BiKrF6wduXClSn
X-Google-Smtp-Source: ACcGV608T1fvPNZDinTYQlkpNKJKwM1RPwkg+1oC3aV7h16OUCowFwPqTlKZreVpNKcpCWq5oauc9A==
X-Received: by 2002:a1c:84cd:: with SMTP id g196-v6mr13546243wmd.38.1538948422543;
        Sun, 07 Oct 2018 14:40:22 -0700 (PDT)
Received: from localhost.localdomain (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id i7-v6sm7758097wmd.41.2018.10.07.14.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 14:40:21 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/11] staging:rtl8192u: Correct comparison with NULL - Style
Date:   Sun,  7 Oct 2018 22:40:25 +0100
Message-Id: <20181007214025.25469-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007214025.25469-1-johnfwhitmore@gmail.com>
References: <20181007214025.25469-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct code to remote comparison with NULL, this clears the resulting
checkpatch issue.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index 5dc780119eff..57127d2a462a 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -275,7 +275,7 @@ int __init ieee80211_debug_init(void)
 	ieee80211_debug_level = debug;
 
 	ieee80211_proc = proc_mkdir(DRV_NAME, init_net.proc_net);
-	if (ieee80211_proc == NULL) {
+	if (!ieee80211_proc) {
 		IEEE80211_ERROR("Unable to create " DRV_NAME
 				" proc directory\n");
 		return -EIO;
-- 
2.19.0

