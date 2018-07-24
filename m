Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE43C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE2420874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+5gY9EK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE2420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbeGXVB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:01:26 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46673 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388587AbeGXVB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:01:26 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so2214197ply.13;
        Tue, 24 Jul 2018 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLhvLS5EoQ8CaU1yIPsPgI0PXjzuWGZnxf3ed/tRZVA=;
        b=T+5gY9EKulmN3i+sM+w8CxeDGats7tAVqz990bW6co44aGJnAHAwngZqgco0H2HDuV
         Hsp15fdbKv48/Sv1vR/9Y4ZzLluwRmkjfZ0neo5R/tCWXaGwARW9vTIAP4f61zF9cvfr
         +ZoBU4QhjEA/6glCU02bH0R1vLPOTlYGmCkpB6/2gLUR7kAOLYMFfqN3RUSnmlqF3yEv
         UDNjWQOF8GfY1JQ5ii8WT3Y99RhF5zmmYLse1Ebyc0z8C+g1HJWBMYk6MFAAXQ/TaeA4
         DOGzMw//Lc6Dhf5JVVtySRL96cJ/1gbKZLpSh5wL5YjcsmtC+LmXq5YpbPOloJlxJcQX
         1Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLhvLS5EoQ8CaU1yIPsPgI0PXjzuWGZnxf3ed/tRZVA=;
        b=P/w8L4c3JH4IQxDOG7q8fXLgKJTvylaZxdkTkwiEW3F/3/WJx7WoJBoBq+XzYErYgO
         Hvxaq0KkopFHJ5ledRi8OfhPmpJNYG3/b9jps7CTZ7bPkx9thfI3JkeV71RSU9ESWpy3
         YFQMJY4mB48FqTIeaa7xA0msez4Fu5jb0RCKqbQWjy/0bN4Bc4NT+PBsrBjH1vFxZD4s
         FSM1A7p7KEKk7yTmlFyIgYYYeaFE/pmxrew7GOQF/50A6sS6sS7tfjlER+BiHa17zJ3w
         ffxLgHc1L04iTkGCCE+dAhb2bp4CDaoZ6XqePINKi8w4RIxmv76BbLJLK11fduImYwiq
         VNAA==
X-Gm-Message-State: AOUpUlFJmxQHUgQOUfPdDmhDhuuEp4+zTpIDaWsGeIS1HOLuWSJxodPM
        z0hOXFgOaDJkTiagfgTEMCs=
X-Google-Smtp-Source: AAOMgpeQtDUvvce9BP4YXvS06qQbYur6XHj6RknWPGeINwEMP1jwdOvWl9ZpwVgehwqpMgyfG/9haQ==
X-Received: by 2002:a17:902:d807:: with SMTP id a7-v6mr18097775plz.214.1532462003832;
        Tue, 24 Jul 2018 12:53:23 -0700 (PDT)
Received: from minwooim-desktop ([1.237.242.62])
        by smtp.googlemail.com with ESMTPSA id b62-v6sm34562141pfm.97.2018.07.24.12.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 12:53:22 -0700 (PDT)
Message-ID: <1532461998.20066.5.camel@gmail.com>
Subject: Re: [PATCH v3 2/3] PCI: Samsung SM961/PM961 NVMe disable before FLR
 quirk
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Date:   Wed, 25 Jul 2018 04:53:18 +0900
In-Reply-To: <20180724161440.2729.89835.stgit@gimli.home>
References: <20180724160440.2729.75178.stgit@gimli.home>
         <20180724161440.2729.89835.stgit@gimli.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Tue, 2018-07-24 at 10:14 -0600, Alex Williamson wrote:
