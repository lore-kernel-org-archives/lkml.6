Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E9EC6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71F920882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="or/wtz48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71F920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeJHEtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:49:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34280 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeJHEsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:48:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id z4-v6so18711582wrb.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/eT30h/5dLsMQi7bdrrJuhg3P83jMrLyGQiMNFnuj0I=;
        b=or/wtz48oSdwY9sip0vbcEBwOv5SVZEK5L2XurkrawrkpELvDqok9NhhwMGZXMew7g
         sqN6Oesi4pA84xdDrNAh3sstLW7Rg31SJqdZhetYbEzTHTaWhV2BgAEd3MdGZH/5cGdJ
         2ejKBbWtwVraDz+Vvrr3qmq6npwLXYuKish/TSdIS2T00NJIr7nFD5cHg8wqSLtcUrGV
         57t8zkUtaeTsdiOQknwV5QJdaoKNjbaEIM4KUWCpgs+UjMZ5gvEqpX8uuPliIayNshhh
         gbW+776sxes7f2OeGLS+w2JKPkNMgSlN9ynPLyHflnD81qkWqN+1rP/NQUyzfDNrHGU7
         aJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/eT30h/5dLsMQi7bdrrJuhg3P83jMrLyGQiMNFnuj0I=;
        b=OX5Ewo9CtjdpIeZBJ5BGZkpkV530XJCcCb2Db8GWD+jO0qY2cnESZUz70pWNcM6ik3
         uBMhu1r6oWRihci+Jhn8EG/Rzg9FaIvne4EKuhO00bTa+yxcKkzuCnGaZJ89NaQo1eEo
         uNEXnA+o71GH9tWu0cL8WptbYkFQNks7IyW47PNkYNCIy2ml0lFPFpyH6Znyap+3IzGD
         FdGL/g2ezMi0iXJj25dqgbu4sLzTxBJOgv7bPBhf0jty03pYt7tgOs0CJqpPQUr112oL
         JhV5LQMzR+nZP475sHBXHC0Bro48OJohdEKXGHww5h0f+b2ngpJEm6R8Dt2qr3Zaj0wn
         kyjg==
X-Gm-Message-State: ABuFfogHsykutrgREp9NiRTdYF38go05Cqn5uluGKXp24ncnFnqxJAjk
        UOkBynZGunzFe/71mD3QA1lYGJFr
X-Google-Smtp-Source: ACcGV629JdeKattX1zqRuyCXC0jjRdrCiV42Wae3xLqgfQvwduX7NEYSE5hLs3bkAadwJdf0BYvpeg==
X-Received: by 2002:a05:6000:114e:: with SMTP id d14mr14161131wrx.301.1538948409842;
        Sun, 07 Oct 2018 14:40:09 -0700 (PDT)
Received: from localhost.localdomain (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id i7-v6sm7758097wmd.41.2018.10.07.14.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 14:40:09 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/11] staging:rtl8192u: Removed commented out include - Style
Date:   Sun,  7 Oct 2018 22:40:16 +0100
Message-Id: <20181007214025.25469-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007214025.25469-1-johnfwhitmore@gmail.com>
References: <20181007214025.25469-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove commented out #include directive.

Additionally shorted a block comment to clear the checkpatch issue
with line length.

These are coding style changes which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index 5f8229f2c757..bd64d126ba2b 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -29,10 +29,9 @@
  *  James P. Ketrenos <ipw2100-admin@linux.intel.com>
  *  Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
  *
- *******************************************************************************/
+ ******************************************************************************/
 
 #include <linux/compiler.h>
-/* #include <linux/config.h> */
 #include <linux/errno.h>
 #include <linux/if_arp.h>
 #include <linux/in6.h>
-- 
2.19.0

