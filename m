Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5510CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0383620815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfBCRlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 12:41:17 -0500
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:45237 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726490AbfBCRlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 12:41:17 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4CD30837F27F;
        Sun,  3 Feb 2019 17:41:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lamp09_61eeb6dd3f22e
X-Filterd-Recvd-Size: 30121
Received: from XPS-9350 (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun,  3 Feb 2019 17:41:12 +0000 (UTC)
Message-ID: <557f20daefbf230239849d5dcad59517d27ff26f.camel@perches.com>
Subject: Re: [PATCH] device.h: Add __cold to dev_<level> logging functions
From:   Joe Perches <joe@perches.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 03 Feb 2019 09:41:11 -0800
In-Reply-To: <201902040059.IqLvyYFo%fengguang.wu@intel.com>
References: <f0737d2d4ba1ccbe0e5054d8dad9bb6385fda91f.camel@perches.com>
         <201902040059.IqLvyYFo%fengguang.wu@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-04 at 00:04 +0800, kbuild test robot wrote:
> Hi Joe,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.0-rc4 next-20190201]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Joe-Perches/device-h-Add-__cold-to-dev_-level-logging-functions/20190203-211040
> config: i386-randconfig-c0-01290401 (attached as .config)
> compiler: gcc-8 (Debian 8.2.0-14) 8.2.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

It is a false warning, a somewhat obviously false
positive warning too.

I do wonder why it was produced at all.

Any idea why this warning was produced as the __cold
patch should not cause this new warning to be emitted?

I tested compilation with no warnings with a similar
version of the gcc compiler.

Even with W=123 no warning was emitted here.

