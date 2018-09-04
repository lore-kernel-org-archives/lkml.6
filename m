Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EA2C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C25220843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C25220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeIDToh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:44:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:57520 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbeIDToh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:44:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 08:19:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="70484198"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.138])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2018 08:19:00 -0700
Date:   Tue, 4 Sep 2018 23:31:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kenneth Lee <nek.in.cn@gmail.com>
Cc:     kbuild-all@01.org, Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>, linuxarm@huawei.com
Subject: [RFC PATCH] vfio: vfio_sdmdev_groups[] can be static
Message-ID: <20180904153135.GI17047@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903005204.26041-4-nek.in.cn@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 1e47d5e60865 ("vfio: add sdmdev support")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 vfio_sdmdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/sdmdev/vfio_sdmdev.c b/drivers/vfio/sdmdev/vfio_sdmdev.c
index c6eb5d4..e7d3c23 100644
--- a/drivers/vfio/sdmdev/vfio_sdmdev.c
+++ b/drivers/vfio/sdmdev/vfio_sdmdev.c
@@ -103,7 +103,7 @@ static const struct attribute_group vfio_sdmdev_group = {
 	.name  = VFIO_SDMDEV_PDEV_ATTRS_GRP_NAME,
 	.attrs = vfio_sdmdev_attrs,
 };
-const struct attribute_group *vfio_sdmdev_groups[] = {
+static const struct attribute_group *vfio_sdmdev_groups[] = {
 	&vfio_sdmdev_group,
 	NULL,
 };
