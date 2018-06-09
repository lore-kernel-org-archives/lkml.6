Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Ct5rGSS/G1suaQAAmS7hNA
	; Sat, 09 Jun 2018 11:51:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3E5CB607BB; Sat,  9 Jun 2018 11:51:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C0AC3602FC;
	Sat,  9 Jun 2018 11:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0AC3602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeFILvE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 07:51:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:50193 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753188AbeFILvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 07:51:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2018 04:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,494,1520924400";
   d="scan'208";a="65628805"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2018 04:50:57 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fRcOX-0001H2-04; Sat, 09 Jun 2018 19:50:57 +0800
Date: Sat, 9 Jun 2018 19:50:42 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Sayali Lokhande <sayalil@codeaurora.org>
Cc: kbuild-all@01.org, subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org, linux-scsi@vger.kernel.org,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] scsi: ufs: dev_attr_ufs_provision can be static
Message-ID: <20180609115042.GA149407@athens>
References: <1528455990-24572-4-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528455990-24572-4-git-send-email-sayalil@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 2f7e32b8cdc9 ("scsi: ufs: Add sysfs support for ufs provision")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 ufs-sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 8b68813..36c28cc 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -264,7 +264,7 @@ static ssize_t ufs_provision_store(struct device *dev,
 	return ufshcd_desc_config_store(dev, attr, buf, count);
 }
 
-DEVICE_ATTR_RW(ufs_provision);
+static DEVICE_ATTR_RW(ufs_provision);
 
 static struct attribute *ufs_sysfs_config_descriptor[] = {
 	&dev_attr_ufs_provision.attr,
