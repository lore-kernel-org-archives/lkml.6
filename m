Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD14C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1A02156E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1A02156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeHOAnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:43:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:64018 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728315AbeHOAnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:43:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 14:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,240,1531810800"; 
   d="scan'208";a="63194794"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2018 14:53:58 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fphG4-000Hyh-G0; Wed, 15 Aug 2018 05:53:44 +0800
Date:   Wed, 15 Aug 2018 05:53:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@01.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Bart van Assche <bart.vanassche@wdc.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
Message-ID: <201808150550.wKf5lVlA%fengguang.wu@intel.com>
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

Hi Hannes,

I love your patch! Perhaps something to improve:

[auto build test WARNING on block/for-next]
[also build test WARNING on next-20180814]
[cannot apply to v4.18]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hannes-Reinecke/genhd-register-default-groups-with-device_add_disk/20180815-034942
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/uapi/linux/perf_event.h:147:56: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   drivers/nvme/host/core.c:506:28: sparse: expression using sizeof(void)
   include/linux/blkdev.h:1269:16: sparse: expression using sizeof(void)
   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
   drivers/nvme/host/core.c:1062:32: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:1062:32: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:1063:26: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:1063:26: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:1844:32: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:1844:32: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:1846:43: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2406:17: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2406:17: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
>> drivers/nvme/host/core.c:2732:30: sparse: symbol 'nvme_ns_id_attr_group' was not declared. Should it be static?
   drivers/nvme/host/core.c:3203:33: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:3566:17: sparse: expression using sizeof(void)
   include/linux/slab.h:631:13: sparse: call with no type!
   drivers/nvme/host/core.c:1264:23: sparse: context imbalance in 'nvme_get_ns_from_disk' - wrong count at exit
   drivers/nvme/host/core.c:1282:33: sparse: context imbalance in 'nvme_put_ns_from_disk' - unexpected unlock

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
