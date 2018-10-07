Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17181C6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE12F2089A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew5pvhYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE12F2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeJHEs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:48:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54084 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbeJHEs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:48:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id y11-v6so3327021wma.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sKJjW55dLoWVBA2Y8+lQ37zymHHAUHdhhYhKbjV+H/c=;
        b=Ew5pvhYkK48Tt3m5cEGJ5BhacEtGtUBYR0++7IZpwLkuIoZo9mzfoiSZcwztLACzKT
         d2vir63i11S+75/b8jvzFlWF9H2baUGluY3HBogUczZ+/Fj+QXcEzqJoUdeXUWCf2U9D
         OTAnLXNpZNicFA8as7XvbzlE9icG4mEKhYzsAtASsdDtEss14Xfcvm2ukmIsFCDLITfv
         z/Ome/7mRo7Fx8Ldwcw7yWBMItAjE/iIWJWkhMbI8PY7M8tkMstjF9QEyBDwAoj1I4np
         +cQ/PBk4TTiSoYj/f4IxRhB6F0cvHg8mbj/5TIP5e9isFgRfpPrptPC3RMeiqcp51+v9
         v/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKJjW55dLoWVBA2Y8+lQ37zymHHAUHdhhYhKbjV+H/c=;
        b=QKLFQe05kvnQEG64OJO/NfveWBzmkJGEe3Odrrej95tjnqzj/8k8aTDKvhDJDn1//U
         jLsPG+HgHC9ETjmy9U+QmYP7isZKsDBfQGpddhGOkOEkvspRk1wcROSkaAQzNtVqkWHL
         DEnjlG3lKHO6baXWOMr6l3VNcMy84ujsVLcPxQzqsQKC3Q+FABihtfetDX9unZNBrwID
         stOKpn53NOjY3ldtfAeRj+aytUTdIjnc4pKkK3rwL0gJtcq/9Czf3bCh3hG0Oez8lcfi
         6OTcqFFiJAuM9hiq4tWLUicAYCAba8oPg3ywcs1fRdYAw7j6oe5haoIdMLLJVNXeQhxe
         DlDg==
X-Gm-Message-State: ABuFfogW5sUJQh1c1DfkWtpW3zYDNLhBSdv3bXFTzrFiCiaYjRMiS2/r
        xezLLr2ZCNNlHRQLuptQD7Nde0FD
X-Google-Smtp-Source: ACcGV60XU6WqJy/leGPJoFr3WDKTNID/RqLRCtMspZeQUvmaspbRTSyI/+VuMrfaC51HOiFllXYoQw==
X-Received: by 2002:a1c:7dd5:: with SMTP id y204-v6mr14195465wmc.63.1538948419752;
        Sun, 07 Oct 2018 14:40:19 -0700 (PDT)
Received: from localhost.localdomain (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id i7-v6sm7758097wmd.41.2018.10.07.14.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 14:40:19 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/11] staging:rtl8192u: Remove unnecessary line continuation - Style
Date:   Sun,  7 Oct 2018 22:40:23 +0100
Message-Id: <20181007214025.25469-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007214025.25469-1-johnfwhitmore@gmail.com>
References: <20181007214025.25469-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary line continuation character to clear checkpatch
issue.

This is a simple coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index f134cd5a9829..1b0f45f1bb84 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -215,8 +215,7 @@ void free_ieee80211(struct net_device *dev)
 #ifdef CONFIG_IEEE80211_DEBUG
 
 u32 ieee80211_debug_level;
-static int debug = \
-	//		    IEEE80211_DL_INFO	|
+static int debug = //	    IEEE80211_DL_INFO	|
 	//		    IEEE80211_DL_WX	|
 	//		    IEEE80211_DL_SCAN	|
 	//		    IEEE80211_DL_STATE	|
-- 
2.19.0

