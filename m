Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57009C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E22B205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/fV3lxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E22B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbeH3AfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:35:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43742 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbeH3AfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:35:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id k5-v6so6011446wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lXvbcQWTZL5MMIK4xrn1DKa4OKpsCMLLvrBKzYOxOSA=;
        b=s/fV3lxs0gdUHv60hI9wGk9DtUCD05+zG98sgMnAEBtNFHrRhaLAa/2+mkVdcbs4px
         tviY8V8KH0Z9BNzb1UHS4sH4zeExJ+vNbPbr0L5LefGgLAmlH+YR4X0uFQTdLc3vA5ur
         gc4d3fT4BWWlYzV6R1KEoJtYxhcq/wYc8HbL9f7uy6NuVs5HP88I+trPTpUR6lQR6dm4
         Se0LmZTP3rfXZgELt5O6ZBQ6f36rl2TFM+dwkafuVk+nDKNgfY0QApA5hZTYxxPbgm5B
         rO+mLe2hjem114bikX9CoIX5R7x/mCtDIm86ySiaThvT8cEHmXDkRnwlmOLBkZ7f7F5C
         AhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lXvbcQWTZL5MMIK4xrn1DKa4OKpsCMLLvrBKzYOxOSA=;
        b=bsw643hZ7K9v0y00kIvE3/OcnbWpePkyU/VS0w+OYmZNH0ETt7eCo+Y8k647lY4oU6
         IJK1FjiZfTkpy8hVkksyOGQkYJeBzvV0odDKH3wL/Bs7waNkYqJR0rwNa7J6VMNXapHk
         n3GX4/EiimmtqrTcN7Ww5BmaDNQhPwhJNfFDDJV1SGmDE9O9DMdeYDHx8QLizvNOYwkI
         goLjMQbVNs+O73OFcnV/5p5x0gXjYo+7UZMw1NXR0HWM1JWrWpXtkhNpcNwJzHatI7TW
         zob8n6DGbTwyECqlTBKSah5exP3eD20LxDA7q8zm8OEVjlugvHDaB0VJFBXZNIYNCjUi
         h7bQ==
X-Gm-Message-State: APzg51DaWPEYOn/br3aEeFH2NpxhSoy+51Dfh0aK7+fC6/iq/VYPZdi8
        EbuDGZp6/8cy0ny1kEb+AnSsCzUwZ1M=
X-Google-Smtp-Source: ANB0Vdak2rXJEL0sAO3DKdU7YBjgZ07KV71RDAku965UHlm+a3dLO7OhYP4pRoe9iaE2qbg4osPFug==
X-Received: by 2002:a5d:4512:: with SMTP id s18-v6mr5773952wrq.82.1535574989865;
        Wed, 29 Aug 2018 13:36:29 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:29 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 19/21] staging:rtl8192u: Rename ExtHTCapInfo - Style
Date:   Wed, 29 Aug 2018 21:35:45 +0100
Message-Id: <20180829203547.15650-20-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable 'ExtHTCapInfo', since it causes a
checkpatch issue, due to its use of CamelCase naming. The name has
been changed to 'not_used_ext_ht_cap_info' since the member
variable is not actually used, apart from an initialisation which
has been removed.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index edd0c00307bf..b4a412d8f61c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -63,7 +63,7 @@ struct ht_capability_ele {
 	u8	cap_mcs[16];
 
 	//Extended HT Capability Info
-	u16	ExtHTCapInfo;
+	u16	not_used_ext_ht_cap_info;
 
 	//TXBF Capabilities
 	u8	TxBFCap[4];
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 625d117e5a8f..fe7682d8e258 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -599,9 +599,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 			pCapELE->cap_mcs[i] = 0;
 	}
 
-	//Extended HT Capability Info
-	memset(&pCapELE->ExtHTCapInfo, 0, 2);
-
 	//TXBF Capabilities
 	memset(pCapELE->TxBFCap, 0, 4);
 
-- 
2.18.0

