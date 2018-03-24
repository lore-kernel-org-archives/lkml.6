Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeCXXUT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 19:20:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:59457 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752880AbeCXXUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 19:20:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,356,1517904000";
   d="scan'208";a="214555170"
Date: Sun, 25 Mar 2018 07:19:14 +0800
From: kbuild test robot <lkp@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: kbuild-all@01.org, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean Delvare <khali@linux-fr.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 20/22] iommu/vt-d: add intel iommu page response
 function
Message-ID: <201803250714.oP5hRa5Y%fengguang.wu@intel.com>
References: <1521774734-48433-21-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521774734-48433-21-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iommu/next]
[also build test WARNING on v4.16-rc6 next-20180323]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jacob-Pan/IOMMU-and-VT-d-driver-support-for-Shared-Virtual-Address-SVA/20180325-024555
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/iommu/intel-iommu.c:500:5: sparse: symbol 'intel_iommu_gfx_mapped' was not declared. Should it be static?
   drivers/iommu/intel-iommu.c:3066:41: sparse: incorrect type in argument 1 (different address spaces) @@    expected void volatile [noderef] <asn:2>*addr @@    got ile [noderef] <asn:2>*addr @@
   drivers/iommu/intel-iommu.c:3066:41:    expected void volatile [noderef] <asn:2>*addr
   drivers/iommu/intel-iommu.c:3066:41:    got struct context_entry *old_ce
>> drivers/iommu/intel-iommu.c:5198:5: sparse: symbol 'intel_iommu_page_response' was not declared. Should it be static?
>> drivers/iommu/intel-iommu.c:5224:48: sparse: right shift by bigger than source value

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