> The Samsung SM961/PM961 (960 EVO) sometimes fails to return from FLR
> with the PCI config space reading back as -1.  A reproducible instance
> of this behavior is resolved by clearing the enable bit in the NVMe
> configuration register and waiting for the ready status to clear
> (disabling the NVMe controller) prior to FLR.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/quirks.c |   83
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e72c8742aafa..3899cdd2514b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -28,6 +28,7 @@
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/switchtec.h>
> +#include <linux/nvme.h>
>  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>  #include "pci.h"
>  
> @@ -3669,6 +3670,87 @@ static int reset_chelsio_generic_dev(struct pci_dev
> *dev, int probe)
>  #define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
>  #define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
>  
> +/*
> + * The Samsung SM961/PM961 controller can sometimes enter a fatal state after
> + * FLR where config space reads from the device return -1.  We seem to be
> + * able to avoid this condition if we disable the NVMe controller prior to
> + * FLR.  This quirk is generic for any NVMe class device requiring similar
> + * assistance to quiesce the device prior to FLR.
> + *
> + * NVMe specification: https://nvmexpress.org/resources/specifications/
> + * Revision 1.0e:

It seems too old version of NVMe specification.  Do you have any special reason
to comment the specified 1.0 version instead of 1.3 or something newer?

> + *    Chapter 2: Required and optional PCI config registers
> + *    Chapter 3: NVMe control registers
> + *    Chapter 7.3: Reset behavior
> + */
> +static int nvme_disable_and_flr(struct pci_dev *dev, int probe)

The name of this function seems able to be started with 'reset_' prefix just
like other quirks for reset.
What about reset_samsung_pm961 or something?

> +{
> +	void __iomem *bar;
> +	u16 cmd;
> +	u32 cfg;
> +
> +	if (dev->class != PCI_CLASS_STORAGE_EXPRESS ||
> +	    !pcie_has_flr(dev) || !pci_resource_start(dev, 0))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> +	if (!bar)
> +		return -ENOTTY;
> +
> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> +
> +	cfg = readl(bar + NVME_REG_CC);
> +
> +	/* Disable controller if enabled */
> +	if (cfg & NVME_CC_ENABLE) {
> +		u64 cap = readq(bar + NVME_REG_CAP);
> +		unsigned long timeout;
> +
> +		/*
> +		 * Per nvme_disable_ctrl() skip shutdown notification as it
> +		 * could complete commands to the admin queue.  We only
> intend
> +		 * to quiesce the device before reset.
> +		 */
> +		cfg &= ~(NVME_CC_SHN_MASK | NVME_CC_ENABLE);
> +
> +		writel(cfg, bar + NVME_REG_CC);
> +
> +		/*
> +		 * Some controllers require an additional delay here, see
> +		 * NVME_QUIRK_DELAY_BEFORE_CHK_RDY.  None of those are yet
> +		 * supported by this quirk.
> +		 */
> +
> +		/* Cap register provides max timeout in 500ms increments */
> +		timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
> +
> +		for (;;) {
> +			u32 status = readl(bar + NVME_REG_CSTS);
> +
> +			/* Ready status becomes zero on disable complete */
> +			if (!(status & NVME_CSTS_RDY))
> +				break;
> +
> +			msleep(100);
> +
> +			if (time_after(jiffies, timeout)) {
> +				pci_warn(dev, "Timeout waiting for NVMe ready
> status to clear after disable\n");
> +				break;
> +			}
> +		}
> +	}
> +
> +	pci_iounmap(dev, bar);
> +
> +	pcie_flr(dev);
> +
> +	return 0;
> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -3676,6 +3758,7 @@ static const struct pci_dev_reset_methods
> pci_dev_reset_methods[] = {
>  		reset_ivb_igd },
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
>  		reset_ivb_igd },
> +	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },

Why don't we just define a macro just like other DEVICE_IDs. (e.g.
PCIE_DEVICE_ID_INTEL_82599_SFP_VF).

#define PCI_DEVICE_ID_SAMSUNG_PM961  0xa804

>  	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>  		reset_chelsio_generic_dev },
>  	{ 0 }
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
