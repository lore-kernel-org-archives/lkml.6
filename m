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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B337FC64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692BA205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUDXfxVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692BA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeJCM0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:26:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34081 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCM0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:26:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id g12-v6so1037698pgs.1;
        Tue, 02 Oct 2018 22:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=rSXE1F6VacTevCbA7egalmTDNA0MErWNqJnY+ifDMwQ=;
        b=jUDXfxVdqUFnZtdJAEhM4hzwXAEGFrcxsY6v+9x2o4ijs85qMDop7/69XgOYDFdpVn
         eKfshoQT4EG4LZQyx443xvkcu61gba0PrvfiN7y13E7BMyDo3aBBsjNpF/BqDwuYqamG
         Q2C/w4/wKArA5VhGoDxOp5V3N3MpepFyEWbzrcPMjGdLKtDNxG/e3H9T9a3Qa8WY/XfQ
         6urXryjZ4fUXgNPvmFtDhmvkEms6rKoazZZQKwt0TljJfUOocSoCFDGxcoiQd2ZekjtV
         MhR+XXj8j0s0TgoREKHJwZNWmnKLfj1gZRuQ6BVQLqfQsjL3rkjZhsPVB9UaglRwZ+k8
         xq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=rSXE1F6VacTevCbA7egalmTDNA0MErWNqJnY+ifDMwQ=;
        b=YgKn67XePOuNDxVvnm4MzeDu+5HD/MzDnj+oBFG9Q6LPb6ZsbjXWxtsntEBfOh9wt3
         V/lL/s+/BOl5iCrLN9ArouFRElASMd88mhX4MWroKFo1ItlWdBB+VH3w+LxCubdItPZp
         2fmICJhAH+BN9kVC8Tt7C7yL1467Czd6FkcOE196xXOBHnYrH9y6gxcaadIoUQ+Q/dum
         XpL+56wK0voUGslil36/M7H9hAJzTV3AZnhfuilgbVzTRATdgxZHHiYS5GxyWOOIGE+z
         JTV7C1Yu4uzhdAJwvPScgA0SWL5AP0qxdiejjhaWzq9Ug82zIGxMj2S8tYRHFTXGxAzz
         nK8Q==
X-Gm-Message-State: ABuFfoif+Ao4aqzfB4mw1X44AxheXwB+tzREfU3Xc9BfRP/VKsn7gMKx
        H5Gs+6gfQyOADUU/G5Q/7is=
X-Google-Smtp-Source: ACcGV63B529bQti4/dQpF5WT4ee8bJ6QnNse28ZOnylttGqDYxJ/L76jzbvbkIqohfW1mY4plx2IXw==
X-Received: by 2002:a62:8145:: with SMTP id t66-v6mr19285852pfd.192.1538545194832;
        Tue, 02 Oct 2018 22:39:54 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id x69-v6sm499091pff.175.2018.10.02.22.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:39:54 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 9EEA61643D0; Tue,  2 Oct 2018 22:39:53 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH 05/16] igbvf: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:38:51 -0700
Message-Id: <20181003053902.6910-6-ldr709@gmail.com>
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
 drivers/net/ethernet/intel/igbvf/mbx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/mbx.c b/drivers/net/ethernet/intel/igbvf/mbx.c
index 163e5838f7c2..a3cd7ac48d4b 100644
--- a/drivers/net/ethernet/intel/igbvf/mbx.c
+++ b/drivers/net/ethernet/intel/igbvf/mbx.c
@@ -241,7 +241,7 @@ static s32 e1000_write_mbx_vf(struct e1000_hw *hw, u32 *msg, u16 size)
 	s32 err;
 	u16 i;
 
-	WARN_ON_ONCE(!spin_is_locked(&hw->mbx_lock));
+	lockdep_assert_held(&hw->mbx_lock);
 
 	/* lock the mailbox to prevent pf/vf race condition */
 	err = e1000_obtain_mbx_lock_vf(hw);
@@ -279,7 +279,7 @@ static s32 e1000_read_mbx_vf(struct e1000_hw *hw, u32 *msg, u16 size)
 	s32 err;
 	u16 i;
 
-	WARN_ON_ONCE(!spin_is_locked(&hw->mbx_lock));
+	lockdep_assert_held(&hw->mbx_lock);
 
 	/* lock the mailbox to prevent pf/vf race condition */
 	err = e1000_obtain_mbx_lock_vf(hw);
-- 
2.19.0

