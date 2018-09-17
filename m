Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B055ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF84C2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDOTUE8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF84C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeIQSHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:07:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38105 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbeIQSHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:07:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id t84-v6so7616440pgb.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KehRlJ+xTY2rI5/JN7I18n+oSI8UZ7/CsuSjjBZO9e8=;
        b=kDOTUE8Fmo4sTlhX36wOdcgH1eyEILcgLI2n1rMYu6Sh8KxPnvDXro2aipuWm5x2qF
         /PkDuyOH8aY6/3JiBXbhRW2pLpt67eFpHEmEcb1NRdGlXXYAgA/ZG8Q3c7+Svo9Ol2XA
         bl+0WBWP71HjLrV9e6q69ZbEUjb3EUSTSky2uy4AC+q9nQ/6SQLPG7bU9xUs1d2XHoPA
         39mDJe+I/MaodW1OD9V/XspdBNtspLNItEfegLgJbdaTKq7PVE1tcmvLwRKZ8/zPUJ+1
         u7UqzZAXkcwRjycSF7HE6Ywwc9ckaNOTfdRonkmHE+NeOr+ImBTH6QA6Y2/nNoyWojvm
         d8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KehRlJ+xTY2rI5/JN7I18n+oSI8UZ7/CsuSjjBZO9e8=;
        b=HTw/RpNCCdVpe3iqy81zQEB54jb8kqVoJG5NT7xlg5H3YZBwDgKUPN0to0AirgE8L0
         q/URsAuDjm7qAYIJ2srbFnjC8wOqn7e5mnaUA0iTH2rOdXr5fid/fU1sKFIwmD2l0iYV
         ABOY+eTqmt9P1Q2M+mfgM/7sjht6wk1DiSSkhVoLL54TvEZkiMW2Yk8cGZhmw6SFsN3O
         vYhkxpOqO4+ePdc4wxQPuqnZmnRDgCuO6lSFlKco/g6CYPQW1HsIYwjYHdTNFQECTTla
         Yf7yoR4mLVo3ng62fsJZ8SY4ickL644QdNGQ85vWCbSBsaHl1Qy+GKVCC4fZIg37KW+q
         AQRw==
X-Gm-Message-State: APzg51Cy7zoY5EjZ3R5SgUsN226fGnzuC6u7Fb0Yv9U/bGhnJYe+stxy
        B+UiX/wkiGH4O80mmRDjP6c=
X-Google-Smtp-Source: ANB0VdYfpQz8NBLvHO8/BVtk0pJPv48O0rc4zhqKbsN7F5dHoUWe+klScfNF9lrp5IVBQ9R76iaVyw==
X-Received: by 2002:a65:41c6:: with SMTP id b6-v6mr23542678pgq.174.1537187993863;
        Mon, 17 Sep 2018 05:39:53 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id v22-v6sm26960020pfi.60.2018.09.17.05.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 05:39:52 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 09/10] staging: gasket: page_table: use total_entries for max ext lvl0 page idx
Date:   Mon, 17 Sep 2018 05:39:04 -0700
Message-Id: <20180917123905.213639-10-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917123905.213639-1-toddpoynor@gmail.com>
References: <20180917123905.213639-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

The maximum number of entries in the page table is configurable at
initialization time and should be used in gasket_extended_lvl0_page_idx.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 779ad2f23ef9b..8364b49f147c2 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -562,7 +562,7 @@ static ulong gasket_extended_lvl0_page_idx(struct gasket_page_table *pg_tbl,
 					   ulong dev_addr)
 {
 	return (dev_addr >> GASKET_EXTENDED_LVL0_SHIFT) &
-	       ((1 << GASKET_EXTENDED_LVL0_WIDTH) - 1);
+		(pg_tbl->config.total_entries - 1);
 }
 
 /*
-- 
2.19.0.397.gdd90340f6a-goog

