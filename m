Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xRIlDOdAGluJWAAAmS7hNA
	; Fri, 08 Jun 2018 08:40:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 146B5607E4; Fri,  8 Jun 2018 08:40:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 84E9060290;
	Fri,  8 Jun 2018 08:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84E9060290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932238AbeFHIkE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:40:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:5992 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752769AbeFHIkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:40:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 01:40:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="46218022"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2018 01:39:59 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fRCwA-000GLt-N8; Fri, 08 Jun 2018 16:39:58 +0800
Date: Fri, 8 Jun 2018 16:39:41 +0800
From: kbuild test robot <lkp@intel.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [v3, 07/10] fsl/fman_port: support getting timestamp
Message-ID: <201806081628.UCdhDsEg%fengguang.wu@intel.com>
References: <20180607092050.46128-8-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607092050.46128-8-yangbo.lu@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangbo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]
[also build test WARNING on next-20180608]
[cannot apply to v4.17]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yangbo-Lu/Support-DPAA-PTP-clock-and-timestamping/20180608-131649
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/freescale/fman/fman_port.c:879:26: sparse: expression using sizeof(void)
   drivers/net/ethernet/freescale/fman/fman_port.c:879:26: sparse: expression using sizeof(void)
   drivers/net/ethernet/freescale/fman/fman_port.c:1035:36: sparse: expression using sizeof(void)
   drivers/net/ethernet/freescale/fman/fman_port.c:1247:17: sparse: expression using sizeof(void)
   drivers/net/ethernet/freescale/fman/fman_port.c:1249:17: sparse: expression using sizeof(void)
   drivers/net/ethernet/freescale/fman/fman_port.c:1249:17: sparse: expression using sizeof(void)
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64

vim +1739 drivers/net/ethernet/freescale/fman/fman_port.c

  1733	
  1734	int fman_port_get_tstamp(struct fman_port *port, const void *data, u64 *tstamp)
  1735	{
  1736		if (port->buffer_offsets.time_stamp_offset == ILLEGAL_BASE)
  1737			return -EINVAL;
  1738	
> 1739		*tstamp = be64_to_cpu(*(u64 *)(data +
  1740				port->buffer_offsets.time_stamp_offset));
  1741	
  1742		return 0;
  1743	}
  1744	EXPORT_SYMBOL(fman_port_get_tstamp);
  1745	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
