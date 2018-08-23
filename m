Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BB8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB3E2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="c6cH95k9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB3E2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeHWXfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:35:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33564 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeHWXfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:35:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so5131812ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GWvf8eRZHYoMpg1E9f6Ec0HVlFWRajcB69cnNBYUbPc=;
        b=c6cH95k9Nr7Kx/E0c6PZQodgKCINisxPcaqtr2Vt0FfznKsVTKridQFSGz3Eozk3CJ
         9OgPvCZHmexxMes+cglN5v6rFFYmCjQQ3QwQjZ0fcI7zKEat9U2/e5U8T9AoA1ryJgpW
         1laU9MyPqUTcSHBuOeoijn+OqwiR+TXu5zZQqZRi/6Xtg1Qb20eqhQBkrPQVtwpMYBeG
         dV447qwFxD9vIdR3ftmJCtn46AR0eitGXad+nRRitDNj/u/09C+ql/ahWlSvXl9rndRS
         fuXb1Axd4C1xq+nbk+QUDW1K5R5Kbh+wsHeVzvFHrVAyjzENZ/f1/k2m94YyYJyhvhUX
         gdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GWvf8eRZHYoMpg1E9f6Ec0HVlFWRajcB69cnNBYUbPc=;
        b=d7zN2AO5dOXkTjz0qnrT8svnAL+D36NIBAt3bgWt24vlOVWo4/VHiyFLCmjBOKvsZr
         oGjMl6s41KGswQ/LRVCScmqMgWaEaIt3fr1CTeNyep4v+DLjUxl/31Uw/Iku7EMJ1bU0
         ecmmot81IOEFlM03T7GWrQNW3VScsBys7oW/edzDu6J/uFYXVBgVbTtya3tCIjaQHzQv
         xvshllDIGGp54dksISDtqrnBxLHvo3lNRWiTvk1ZKc3byd6kXGFi4J2GTPXBjaknciqu
         F64do+M3Dh3BdoIMf5GBGVwCbCeJxZO8GZ7zGxp33YsH7TwTir75UPs6arYZa1V0P0rc
         lSAA==
X-Gm-Message-State: AOUpUlFSJWDVw57msHvxm2jcx4wZhfElLXl55PWYyDF/qTW3VnDo5vUa
        0aR57aZ/UMgZOt/UG2Px3SVx4vQpvds=
X-Google-Smtp-Source: AA+uWPwfg1zla6i9RIIDt/H83MlS9lXdv1p5uByxG3/qZobn2CRWAmH1ZrP90lu/JLVy0mFWnm26fQ==
X-Received: by 2002:a2e:1c4:: with SMTP id f65-v6mr37416656lji.58.1535054674384;
        Thu, 23 Aug 2018 13:04:34 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.84.155])
        by smtp.gmail.com with ESMTPSA id b2-v6sm993862lfh.76.2018.08.23.13.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:04:33 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 4.9.y] PCI: OF: Fix I/O space page leak
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org
References: <3e862a05-084a-d732-3060-6e2b234e9718@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <9124e7d1-0802-5f7f-6cba-00239411f09c@cogentembedded.com>
Date:   Thu, 23 Aug 2018 23:04:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <3e862a05-084a-d732-3060-6e2b234e9718@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a5fb9fb023a1435f2b42bccd7f547560f3a21dc3 upstream.

When testing the R-Car PCIe driver on the Condor board, if the PCIe PHY
driver was left disabled, the kernel crashed with this BUG:

  kernel BUG at lib/ioremap.c:72!
  Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 0 PID: 39 Comm: kworker/0:1 Not tainted 4.17.0-dirty #1092
  Hardware name: Renesas Condor board based on r8a77980 (DT)
  Workqueue: events deferred_probe_work_func
  pstate: 80000005 (Nzcv daif -PAN -UAO)
  pc : ioremap_page_range+0x370/0x3c8
  lr : ioremap_page_range+0x40/0x3c8
  sp : ffff000008da39e0
  x29: ffff000008da39e0 x28: 00e8000000000f07
  x27: ffff7dfffee00000 x26: 0140000000000000
  x25: ffff7dfffef00000 x24: 00000000000fe100
  x23: ffff80007b906000 x22: ffff000008ab8000
  x21: ffff000008bb1d58 x20: ffff7dfffef00000
  x19: ffff800009c30fb8 x18: 0000000000000001
  x17: 00000000000152d0 x16: 00000000014012d0
  x15: 0000000000000000 x14: 0720072007200720
  x13: 0720072007200720 x12: 0720072007200720
  x11: 0720072007300730 x10: 00000000000000ae
  x9 : 0000000000000000 x8 : ffff7dffff000000
  x7 : 0000000000000000 x6 : 0000000000000100
  x5 : 0000000000000000 x4 : 000000007b906000
  x3 : ffff80007c61a880 x2 : ffff7dfffeefffff
  x1 : 0000000040000000 x0 : 00e80000fe100f07
  Process kworker/0:1 (pid: 39, stack limit = 0x        (ptrval))
  Call trace:
   ioremap_page_range+0x370/0x3c8
   pci_remap_iospace+0x7c/0xac
   pci_parse_request_of_pci_ranges+0x13c/0x190
   rcar_pcie_probe+0x4c/0xb04
   platform_drv_probe+0x50/0xbc
   driver_probe_device+0x21c/0x308
   __device_attach_driver+0x98/0xc8
   bus_for_each_drv+0x54/0x94
   __device_attach+0xc4/0x12c
   device_initial_probe+0x10/0x18
   bus_probe_device+0x90/0x98
   deferred_probe_work_func+0xb0/0x150
   process_one_work+0x12c/0x29c
   worker_thread+0x200/0x3fc
   kthread+0x108/0x134
   ret_from_fork+0x10/0x18
  Code: f9004ba2 54000080 aa0003fb 17ffff48 (d4210000)

