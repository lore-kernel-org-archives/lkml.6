Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 78B16C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2764C20839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2764C20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933120AbeFKXJS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 19:09:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:12377 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932300AbeFKXJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 19:09:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 16:09:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,212,1526367600"; 
   d="scan'208";a="63228283"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jun 2018 16:09:12 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fSVvz-000LkZ-H9; Tue, 12 Jun 2018 07:09:11 +0800
Date:   Tue, 12 Jun 2018 07:08:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     kbuild-all@01.org, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v4 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
Message-ID: <201806120747.RxEPI6T2%fengguang.wu@intel.com>
References: <20180611205224.23340-5-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611205224.23340-5-stefan@agner.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on v4.17 next-20180608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stefan-Agner/mtd-rawnand-add-NVIDIA-Tegra-NAND-flash-support/20180612-045611
base:   git://git.infradead.org/linux-mtd.git nand/next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/mtd/nand/raw/tegra_nand.c:422:41: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:425:41: sparse: expression using sizeof(void)
>> drivers/mtd/nand/raw/tegra_nand.c:656:56: sparse: Using plain integer as NULL pointer
   drivers/mtd/nand/raw/tegra_nand.c:667:56: sparse: Using plain integer as NULL pointer
   drivers/mtd/nand/raw/tegra_nand.c:693:56: sparse: Using plain integer as NULL pointer
   drivers/mtd/nand/raw/tegra_nand.c:759:48: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:759:48: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:762:24: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:762:24: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:792:56: sparse: Using plain integer as NULL pointer
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:814:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:818:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:823:15: sparse: expression using sizeof(void)
   drivers/mtd/nand/raw/tegra_nand.c:823:15: sparse: expression using sizeof(void)

vim +656 drivers/mtd/nand/raw/tegra_nand.c

   651	
   652	static int tegra_nand_read_page_raw(struct mtd_info *mtd,
   653					    struct nand_chip *chip,
   654					    uint8_t *buf, int oob_required, int page)
   655	{
 > 656		void *oob_buf = oob_required ? chip->oob_poi : 0;
   657	
   658		return tegra_nand_page_xfer(mtd, chip, buf, oob_buf,
   659					    mtd->oobsize, page, true);
   660	}
   661	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
