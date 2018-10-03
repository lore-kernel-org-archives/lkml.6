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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FCCC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299402098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2UnFVCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299402098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeJCM0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:26:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38150 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeJCM0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:26:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id r77-v6so1026692pgr.5;
        Tue, 02 Oct 2018 22:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=DByBoSbdwmE2yss2OueEXXtxDWCriUE65qgmrge67jE=;
        b=p2UnFVCzbQT2TNU+gMIaZYkWA1b+75YEfWd5x6xV56vwS9fh9ijPJxMFvHjksTcXUX
         v9M0AYGcKsGGZASFKasVcmxYG7cajrjYkJEU/dbXrFAfCnR0PlII4WZusTIu8ZbibmUq
         bul/rI3vKZOaxk2BwHRDBiOrqtHOEKJOMyXy+p/jzDzl78hz9hl6QjAgsohvI6Qt+Okd
         76IJYIPRezW0jhBZGP64iG7bkCCpQbdw7ymO52UAaaF+vyDRmbOL4uOW65huT75SCz8J
         HAe8+dzsq58sPyZRmX3biERy2vWlTi/jUQhbNFjhMuvKpltCtiho0l2d8ku+34zqxWyv
         wJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=DByBoSbdwmE2yss2OueEXXtxDWCriUE65qgmrge67jE=;
        b=Zhxg7lbA1JhCPGy/3z3lyElMwss/E3Cjt8EowlLHqi6uyiSE+SuTjkz7WF+cP+aFRV
         6lv2f74kVBq05lg+dO2dZ55FmABXSpemunYFVum62Z7mUwJG+Sgcwi4Hc2vAKZOokL/R
         PcQyKdAEi7W9f3fSaJIXUcJ4KH6cm6+VfsPb60UcFAVbj/Y7+RWxePZ59iaGOCNzURqH
         2u9rQY9yvdtC6Y2iehbaqERoUmQHxNff1K6SxKqBcXdVOYG95kcmV+BJTeoIXI2DwO5T
         BplrVFqVk7cquDNt6DTVtCFvuPNu+gtraqGmu3UD5GTiEybYHGshIzVtpuxqbEWnvjbd
         znRw==
X-Gm-Message-State: ABuFfoiegRVZkYHoOGxKD4p9CfRlOn4cQ1eT5fwtQ4BdDGcKWDgBgN71
        TNbH7t8Nve+ooLConnFZrfY=
X-Google-Smtp-Source: ACcGV62qhWd8CWd2rNe2KOrFqieNvJK/UugJU2tRg5go6hCX1BAuuIw81wMRzwXQakLxFTpaDsNHGA==
X-Received: by 2002:a63:cc04:: with SMTP id x4-v6mr16962151pgf.33.1538545197507;
        Tue, 02 Oct 2018 22:39:57 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id k83-v6sm583290pfj.63.2018.10.02.22.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:39:57 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 42B8F1643D0; Tue,  2 Oct 2018 22:39:56 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 06/16] sfc: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:38:52 -0700
Message-Id: <20181003053902.6910-7-ldr709@gmail.com>
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
Cc: Solarflare linux maintainers <linux-net-drivers@solarflare.com>
Cc: Edward Cree <ecree@solarflare.com>
Cc: Bert Kenward <bkenward@solarflare.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: <netdev@vger.kernel.org>
---
 drivers/net/ethernet/sfc/efx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 330233286e78..f40c3d5ca413 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -3193,7 +3193,7 @@ struct hlist_head *efx_rps_hash_bucket(struct efx_nic *efx,
 {
 	u32 hash = efx_filter_spec_hash(spec);
 
-	WARN_ON(!spin_is_locked(&efx->rps_hash_lock));
+	lockdep_assert_held(&efx->rps_hash_lock);
 	if (!efx->rps_hash_table)
 		return NULL;
 	return &efx->rps_hash_table[hash % EFX_ARFS_HASH_TABLE_SIZE];
-- 
2.19.0

