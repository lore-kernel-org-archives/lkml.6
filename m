Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E04AC6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E6420882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDknYPdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E6420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeJHEs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:48:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38522 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeJHEsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:48:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id 193-v6so6434279wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+rGju/Q64zBILSg9WeU6jS3iSTqDtdja3Ai8dfQGoMk=;
        b=WDknYPdvkXYNYDHjWZKkoAQ7tlUGo6BXwq6afg9MRJSfsBBn1naJDhp7PUU+SPAGUY
         uJ8eBEzfVtxCST1ZIOOktg//S8CnkobUvl6ulpZAPaaHxFjn0blPNE3KYKuwAkNp/wP4
         a+c1hYraS12/MqGH8JKw+PNTqnRk4aEipIAPanxWjv8ALjFvqV301TcaXNRPo9WY9dBo
         seHvThnP0mVkB6QCv6jx2fX2WYj1nG4gchYNZNzhn8ct7mIO4ooBMJUbHUdbQlf7mqxD
         kYqOLezvj2FlmWttBbMCMVe0sCB4rBDx1FCS4QSXwDyny5XUS4dpWt7Fxuc/rRdNncG2
         iRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+rGju/Q64zBILSg9WeU6jS3iSTqDtdja3Ai8dfQGoMk=;
        b=DwyPT81n88Qwbw9021MLkX7CTgD53L6O/kXbEq8tIWnYVuK4IkZx45JlMiKn8+UU5v
         IqnGNTsRQJiG/2QFTVTBtmeVPNETE+fV8AdB9jaV0GKpS9xbPgM5vq5RcpXRPRiOZbuz
         iqCBMoQhsKEPiynZyy5jqdLtjZCwNSU+IJGj7ox/53HnR+PJKedRvb++FbWC+1atepYa
         +vd2XoIecTWpyEz7kDw96I/u3ZjWd2QXYIlCltLOcCu/9RUTi8wyK/oVzm+zEl4ac/f9
         JeAol3xuOHMPqrRGo5S7V37hAqJPnDKLMVETxhU6fuqH3NXzEmhjkAU1ObKuDSPVSPiu
         hG2A==
X-Gm-Message-State: ABuFfogTcemb7B7N3mnJK3cFHDZ2A13LmWv+lbzAT2WfiqnO6IKAxNyZ
        GKNi+/Fm1enhqrEg5g9TWDg39hwH
X-Google-Smtp-Source: ACcGV609YBsjxNWiSky/65j8zJxOALGDRp+jtnXUpk/iw+vpYOwneqQGXhY3PLz983vpRnGKofjxvQ==
X-Received: by 2002:a1c:8bcc:: with SMTP id n195-v6mr14375332wmd.118.1538948418411;
        Sun, 07 Oct 2018 14:40:18 -0700 (PDT)
Received: from localhost.localdomain (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id i7-v6sm7758097wmd.41.2018.10.07.14.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 14:40:17 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/11] staging:rtl8192u: Add missing blank lines - Style
Date:   Sun,  7 Oct 2018 22:40:22 +0100
Message-Id: <20181007214025.25469-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007214025.25469-1-johnfwhitmore@gmail.com>
References: <20181007214025.25469-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing blank lines after declarations. This clears the resulting
checkpatch issue.

This is a simple coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index c31db21f7e63..f134cd5a9829 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -199,6 +199,7 @@ void free_ieee80211(struct net_device *dev)
 
 	for (i = 0; i < WEP_KEYS; i++) {
 		struct ieee80211_crypt_data *crypt = ieee->crypt[i];
+
 		if (crypt) {
 			if (crypt->ops)
 				crypt->ops->deinit(crypt->priv);
@@ -248,6 +249,7 @@ static ssize_t write_debug_level(struct file *file, const char __user *buffer,
 {
 	unsigned long val;
 	int err = kstrtoul_from_user(buffer, count, 0, &val);
+
 	if (err)
 		return err;
 	ieee80211_debug_level = val;
-- 
2.19.0

