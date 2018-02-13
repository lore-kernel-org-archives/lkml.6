Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845453-1518514777-2-1087696995128182777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518514776; b=mLT/CyHVbF0Di462NZDLIHtefFnAW4jsa7t0mFNLDCRtaA1
    D7yHjSJ3GCvpNFJXq5wwt9xcOxdEfMY+t6Izd7wB+y5ZCzAkIZeLvhuXD23YPRa7
    8+Cqv04TQP5+NDxlaqW6YfLf5rM+mA+QFBam71cbsi8cWkeD/iMYSstmKXPBbfmB
    a7hQoKZ4BgQXfK7jmVDjoo7oLJWR0pLkOheL1zdRecwrP0xrtUUu+XHSRseHYsSX
    yfK6JVeSTsbL1Wwrbupl/OXj0rW3pK/2imVTv2Kngg+F5iv9sG5MI5s0+jQ+pbBK
    ik1ngBBXxkyeAz4J7fxzIqtAjmY2npcjHHDX5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518514776;
    bh=5Shs20LElZmJKJYJPc7jzsk0sysN8Uu1LU2aG3BW7ic=; b=Sk/EevLp5iHg
    IqIS28eRcAr9D59DV3kGy39KXoknpV+4WsEilZCVB8q9MxGBLQh755VRM6HMNPHQ
    HY9I+m8pYbjTUW10CFCLu/J/tCn8fTHbeeDgdn1/z+BS8w0F1wz+LxOSeHDIc2jU
    L8VRKeM0nwDNsUhMarfpftvNEzbjF4vSECv4uQIbvqv5hkqB9PFnX+ad/3gv8pJe
    M63UvNKHE6Xui2NCY8KRcUazATm0bVUoq36SOYyV3xThzjwR1CD/onvbukxKg7un
    a1et3+i5qkVvHgAzkcpJ64CECOVX5kEjrE/PpnLEmgBfTEWDy1GpNzzBikXbVCg/
    a1Ux/As9OA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934407AbeBMJgD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:36:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:27144 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934397AbeBMJf7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:35:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889620"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v4 19/24] fpga: dfl-fme-region: add compat_id support
Date: Tue, 13 Feb 2018 17:24:48 +0800
Message-Id: <1518513893-4719-20-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds compat_id support, configure the compat_id value
of fpga_region, then userspace could read it from the common sysfs
interface compat_id of fpga_region.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl-fme-region.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 1f5f33d..bcef98a 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -48,6 +48,7 @@ static int fme_region_probe(struct platform_device *pdev)
 	region->get_bridges = fme_region_get_bridges;
 	region->priv = pdata;
 	region->parent = dev;
+	region->compat_id = pdata->compat_id;
 	platform_set_drvdata(pdev, region);
 
 	ret = fpga_region_register(region);
-- 
2.7.4

