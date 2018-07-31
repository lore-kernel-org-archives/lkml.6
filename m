Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7FFC46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FE5208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqNIVN5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FE5208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbeGaWHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41940 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeGaWHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id z8-v6so9626109pgu.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HGopYY+uDQEH5n6zMPWc1E+bSMfWeHkLcC2Em93puC4=;
        b=pqNIVN5Vm6TLrLZ7f2VSIJ1mQgTf5nxEfZ+L+9eU3NlgeGhM+2ZKnwJ235Kqmes4Se
         GUH4t2Nahq0zl7sx7ByRBcttneywdpQRV48TNbXztSl88XApf4ZL4Yo7v8v96gOhAZsm
         2l/JJNOHIWgupwQ3b+fYuyH+fSKiAbeDhpAA1hJE78Rmk7i1GSdFjK8VH06+YoLOV5+J
         pj+YQyWJ6QXjNFOnM8YevHtNlD3NSfkET59kzrwAyeV+bXGzLxDeRAI8lhWxXSmduURw
         hEKYnSpy/LPXYjyNDOC8MPsqeyFVJHFD/08MZ1Wj+7CcbK0ETatPH1OX4Pkw1+RqIBmj
         UP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HGopYY+uDQEH5n6zMPWc1E+bSMfWeHkLcC2Em93puC4=;
        b=Ch0R/6+b3aZOdwio+LHlnsQ15imhWr3laLUmLjRA9YeWxKKj6x5AOCPpgq7PmYEiU3
         RqKzB75BfWJLid1jSUY1FLz8mxke6sdy3J+XDwV140ZRA75+tVpQqGN9ih5J3VF2+bUX
         y/i/oNOSGAO9aIoyELCSwlxgDqBXzSM1lR99RiNyR+efUX357tx7wL/bI7o8scaO7Cin
         TlA8qgwU8e8nM6SctyT96CxzIG0lfcyM8rpciEthxhZjscxsmDM9RWpOU4aBVkHmNhiw
         MC7daY+RxFzZtWxSbcs5xgkCDNzQucpVPYRv8LMdZvCJ90PjppcaZJlgcvZXucvZ9vXy
         YBZw==
X-Gm-Message-State: AOUpUlGkXVIA8wy1XP+vsqhwHBDXIunYYdj1e4zGgD2RslFapSEMBqJR
        CTKqmErDdOUGn/xClumci3FJTCTmjCs=
X-Google-Smtp-Source: AAOMgpd+ZPFAzaPAJIRP/xLUPkIDQHUrdLdjvjpPG8oJUDa1mEb6VXSP12qioZ+8pUtKq0T5X57chg==
X-Received: by 2002:a63:9e0a:: with SMTP id s10-v6mr21681413pgd.326.1533068726818;
        Tue, 31 Jul 2018 13:25:26 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:26 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 15/15] staging: gasket: page table: fix header file include guard symbol
Date:   Tue, 31 Jul 2018 13:24:48 -0700
Message-Id: <20180731202448.229487-16-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731202448.229487-1-toddpoynor@gmail.com>
References: <20180731202448.229487-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The include guard symbol for gasket_page_table.h is out-of-date.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.h b/drivers/staging/gasket/gasket_page_table.h
index 00c06f050eb9..7b01b73ea3e7 100644
--- a/drivers/staging/gasket/gasket_page_table.h
+++ b/drivers/staging/gasket/gasket_page_table.h
@@ -9,8 +9,8 @@
  * Copyright (C) 2018 Google, Inc.
  */
 
-#ifndef __GASKET_ADDR_TRNSL_H__
-#define __GASKET_ADDR_TRNSL_H__
+#ifndef __GASKET_PAGE_TABLE_H__
+#define __GASKET_PAGE_TABLE_H__
 
 #include <linux/pci.h>
 #include <linux/types.h>
@@ -246,4 +246,4 @@ void gasket_free_coherent_memory_all(struct gasket_dev *gasket_dev,
 int gasket_set_user_virt(struct gasket_dev *gasket_dev, uint64_t size,
 			 dma_addr_t dma_address, ulong vma);
 
-#endif
+#endif  /* __GASKET_PAGE_TABLE_H__ */
-- 
2.18.0.345.g5c9ce644c3-goog

