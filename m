Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F386C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFF621570
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFF621570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbeHOAnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:43:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:42275 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbeHOAnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:43:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 14:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,240,1531810800"; 
   d="scan'208";a="75395038"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2018 14:53:58 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fphG4-000Hz7-HG; Wed, 15 Aug 2018 05:53:44 +0800
Date:   Wed, 15 Aug 2018 05:53:13 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@01.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Bart van Assche <bart.vanassche@wdc.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: [RFC PATCH] nvme: nvme_ns_id_attr_group can be static
Message-ID: <20180814215313.GA30264@lkp-wsm-ep2>
References: <20180814073305.87255-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814073305.87255-3-hare@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 8bb7a8e4617e ("nvme: register ns_id attributes as default sysfs groups")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8e26d98..76cdb60 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2729,7 +2729,7 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-const struct attribute_group nvme_ns_id_attr_group = {
+static const struct attribute_group nvme_ns_id_attr_group = {
 	.attrs		= nvme_ns_id_attrs,
 	.is_visible	= nvme_ns_id_attrs_are_visible,
 };
