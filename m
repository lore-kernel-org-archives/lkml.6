Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3370170-1522686965-2-2052369083029259349
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES encafr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522686964; b=YjW1E9m2HjvP1uAgErnqcIyzogwTCJ1pZHpEtYAQEmMAS+o7pf
    9bNwd9FSLy5ySCcw+ltVGiMm7ddhC7zNYXQpcFTMr3CD9U+bakmEjlHe4H43Kr4N
    YVWjwhXFgfm2UP5sqzjNUN+DST1on0q9NOoFMx8SXwQAzWfNRMmajjk0E1EKpJla
    zqO7VUcbihATw0mINL22pGp5qYr4jJkuvDLykBScIe784g/tw49kGkcUQ8an4tsD
    rdHqm4/oMbTGEqDpIVGXGvMbf5vQjdwbrMTT0vxSc8tNScoricTBOQ97/+PTGWM4
    5JK8z+duBXI0pFkreELbCCtWNDUqxseUiwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522686964; bh=vQUCH
    cEGxRJDZW5i/y0PTdABnGayiRbRWfpolamvci4=; b=SaQcW68d87/9QPsUb+okl
    LEiDjKL/P+4JfhIAuI3JLTX+tisciHAmC5E6NUrrRp8Y99WcCgBiupjtE+OGFdTK
    poWeytgzHxyTxSMKHFrEV4YKr1y99UBNrlEkijZv20OjRNSQ+gL2CS1Kd1azPe8O
    JhK/mJkAWrV+6b+JaRUIgL10H2d0uKD9Mlfd3vHirefAP9nYC/wIoo4ET8k+giuM
    4zanfmdfYqSQ9fZJbtaYm9ytT+c4eVXRbuuluJWn4POX3I9uycgZkiEpLUfKQhdo
    lyEvcYNQEfINvR9EaFXmrCsKTwTaNlKjCFbXTeE1WGuZw9SOhIkl683e4uC2f5pr
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPWOAe+kLTPcmmoYwbNSH4DNiUbhiB+IKyG/1dGEDQfVG8g8Oa7a8Li915YfA+Q29Qvjz9Hnr9tFZa+FS7UvXuv5ZzeDmnSq5ninRdJ1pGFWZM3VMc8Q
    sM3/XrYPgyPSbVhoLO1lPG2jPEcEeQJZvk1np32GHd6eZN0IS2lsqXa4rszRf2OtBL4zr76U5qA2LljwDPgcCKv1FTNuoyIrF3fZRcQvb3cM4DQl8zQxbPUF
    SP2OLTllOEmRG3Olgr66AA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=NEAV23lmAAAA:8 a=uP1ucDPQAAAA:8
    a=i3X5FwGiAAAA:8 a=DDOyTI_5AAAA:8 a=1RUgToNGMIOfB09XNQgA:9
    a=M6If2JTKAOIgx3_K:21 a=k-3hzG-fpP0dA1LC:21 a=CjuIK1q_8ugA:10
    a=9a9ggB8z3XFZH39hjkD6:22 a=mmqRlSCDY2ywfjPLJ4af:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,396,1517904000"; d="scan'208";a="188026197"
Date: Tue, 3 Apr 2018 00:35:13 +0800
From: kbuild test robot <lkp@intel.com>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 12/15] dmaengine: pxa: make the filter function internal
Message-ID: <201804030025.FmWPyArN%fengguang.wu@intel.com>
References: <20180402142656.26815-13-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180402142656.26815-13-robert.jarzmik@free.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, linux-ide@vger.kernel.org,
 netdev@vger.kernel.org, linux-mtd@lists.infradead.org,
 Robert Jarzmik <robert.jarzmik@free.fr>, devel@driverdev.osuosl.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut@gmail.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 linux-media@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 kbuild-all@01.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Tejun Heo <tj@kernel.org>, Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Robert,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16]
