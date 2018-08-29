Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F3FC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8461D2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="sYIkLWnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8461D2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeH2QUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:20:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42000 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbeH2QUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:20:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id l5so1132026edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lfyMZlbjbi+SYjhMjZnTgdIpBeV8AHl05jO2l5sWcXY=;
        b=sYIkLWnCVWGpFIbCk/wCWULMG4wXn798HYm6CEGy/nmnWGgONpOOwLBVaDEkiywptB
         OPCxvyQAjEm8oIRIWYHDj09K2BODTqTBw3lXrwdQ1SwTPTVx9NWdaW6kn8OsooKi+CbN
         qiuGVly//MVu3sieDFpQN5XcqCAkTMuO9UxCxc5lmyMX4KJFPad8BcRcty6RUEipWw/4
         Whtl8evBPM8fvW0+L/xdAkmWwuN0kO+K7qChzcdzlB1ebjaH57I/aWTZ0kYvUhtKHCgq
         aVUxz+dPid4bckQtSYO86OREvy3DVMOsLOxWlf3N894Mps/wutI1jmtV4G+aZe3MQ4Qu
         cq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lfyMZlbjbi+SYjhMjZnTgdIpBeV8AHl05jO2l5sWcXY=;
        b=VgDZKjPJioZPQUBwGhNzqmvGCT+1ZHmU0SABx5nro+NoZhOUPkZqpcGd65jAxPHzCX
         nBf+OEt9gUmorAwz4ftmqNMD25cjxONKiTDB/N4vkFgSlHD4wDKDoUqljYCba1ONw7wP
         8K+JAzEbrsz+5zeRMfe28kYpQ/dZb1ntouW4NBoCBmUJFyv+IZk+PdNHzBS2pLDFFdqi
         k6VmhGUx8OqM9pxua5hMT+06FeTic2a61aD0NnafujLQPUX/Jgl9KR0Xc4e+/tLZA0Rh
         WB5Sa3btVY9PMKZjPaarq5jSxEjUf8Wmaevsf7/omd8xb/g/lYuz12sV1ZHfUOkofCOA
         hieQ==
X-Gm-Message-State: APzg51BEiNoy/21J2IVarDC173dybkz07vL7om/Hzr2svtT/iDrg2d+1
        ZAbsbDlERyPBW2/55xAkEuKGgA==
X-Google-Smtp-Source: ANB0VdYAQ+RjHI27Vgvn+uBh+ixA2+fz4NDdj+pxYu+jFIJP1CAvy4FAM85CyiANDIdz9SL5yVxUkw==
X-Received: by 2002:a50:c05a:: with SMTP id u26-v6mr7258923edd.107.1535545439305;
        Wed, 29 Aug 2018 05:23:59 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id f26-v6sm1752068edb.28.2018.08.29.05.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 05:23:58 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 7/7] lightnvm: pblk: fix write amplificiation calculation
Date:   Wed, 29 Aug 2018 14:23:34 +0200
Message-Id: <1535545414-550-8-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

When the user data counter exceeds 32 bits, the write amplification
calculation does not provide the right value. Fix this by using
div64_u64 in stead of div64.

Fixes: 76758390f83e ("lightnvm: pblk: export write amplification counters to sysfs")

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 9fc3dfa168b4..e56eeeeb914e 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -337,7 +337,6 @@ static ssize_t pblk_get_write_amp(u64 user, u64 gc, u64 pad,
 {
 	int sz;
 
-
 	sz = snprintf(page, PAGE_SIZE,
 			"user:%lld gc:%lld pad:%lld WA:",
 			user, gc, pad);
@@ -349,7 +348,7 @@ static ssize_t pblk_get_write_amp(u64 user, u64 gc, u64 pad,
 		u32 wa_frac;
 
 		wa_int = (user + gc + pad) * 100000;
-		wa_int = div_u64(wa_int, user);
+		wa_int = div64_u64(wa_int, user);
 		wa_int = div_u64_rem(wa_int, 100000, &wa_frac);
 
 		sz += snprintf(page + sz, PAGE_SIZE - sz, "%llu.%05u\n",
-- 
2.7.4

