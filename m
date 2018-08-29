Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF434C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949D1205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnxricDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949D1205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeH3Aee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34885 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeH3Aed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so6025701wre.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+gHeebErSNXSjl5+WIlqNIEpgw2eqtRv+MI8ZWddzIM=;
        b=pnxricDw3KZl0+oMCm3fFKmEVkXS7PU/2g3aVh+y7bQ1Et7Av0NF8zU7q3TC94jlBZ
         1bdpoNQfQziM6H2wqR3zjSJOckIGqJJyGZzpzgVyOfo3SkrWlllSWgfJRfi9uWpgRHTm
         UfNc7tHXubEDF9ZwV6nBUSg+Wr4i/P8wwTYcTwd+uf4GI0FiSxl5SRZ3U54jfckYZS37
         Txgn+3gG6CDJjKP1UFCYkLeyZMorx+H7bgAeW46EJb5FyyxzJGuoSrc6zKoWwEUEDJxD
         eQ7RmbcR1blPQ4WnOrQu4twZBiuoJnF+ZMeoOw2xjzKoRyJDllKWqBj/grtm390VApHn
         jNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+gHeebErSNXSjl5+WIlqNIEpgw2eqtRv+MI8ZWddzIM=;
        b=E1f/6g5oLpdJCHNol6Zm08nZRybZFLdDWNh1nhOrVz57MyPO7dwb3CBFXudfQP2ylM
         3fb7Be9/g6JHsl3NLLeyWnHDZcZYa8ecaYirE0kjN+dxiU3rbS70iYWeOpz8p4Q2p6u4
         lD1AbI/BQfrVsa836AYDygmxG2IaNrWp3uqWGAIBF+m5B4baiIC2rAP6/LPt+qBa5Jri
         fYs4Ko60GciRAB7uaBH0FR1zaSYnWlzVP2FNhxZlfovfNPuh4QWCCAaRNw3HGkcKZ3NJ
         6/oz+pJW8jgp9hbi9ZIAVvBbRV7zrH+Lh32hwxDUZmFbr65B4oNbj1KN2nb+E+umwJ8D
         jpVg==
X-Gm-Message-State: APzg51BFgEPkr9xOnDDc7RvCLFFR49XK2Zdz1GVGAZd59i9MfsQSHFks
        8YfFWlrMbkG2qi5ZqAXjghBdLnlL4S4=
X-Google-Smtp-Source: ANB0VdaXPBw/FSYUrcB0+D8sV4AKiXjtfq3H+znMTUUrjf/ecEUW9u8Z86y/L6cojNjcW4k1/RxK7w==
X-Received: by 2002:a5d:68c9:: with SMTP id p9-v6mr5412115wrw.108.1535574957994;
        Wed, 29 Aug 2018 13:35:57 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:35:57 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/21] staging:rtl8192u: Rename AdvCoding - Style
Date:   Wed, 29 Aug 2018 21:35:27 +0100
Message-Id: <20180829203547.15650-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bit field element AdvCoding, as it causes a checkpatch issue
with CamelCase naming. As the element is not actually used in code it
has been renamed to 'not_used_adv_coding'.

The single line of code which initialises the bit has been removed,
as the  field is unused.

This is a purely coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 64d5359cf7e2..66a0274077d3 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -39,7 +39,7 @@ enum ht_extension_chan_offset {
 
 struct ht_capability_ele {
 	//HT capability info
-	u8	AdvCoding:1;
+	u8	not_used_adv_coding:1;
 	u8	ChlWidth:1;
 	u8	MimoPwrSave:2;
 	u8	GreenField:1;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 9bf52cebe4cd..d7f73a5831da 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -550,7 +550,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	}
 
 	//HT capability info
-	pCapELE->AdvCoding		= 0; // This feature is not supported now!!
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pCapELE->ChlWidth = 0;
 	else
-- 
2.18.0