It turned out that pci_remap_iospace() wasn't undone when the driver's
probe failed, and since devm_phy_optional_get() returned -EPROBE_DEFER,
the probe was retried, finally causing the BUG due to trying to remap
already remapped pages.

Introduce the devm_pci_remap_iospace() managed API and replace the
pci_remap_iospace() call with it to fix the bug.

Fixes: dbf9826d5797 ("PCI: generic: Convert to DT resource parsing API")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[lorenzo.pieralisi@arm.com: split commit/updated the commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

---
 drivers/pci/host/pci-host-common.c |    2 -
 drivers/pci/host/pcie-rcar.c       |    2 -
 drivers/pci/pci.c                  |   38 +++++++++++++++++++++++++++++++++++++
 include/linux/pci.h                |    2 +
 4 files changed, 42 insertions(+), 2 deletions(-)

Index: linux-stable/drivers/pci/host/pci-host-common.c
===================================================================
--- linux-stable.orig/drivers/pci/host/pci-host-common.c
+++ linux-stable/drivers/pci/host/pci-host-common.c
@@ -45,7 +45,7 @@ static int gen_pci_parse_request_of_pci_
 
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
-			err = pci_remap_iospace(res, iobase);
+			err = devm_pci_remap_iospace(dev, res, iobase);
 			if (err) {
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 err, res);
Index: linux-stable/drivers/pci/host/pcie-rcar.c
===================================================================
--- linux-stable.orig/drivers/pci/host/pcie-rcar.c
+++ linux-stable/drivers/pci/host/pcie-rcar.c
@@ -1102,7 +1102,7 @@ static int rcar_pcie_parse_request_of_pc
 		struct resource *res = win->res;
 
 		if (resource_type(res) == IORESOURCE_IO) {
-			err = pci_remap_iospace(res, iobase);
+			err = devm_pci_remap_iospace(dev, res, iobase);
 			if (err) {
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 err, res);
Index: linux-stable/drivers/pci/pci.c
===================================================================
--- linux-stable.orig/drivers/pci/pci.c
+++ linux-stable/drivers/pci/pci.c
@@ -3436,6 +3436,44 @@ char * __weak __init pcibios_setup(char
 	return str;
 }
 
+static void devm_pci_unmap_iospace(struct device *dev, void *ptr)
+{
+	struct resource **res = ptr;
+
+	pci_unmap_iospace(*res);
+}
+
+/**
+ * devm_pci_remap_iospace - Managed pci_remap_iospace()
+ * @dev: Generic device to remap IO address for
+ * @res: Resource describing the I/O space
+ * @phys_addr: physical address of range to be mapped
+ *
+ * Managed pci_remap_iospace().  Map is automatically unmapped on driver
+ * detach.
+ */
+int devm_pci_remap_iospace(struct device *dev, const struct resource *res,
+			   phys_addr_t phys_addr)
+{
+	const struct resource **ptr;
+	int error;
+
+	ptr = devres_alloc(devm_pci_unmap_iospace, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	error = pci_remap_iospace(res, phys_addr);
+	if (error) {
+		devres_free(ptr);
+	} else	{
+		*ptr = res;
+		devres_add(dev, ptr);
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(devm_pci_remap_iospace);
+
 /**
  * pcibios_set_master - enable PCI bus-mastering for device dev
  * @dev: the PCI device to enable
Index: linux-stable/include/linux/pci.h
===================================================================
--- linux-stable.orig/include/linux/pci.h
+++ linux-stable/include/linux/pci.h
@@ -1190,6 +1190,8 @@ int pci_register_io_range(phys_addr_t ad
 unsigned long pci_address_to_pio(phys_addr_t addr);
 phys_addr_t pci_pio_to_address(unsigned long pio);
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
+int devm_pci_remap_iospace(struct device *dev, const struct resource *res,
+			   phys_addr_t phys_addr);
 void pci_unmap_iospace(struct resource *res);
 
 static inline pci_bus_addr_t pci_bus_address(struct pci_dev *pdev, int bar)
