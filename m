Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF762C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8576C2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhDoom+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8576C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJCM0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:26:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41518 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCM0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:26:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23-v6so1016596pgc.8;
        Tue, 02 Oct 2018 22:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=5L6Z4aW4+1t2LE/MND/iINCiEdG9eaFMJEfCbvDLBaQ=;
        b=VhDoom+TY1K77b9/Qh+vlNgbAUyKBqHN74GHpYz7GAFqydYOaKD9cc7x9P2HLvJgVq
         vHPbLvZCxfNFff+tmizReKcLb+vIE/2LKf6vsRzY/a3SJl26c0+QaCvImgSslRE6kZdc
         Tgc72eC+38Sojg0tfUa27CwNHqLk9zxRG4uuR3MblN39ogHvq/s0vKSTyvMLQG47+LbV
         4mzfWukTnRP+eQq52vnoeeD85IDsBnPmVrpgsJWWC8LjyUT8DGtb7qPbTz2bOKUCPVXr
         1pdeK9VDZKq0f7eKuEHQWgoJEM9iNmZSNqYan2t6PdpV5MJw1h3ax+jhcLk+dI41LWWM
         Kc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=5L6Z4aW4+1t2LE/MND/iINCiEdG9eaFMJEfCbvDLBaQ=;
        b=B6X3LYftFRCd/wsNosyEWpVClcxd3WM46I1c0ueh9vbq260otCXplXYxCTUyaE9m7y
         H464a/Z5CCU1dYn3o2UJUCre1ek/NasTYUynDsLMqnFnwoNF8+ryr8VHVdMp2kieNghP
         3i0M47jP0EiHPDbicwmG1VeyfGYNRQEYAnj8xLnzweUN3XHyoAZGbIa1i6buP9jvGlDe
         YnJaPaC7jId34ZjlDg7nBjXhK5Sm2kK7uTJbY9I1nMFu7tJbQufHRvvdkYHiIoTlUclg
         ALrH2QFTU6htOkW8kU87SYe15fp2j1hXTeEi8DHceUWkuu7W/m7ToYr2DBUBMjJwU32x
         xEwQ==
X-Gm-Message-State: ABuFfogpBydKwkrz4NU7yrlv8DrOgfJlndU2R3CwEG/jmlLxtdraGbyA
        t22chc1FoSFky6Cx4qiPB+8=
X-Google-Smtp-Source: ACcGV60WvxLiMsH35V+1rzrINgt5FwS72CIvI4rivm2nYxtxFcPmuEu2cpUg3gQ2PO8XYuwUo4vCOA==
X-Received: by 2002:aa7:8598:: with SMTP id w24-v6mr3587383pfn.77.1538545192026;
        Tue, 02 Oct 2018 22:39:52 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id w23-v6sm363481pgi.18.2018.10.02.22.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:39:51 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id BAF131643D0; Tue,  2 Oct 2018 22:39:50 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH 04/16] i40e: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:38:50 -0700
Message-Id: <20181003053902.6910-5-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003053902.6910-1-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
Reply-To: Lance Roy <ldr709@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep_assert_held() is better suited to checking locking requirements,
since it won't get confused when someone else holds the lock. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: intel-wired-lan@lists.osuosl.org
Cc: <netdev@vger.kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ac685ad4d877..8ce3471723d3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1489,8 +1489,7 @@ int i40e_del_mac_filter(struct i40e_vsi *vsi, const u8 *macaddr)
 	bool found = false;
 	int bkt;
 
-	WARN(!spin_is_locked(&vsi->mac_filter_hash_lock),
-	     "Missing mac_filter_hash_lock\n");
+	lockdep_assert_held(&vsi->mac_filter_hash_lock);
 	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
 		if (ether_addr_equal(macaddr, f->macaddr)) {
 			__i40e_del_filter(vsi, f);
-- 
2.19.0

