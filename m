Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A7CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EEF20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obFskZWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EEF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbeG0JZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:25:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40065 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0JZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:25:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id e13-v6so1474854pff.7;
        Fri, 27 Jul 2018 01:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xO8+QcS/sypcgqi50Iq0IApJl+12RbGbr6B6n84+oh0=;
        b=obFskZWgZgCKI3cJfcA9T3XrCEHvk43AGXpzEifmIAo9m+LW/nh2EYtegacwAFn8d1
         ptGd2WthkQ0HHiDEADfW26grTyVTRyrRIpttEbWpj2VqdCIXMc8geiyEVJALKwqsUMOh
         pwObEXu2+3NBamSXuj27EM3Uihq8mfc3qoaFfSz5Nx+AugEm4QneCjfGwVRcAusPWO28
         xxF1qtibxWW6wEFapG7KDqX4egfprvfOx1sNZDOS5xAqit+HfkaY9KLGVq6ADOVsU/3S
         zr62ZJfFUJUuX3OBbdajbc7JaMbrlSdRJyYobSHGNEzrldt6dOzg4PdqWzimt/Ps7ST8
         ptPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xO8+QcS/sypcgqi50Iq0IApJl+12RbGbr6B6n84+oh0=;
        b=MSwbGlrymehZsjly98mNZgci+PDnnBMdZT02caJzFpN/tiFSfoH1CrkyY81YLUy2Tb
         dNn0cajNKLA2AjEBIuSX+GzUmCdci9N3DIuGDeahygFexG1Gh/fIapf4EgQNpInEo2P2
         R+UsGs7EZOTPK0Ilm5G3jJkSyj3nBMLbcR90VdE8AhNnVjC7sXmvyH5SzlNkpNQdOY18
         p2grF2NV4+zxpKNOJ7oEreUz9gBhys1TvAx0/RUzY4bOicceVVWh28+rgYkqiYCzTkd+
         I1BrQDa0rg28qv5/BVeNFkxUcj2iNO8ayvcNiYibVF0kcWNS7sqKh3ObsMM3f6chrfet
         FlCQ==
X-Gm-Message-State: AOUpUlEBuMKsi1yIz0ZXTraGS/exOc+C1JY5f03so0dPV8bY/Khm8qXv
        QXN/rKVFTL8IEPSL5sKZr5drbP4t
X-Google-Smtp-Source: AAOMgpc1njOMZg0VfBtiDGC4BHqFU87rrLqr6EIVtUtxbIL0hSq1NLGWhOvIb5P+MCJcfCFqKWQg3w==
X-Received: by 2002:a62:229a:: with SMTP id p26-v6mr5590454pfj.53.1532678701099;
        Fri, 27 Jul 2018 01:05:01 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id x24-v6sm5254978pfh.67.2018.07.27.01.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:05:00 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jeffrey.t.kirsher@intel.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] net: intel: igb: Replace GFP_ATOMIC with GFP_KERNEL in igb_sw_init()
Date:   Fri, 27 Jul 2018 16:04:53 +0800
Message-Id: <20180727080453.3198-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

igb_sw_init() is never called in atomic context.
It calls kzalloc() and kcalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index cce7ada89255..5332a1b608e6 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3534,7 +3534,7 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	adapter->flags |= IGB_FLAG_HAS_MSIX;
 
 	adapter->mac_table = kzalloc(sizeof(struct igb_mac_addr) *
-				     hw->mac.rar_entry_count, GFP_ATOMIC);
+				     hw->mac.rar_entry_count, GFP_KERNEL);
 	if (!adapter->mac_table)
 		return -ENOMEM;
 
@@ -3544,7 +3544,7 @@ static int igb_sw_init(struct igb_adapter *adapter)
 
 	/* Setup and initialize a copy of the hw vlan table array */
 	adapter->shadow_vfta = kcalloc(E1000_VLAN_FILTER_TBL_SIZE, sizeof(u32),
-				       GFP_ATOMIC);
+				       GFP_KERNEL);
 	if (!adapter->shadow_vfta)
 		return -ENOMEM;
 
-- 
2.17.0

