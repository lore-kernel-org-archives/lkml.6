Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A808C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D122A20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTfWCoKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D122A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbeG2Whe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:37:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39071 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbeG2Whe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:37:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so10583145wre.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wlXd15PhfUS8yG4U5TS9F83C/I+YrgCvbVzrdjilPeY=;
        b=OTfWCoKE0h6FQ2x8oGVK3ueC2ZsVuurIeLwyO+tNhMGCI6rITutX0H3jcYZp1deAWb
         kBg46qnW4nb3hGY0SimFXGqOB+URrdjaJkif5RM/aabbOr3yoVoDe813o/Z5IAnt6/74
         YcnSsaDVa8NJh1k/XMlaY9qnYp/6YcB00aCc4EcqBp0mkRHsBJ5OFZkOi6AGRqMXY+SP
         0FJ/5Zp4kdGA/6qcwd7WpPFr569MgJJAKNbS+Q/lO343c6bvZGYndmI4JcKv/Fpcak4I
         1Jg/l01w6RPNooYlhfAe0jehrwTYOVyDFh7LUxfRkPWRK50ynd1peM+P4aSm7/uy2BHL
         PYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wlXd15PhfUS8yG4U5TS9F83C/I+YrgCvbVzrdjilPeY=;
        b=Zt/KKkbqfA3nEVeZwjGrYwxY2h+uD9tRTJFhOoPZ3Re9XlaJhmwOWOISHqXFOUeCu5
         36y1IOz5k2qkicH+mayNq3tRt0cq/OYAjVRX4AoobOYgpPU/1UXoYiCGP1Lg47fasWD+
         21RkzGzFfJP/zUIMTMFdJT/EgiKQ07+s84b/EFJsRLKOby6PdjVTwb7J5hJZZiMQvmIs
         IDVNTnG9ZLjfR31LXmTol/l2sbLjOi2E91hePfgwCuVfvO4ImuGhZISITCkRLTXyuqfV
         nhH0IIiReZuiEQcIyOaR8q3KfxR9dxPSAS733LCtc36+vDymYLyntBiLhwwA4B2BQTMf
         mKkw==
X-Gm-Message-State: AOUpUlH06UR8UNpuOVbHwmJqBGEprNID4RHLC+VRaD1WwZPCK7af3+xA
        ICdnpMMDiHYNuqS9t8UT/cVA3/zGqyM=
X-Google-Smtp-Source: AAOMgpfUGJxm7lnHaxwAcTgT/W+utga3Ubryx58oJ9yo1piBUNPumdtZ9BaqA86p0iQs0EXYeJOVqA==
X-Received: by 2002:adf:96b2:: with SMTP id u47-v6mr14893840wrb.204.1532898343459;
        Sun, 29 Jul 2018 14:05:43 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id l19-v6sm10476876wmc.3.2018.07.29.14.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:05:42 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 01/08] staging:rtl8192u: Add spaces around operators - Style
Date:   Sun, 29 Jul 2018 22:05:12 +0100
Message-Id: <20180729210534.10617-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210534.10617-1-johnfwhitmore@gmail.com>
References: <20180729210534.10617-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required spaces around '+' and '*' operators. This is a
coding style change to clear the checkpatch issue. There should be
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 8ee9370520f3..92afa9dc9663 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -7,7 +7,7 @@
 #define AC_PARAM_SIZE	4
 #define WMM_PARAM_ELE_BODY_LEN	18
 
-#define WMM_PARAM_ELEMENT_SIZE	(8+(4*AC_PARAM_SIZE))
+#define WMM_PARAM_ELEMENT_SIZE	(8 + (4 * AC_PARAM_SIZE))
 
 //
 // ACI/AIFSN Field.
-- 
2.18.0

