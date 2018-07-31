Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DB3C46463
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE7420894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HI6bdui2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE7420894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbeGaWHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35309 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeGaWHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6-v6so9631943pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LF727irvjBtDcKG8uGyFs+olb0pJWnCiykXoIyEWfZg=;
        b=HI6bdui2GG4ejBr3B3vfUzHExrq+d0HgokcUAEWELSkvqY+L7JihW8sM0WO1vLDVJC
         Lfsos3afwr+WzwuaMnYwcHvbpbFkA0yEXDtLagOoNFkAFI45KYapSmb35LvJdWWUWi5j
         QDKckuN6atJ2ga0YV7PgXNFfFbQwovSb2WcAIalaK3UokcF+6XZGu7UnXNNlZM9xl42H
         kJ7IQtgHmflEN6Xsxa4fDSudHyzPeauos/w80X0EeuNOMxZHxREGtoNY/kJVtOlLYCG8
         /8+xFp+qTxSwQLhMQszmLMT+XoCz7+5Fe0eAdASEStaW5danWE5fODvwtXvmv9Yfnqnu
         mR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LF727irvjBtDcKG8uGyFs+olb0pJWnCiykXoIyEWfZg=;
        b=IXlG+zEbEH7K15ddvnNbt5/4HEXN3fwk4nBxH3Gkg7p7DGqIjJSY6Q5CSrSmxqyRrY
         4uj0uz+V80ne54I8CdVwy2oMPdWlZdDZMuap32xepZZ+WTI4xiTBM++prAL98dMAqTZp
         ZzkkO4acDVGAnrCu8LpE5nCENUnAnGbdO8l2KqsD3gS16CjNWo2hbrGQkciVVsDuDzlK
         OymSop889UCLL77DaIsmZbGQfW5OsHyHk32eK35Cb3neBcOnz1Rj8q8STjI5RKxSnCsp
         nQDnk7IiVfMASZ0wpLo56oL5jXs3kdaystXdR5cwvZcyYLM5P5Iuxm1XPnrcpTlDMb9M
         LLIQ==
X-Gm-Message-State: AOUpUlECMYZpnM5k54DNufnhSjuXBn6YZHcyBPlCmVSzq0CawrMx/ys+
        4jRTVd3tUISrYDYQhKr1cQQ=
X-Google-Smtp-Source: AAOMgpd+lA8w/BzZBWOAxmdIFhUR2pkppfcw5PKId3j5OHPkLz5dF/a/SP0pgdoMnJ5l7zoqaxPIQA==
X-Received: by 2002:a62:e511:: with SMTP id n17-v6mr10670528pff.210.1533068718314;
        Tue, 31 Jul 2018 13:25:18 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:17 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 07/15] staging: gasket: ioctl: fix function param line continuation style
Date:   Tue, 31 Jul 2018 13:24:40 -0700
Message-Id: <20180731202448.229487-8-toddpoynor@gmail.com>
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

Fix multi-line alignment formatting to look like:
      int ret = long_function_name(device, VARIABLE1, VARIABLE2,
                                   VARIABLE3, VARIABLE4);

