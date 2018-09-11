Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5819C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7734520866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7734520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeIKFho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:37:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:55836 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbeIKFhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:37:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 17:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,358,1531810800"; 
   d="scan'208";a="90579149"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga002.jf.intel.com with ESMTP; 10 Sep 2018 17:41:06 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fzWjp-0001bG-HC; Tue, 11 Sep 2018 08:41:05 +0800
Date:   Tue, 11 Sep 2018 08:40:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ocean He <oceanhehy@gmail.com>
Cc:     kbuild-all@01.org, dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Ocean He <hehy1@lenovo.com>
Subject: Re: [PATCH 3/3] libnvdimm, region_devs: reset related seeds when
 fail to create namespace
Message-ID: <201809110838.E3lo4lfn%fengguang.wu@intel.com>
References: <1536560508-24564-4-git-send-email-oceanhehy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536560508-24564-4-git-send-email-oceanhehy@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ocean,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux-nvdimm/libnvdimm-for-next]
[also build test WARNING on v4.19-rc3 next-20180910]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ocean-He/libnvdimm-reset-seeds-for-next-namespace-creation/20180911-005505
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/nvdimm/region_devs.c:84:29: sparse: expression using sizeof(void)
   drivers/nvdimm/region_devs.c:84:29: sparse: expression using sizeof(void)
   drivers/nvdimm/region_devs.c:405:37: sparse: expression using sizeof(void)
   drivers/nvdimm/region_devs.c:405:37: sparse: expression using sizeof(void)
>> drivers/nvdimm/region_devs.c:710:6: sparse: symbol 'nd_region_detach_and_reset' was not declared. Should it be static?
   drivers/nvdimm/region_devs.c:1127:31: sparse: expression using sizeof(void)
   drivers/nvdimm/region_devs.c:985:9: sparse: context imbalance in 'nd_region_acquire_lane' - wrong count at exit
   drivers/nvdimm/region_devs.c:998:36: sparse: context imbalance in 'nd_region_release_lane' - unexpected unlock

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
