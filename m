Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 140EEC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA71D208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA71D208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935527AbeFMVpO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:45:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:50746 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935060AbeFMVpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:45:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 14:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,220,1526367600"; 
   d="scan'208";a="49130246"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2018 14:45:10 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fTDZl-000Q5E-KG; Thu, 14 Jun 2018 05:45:09 +0800
Date:   Thu, 14 Jun 2018 05:44:38 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     kbuild-all@01.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] soc: qcom: Remove depends on ARCH_QCOM
Message-ID: <201806140551.XMO7Ml2D%fengguang.wu@intel.com>
References: <20180613125401.11734-6-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613125401.11734-6-niklas.cassel@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20180613]
[cannot apply to v4.17]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Niklas-Cassel/soc-qcom-remove-depends-on-ARCH_QCOM/20180613-205858
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> /kbuild/src/sparse/drivers/rpmsg/qcom_glink_smem.c:91:15: sparse: expression using sizeof(void)
>> /kbuild/src/sparse/drivers/rpmsg/qcom_glink_smem.c:91:15: sparse: expression using sizeof(void)
>> /kbuild/src/sparse/drivers/rpmsg/qcom_glink_smem.c:93:50: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const [noderef] <asn:2>*from @@    got sn:2>*from @@
   /kbuild/src/sparse/drivers/rpmsg/qcom_glink_smem.c:93:50:    expected void const [noderef] <asn:2>*from
   /kbuild/src/sparse/drivers/rpmsg/qcom_glink_smem.c:93:50:    got void *
   /kbuild/src/sparse/drivers/rpmsg/qcom_glink_smem.c:98:49: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const [noderef] <asn:2>*from @@    got sn:2>*from @@
   /kbuild/src/sparse/drivers/rpmsg/qcom_glink_smem.c:98:49:    expected void const [noderef] <asn:2>*from
   /kbuild/src/sparse/drivers/rpmsg/qcom_glink_smem.c:98:49:    got void *fifo
   /kbuild/src/sparse/drivers/rpmsg/qcom_glink_smem.c:147:15: sparse: expression using sizeof(void)
   /kbuild/src/sparse/drivers/rpmsg/qcom_glink_smem.c:147:15: sparse: expression using sizeof(void)
--
>> drivers/clk/qcom/clk-smd-rpm.c:250:23: sparse: expression using sizeof(void)
>> drivers/clk/qcom/clk-smd-rpm.c:250:23: sparse: expression using sizeof(void)
   drivers/clk/qcom/clk-smd-rpm.c:259:22: sparse: expression using sizeof(void)
   drivers/clk/qcom/clk-smd-rpm.c:259:22: sparse: expression using sizeof(void)
   drivers/clk/qcom/clk-smd-rpm.c:333:23: sparse: expression using sizeof(void)
   drivers/clk/qcom/clk-smd-rpm.c:333:23: sparse: expression using sizeof(void)
   drivers/clk/qcom/clk-smd-rpm.c:338:22: sparse: expression using sizeof(void)
   drivers/clk/qcom/clk-smd-rpm.c:338:22: sparse: expression using sizeof(void)
--
   /kbuild/src/sparse/drivers/soc/qcom/smd-rpm.c:182:31: sparse: expression using sizeof(void)
>> /kbuild/src/sparse/drivers/soc/qcom/smd-rpm.c:183:47: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const volatile [noderef] <asn:2>*addr @@    got le [noderef] <asn:2>*addr @@
   /kbuild/src/sparse/drivers/soc/qcom/smd-rpm.c:183:47:    expected void const volatile [noderef] <asn:2>*addr
   /kbuild/src/sparse/drivers/soc/qcom/smd-rpm.c:183:47:    got unsigned char const *<noident>
--
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:418:16: sparse: incorrect type in assignment (different address spaces) @@    expected struct smem_header *header @@    got voistruct smem_header *header @@
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:418:16:    expected struct smem_header *header
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:418:16:    got void [noderef] <asn:2>*virt_base
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:503:16: sparse: incorrect type in assignment (different address spaces) @@    expected struct smem_header *header @@    got voistruct smem_header *header @@
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:503:16:    expected struct smem_header *header
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:503:16:    got void [noderef] <asn:2>*virt_base
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:516:48: sparse: incorrect type in return expression (different address spaces) @@    expected void * @@    got void [noderef] <avoid * @@
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:516:48:    expected void *
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:516:48:    got void [noderef] <asn:2>*
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:651:24: sparse: incorrect type in assignment (different address spaces) @@    expected struct smem_header *header @@    got voistruct smem_header *header @@
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:651:24:    expected struct smem_header *header
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:651:24:    got void [noderef] <asn:2>*virt_base
>> /kbuild/src/sparse/drivers/soc/qcom/smem.c:673:23: sparse: incompatible types in comparison expression (different address spaces)
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:675:23: sparse: incompatible types in comparison expression (different address spaces)
>> /kbuild/src/sparse/drivers/soc/qcom/smem.c:676:40: sparse: subtraction of different types can't work (different address spaces)
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:691:16: sparse: incorrect type in assignment (different address spaces) @@    expected struct smem_header *header @@    got voistruct smem_header *header @@
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:691:16:    expected struct smem_header *header
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:691:16:    got void [noderef] <asn:2>*virt_base
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:702:16: sparse: incorrect type in assignment (different address spaces) @@    expected struct smem_ptable *ptable @@    got voistruct smem_ptable *ptable @@
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:702:16:    expected struct smem_ptable *ptable
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:702:16:    got void [noderef] <asn:2>*
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:724:57: sparse: restricted __le32 degrades to integer
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:765:16: sparse: incorrect type in assignment (different address spaces) @@    expected struct smem_partition_header *header @@    got smem_partition_header *header @@
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:765:16:    expected struct smem_partition_header *header
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:765:16:    got void [noderef] <asn:2>*
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:844:24: sparse: incorrect type in assignment (different address spaces) @@    expected struct smem_partition_header *header @@    got smem_partition_header *header @@
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:844:24:    expected struct smem_partition_header *header
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:844:24:    got void [noderef] <asn:2>*
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:943:16: sparse: incorrect type in assignment (different address spaces) @@    expected struct smem_header *header @@    got voistruct smem_header *header @@
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:943:16:    expected struct smem_header *header
   /kbuild/src/sparse/drivers/soc/qcom/smem.c:943:16:    got void [noderef] <asn:2>*virt_base

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
