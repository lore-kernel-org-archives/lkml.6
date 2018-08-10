Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994EFC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BC3223E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3cdaKsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BC3223E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeHJFuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:50:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41915 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeHJFtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id y10-v6so3824055pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Uu4yq9mlG0JgfVfBKVMHEaDb+WHU5AbpHdC1hwSdUY=;
        b=e3cdaKsXD2lwFcq6kXE/1eASobb1W1ePUtX6YbDuxRK/BRr/Hujp2QFPqRwVcYaj71
         ul0WBGet+O0G84ydCfclULKqC/1gHcDKS2K4sNkLCKWiBmbxEWFex1tDcXbvsHCC4Xvw
         iUdNOTaqWLk2tpH8P+bB66CkF19bhdyUYu7o1OXHtUIuhqMlQbNboDWFaHqhL6szQIq9
         Ns3yNeZoiF+fgLmiNNFjWtMRXKJGkK2+YArgIibtHWWICJLpz9pwuw9ePc3RFihHtxbr
         H3L6WwDlKH/HmdY6B2sDROEzZ7MYMeqy6Mdy1SE5EcsH1bQIJKj2aTK1HUFqxcfdURTG
         RaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Uu4yq9mlG0JgfVfBKVMHEaDb+WHU5AbpHdC1hwSdUY=;
        b=OlyjDzzROcqM1/DCO9xfNIRkgKPhLeqzCB9aiyxrJ0/Fo1kqrLSooXaMpKBtuTMZ0y
         C7lkBnFw8iW2kv4/0vCiVhGVzS8dZPxk0bmJg0UqeW3Y34Clz5QgEuxzUcXLQIn7Sa8r
         K5C42zSZOZZ8Zzao5It7e/MX9wOcgRPYfGOCjRB91ulf3weLTN7/kzYb5gymwJLiuj+D
         xiC8x28Wrc0zEQVnDvvqzd88aYyKbzQMj9Aoz8kJENDPXhrREcco6sxxHd4uDKuaC51m
         ryStq7TUd1bBqq493osMr2pHn+VKVMr6jQiFYJfix56lp3eY8DL4r89YglGjJeTtnBu1
         w6xA==
X-Gm-Message-State: AOUpUlHelCyS+Pqa5MHbP4BRwfh6PBNnHezUtwZOD2ulrD6pPH33sOV5
        2j/dBOkuhGYRVgKTjM0TQS4=
X-Google-Smtp-Source: AA+uWPwIMph/k9fstGt0NnRy7kF+7Md0riicih2Vw+u3ZggjFbibO4EMlvlLDYBIhLDH4Ayrl/o9+g==
X-Received: by 2002:a62:2e02:: with SMTP id u2-v6mr5084743pfu.134.1533871289777;
        Thu, 09 Aug 2018 20:21:29 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:29 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 07/16] staging: gasket: page table: remove unnecessary NULL check
Date:   Thu,  9 Aug 2018 20:21:02 -0700
Message-Id: <20180810032111.197743-8-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810032111.197743-1-toddpoynor@gmail.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_alloc_coherent_memory remove unnecessary NULL check for
coherent_pages.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index d4c5f8aa7dd34..bd921dc6094de 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1328,10 +1328,8 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 				  num_pages * PAGE_SIZE, mem, handle);
 	}
 
-	if (gasket_dev->page_table[index]->coherent_pages) {
-		kfree(gasket_dev->page_table[index]->coherent_pages);
-		gasket_dev->page_table[index]->coherent_pages = NULL;
-	}
+	kfree(gasket_dev->page_table[index]->coherent_pages);
+	gasket_dev->page_table[index]->coherent_pages = NULL;
 	gasket_dev->page_table[index]->num_coherent_pages = 0;
 	return -ENOMEM;
 }
-- 
2.18.0.597.ga71716f1ad-goog

