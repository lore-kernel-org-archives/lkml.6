Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6523C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD6E21570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="gZZGILIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD6E21570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeI0K1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:27:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42495 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeI0K1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:27:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so283201pgq.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 21:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=fmn5w2Vsi1vG/lbBOq8Q139Hj9dWw6MZ7Oa4lbqZFSQ=;
        b=gZZGILIpc7vhBN/Yx3KIOptISTxGRgYccUp3Do2PlS12ynHP0/zPjmX4vuWRYpHmy+
         3LIE7E/MNbwA/rqLlMgdca2QGTIiGkWcx/slAcXt+Z7w+dn+LLhwVGSmFGuGF8a52Fav
         s3SOZk0cO5+gOc82x9cL3jpkrrvgYiBZbl9Vqh9Q0NsQr0Ec7HjbWNlxODjS8MFU2Sqa
         zkkeGl51ijsj1J1uS5vsJCArMgd/vQAjq/V4UeYDhdW8BohE/G8lCmILVolXqKbPuCdA
         6UKDfV1ebkKQlf+rO7lNt3Xg7FY6jzp7Q0KUqIk7BxDffEj2YYRvRnqrMGsNYa2Cm/Pf
         6vbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fmn5w2Vsi1vG/lbBOq8Q139Hj9dWw6MZ7Oa4lbqZFSQ=;
        b=doj1JW83gLkkn9GhbC9H+/AQE0DkIrZBtiYa1A9Jqp2hsRDdwkxlM8M+umC7P+tjzk
         AvRHIxq8dtbBXUkzeiCaYU6zWiqtuDbxM6V01bUnnKZQ6ACLzAa4YVLU2GsAlq5YESkR
         7b75AfjBdvZlPo7/M3LFg+Ecjzfdq9uNpBSeo6L1rp2iYOmV8z1ZU9xVWuKn5jN33p4M
         bPHtglnyWaBjTs4CeyobsI6DNfn7v6zwwOw558rmXHyUpYW9f5JMReC82QRU1SCcjJT9
         dioTk7mnvGq9yqupcAEXR5EC3Cv1KVqYDRFKjDprvf9IskusofgLyBZqW5OQqWlj+tog
         l+ow==
X-Gm-Message-State: ABuFfojGOa7JL+jFmVEgPtqlaL0WxMwJ3y4lCt8sa5Gmcux6xvppiPih
        ERGifCJCXHphHEevxIEQsxOK7Q==
X-Google-Smtp-Source: ACcGV60PZCMOML2orOKiC5KTa/VXr/k9u4Rr+LTagwx/c9oAjgIHcLaJ5B3gfvVQL7IBbqb3I7f+tg==
X-Received: by 2002:a17:902:29e3:: with SMTP id h90-v6mr8804617plb.215.1538021461581;
        Wed, 26 Sep 2018 21:11:01 -0700 (PDT)
Received: from endless.endlessm-sf.com (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id t26-v6sm827850pfm.138.2018.09.26.21.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 21:10:58 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kai.heng.feng@canonical.com, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH net] r8169: Enable MSI-X on RTL8106e
Date:   Thu, 27 Sep 2018 12:09:48 +0800
Message-Id: <20180927040948.11891-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, we have an issue where r8169 MSI-X interrupt is broken after
S3 suspend/resume on RTL8106e of ASUS X441UAR.

02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller [10ec:8136]
(rev 07)
	Subsystem: ASUSTeK Computer Inc. RTL810xE PCI Express Fast
Ethernet controller [1043:200f]
	Flags: bus master, fast devsel, latency 0, IRQ 16
	I/O ports at e000 [size=256]
	Memory at ef100000 (64-bit, non-prefetchable) [size=4K]
	Memory at e0000000 (64-bit, prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [70] Express Endpoint, MSI 01
	Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
	Capabilities: [d0] Vital Product Data
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [160] Device Serial Number 01-00-00-00-36-4c-e0-00
	Capabilities: [170] Latency Tolerance Reporting
	Kernel driver in use: r8169
	Kernel modules: r8169

We found the all of the values in PCI BAR=4 of the ethernet adapter
become 0xFF after system resumes.  That breaks the MSI-X interrupt.
Therefore, we can only fall back to MSI interrupt to fix the issue at
that time.

However, there is a commit which resolves the drivers getting nothing in
PCI BAR=4 after system resumes.  It is 04cb3ae895d7 "PCI: Reprogram
bridge prefetch registers on resume" by Daniel Drake.

After apply the patch, the ethernet adapter works fine before suspend
and after resume.  So, we can revert the workaround after the commit
"PCI: Reprogram bridge prefetch registers on resume" is merged into main
tree.

This patch reverts commit 7bb05b85bc2d1a1b647b91424b2ed4a18e6ecd81
"r8169: don't use MSI-X on RTL8106e".

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=201181
Fixes: 7bb05b85bc2d ("r8169: don't use MSI-X on RTL8106e")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/net/ethernet/realtek/r8169.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index bb529ff2ca81..445508c7e067 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7084,20 +7084,17 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 {
 	unsigned int flags;
 
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
+	if (tp->mac_version <= RTL_GIGA_MAC_VER_06) {
 		RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
 		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~MSIEnable);
 		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
 		flags = PCI_IRQ_LEGACY;
-		break;
-	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_40:
+	} else if (tp->mac_version == RTL_GIGA_MAC_VER_40) {
 		/* This version was reported to have issues with resume
 		 * from suspend when using MSI-X
 		 */
 		flags = PCI_IRQ_LEGACY | PCI_IRQ_MSI;
-		break;
-	default:
+	} else {
 		flags = PCI_IRQ_ALL_TYPES;
 	}
 
-- 
2.11.0

