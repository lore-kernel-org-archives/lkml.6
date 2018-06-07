Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pG6JLqrrGFuXagAAmS7hNA
	; Thu, 07 Jun 2018 08:24:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A55696089E; Thu,  7 Jun 2018 08:24:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EA22C6063F;
	Thu,  7 Jun 2018 08:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA22C6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932639AbeFGIYG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:24:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:58952 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753359AbeFGIXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:23:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 01:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="gz'50?scan'50,208,50";a="45316624"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jun 2018 01:23:43 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fQqCt-0007QL-8B; Thu, 07 Jun 2018 16:23:43 +0800
Date: Thu, 7 Jun 2018 16:23:22 +0800
From: kbuild test robot <lkp@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: fix dev iotlb pfsid use
Message-ID: <201806071554.icNd3het%fengguang.wu@intel.com>
References: <1528316280-24307-3-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <1528316280-24307-3-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jacob,

I love your patch! Yet something to improve:

[auto build test ERROR on iommu/next]
[also build test ERROR on v4.17 next-20180606]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jacob-Pan/iommu-vt-d-pfsid-fix/20180607-134305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: ia64-defconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   In file included from drivers//iommu/intel-iommu.c:31:
   drivers//iommu/intel-iommu.c: In function 'iommu_enable_dev_iotlb':
>> drivers//iommu/intel-iommu.c:1488:33: error: 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
      info->pfsid = PCI_DEVID(pdev->physfn->bus->number, pdev->physfn->devfn);
                                    ^~~~~~
   include/linux/pci.h:51:40: note: in definition of macro 'PCI_DEVID'
    #define PCI_DEVID(bus, devfn) ((((u16)(bus)) << 8) | (devfn))
                                           ^~~
   drivers//iommu/intel-iommu.c:1488:60: error: 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
      info->pfsid = PCI_DEVID(pdev->physfn->bus->number, pdev->physfn->devfn);
                                                               ^~~~~~
   include/linux/pci.h:51:55: note: in definition of macro 'PCI_DEVID'
    #define PCI_DEVID(bus, devfn) ((((u16)(bus)) << 8) | (devfn))
                                                          ^~~~~

vim +1488 drivers//iommu/intel-iommu.c

  1467	
  1468	static void iommu_enable_dev_iotlb(struct device_domain_info *info)
  1469	{
  1470		struct pci_dev *pdev;
  1471	
  1472		assert_spin_locked(&device_domain_lock);
  1473	
  1474		if (!info || !dev_is_pci(info->dev))
  1475			return;
  1476	
  1477		pdev = to_pci_dev(info->dev);
  1478		/* For IOMMU that supports device IOTLB throttling (DIT), we assign
  1479		 * PFSID to the invalidation desc of a VF such that IOMMU HW can gauge
  1480		 * queue depth at PF level. If DIT is not set, PFSID will be treated as
  1481		 * reserved, which should be set to 0.
  1482		 */
  1483		if (!ecap_dit(info->iommu->ecap))
  1484			info->pfsid = 0;
  1485		else if (pdev && pdev->is_virtfn) {
  1486			if (ecap_dit(info->iommu->ecap))
  1487				dev_warn(&pdev->dev, "SRIOV VF device IOTLB enabled without flow control\n");
> 1488			info->pfsid = PCI_DEVID(pdev->physfn->bus->number, pdev->physfn->devfn);
  1489		} else
  1490			info->pfsid = PCI_DEVID(info->bus, info->devfn);
  1491	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--nFreZHaLTZJo0R7j
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
bfH/ATpcH6oaJgEA

--nFreZHaLTZJo0R7j--
