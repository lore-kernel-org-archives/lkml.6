Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3FAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BB621710
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc+WHNRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BB621710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeHXM6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:58:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38489 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeHXM6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:58:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id k8-v6so4047472pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=SsMWTG4Hi67q6Ivcj/9tQpFZwE441EAjYPA0l7K9ZtM=;
        b=Sc+WHNRPtLCRT7MmN+GEC2lKDQVYaUjtO24YVYCujxFmrKNWEDoIIbUoRPNfg/3AzF
         o2ya/A48F1ck6xmdK+xrImFXs5x0vPjSSnKXde4RcY5Y14i6cCmjoEAiyU8HelQ7swCz
         1GPjCXevJhSEfWhqfPypfdX5oVZLyma3O6+h/h4R81btdn0jeZIIs9QPlEBR71HPhlou
         sw7pBQFj8CTDqxogQXzyiTepkUH8n+N90mkt9dkfNBOmteSv/Lw0q5zaBRkFJ6AL7VBP
         tCE6gcZ5ZE5NDdS1hNfJTQNuzaSarnHBFYPXXHf+P/sVT2Y5XD2azaZqYarw9w1oeFH6
         iqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=SsMWTG4Hi67q6Ivcj/9tQpFZwE441EAjYPA0l7K9ZtM=;
        b=NN/BrUIQvkTf3wlz9uy/WwVTPsD5DQsP9B891AVFW1UqF+fLoi10Gwi6sRyDWnk8n1
         IhPhluEpAuEIx0cLkuW+OgM0r/u3v5hCIWT1EqxUKeQr2OMB9JLh5Kxyhf5nBZb5vHKb
         ZCW1M/XkiKKE4gYR1jnoupYqtcGncvMz91pn/ieeHuNMB876u3Gu9nTDBPavm9bfmPjF
         5E5a0bMoqSDT0h9zYb+ibQiValKWSQTFzxZkWSpBirc1gBtNBc5iEzADGdQY4muXlIx3
         ZiDnlYZQqWhP2fGH+84n65J1rD4zXfGwv1WOiCqaeHNfiq2LqNG7swmmbLFScW6oCRjA
         FuOg==
X-Gm-Message-State: APzg51AfvktA/oHiWqtFS9e74Jrt7jKlswTOQAwm+/xhkmCyhElwPEX0
        FZDf9ReRt1pU9T8htvkC6A==
X-Google-Smtp-Source: ANB0VdYFdJUjiWzXQ+MgCEf+h/KiMtIr8hvEjTwpACEjrUJYvHJee1bwPWC9PLHZ6pzlFPCcopfUwQ==
X-Received: by 2002:a63:d857:: with SMTP id k23-v6mr917008pgj.106.1535102664238;
        Fri, 24 Aug 2018 02:24:24 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id o21-v6sm10300114pfa.54.2018.08.24.02.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 02:24:22 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] tools/vm/page-types.c: fix "defined but not used" warning
Date:   Fri, 24 Aug 2018 18:24:11 +0900
Message-Id: <1535102651-19418-1-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_known_mountpoints[] is not used any more, so let's remove it.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 tools/vm/page-types.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git v4.18-mmotm-2018-08-17-15-48/tools/vm/page-types.c v4.18-mmotm-2018-08-17-15-48_patched/tools/vm/page-types.c
index 30cb0a0..37908a8 100644
--- v4.18-mmotm-2018-08-17-15-48/tools/vm/page-types.c
+++ v4.18-mmotm-2018-08-17-15-48_patched/tools/vm/page-types.c
@@ -159,12 +159,6 @@ static const char * const page_flag_names[] = {
 };
 
 
-static const char * const debugfs_known_mountpoints[] = {
-	"/sys/kernel/debug",
-	"/debug",
-	0,
-};
-
 /*
  * data structures
  */
-- 
2.7.0

