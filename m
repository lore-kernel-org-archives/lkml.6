Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230118-2-12367020251338229359
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
    1525230117; b=BXB8wFhZsQKBzbn8bFkaEQ8orQ4QOvERwVU/guHvZJ3Z75RnXr
    Sq17DagmvWpYO1EEJ3uv6LWyMpZ1TRQ8Jaet6EGhjnsQRB+a3JnNV8WSTuJrly00
    Qk9I12SNh8ZrgfhYUqH5SeDA8k6AY+lOlQJ75gJf+Wc1dtb313s65NoCZGcP2VjZ
    F5JQgDMLRJBWwLaLokKOBVqDc40Q+Jsr2ZmBLYt2XgPdbpTnZFNUMyabbOo172GF
    oWeWcVdwfUgfPiDxRGDy+vQahIrkJxKVO/cjh9y6gO5VX0kseS2MLdfaV+Drfshd
    0JZn5JgEWwJ1sQw2jUcf3GTIjxI+F6IQ7VLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230117; bh=
    oiER6maGx8cZaSvkBoEcQV4+Zpex03Uf1RAe14Ki+vc=; b=QTguwSjup1RxljjJ
    hZO1vLplaPtdvVYuTzgXrw7is83hF4QjhfE6cNiYrsc3LPP9degmzVIcG6Yn8aef
    bsHhQCWFzBhFDs3cEIar7Sg61TDFcE8I+MCh2hkaLEs3R8h2A1XeYbSsP3iAVv0t
    yUK4XNLjRN5CxzQtWmLCFNYG3lYt1hWfwZdODVgxXsOc8hbBQ5TJT3ygQxlJHxZH
    UuSRWCY7wlbV6rb8+jnnzsLIWFgszQUao/gc9+8ycIOHBrK2F5yNvacKe4pOIrjC
    3Xj8PClpvPMPUz7OgSjaJoS9s5aS7vn8SFZ3Lsk70WJUEeECL33hG7ILz4X5rDp+
    3cFlzw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfKPRZy7daBZ/HDDH2gbF3GaJ+y/oauQ1lD+cfpkNU/P9Zdf5MpAjZYYuQ7ARoiVJtOZgVgRDFpfVnu4J/iz/YG9rCrH74VMQir+XNCMISIiPLmJnug5K
    0ZJQEPCwhWe/mhxLFCOj7smck200Gd8v5GiQ9NSqeHzWnCsj3M2rRyBPhsTdVN8qdOZL/d2Aohpm13Fo6oOxwehWtzbXNW89k9vC7RbBgpV/OzEqsJgCL2Bn
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=G0raO7cM-fZGaQv_qUMA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeEBDBx (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:01:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:63823 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeEBDBq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:01:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058213"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v5 02/28] fpga: mgr: add region_id to fpga_image_info
Date: Wed,  2 May 2018 10:50:05 +0800
Message-Id: <1525229431-3087-3-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds region_id to fpga_image_info data structure, it
allows driver to pass region id information to fpga-mgr via
fpga_image_info for fpga reconfiguration function.

Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
v3: add one line comment for region_id
v4: add Acked-by from Moritz and Alan.
---
 include/linux/fpga/fpga-mgr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 1266c11..eecfca5 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -88,6 +88,7 @@ enum fpga_mgr_states {
  * @sgt: scatter/gather table containing FPGA image
  * @buf: contiguous buffer containing FPGA image
  * @count: size of buf
+ * @region_id: id of target region
  * @dev: device that owns this
  * @overlay: Device Tree overlay
  */
@@ -100,6 +101,7 @@ struct fpga_image_info {
 	struct sg_table *sgt;
 	const char *buf;
 	size_t count;
+	int region_id;
 	struct device *dev;
 #ifdef CONFIG_OF
 	struct device_node *overlay;
-- 
1.8.3.1