> All warnings (new ones prefixed by >>):
> 
>    drivers/staging/axis-fifo/axis-fifo.c: In function 'axis_fifo_probe':
>    drivers/staging/axis-fifo/axis-fifo.c:900:5: warning: 'rxd_tdata_width' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      if (rxd_tdata_width != 32) {
>         ^
> > > drivers/staging/axis-fifo/axis-fifo.c:907:5: warning: 'txd_tdata_width' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
>      if (txd_tdata_width != 32) {
>         ^
>    drivers/staging/axis-fifo/axis-fifo.c:914:5: warning: 'has_tdest' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      if (has_tdest) {
>         ^
> > > drivers/staging/axis-fifo/axis-fifo.c:919:5: warning: 'has_tid' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
>      if (has_tid) {
>         ^
> > > drivers/staging/axis-fifo/axis-fifo.c:924:5: warning: 'has_tkeep' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
>      if (has_tkeep) {
>         ^
> > > drivers/staging/axis-fifo/axis-fifo.c:929:5: warning: 'has_tstrb' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
>      if (has_tstrb) {
>         ^
> > > drivers/staging/axis-fifo/axis-fifo.c:934:5: warning: 'has_tuser' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
>      if (has_tuser) {
>         ^
> > > drivers/staging/axis-fifo/axis-fifo.c:939:5: warning: 'use_rx_cut_through' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
>      if (use_rx_cut_through) {
>         ^
> > > drivers/staging/axis-fifo/axis-fifo.c:944:5: warning: 'use_tx_cut_through' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
>      if (use_tx_cut_through) {
>         ^
> > > drivers/staging/axis-fifo/axis-fifo.c:949:5: warning: 'use_tx_control' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
>      if (use_tx_control) {
>         ^
>    drivers/staging/axis-fifo/axis-fifo.c:962:22: warning: 'rx_fifo_depth' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      fifo->rx_fifo_depth = rx_fifo_depth;
>      ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
>    drivers/staging/axis-fifo/axis-fifo.c:964:38: warning: 'tx_fifo_depth' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      fifo->tx_fifo_depth = tx_fifo_depth - 4;
>                            ~~~~~~~~~~~~~~^~~
>    drivers/staging/axis-fifo/axis-fifo.c:965:20: warning: 'use_rx_data' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      fifo->has_rx_fifo = use_rx_data;
>      ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
>    drivers/staging/axis-fifo/axis-fifo.c:966:20: warning: 'use_tx_data' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      fifo->has_tx_fifo = use_tx_data;
>      ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
> 
> vim +/txd_tdata_width +907 drivers/staging/axis-fifo/axis-fifo.c
> 
> 4a965c5f8 Jacob Feder 2018-07-22   703  
> 4a965c5f8 Jacob Feder 2018-07-22   704  static int axis_fifo_probe(struct platform_device *pdev)
> 4a965c5f8 Jacob Feder 2018-07-22   705  {
> 4a965c5f8 Jacob Feder 2018-07-22   706  	struct resource *r_irq; /* interrupt resources */
> 4a965c5f8 Jacob Feder 2018-07-22   707  	struct resource *r_mem; /* IO mem resources */
> 4a965c5f8 Jacob Feder 2018-07-22   708  	struct device *dev = &pdev->dev; /* OS device (from device tree) */
> 4a965c5f8 Jacob Feder 2018-07-22   709  	struct axis_fifo *fifo = NULL;
> 4a965c5f8 Jacob Feder 2018-07-22   710  
> 4a965c5f8 Jacob Feder 2018-07-22   711  	char device_name[32];
> 4a965c5f8 Jacob Feder 2018-07-22   712  
> 4a965c5f8 Jacob Feder 2018-07-22   713  	int rc = 0; /* error return value */
> 4a965c5f8 Jacob Feder 2018-07-22   714  
> 4a965c5f8 Jacob Feder 2018-07-22   715  	/* IP properties from device tree */
> 4a965c5f8 Jacob Feder 2018-07-22   716  	unsigned int rxd_tdata_width;
> 4a965c5f8 Jacob Feder 2018-07-22   717  	unsigned int txc_tdata_width;
> 4a965c5f8 Jacob Feder 2018-07-22   718  	unsigned int txd_tdata_width;
> 4a965c5f8 Jacob Feder 2018-07-22   719  	unsigned int tdest_width;
> 4a965c5f8 Jacob Feder 2018-07-22   720  	unsigned int tid_width;
> 4a965c5f8 Jacob Feder 2018-07-22   721  	unsigned int tuser_width;
> 4a965c5f8 Jacob Feder 2018-07-22   722  	unsigned int data_interface_type;
> 4a965c5f8 Jacob Feder 2018-07-22   723  	unsigned int has_tdest;
> 4a965c5f8 Jacob Feder 2018-07-22   724  	unsigned int has_tid;
> 4a965c5f8 Jacob Feder 2018-07-22   725  	unsigned int has_tkeep;
> 4a965c5f8 Jacob Feder 2018-07-22   726  	unsigned int has_tstrb;
> 4a965c5f8 Jacob Feder 2018-07-22   727  	unsigned int has_tuser;
> 4a965c5f8 Jacob Feder 2018-07-22   728  	unsigned int rx_fifo_depth;
> 4a965c5f8 Jacob Feder 2018-07-22   729  	unsigned int rx_programmable_empty_threshold;
> 4a965c5f8 Jacob Feder 2018-07-22   730  	unsigned int rx_programmable_full_threshold;
> 4a965c5f8 Jacob Feder 2018-07-22   731  	unsigned int axi_id_width;
> 4a965c5f8 Jacob Feder 2018-07-22   732  	unsigned int axi4_data_width;
> 4a965c5f8 Jacob Feder 2018-07-22   733  	unsigned int select_xpm;
> 4a965c5f8 Jacob Feder 2018-07-22   734  	unsigned int tx_fifo_depth;
> 4a965c5f8 Jacob Feder 2018-07-22   735  	unsigned int tx_programmable_empty_threshold;
> 4a965c5f8 Jacob Feder 2018-07-22   736  	unsigned int tx_programmable_full_threshold;
> 4a965c5f8 Jacob Feder 2018-07-22   737  	unsigned int use_rx_cut_through;
> 4a965c5f8 Jacob Feder 2018-07-22   738  	unsigned int use_rx_data;
> 4a965c5f8 Jacob Feder 2018-07-22   739  	unsigned int use_tx_control;
> 4a965c5f8 Jacob Feder 2018-07-22   740  	unsigned int use_tx_cut_through;
> 4a965c5f8 Jacob Feder 2018-07-22   741  	unsigned int use_tx_data;
> 4a965c5f8 Jacob Feder 2018-07-22   742  
> 4a965c5f8 Jacob Feder 2018-07-22   743  	/* ----------------------------
> 4a965c5f8 Jacob Feder 2018-07-22   744  	 *     init wrapper device
> 4a965c5f8 Jacob Feder 2018-07-22   745  	 * ----------------------------
> 4a965c5f8 Jacob Feder 2018-07-22   746  	 */
> 4a965c5f8 Jacob Feder 2018-07-22   747  
> 4a965c5f8 Jacob Feder 2018-07-22   748  	/* allocate device wrapper memory */
> 4a965c5f8 Jacob Feder 2018-07-22   749  	fifo = devm_kmalloc(dev, sizeof(*fifo), GFP_KERNEL);
> 4a965c5f8 Jacob Feder 2018-07-22   750  	if (!fifo)
> 4a965c5f8 Jacob Feder 2018-07-22   751  		return -ENOMEM;
> 4a965c5f8 Jacob Feder 2018-07-22   752  
> 4a965c5f8 Jacob Feder 2018-07-22   753  	dev_set_drvdata(dev, fifo);
> 4a965c5f8 Jacob Feder 2018-07-22   754  	fifo->dt_device = dev;
> 4a965c5f8 Jacob Feder 2018-07-22   755  
> 4a965c5f8 Jacob Feder 2018-07-22   756  	init_waitqueue_head(&fifo->read_queue);
> 4a965c5f8 Jacob Feder 2018-07-22   757  	init_waitqueue_head(&fifo->write_queue);
> 4a965c5f8 Jacob Feder 2018-07-22   758  
> 4a965c5f8 Jacob Feder 2018-07-22   759  	spin_lock_init(&fifo->read_queue_lock);
> 4a965c5f8 Jacob Feder 2018-07-22   760  	spin_lock_init(&fifo->write_queue_lock);
> 4a965c5f8 Jacob Feder 2018-07-22   761  
> 4a965c5f8 Jacob Feder 2018-07-22   762  	/* ----------------------------
> 4a965c5f8 Jacob Feder 2018-07-22   763  	 *   init device memory space
> 4a965c5f8 Jacob Feder 2018-07-22   764  	 * ----------------------------
> 4a965c5f8 Jacob Feder 2018-07-22   765  	 */
> 4a965c5f8 Jacob Feder 2018-07-22   766  
> 4a965c5f8 Jacob Feder 2018-07-22   767  	/* get iospace for the device */
> 4a965c5f8 Jacob Feder 2018-07-22   768  	r_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 4a965c5f8 Jacob Feder 2018-07-22   769  	if (!r_mem) {
> 4a965c5f8 Jacob Feder 2018-07-22   770  		dev_err(fifo->dt_device, "invalid address\n");
> 4a965c5f8 Jacob Feder 2018-07-22   771  		rc = -ENODEV;
> 4a965c5f8 Jacob Feder 2018-07-22   772  		goto err_initial;
> 4a965c5f8 Jacob Feder 2018-07-22   773  	}
> 4a965c5f8 Jacob Feder 2018-07-22   774  
> 4a965c5f8 Jacob Feder 2018-07-22   775  	fifo->mem = r_mem;
> 4a965c5f8 Jacob Feder 2018-07-22   776  
> 4a965c5f8 Jacob Feder 2018-07-22   777  	/* request physical memory */
> 4a965c5f8 Jacob Feder 2018-07-22   778  	if (!request_mem_region(fifo->mem->start, resource_size(fifo->mem),
> 4a965c5f8 Jacob Feder 2018-07-22   779  				DRIVER_NAME)) {
> 4a965c5f8 Jacob Feder 2018-07-22   780  		dev_err(fifo->dt_device,
> 4a965c5f8 Jacob Feder 2018-07-22   781  			"couldn't lock memory region at 0x%pa\n",
> 4a965c5f8 Jacob Feder 2018-07-22   782  			&fifo->mem->start);
> 4a965c5f8 Jacob Feder 2018-07-22   783  		rc = -EBUSY;
> 4a965c5f8 Jacob Feder 2018-07-22   784  		goto err_initial;
> 4a965c5f8 Jacob Feder 2018-07-22   785  	}
> 4a965c5f8 Jacob Feder 2018-07-22   786  	dev_dbg(fifo->dt_device, "got memory location [0x%pa - 0x%pa]\n",
> 4a965c5f8 Jacob Feder 2018-07-22   787  		&fifo->mem->start, &fifo->mem->end);
> 4a965c5f8 Jacob Feder 2018-07-22   788  
> 4a965c5f8 Jacob Feder 2018-07-22   789  	/* map physical memory to kernel virtual address space */
> 4a965c5f8 Jacob Feder 2018-07-22   790  	fifo->base_addr = ioremap(fifo->mem->start, resource_size(fifo->mem));
> 4a965c5f8 Jacob Feder 2018-07-22   791  	if (!fifo->base_addr) {
> 4a965c5f8 Jacob Feder 2018-07-22   792  		dev_err(fifo->dt_device, "couldn't map physical memory\n");
> 4a965c5f8 Jacob Feder 2018-07-22   793  		rc = -ENOMEM;
> 4a965c5f8 Jacob Feder 2018-07-22   794  		goto err_mem;
> 4a965c5f8 Jacob Feder 2018-07-22   795  	}
> 4a965c5f8 Jacob Feder 2018-07-22   796  	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
> 4a965c5f8 Jacob Feder 2018-07-22   797  
> 4a965c5f8 Jacob Feder 2018-07-22   798  	/* create unique device name */
> 4a965c5f8 Jacob Feder 2018-07-22   799  	snprintf(device_name, sizeof(device_name), "%s_%pa",
> 4a965c5f8 Jacob Feder 2018-07-22   800  		 DRIVER_NAME, &fifo->mem->start);
> 4a965c5f8 Jacob Feder 2018-07-22   801  
> 4a965c5f8 Jacob Feder 2018-07-22   802  	dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
> 4a965c5f8 Jacob Feder 2018-07-22   803  
> 4a965c5f8 Jacob Feder 2018-07-22   804  	/* ----------------------------
> 4a965c5f8 Jacob Feder 2018-07-22   805  	 *          init IP
> 4a965c5f8 Jacob Feder 2018-07-22   806  	 * ----------------------------
> 4a965c5f8 Jacob Feder 2018-07-22   807  	 */
> 4a965c5f8 Jacob Feder 2018-07-22   808  
> 4a965c5f8 Jacob Feder 2018-07-22   809  	/* retrieve device tree properties */
> 4a965c5f8 Jacob Feder 2018-07-22   810  	rc = get_dts_property(fifo, "xlnx,axi-str-rxd-tdata-width",
> 4a965c5f8 Jacob Feder 2018-07-22   811  			      &rxd_tdata_width);
> 4a965c5f8 Jacob Feder 2018-07-22   812  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   813  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   814  	rc = get_dts_property(fifo, "xlnx,axi-str-txc-tdata-width",
> 4a965c5f8 Jacob Feder 2018-07-22   815  			      &txc_tdata_width);
> 4a965c5f8 Jacob Feder 2018-07-22   816  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   817  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   818  	rc = get_dts_property(fifo, "xlnx,axi-str-txd-tdata-width",
> 4a965c5f8 Jacob Feder 2018-07-22   819  			      &txd_tdata_width);
> 4a965c5f8 Jacob Feder 2018-07-22   820  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   821  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   822  	rc = get_dts_property(fifo, "xlnx,axis-tdest-width", &tdest_width);
> 4a965c5f8 Jacob Feder 2018-07-22   823  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   824  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   825  	rc = get_dts_property(fifo, "xlnx,axis-tid-width", &tid_width);
> 4a965c5f8 Jacob Feder 2018-07-22   826  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   827  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   828  	rc = get_dts_property(fifo, "xlnx,axis-tuser-width", &tuser_width);
> 4a965c5f8 Jacob Feder 2018-07-22   829  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   830  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   831  	rc = get_dts_property(fifo, "xlnx,data-interface-type",
> 4a965c5f8 Jacob Feder 2018-07-22   832  			      &data_interface_type);
> 4a965c5f8 Jacob Feder 2018-07-22   833  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   834  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   835  	rc = get_dts_property(fifo, "xlnx,has-axis-tdest", &has_tdest);
> 4a965c5f8 Jacob Feder 2018-07-22   836  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   837  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   838  	rc = get_dts_property(fifo, "xlnx,has-axis-tid", &has_tid);
> 4a965c5f8 Jacob Feder 2018-07-22   839  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   840  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   841  	rc = get_dts_property(fifo, "xlnx,has-axis-tkeep", &has_tkeep);
> 4a965c5f8 Jacob Feder 2018-07-22   842  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   843  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   844  	rc = get_dts_property(fifo, "xlnx,has-axis-tstrb", &has_tstrb);
> 4a965c5f8 Jacob Feder 2018-07-22   845  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   846  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   847  	rc = get_dts_property(fifo, "xlnx,has-axis-tuser", &has_tuser);
> 4a965c5f8 Jacob Feder 2018-07-22   848  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   849  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   850  	rc = get_dts_property(fifo, "xlnx,rx-fifo-depth", &rx_fifo_depth);
> 4a965c5f8 Jacob Feder 2018-07-22   851  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   852  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   853  	rc = get_dts_property(fifo, "xlnx,rx-fifo-pe-threshold",
> 4a965c5f8 Jacob Feder 2018-07-22   854  			      &rx_programmable_empty_threshold);
> 4a965c5f8 Jacob Feder 2018-07-22   855  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   856  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   857  	rc = get_dts_property(fifo, "xlnx,rx-fifo-pf-threshold",
> 4a965c5f8 Jacob Feder 2018-07-22   858  			      &rx_programmable_full_threshold);
> 4a965c5f8 Jacob Feder 2018-07-22   859  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   860  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   861  	rc = get_dts_property(fifo, "xlnx,s-axi-id-width", &axi_id_width);
> 4a965c5f8 Jacob Feder 2018-07-22   862  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   863  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   864  	rc = get_dts_property(fifo, "xlnx,s-axi4-data-width", &axi4_data_width);
> 4a965c5f8 Jacob Feder 2018-07-22   865  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   866  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   867  	rc = get_dts_property(fifo, "xlnx,select-xpm", &select_xpm);
> 4a965c5f8 Jacob Feder 2018-07-22   868  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   869  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   870  	rc = get_dts_property(fifo, "xlnx,tx-fifo-depth", &tx_fifo_depth);
> 4a965c5f8 Jacob Feder 2018-07-22   871  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   872  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   873  	rc = get_dts_property(fifo, "xlnx,tx-fifo-pe-threshold",
> 4a965c5f8 Jacob Feder 2018-07-22   874  			      &tx_programmable_empty_threshold);
> 4a965c5f8 Jacob Feder 2018-07-22   875  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   876  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   877  	rc = get_dts_property(fifo, "xlnx,tx-fifo-pf-threshold",
> 4a965c5f8 Jacob Feder 2018-07-22   878  			      &tx_programmable_full_threshold);
> 4a965c5f8 Jacob Feder 2018-07-22   879  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   880  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   881  	rc = get_dts_property(fifo, "xlnx,use-rx-cut-through",
> 4a965c5f8 Jacob Feder 2018-07-22   882  			      &use_rx_cut_through);
> 4a965c5f8 Jacob Feder 2018-07-22   883  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   884  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   885  	rc = get_dts_property(fifo, "xlnx,use-rx-data", &use_rx_data);
> 4a965c5f8 Jacob Feder 2018-07-22   886  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   887  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   888  	rc = get_dts_property(fifo, "xlnx,use-tx-ctrl", &use_tx_control);
> 4a965c5f8 Jacob Feder 2018-07-22   889  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   890  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   891  	rc = get_dts_property(fifo, "xlnx,use-tx-cut-through",
> 4a965c5f8 Jacob Feder 2018-07-22   892  			      &use_tx_cut_through);
> 4a965c5f8 Jacob Feder 2018-07-22   893  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   894  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   895  	rc = get_dts_property(fifo, "xlnx,use-tx-data", &use_tx_data);
> 4a965c5f8 Jacob Feder 2018-07-22   896  	if (rc)
> 4a965c5f8 Jacob Feder 2018-07-22   897  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   898  
> 4a965c5f8 Jacob Feder 2018-07-22   899  	/* check validity of device tree properties */
> 4a965c5f8 Jacob Feder 2018-07-22  @900  	if (rxd_tdata_width != 32) {
> 4a965c5f8 Jacob Feder 2018-07-22   901  		dev_err(fifo->dt_device,
> 4a965c5f8 Jacob Feder 2018-07-22   902  			"rxd_tdata_width width [%u] unsupported\n",
> 4a965c5f8 Jacob Feder 2018-07-22   903  			rxd_tdata_width);
> 4a965c5f8 Jacob Feder 2018-07-22   904  		rc = -EIO;
> 4a965c5f8 Jacob Feder 2018-07-22   905  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   906  	}
> 4a965c5f8 Jacob Feder 2018-07-22  @907  	if (txd_tdata_width != 32) {
> 4a965c5f8 Jacob Feder 2018-07-22   908  		dev_err(fifo->dt_device,
> 4a965c5f8 Jacob Feder 2018-07-22   909  			"txd_tdata_width width [%u] unsupported\n",
> 4a965c5f8 Jacob Feder 2018-07-22   910  			txd_tdata_width);
> 4a965c5f8 Jacob Feder 2018-07-22   911  		rc = -EIO;
> 4a965c5f8 Jacob Feder 2018-07-22   912  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   913  	}
> 4a965c5f8 Jacob Feder 2018-07-22  @914  	if (has_tdest) {
> 4a965c5f8 Jacob Feder 2018-07-22   915  		dev_err(fifo->dt_device, "tdest not supported\n");
> 4a965c5f8 Jacob Feder 2018-07-22   916  		rc = -EIO;
> 4a965c5f8 Jacob Feder 2018-07-22   917  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   918  	}
> 4a965c5f8 Jacob Feder 2018-07-22  @919  	if (has_tid) {
> 4a965c5f8 Jacob Feder 2018-07-22   920  		dev_err(fifo->dt_device, "tid not supported\n");
> 4a965c5f8 Jacob Feder 2018-07-22   921  		rc = -EIO;
> 4a965c5f8 Jacob Feder 2018-07-22   922  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   923  	}
> 4a965c5f8 Jacob Feder 2018-07-22  @924  	if (has_tkeep) {
> 4a965c5f8 Jacob Feder 2018-07-22   925  		dev_err(fifo->dt_device, "tkeep not supported\n");
> 4a965c5f8 Jacob Feder 2018-07-22   926  		rc = -EIO;
> 4a965c5f8 Jacob Feder 2018-07-22   927  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   928  	}
> 4a965c5f8 Jacob Feder 2018-07-22  @929  	if (has_tstrb) {
> 4a965c5f8 Jacob Feder 2018-07-22   930  		dev_err(fifo->dt_device, "tstrb not supported\n");
> 4a965c5f8 Jacob Feder 2018-07-22   931  		rc = -EIO;
> 4a965c5f8 Jacob Feder 2018-07-22   932  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   933  	}
> 4a965c5f8 Jacob Feder 2018-07-22  @934  	if (has_tuser) {
> 4a965c5f8 Jacob Feder 2018-07-22   935  		dev_err(fifo->dt_device, "tuser not supported\n");
> 4a965c5f8 Jacob Feder 2018-07-22   936  		rc = -EIO;
> 4a965c5f8 Jacob Feder 2018-07-22   937  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   938  	}
> 4a965c5f8 Jacob Feder 2018-07-22  @939  	if (use_rx_cut_through) {
> 4a965c5f8 Jacob Feder 2018-07-22   940  		dev_err(fifo->dt_device, "rx cut-through not supported\n");
> 4a965c5f8 Jacob Feder 2018-07-22   941  		rc = -EIO;
> 4a965c5f8 Jacob Feder 2018-07-22   942  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   943  	}
> 4a965c5f8 Jacob Feder 2018-07-22  @944  	if (use_tx_cut_through) {
> 4a965c5f8 Jacob Feder 2018-07-22   945  		dev_err(fifo->dt_device, "tx cut-through not supported\n");
> 4a965c5f8 Jacob Feder 2018-07-22   946  		rc = -EIO;
> 4a965c5f8 Jacob Feder 2018-07-22   947  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   948  	}
> 4a965c5f8 Jacob Feder 2018-07-22  @949  	if (use_tx_control) {
> 4a965c5f8 Jacob Feder 2018-07-22   950  		dev_err(fifo->dt_device, "tx control not supported\n");
> 4a965c5f8 Jacob Feder 2018-07-22   951  		rc = -EIO;
> 4a965c5f8 Jacob Feder 2018-07-22   952  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   953  	}
> 4a965c5f8 Jacob Feder 2018-07-22   954  
> 4a965c5f8 Jacob Feder 2018-07-22   955  	/* TODO
> 4a965c5f8 Jacob Feder 2018-07-22   956  	 * these exist in the device tree but it's unclear what they do
> 4a965c5f8 Jacob Feder 2018-07-22   957  	 * - select-xpm
> 4a965c5f8 Jacob Feder 2018-07-22   958  	 * - data-interface-type
> 4a965c5f8 Jacob Feder 2018-07-22   959  	 */
> 4a965c5f8 Jacob Feder 2018-07-22   960  
> 4a965c5f8 Jacob Feder 2018-07-22   961  	/* set device wrapper properties based on IP config */
> 4a965c5f8 Jacob Feder 2018-07-22   962  	fifo->rx_fifo_depth = rx_fifo_depth;
> 4a965c5f8 Jacob Feder 2018-07-22   963  	/* IP sets TDFV to fifo depth - 4 so we will do the same */
> 4a965c5f8 Jacob Feder 2018-07-22   964  	fifo->tx_fifo_depth = tx_fifo_depth - 4;
> 4a965c5f8 Jacob Feder 2018-07-22   965  	fifo->has_rx_fifo = use_rx_data;
> 4a965c5f8 Jacob Feder 2018-07-22   966  	fifo->has_tx_fifo = use_tx_data;
> 4a965c5f8 Jacob Feder 2018-07-22   967  
> 4a965c5f8 Jacob Feder 2018-07-22   968  	reset_ip_core(fifo);
> 4a965c5f8 Jacob Feder 2018-07-22   969  
> 4a965c5f8 Jacob Feder 2018-07-22   970  	/* ----------------------------
> 4a965c5f8 Jacob Feder 2018-07-22   971  	 *    init device interrupts
> 4a965c5f8 Jacob Feder 2018-07-22   972  	 * ----------------------------
> 4a965c5f8 Jacob Feder 2018-07-22   973  	 */
> 4a965c5f8 Jacob Feder 2018-07-22   974  
> 4a965c5f8 Jacob Feder 2018-07-22   975  	/* get IRQ resource */
> 4a965c5f8 Jacob Feder 2018-07-22   976  	r_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> 4a965c5f8 Jacob Feder 2018-07-22   977  	if (!r_irq) {
> 4a965c5f8 Jacob Feder 2018-07-22   978  		dev_err(fifo->dt_device, "no IRQ found for 0x%pa\n",
> 4a965c5f8 Jacob Feder 2018-07-22   979  			&fifo->mem->start);
> 4a965c5f8 Jacob Feder 2018-07-22   980  		rc = -EIO;
> 4a965c5f8 Jacob Feder 2018-07-22   981  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   982  	}
> 4a965c5f8 Jacob Feder 2018-07-22   983  
> 4a965c5f8 Jacob Feder 2018-07-22   984  	/* request IRQ */
> 4a965c5f8 Jacob Feder 2018-07-22   985  	fifo->irq = r_irq->start;
> 4a965c5f8 Jacob Feder 2018-07-22   986  	rc = request_irq(fifo->irq, &axis_fifo_irq, 0, DRIVER_NAME, fifo);
> 4a965c5f8 Jacob Feder 2018-07-22   987  	if (rc) {
> 4a965c5f8 Jacob Feder 2018-07-22   988  		dev_err(fifo->dt_device, "couldn't allocate interrupt %i\n",
> 4a965c5f8 Jacob Feder 2018-07-22   989  			fifo->irq);
> 4a965c5f8 Jacob Feder 2018-07-22   990  		goto err_unmap;
> 4a965c5f8 Jacob Feder 2018-07-22   991  	}
> 4a965c5f8 Jacob Feder 2018-07-22   992  
> 4a965c5f8 Jacob Feder 2018-07-22   993  	/* ----------------------------
> 4a965c5f8 Jacob Feder 2018-07-22   994  	 *      init char device
> 4a965c5f8 Jacob Feder 2018-07-22   995  	 * ----------------------------
> 4a965c5f8 Jacob Feder 2018-07-22   996  	 */
> 4a965c5f8 Jacob Feder 2018-07-22   997  
> 4a965c5f8 Jacob Feder 2018-07-22   998  	/* allocate device number */
> 4a965c5f8 Jacob Feder 2018-07-22   999  	rc = alloc_chrdev_region(&fifo->devt, 0, 1, DRIVER_NAME);
> 4a965c5f8 Jacob Feder 2018-07-22  1000  	if (rc < 0)
> 4a965c5f8 Jacob Feder 2018-07-22  1001  		goto err_irq;
> 4a965c5f8 Jacob Feder 2018-07-22  1002  	dev_dbg(fifo->dt_device, "allocated device number major %i minor %i\n",
> 4a965c5f8 Jacob Feder 2018-07-22  1003  		MAJOR(fifo->devt), MINOR(fifo->devt));
> 4a965c5f8 Jacob Feder 2018-07-22  1004  
> 4a965c5f8 Jacob Feder 2018-07-22  1005  	/* create driver file */
> 4a965c5f8 Jacob Feder 2018-07-22  1006  	fifo->device = device_create(axis_fifo_driver_class, NULL, fifo->devt,
> 4a965c5f8 Jacob Feder 2018-07-22  1007  				     NULL, device_name);
> 6d4abf1c0 Wei Yongjun 2018-07-27  1008  	if (IS_ERR(fifo->device)) {
> 4a965c5f8 Jacob Feder 2018-07-22  1009  		dev_err(fifo->dt_device,
> 4a965c5f8 Jacob Feder 2018-07-22  1010  			"couldn't create driver file\n");
> 6d4abf1c0 Wei Yongjun 2018-07-27  1011  		rc = PTR_ERR(fifo->device);
> 4a965c5f8 Jacob Feder 2018-07-22  1012  		goto err_chrdev_region;
> 4a965c5f8 Jacob Feder 2018-07-22  1013  	}
> 4a965c5f8 Jacob Feder 2018-07-22  1014  	dev_set_drvdata(fifo->device, fifo);
> 4a965c5f8 Jacob Feder 2018-07-22  1015  
> 4a965c5f8 Jacob Feder 2018-07-22  1016  	/* create character device */
> 4a965c5f8 Jacob Feder 2018-07-22  1017  	cdev_init(&fifo->char_device, &fops);
> 4a965c5f8 Jacob Feder 2018-07-22  1018  	rc = cdev_add(&fifo->char_device, fifo->devt, 1);
> 4a965c5f8 Jacob Feder 2018-07-22  1019  	if (rc < 0) {
> 4a965c5f8 Jacob Feder 2018-07-22  1020  		dev_err(fifo->dt_device, "couldn't create character device\n");
> 4a965c5f8 Jacob Feder 2018-07-22  1021  		goto err_dev;
> 4a965c5f8 Jacob Feder 2018-07-22  1022  	}
> 4a965c5f8 Jacob Feder 2018-07-22  1023  
> 4a965c5f8 Jacob Feder 2018-07-22  1024  	/* create sysfs entries */
> 4a965c5f8 Jacob Feder 2018-07-22  1025  	rc = sysfs_create_group(&fifo->device->kobj, &axis_fifo_attrs_group);
> 4a965c5f8 Jacob Feder 2018-07-22  1026  	if (rc < 0) {
> 4a965c5f8 Jacob Feder 2018-07-22  1027  		dev_err(fifo->dt_device, "couldn't register sysfs group\n");
> 4a965c5f8 Jacob Feder 2018-07-22  1028  		goto err_cdev;
> 4a965c5f8 Jacob Feder 2018-07-22  1029  	}
> 4a965c5f8 Jacob Feder 2018-07-22  1030  
> 4a965c5f8 Jacob Feder 2018-07-22  1031  	dev_info(fifo->dt_device, "axis-fifo created at %pa mapped to 0x%pa, irq=%i, major=%i, minor=%i\n",
> 4a965c5f8 Jacob Feder 2018-07-22  1032  		 &fifo->mem->start, &fifo->base_addr, fifo->irq,
> 4a965c5f8 Jacob Feder 2018-07-22  1033  		 MAJOR(fifo->devt), MINOR(fifo->devt));
> 4a965c5f8 Jacob Feder 2018-07-22  1034  
> 4a965c5f8 Jacob Feder 2018-07-22  1035  	return 0;
> 4a965c5f8 Jacob Feder 2018-07-22  1036  
> 4a965c5f8 Jacob Feder 2018-07-22  1037  err_cdev:
> 4a965c5f8 Jacob Feder 2018-07-22  1038  	cdev_del(&fifo->char_device);
> 4a965c5f8 Jacob Feder 2018-07-22  1039  err_dev:
> 4a965c5f8 Jacob Feder 2018-07-22  1040  	device_destroy(axis_fifo_driver_class, fifo->devt);
> 4a965c5f8 Jacob Feder 2018-07-22  1041  err_chrdev_region:
> 4a965c5f8 Jacob Feder 2018-07-22  1042  	unregister_chrdev_region(fifo->devt, 1);
> 4a965c5f8 Jacob Feder 2018-07-22  1043  err_irq:
> 4a965c5f8 Jacob Feder 2018-07-22  1044  	free_irq(fifo->irq, fifo);
> 4a965c5f8 Jacob Feder 2018-07-22  1045  err_unmap:
> 4a965c5f8 Jacob Feder 2018-07-22  1046  	iounmap(fifo->base_addr);
> 4a965c5f8 Jacob Feder 2018-07-22  1047  err_mem:
> 4a965c5f8 Jacob Feder 2018-07-22  1048  	release_mem_region(fifo->mem->start, resource_size(fifo->mem));
> 4a965c5f8 Jacob Feder 2018-07-22  1049  err_initial:
> 4a965c5f8 Jacob Feder 2018-07-22  1050  	dev_set_drvdata(dev, NULL);
> 4a965c5f8 Jacob Feder 2018-07-22  1051  	return rc;
> 4a965c5f8 Jacob Feder 2018-07-22  1052  }
> 4a965c5f8 Jacob Feder 2018-07-22  1053  
> 
> :::::: The code at line 907 was first introduced by commit
> :::::: 4a965c5f89decd636129cddc47e5f2c61e8f13e6 staging: add driver for Xilinx AXI-Stream FIFO v4.1 IP core
> 
> :::::: TO: Jacob Feder <jacobsfeder@gmail.com>
> :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