[cannot apply to arm-soc/for-next next-20180329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Robert-Jarzmik/ARM-pxa-switch-to-DMA-slave-maps/20180402-233029
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/mtd/nand/marvell_nand.c:2621:17: sparse: undefined identifier 'pxad_filter_fn'
>> drivers/mtd/nand/marvell_nand.c:2621:17: sparse: call with no type!
   In file included from drivers/mtd/nand/marvell_nand.c:21:0:
   drivers/mtd/nand/marvell_nand.c: In function 'marvell_nfc_init_dma':
   drivers/mtd/nand/marvell_nand.c:2621:42: error: 'pxad_filter_fn' undeclared (first use in this function); did you mean 'dma_filter_fn'?
      dma_request_slave_channel_compat(mask, pxad_filter_fn,
                                             ^
   include/linux/dmaengine.h:1408:46: note: in definition of macro 'dma_request_slave_channel_compat'
     __dma_request_slave_channel_compat(&(mask), x, y, dev, name)
                                                 ^
   drivers/mtd/nand/marvell_nand.c:2621:42: note: each undeclared identifier is reported only once for each function it appears in
      dma_request_slave_channel_compat(mask, pxad_filter_fn,
                                             ^
   include/linux/dmaengine.h:1408:46: note: in definition of macro 'dma_request_slave_channel_compat'
     __dma_request_slave_channel_compat(&(mask), x, y, dev, name)
                                                 ^

vim +2621 drivers/mtd/nand/marvell_nand.c

02f26ecf Miquel Raynal 2018-01-09  2588  
02f26ecf Miquel Raynal 2018-01-09  2589  static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
02f26ecf Miquel Raynal 2018-01-09  2590  {
02f26ecf Miquel Raynal 2018-01-09  2591  	struct platform_device *pdev = container_of(nfc->dev,
02f26ecf Miquel Raynal 2018-01-09  2592  						    struct platform_device,
02f26ecf Miquel Raynal 2018-01-09  2593  						    dev);
02f26ecf Miquel Raynal 2018-01-09  2594  	struct dma_slave_config config = {};
02f26ecf Miquel Raynal 2018-01-09  2595  	struct resource *r;
02f26ecf Miquel Raynal 2018-01-09  2596  	dma_cap_mask_t mask;
02f26ecf Miquel Raynal 2018-01-09  2597  	struct pxad_param param;
02f26ecf Miquel Raynal 2018-01-09  2598  	int ret;
02f26ecf Miquel Raynal 2018-01-09  2599  
02f26ecf Miquel Raynal 2018-01-09  2600  	if (!IS_ENABLED(CONFIG_PXA_DMA)) {
02f26ecf Miquel Raynal 2018-01-09  2601  		dev_warn(nfc->dev,
02f26ecf Miquel Raynal 2018-01-09  2602  			 "DMA not enabled in configuration\n");
02f26ecf Miquel Raynal 2018-01-09  2603  		return -ENOTSUPP;
02f26ecf Miquel Raynal 2018-01-09  2604  	}
02f26ecf Miquel Raynal 2018-01-09  2605  
02f26ecf Miquel Raynal 2018-01-09  2606  	ret = dma_set_mask_and_coherent(nfc->dev, DMA_BIT_MASK(32));
02f26ecf Miquel Raynal 2018-01-09  2607  	if (ret)
02f26ecf Miquel Raynal 2018-01-09  2608  		return ret;
02f26ecf Miquel Raynal 2018-01-09  2609  
02f26ecf Miquel Raynal 2018-01-09  2610  	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
02f26ecf Miquel Raynal 2018-01-09  2611  	if (!r) {
02f26ecf Miquel Raynal 2018-01-09  2612  		dev_err(nfc->dev, "No resource defined for data DMA\n");
02f26ecf Miquel Raynal 2018-01-09  2613  		return -ENXIO;
02f26ecf Miquel Raynal 2018-01-09  2614  	}
02f26ecf Miquel Raynal 2018-01-09  2615  
02f26ecf Miquel Raynal 2018-01-09  2616  	param.drcmr = r->start;
02f26ecf Miquel Raynal 2018-01-09  2617  	param.prio = PXAD_PRIO_LOWEST;
02f26ecf Miquel Raynal 2018-01-09  2618  	dma_cap_zero(mask);
02f26ecf Miquel Raynal 2018-01-09  2619  	dma_cap_set(DMA_SLAVE, mask);
02f26ecf Miquel Raynal 2018-01-09  2620  	nfc->dma_chan =
02f26ecf Miquel Raynal 2018-01-09 @2621  		dma_request_slave_channel_compat(mask, pxad_filter_fn,
02f26ecf Miquel Raynal 2018-01-09  2622  						 &param, nfc->dev,
02f26ecf Miquel Raynal 2018-01-09  2623  						 "data");
02f26ecf Miquel Raynal 2018-01-09  2624  	if (!nfc->dma_chan) {
02f26ecf Miquel Raynal 2018-01-09  2625  		dev_err(nfc->dev,
02f26ecf Miquel Raynal 2018-01-09  2626  			"Unable to request data DMA channel\n");
02f26ecf Miquel Raynal 2018-01-09  2627  		return -ENODEV;
02f26ecf Miquel Raynal 2018-01-09  2628  	}
02f26ecf Miquel Raynal 2018-01-09  2629  
02f26ecf Miquel Raynal 2018-01-09  2630  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
02f26ecf Miquel Raynal 2018-01-09  2631  	if (!r)
02f26ecf Miquel Raynal 2018-01-09  2632  		return -ENXIO;
02f26ecf Miquel Raynal 2018-01-09  2633  
02f26ecf Miquel Raynal 2018-01-09  2634  	config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
02f26ecf Miquel Raynal 2018-01-09  2635  	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
02f26ecf Miquel Raynal 2018-01-09  2636  	config.src_addr = r->start + NDDB;
02f26ecf Miquel Raynal 2018-01-09  2637  	config.dst_addr = r->start + NDDB;
02f26ecf Miquel Raynal 2018-01-09  2638  	config.src_maxburst = 32;
02f26ecf Miquel Raynal 2018-01-09  2639  	config.dst_maxburst = 32;
02f26ecf Miquel Raynal 2018-01-09  2640  	ret = dmaengine_slave_config(nfc->dma_chan, &config);
02f26ecf Miquel Raynal 2018-01-09  2641  	if (ret < 0) {
02f26ecf Miquel Raynal 2018-01-09  2642  		dev_err(nfc->dev, "Failed to configure DMA channel\n");
02f26ecf Miquel Raynal 2018-01-09  2643  		return ret;
02f26ecf Miquel Raynal 2018-01-09  2644  	}
02f26ecf Miquel Raynal 2018-01-09  2645  
02f26ecf Miquel Raynal 2018-01-09  2646  	/*
02f26ecf Miquel Raynal 2018-01-09  2647  	 * DMA must act on length multiple of 32 and this length may be
02f26ecf Miquel Raynal 2018-01-09  2648  	 * bigger than the destination buffer. Use this buffer instead
02f26ecf Miquel Raynal 2018-01-09  2649  	 * for DMA transfers and then copy the desired amount of data to
02f26ecf Miquel Raynal 2018-01-09  2650  	 * the provided buffer.
02f26ecf Miquel Raynal 2018-01-09  2651  	 */
c495a927 Miquel Raynal 2018-01-19  2652  	nfc->dma_buf = kmalloc(MAX_CHUNK_SIZE, GFP_KERNEL | GFP_DMA);
02f26ecf Miquel Raynal 2018-01-09  2653  	if (!nfc->dma_buf)
02f26ecf Miquel Raynal 2018-01-09  2654  		return -ENOMEM;
02f26ecf Miquel Raynal 2018-01-09  2655  
02f26ecf Miquel Raynal 2018-01-09  2656  	nfc->use_dma = true;
02f26ecf Miquel Raynal 2018-01-09  2657  
02f26ecf Miquel Raynal 2018-01-09  2658  	return 0;
02f26ecf Miquel Raynal 2018-01-09  2659  }
02f26ecf Miquel Raynal 2018-01-09  2660  

:::::: The code at line 2621 was first introduced by commit
:::::: 02f26ecf8c772751d4b24744d487f6b1b20e75d4 mtd: nand: add reworked Marvell NAND controller driver

:::::: TO: Miquel Raynal <miquel.raynal@free-electrons.com>
:::::: CC: Boris Brezillon <boris.brezillon@free-electrons.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
