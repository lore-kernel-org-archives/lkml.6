Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EB1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E859B20857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e0ygaEe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E859B20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeICGuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:50:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33178 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICGuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LgHDWT7it9wTesOBhRKCaM1Lh8xEceNKfEb/lnaPHYE=; b=e0ygaEe6gVkhRU4GoPH2H3CzCI
        lZkVpcBH/N8KpGuk2a56R05bI+JaFw5E+L7msRywkbRHnSbUAZJW7x3dSYSsDmVbAiq8zy3XipHbB
        KjIYIlOLNAllloK6cPlhgKzdALUoBx7ZJfv9iR25bq2WADoDurRhFovC3bjjPt4sVsvP8I+4e9+ll
        LeOx2QLNhVFN/ZCPUppWz14ualASPQXWnUqnt92hN9y9rjRWx067YCXKM6M9WEETEXD1052fgKsNC
        45VisSagiI8704B2beI2seylnC4lo2cwsPZwfd4Zzxv6mTVJgNBlIQOG4bvydc0nlTv15r2FrTH1r
        koJM8ikA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwefc-0005UD-3V; Mon, 03 Sep 2018 02:32:52 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] pci: fix pci.c kernel-doc parameter warning
Message-ID: <1fe6f0c6-7ebb-7ddd-af91-659afad2d7da@infradead.org>
Date:   Sun, 2 Sep 2018 19:32:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning:

../drivers/pci/pci.c:218: warning: Excess function parameter 'p' description in 'pci_dev_str_match_path'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-419-rc2.orig/drivers/pci/pci.c
+++ lnx-419-rc2/drivers/pci/pci.c
@@ -196,7 +196,7 @@ EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
 /**
  * pci_dev_str_match_path - test if a path string matches a device
  * @dev:    the PCI device to test
- * @p:      string to match the device against
+ * @path:   string to match the device against
  * @endptr: pointer to the string after the match
  *
  * Test if a string (typically from a kernel parameter) formatted as a