Many of these TODO items were previously cleaned up during the conversion
to standard logging functions.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 60 +++++++++++++--------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 134d45a281ac..d3397cc74e69 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -79,12 +79,12 @@ static int gasket_read_simple_page_table_size(
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	ibuf.size = gasket_page_table_num_simple_entries(
-		gasket_dev->page_table[ibuf.page_table_index]);
+	ibuf.size =
+		gasket_page_table_num_simple_entries(gasket_dev->page_table[ibuf.page_table_index]);
 
-	trace_gasket_ioctl_page_table_data(
-		ibuf.page_table_index, ibuf.size, ibuf.host_address,
-		ibuf.device_address);
+	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
+					   ibuf.host_address,
+					   ibuf.device_address);
 
 	if (copy_to_user(argp, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
@@ -138,21 +138,21 @@ static int gasket_map_buffers(struct gasket_dev *gasket_dev,
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
-	trace_gasket_ioctl_page_table_data(
-		ibuf.page_table_index, ibuf.size, ibuf.host_address,
-		ibuf.device_address);
+	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
+					   ibuf.host_address,
+					   ibuf.device_address);
 
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	if (gasket_page_table_are_addrs_bad(
-		    gasket_dev->page_table[ibuf.page_table_index],
-		    ibuf.host_address, ibuf.device_address, ibuf.size))
+	if (gasket_page_table_are_addrs_bad(gasket_dev->page_table[ibuf.page_table_index],
+					    ibuf.host_address,
+					    ibuf.device_address, ibuf.size))
 		return -EINVAL;
 
-	return gasket_page_table_map(
-		gasket_dev->page_table[ibuf.page_table_index],
-		ibuf.host_address, ibuf.device_address, ibuf.size / PAGE_SIZE);
+	return gasket_page_table_map(gasket_dev->page_table[ibuf.page_table_index],
+				     ibuf.host_address, ibuf.device_address,
+				     ibuf.size / PAGE_SIZE);
 }
 
 /* Unmap a userspace buffer from a device virtual address. */
@@ -164,16 +164,15 @@ static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
-	trace_gasket_ioctl_page_table_data(
-		ibuf.page_table_index, ibuf.size, ibuf.host_address,
-		ibuf.device_address);
+	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
+					   ibuf.host_address,
+					   ibuf.device_address);
 
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	if (gasket_page_table_is_dev_addr_bad(
-		    gasket_dev->page_table[ibuf.page_table_index],
-		    ibuf.device_address, ibuf.size))
+	if (gasket_page_table_is_dev_addr_bad(gasket_dev->page_table[ibuf.page_table_index],
+					      ibuf.device_address, ibuf.size))
 		return -EINVAL;
 
 	gasket_page_table_unmap(gasket_dev->page_table[ibuf.page_table_index],
@@ -197,8 +196,8 @@ static int gasket_config_coherent_allocator(
 			   sizeof(struct gasket_coherent_alloc_config_ioctl)))
 		return -EFAULT;
 
-	trace_gasket_ioctl_config_coherent_allocator(
-		ibuf.enable, ibuf.size, ibuf.dma_address);
+	trace_gasket_ioctl_config_coherent_allocator(ibuf.enable, ibuf.size,
+						     ibuf.dma_address);
 
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
@@ -207,13 +206,13 @@ static int gasket_config_coherent_allocator(
 		return -ENOMEM;
 
 	if (ibuf.enable == 0) {
-		ret = gasket_free_coherent_memory(
-			gasket_dev, ibuf.size, ibuf.dma_address,
-			ibuf.page_table_index);
+		ret = gasket_free_coherent_memory(gasket_dev, ibuf.size,
+						  ibuf.dma_address,
+						  ibuf.page_table_index);
 	} else {
-		ret = gasket_alloc_coherent_memory(
-			gasket_dev, ibuf.size, &ibuf.dma_address,
-			ibuf.page_table_index);
+		ret = gasket_alloc_coherent_memory(gasket_dev, ibuf.size,
+						   &ibuf.dma_address,
+						   ibuf.page_table_index);
 	}
 	if (ret)
 		return ret;
@@ -313,8 +312,9 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
 		break;
 	case GASKET_IOCTL_CLEAR_EVENTFD:
 		trace_gasket_ioctl_integer_data(arg);
-		retval = gasket_interrupt_clear_eventfd(
-			gasket_dev->interrupt_data, (int)arg);
+		retval =
+			gasket_interrupt_clear_eventfd(gasket_dev->interrupt_data,
+						       (int)arg);
 		break;
 	case GASKET_IOCTL_PARTITION_PAGE_TABLE:
 		trace_gasket_ioctl_integer_data(arg);
-- 
2.18.0.345.g5c9ce644c3-goog

