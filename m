Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230330-2-5919127178813985769
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230329; b=Br15Lwl5Ui2lpFauwQkWaer/eyIHbxSEd4bKPd8o7HfbkxhgLW
    Pbe6CeWutE2oEXAefUfqmjuZT9BDsA/Mbda8nS/NfbtvhhGazlSkoersUx+hXx5Z
    ZxQEzcpcC6pOSaMewu63e5pRIDGPWY54+/uWVuN6mdJ9TbkvcA6d2UPKwCFr2epM
    ECkkTMnv/yd8BavNzT26YDagtBculcAsfAUSMfFmGe4XlwnMJlcRnP3je3jdAXy9
    gzIdYFielzgcxda0cFT6dp5pDEPXx5dFVThVFaYE8nx326kdYkVa6AK9shKhXVDP
    EM35KyD3bO8/QORM9FRZ3F7K6y82s4HPIGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230329; bh=
    sgwAy2Iq88n6/Gj5QWnjc8WgSVzrNW9JLCSpkeiPSSM=; b=cuv5zbbDQmvfiZMf
    UaybIyG11f0uQEsvaZn3xFIiozt0vFhbUQrB1ZjnMd5G+F9P4q1MdWNkgBvyRydU
    DP2TPdXdV1TMiFk0oSY7X0KFlwn34ORTQYttCS+jxHYOE+/Y9shykVJ4vvyYr0v0
    7pqPZ2I+sS3x1upC9WHXIMitDgERTZy4TeapdTnz768NEysa4FRpUZyKMd0FhrH0
    PB/uy+xNTxtp36wCkg5kG1IpBYCDa708x2v1XzEsE7NjNJJrp3sXXBaf3Zply/fQ
    liMpZDpHeX5fozfW8633E4jUwo36QSSL+VSDb3m2dtIpoUGytxO7LWesgFhFuWyU
    tpQp5g==
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
X-CM-Envelope: MS4wfODQIdLyW6qt/NCrCxtE2uix5RdGXI77iTxBPxclZks1xUJXOv6JTg2ecWIuY5FxDU23WhzrotM5ibPVhqGy0B5+Mk79G/v1eMVil0wHShafVxUf20Ds
    JOZzlzeqlbjsEF5r9aTIJhdfu8Fi4/G7D8KC9v996BQg1EWqi/2cUi12NdeJe6TkyXJVuJCs7CbTI1OXypZps4bRUUz76qg/5UhIpMrhVR1RprDA1OM9tSQr
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=94gbBRZrzIZMrSAYxZQA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbeEBDE7 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:04:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:63852 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751514AbeEBDCc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058521"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v5 19/28] fpga: dfl: fme-mgr: add compat_id support
Date: Wed,  2 May 2018 10:50:22 +0800
Message-Id: <1525229431-3087-20-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds compat_id support to fme manager driver, it
reads the ID from the hardware register. And it could be used
for compatibility check before partial reconfiguration.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl-fme-mgr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index 1c5bc5a..afcdb39 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -272,9 +272,17 @@ static u64 fme_mgr_status(struct fpga_manager *mgr)
 	.status = fme_mgr_status,
 };
 
+static void fme_mgr_get_compat_id(void __iomem *fme_pr,
+				  struct fpga_compat_id *id)
+{
+	id->id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
+	id->id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
+}
+
 static int fme_mgr_probe(struct platform_device *pdev)
 {
 	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct fpga_compat_id *compat_id;
 	struct device *dev = &pdev->dev;
 	struct fme_mgr_priv *priv;
 	struct fpga_manager *mgr;
@@ -295,11 +303,18 @@ static int fme_mgr_probe(struct platform_device *pdev)
 			return PTR_ERR(priv->ioaddr);
 	}
 
+	compat_id = devm_kzalloc(dev, sizeof(*compat_id), GFP_KERNEL);
+	if (!compat_id)
+		return -ENOMEM;
+
+	fme_mgr_get_compat_id(priv->ioaddr, compat_id);
+
 	mgr = fpga_mgr_create(dev, "DFL FME FPGA Manager",
 			      &fme_mgr_ops, priv);
 	if (!mgr)
 		return -ENOMEM;
 
+	mgr->compat_id = compat_id;
 	platform_set_drvdata(pdev, mgr);
 
 	ret = fpga_mgr_register(mgr);
-- 
1.8.3.1

