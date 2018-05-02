Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230293-2-2414169258122622855
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230293; b=AfpIMSAOlY5IfxqUfGYXr/WzZdANs5cSk9r9haNY0fkP8I/aCv
    Z0/hMpf/mliOJJcq2BvjVoTalJSvGjIZM07DGmG8XgxDUxpfgKdERBfdfzOLRxwr
    lVlg18/0NAsAQifWQVK7POX4ynOT0jsgNw4JM8xwnF9asd22ub0fLHROikMULFtf
    j+DXI2uUbW4O5uL19RXPU99FeDX3DmA5AS5zUU2zxD6dk2RYJvFiTm0RG+7uTg6g
    4qYaz/ANMCTemNcldWCGBzh9W04P1s9yAw6GoYU2/tprsS0sOK6jtEYGIZFkNBFo
    qpUXRnli4FDUKDHHOIoWHChXdqj4JHOlSFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230293; bh=
    aakxGkwqKDn7ojIzksAzgCijWgyZ0Amf5XY5WbnIIRQ=; b=QJcp53WkHLCOfPSR
    DN/G8RYTmRabjTBvEwnjbkThtHath5fZboXFTDxQh7V85SmHeUix1ITjZLGdrTy4
    vyjtyiVklyfPGU3WGruxHmwCoX5LsWaZIjpKbKVHR5cQ251o7/wNkp13f3/PMbbn
    vQW86JcwgqcO+YfIB4dYEeFW4i9pcbcGPf34eYEMc8zKpmYjjfmbMjMEqd/n9w6W
    kJKKTL1cUt/c5hfzBuwJDVIlw6/UiEAeg1bJtVffFYOAEcD//2LWkuOBCz8ZDbS+
    zU5o0LQjZo8JHZEgMBdML7oXV4D8qctborzyvz8P0DevdOYRJbld0hSUFl/zbUfE
    U9Gw2w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOpv9TkCjvxTHHRXbLAYIKJUdlDNNGANKZg14fpxj9dOiuUHrEfyuTsjY+BsU9pcs2OnNX3+vmHIA+Pxu5fDVsViyUAGeP3X4aAxgvkRBbB6O0GzyKVD
    bJo/w/mz3J8Annxy16w2YwXfcCivHEv+AOP81LTlH/UDTLOjv2hN0tGeY+oleGbtrhHDn4z0kqoFYWPLt0//m+n7MVWM3VzfDJCSueIAxDDJantCZy3fXHiC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=XD4hknt_4UHAuEvMGKYA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeEBDCo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:02:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:63852 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751555AbeEBDCk (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058563"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v5 22/28] fpga: dfl: fme-region: add support for compat_id
Date: Wed,  2 May 2018 10:50:25 +0800
Message-Id: <1525229431-3087-23-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds compat_id support, it reuses fme manager's
compat id, as the per region compat id is actually from the
fme manager's register.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v5: reuse fme manager's compat_id as per region compat_id
---
 drivers/fpga/dfl-fme-region.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 696b313..b82a381 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -45,6 +45,7 @@ static int fme_region_probe(struct platform_device *pdev)
 	}
 
 	region->priv = pdata;
+	region->compat_id = mgr->compat_id;
 	platform_set_drvdata(pdev, region);
 
 	ret = fpga_region_register(region);
-- 
1.8.3.1

