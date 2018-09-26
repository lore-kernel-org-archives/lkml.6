Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7846CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD5B2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkdM+3h6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD5B2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeI0CS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:18:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40228 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeI0CS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:18:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id y8-v6so191659wrh.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioZNik7AeSalSY42OJGMkcJeZ/0STxrHWHBthIxRAu4=;
        b=qkdM+3h6NCe/RFtjdBasnBuwAffTpyHxGIKP5CEd598of5GNfUQ61GJQj85CzEapDE
         vjFokSiQXOb9ans7VJaEr3cMLnnkoMaH0Lz0FlQiQHjskXwNTLiTzOi4bYUTpoGgHW1m
         ttZk6sQg+8d0FRhuNNZ/OhyBhRdPIhq1FLGX+mrjgIvq7OIHW4htOodeS+naxoVWB3iP
         ICe4W3o1DQD7KZ4soAF0B4OL6FQbHUqnrt/slMlPdGpQMHF+FcJiPnNdZfztS6CCBvLi
         wodZ8TREbZzdsfDjSxthu4suxvKBCjznOm3T56bht+hrdrjf/GD3zquDZik90gO6Y5N2
         2rSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioZNik7AeSalSY42OJGMkcJeZ/0STxrHWHBthIxRAu4=;
        b=h8hBnCX6NevAZFfQ4dmaJo9Gv3LpvFFYvaUOXwldtFBvqnanePGuawwNzY2BB7TFwv
         2No4FMc/FBtbab9KIRspb1rCBvU78rA9iR++vFuGBGxVnI/HRaU0gHbd7K+R7LsP8vSR
         EuE6uTVG5Yd7XD1oEnsYBI5p5+cHJKii3T/mP9MkX2BmPlT/NAijjbp1sPNNCVoqsV/i
         WKLSuRPgr5joVmJYTwf47dDkJZWSspGgJSR40jzTWDeJ/41zWvES7gYmElOjmprOQOzE
         t6VGv1fLNHhhbbTkMD1bUZ0Rh8EJo8XtlaBX0uCQTXrjhstU8nYEYwdAWlZoNOmf0RT0
         mlUg==
X-Gm-Message-State: ABuFfojoEhP3+vG5IVCPh6muwbPzSCg6/JZiMl0yUstLdtxfrZ10x9RA
        6o9VdExvjEYhX+xzne/TxeA=
X-Google-Smtp-Source: ACcGV60mlr0TeSMPHXehIGChyU+8Sv+JQOhzmzuSzqQm/UPxFg2cqYndNrLmE9Ojcs4utQe9wLqOuQ==
X-Received: by 2002:adf:9503:: with SMTP id 3-v6mr6271864wrs.91.1537992258873;
        Wed, 26 Sep 2018 13:04:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id n4-v6sm7447403wrr.21.2018.09.26.13.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 13:04:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: rtl8188eu: do not line break function definition - style
Date:   Wed, 26 Sep 2018 22:04:06 +0200
Message-Id: <20180926200408.2372-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926200408.2372-1-straube.linux@gmail.com>
References: <20180926200408.2372-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not line break function definition. Clears a checkpatch issue.
CHECK: Lines should not end with a '('

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 9226a96aba67..ce8add5773de 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -900,9 +900,7 @@ static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse)
 }
 
 /* Transfer current EFUSE content to shadow init and modify map. */
-void EFUSE_ShadowMapUpdate(
-	struct adapter *pAdapter,
-	u8 efuseType)
+void EFUSE_ShadowMapUpdate(struct adapter *pAdapter, u8 efuseType)
 {
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(pAdapter);
 
-- 
2.19.0

