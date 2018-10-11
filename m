Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61863C6780C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D9420835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITiVOAsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D9420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJLD0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:26:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34760 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeJLD0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:26:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id w19-v6so9422317eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+famgbS4xqDLtsCwgwELn3t42pyYb+63Ovu0DKc1/xQ=;
        b=ITiVOAsbPM4LXWAdYyMdGC52HEfZHkeAjGiyEiYgsZ2tbok9OTdjyPgVUhTJEpEgMM
         AY3Kn+6SVVIrpim1nSPdpnqg5HfEX5uSVENfL9nRwuXHXu0ys2+lRafPHlqRTbkH2jiZ
         3Af6D+V3bk8VNi5hAJ0eHZjRBj/2NvMVeIKY5yVRVE7K03WvHxgDRbabj1OkcXYPOH5O
         F1ZeRy5nqRizdVwjtd7l/bYxxiXRjOUIbKsxTKWouhaR4kFlj1+15MQ62Sf5dOLjM6YT
         tahRD3WeyWP5EMloJHIqf8MyJejjplKhF6dUJpt7hDkmpQbaYlOLtL7YfJyjy6Zh2Q99
         Fe5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+famgbS4xqDLtsCwgwELn3t42pyYb+63Ovu0DKc1/xQ=;
        b=ZkZWl41e/fxnrKutK2MyIzktzw+IFQXLMPWYDdZRrKk9GVnct3R3Hi2eSP1FoqaWI7
         EwzppMM5r9Y13GcNUkKS1R0BVDJch0N4TyMm/ATJaIKXzTwfUH/UyC7fUTPeexBJUrKe
         tTySASVlEv2+Vw7RV25kpaKIVnLE3fQ2CFR1VGgAh3RsCNXBUpchhlbmOuoAp1WIeDql
         KFeQK9A121O9yryU3nbW13FY3atq7Af3A39sUZHCCJ9z7NFHIUkf9w9mR9GWiHhOZfyv
         lFe3BjLuY/HfAThaEPc+MhFoJ5MMFASN5tUg1qrVGl4ZcyU7zxUshBwGrZza0R40c+Oc
         vFbQ==
X-Gm-Message-State: ABuFfoi8P02L+uYBLOGRC1UC5PJTcKlVCFkL5I+KwIm9SynOKqvVVJ4C
        YPTYxlYF+WR4qKFt5DYZuhs=
X-Google-Smtp-Source: ACcGV6004Z265JSdUoH6WXSXgpWtwRCrczMR+E2FkJdrkogfqZ/XugGi6D0ngGZlclUVJFcYiyJ6Ow==
X-Received: by 2002:aa7:d58a:: with SMTP id r10-v6mr4998873edq.161.1539287852630;
        Thu, 11 Oct 2018 12:57:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id k22-v6sm919408eja.23.2018.10.11.12.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:57:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/8] staging: rtl8188eu: remove whitespace in qos_acm()
Date:   Thu, 11 Oct 2018 21:57:12 +0200
Message-Id: <20181011195712.1472-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011195712.1472-1-straube.linux@gmail.com>
References: <20181011195712.1472-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove whitespace in qos_acm() to improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index f0dde8aa853d..ce631efd48e5 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -335,9 +335,9 @@ static void update_attrib_phy_info(struct pkt_attrib *pattrib, struct sta_info *
 	pattrib->retry_ctrl = false;
 }
 
-u8	qos_acm(u8 acm_mask, u8 priority)
+u8 qos_acm(u8 acm_mask, u8 priority)
 {
-	u8	change_priority = priority;
+	u8 change_priority = priority;
 
 	switch (priority) {
 	case 0:
-- 
2.19.1

