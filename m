Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FB1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9056620866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyfqPVUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9056620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbeLNGcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:32:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46194 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNGcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:32:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so2212145pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 22:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pzNwl8uBgNNyis/bc9NTuPrBgTojXNrJ+rJ9m3YGFp4=;
        b=uyfqPVULO04xu1npW4Rrcu+6JIArwOO9PRfkH1g0Hk8dBIBo0OB2Fwmi0vGxgQph/+
         Jo+yjNd1b6xFQdM0HZa7s4gSGap74LyW0ctyi63kxd97/nHMvEJgj5xODIXZTSxYWIBm
         L88ZNvRzCdZWXjH7CO6P4QQ5RFIhNLaYvWYmqHFe70TrBOlOrTqPKxAgHI/+eL1WRXdM
         WEeNMnbPfJarb6wsBzis4iqHsQnQ++Bdu4qfQPA3WVbuoJm3aqQwf/Ef1mIkUrZTgIbS
         5V/y10Bzz8lStOOdZuWCEVNip1jPzedx9qpsJas/+/2K4ZEAFKalmbzeVY73fxhGkx1D
         V/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pzNwl8uBgNNyis/bc9NTuPrBgTojXNrJ+rJ9m3YGFp4=;
        b=Jc3YA4zC0nGlYpO6hXF9u/dBQesYwoMXgo4SzO0eUikcFtfj3o7h7Y4e6ykrwGxE+j
         z2mAGNYohv5PxjBZdog1uP0tWmxWhFKNaCpYdRKYZ333VTpJ9//VyPuqxJzHBkluFqX7
         uHcVh4xx3nWsgQ/1B7Lf2gTcBDd6KjoaHSZwJv0s4LZtpp31dBGzWcrQyAY6vHJ7ieLW
         3CH0XZFrG2VQ2DYpxrXPKCWxity5MaJJAs6hgk96Hv944z88hhEbpfblLCgLFoajgAOE
         WCvtx1q4WWlbEh3x+vPT+VOJMDTpUsG80YEvyFxLUNkHiyG4Ag4couc224YAuaBwstr/
         wszw==
X-Gm-Message-State: AA+aEWYf8M/yOOd9lnDrbra4b/ZjrxOrDeF/L89HEp8FinE7KmTwg6PP
        FcCzkb5njHkTJcTfqdal4Om9iEAE
X-Google-Smtp-Source: AFSGD/XNoa4Evi0M3bWtY8jmXD39kPiveIOIjUXiG07Apk0AYgvjhF5XomQ84ATBgkO4qOl9pxFklw==
X-Received: by 2002:a62:2044:: with SMTP id g65mr1691462pfg.127.1544769143294;
        Thu, 13 Dec 2018 22:32:23 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id i184sm6675396pfc.41.2018.12.13.22.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 22:32:22 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] mm: remove unused page state adjustment macro
Date:   Fri, 14 Dec 2018 14:32:11 +0800
Message-Id: <20181214063211.2290-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These four macro are not used anymore.

Just remove them.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/vmstat.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index f25cef84b41d..2db8d60981fe 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -239,11 +239,6 @@ extern unsigned long node_page_state(struct pglist_data *pgdat,
 #define node_page_state(node, item) global_node_page_state(item)
 #endif /* CONFIG_NUMA */
 
-#define add_zone_page_state(__z, __i, __d) mod_zone_page_state(__z, __i, __d)
-#define sub_zone_page_state(__z, __i, __d) mod_zone_page_state(__z, __i, -(__d))
-#define add_node_page_state(__p, __i, __d) mod_node_page_state(__p, __i, __d)
-#define sub_node_page_state(__p, __i, __d) mod_node_page_state(__p, __i, -(__d))
-
 #ifdef CONFIG_SMP
 void __mod_zone_page_state(struct zone *, enum zone_stat_item item, long);
 void __inc_zone_page_state(struct page *, enum zone_stat_item);
-- 
2.15.1

