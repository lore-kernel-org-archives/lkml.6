Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D5BC6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1DF20895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nioCVicY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1DF20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeJHEsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:48:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41597 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeJHEsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:48:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so18697251wru.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QP+9x02XMKXpNt4AiFnwzez6bPYd5DNcuufQKA5uF1k=;
        b=nioCVicYn/j5Ida9I6E9GJegEAA9l+QQw69abtzn5TpWa6msiuIBwLFO7WEw9hjPPP
         8HC/eCVDO4e029edvYps+iNlNGGHldSQbzZ4QKWne6QZG2PKCB3GZ9Meyj03f94S8i/K
         KUEfdMcBK1L6CIBxO1rBft3a1UH7xgA67IlTKuvmx1dYmUiGjtypI9vmrCDZmvmz9V9i
         0QNyy3ZVsl1zBz9/iSS4uaMkcAqe5ORiCnZv8OFCml+YW3sMRKlX/Um5nhjHsQFVSQtq
         Cf60+UGtAJOAtqS70c7/hx4Xj4TOjwdGdUui2yfWhgT5s3WrD8O0VGBN6FjS4qBo06n6
         HQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QP+9x02XMKXpNt4AiFnwzez6bPYd5DNcuufQKA5uF1k=;
        b=CNyLeen+FvI63YkkyMxBdAFxIGI+Yz+qD9q5wCOdC5iOtyAqkBsXZlm4amHlH+nO3J
         u1IbN9dkGKS6+nKLHC9TWV9vMDzwKUWjkGUgXs040tvqqeQoRyHMaoVIzdBowyb++HUr
         gIoW+f/AIAFE+4WvF19/hJC2dLPGPdrnV7YFlXcnn4sNsm0ECey/zTIIeb+g/P5MgQkL
         sf2HizLK1cf3hICN3hmZKNFpGEkSrNToH7pRxVWlA1FQRO/FTc+r3/Ng7oc/5v/R8T0j
         ljAVRsF8T1vAEP+gBew18ZUhZjPym62KkagBVTnkq9Mac8ra1CXeHU8+NmoiVHmonp/u
         nO/A==
X-Gm-Message-State: ABuFfojJ2HRIVnZ8KhihH2Ig+BsF3o0ratg1RW0Aker7gmNa8NrLUJ0k
        WWDFfPHIdvOrRMd4Drdik4okfS3F
X-Google-Smtp-Source: ACcGV63G+sP+xDQQZP9r0hkOdQqTfKYSfdoMFp8bM4kmHDA44EpD+deHrnJjVLi6uq59MHEqO7E9lw==
X-Received: by 2002:adf:c594:: with SMTP id m20-v6mr14459244wrg.30.1538948414011;
        Sun, 07 Oct 2018 14:40:14 -0700 (PDT)
Received: from localhost.localdomain (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id i7-v6sm7758097wmd.41.2018.10.07.14.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 14:40:13 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/11] staging:rtl8192u: Add spaces around + operator - Style
Date:   Sun,  7 Oct 2018 22:40:19 +0100
Message-Id: <20181007214025.25469-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007214025.25469-1-johnfwhitmore@gmail.com>
References: <20181007214025.25469-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '+' operator to clear the checkpatch issue.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index c52eac0bf6f6..0fe65dd8c407 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -109,7 +109,7 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
 	}
 
 	ieee = netdev_priv(dev);
-	memset(ieee, 0, sizeof(struct ieee80211_device)+sizeof_priv);
+	memset(ieee, 0, sizeof(struct ieee80211_device) + sizeof_priv);
 	ieee->dev = dev;
 
 	err = ieee80211_networks_allocate(ieee);
-- 
2.19.0

