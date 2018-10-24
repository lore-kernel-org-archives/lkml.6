Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17930C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5BD2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VlUzy/hP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5BD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeJXLXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:23:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39644 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeJXLXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:23:48 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9O2vhAi047529;
        Tue, 23 Oct 2018 21:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540349863;
        bh=7VM5FF/F0lxmPR+ryEz2lVCDqXSSZM+tePUcVeb/jcE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VlUzy/hPiXzr4cifdqjL22TF4joP1fy5k0HWZmbTbPBrTWc2yzD/P+NSYO2T8Gnsc
         fV56yCqb2pMd+3fe72YBnOXYbg2HJcF3V+ugy/MEnIJG5A1CuKg8GOgVc+KltYTp7k
         QC1AvxCbAvdb9RpBOn4Vbf88nHR/VV32iWBb9cYw=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9O2vhNM003774;
        Tue, 23 Oct 2018 21:57:43 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 21:57:43 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 21:57:43 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9O2vhem025454;
        Tue, 23 Oct 2018 21:57:43 -0500
Subject: Re: [PATCH v4 15/17] remoteproc: da8xx: declare reserved memory
 region for vdev device
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-16-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <d62a0299-1966-887e-05fd-96a26e0aa838@ti.com>
Date:   Tue, 23 Oct 2018 21:57:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1532697292-14272-16-git-send-email-loic.pallardy@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On 7/27/18 8:14 AM, Loic Pallardy wrote:
> This patch introduces da8xx_rproc_parse_fw() to declare a
> carveout region based on reserved memory for vdev buffer
> allocation.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 38 +++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index b668e32..679a076 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -16,6 +16,7 @@
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_address.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
> @@ -179,10 +180,47 @@ static void da8xx_rproc_kick(struct rproc *rproc, int vqid)
>  	writel(SYSCFG_CHIPSIG2, drproc->chipsig);
>  }
>  
> +static int da8xx_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	struct rproc_mem_entry *mem;
> +	struct device_node *node;
> +	struct resource res;
> +	int err;
> +
> +	node = of_parse_phandle(dev->of_node, "memory-region", 0);
> +	if (!node) {
> +		dev_err(dev, "No memory-region specified\n");
> +		return -EINVAL;
> +	}
> +
> +	err = of_address_to_resource(node, 0, &res);
> +	if (err) {
> +		dev_err(dev, "Bad memory-region definition\n");
> +		return err;
> +	}
> +
> +	/* Register memory region for vdev buffer allocation */
> +	mem = rproc_of_resm_mem_entry_init(dev, 0, resource_size(&res),
> +					   res.start, "vdev0buffer");> +
> +	if (!mem)
> +		return -ENOMEM;
> +
> +	rproc_add_carveout(rproc, mem);
> +
> +	return rproc_elf_load_rsc_table(rproc, fw);
> +}

Thanks for the patch, but this creates a kernel crash for me due to
overlaps with manually created carveouts. I currently have a single
memory-region and all allocations come from the same DMA pool, but the
rproc_of_resm_mem_entry_init() creates an overall mem entry without the
va being set (no alloc function plumbed in). In general, it is permitted
to use the same reserved-memory node with multiple devices, so the index
usage should have allowed it to do DMA allocations with vdev devices,
but the loading is performed even before the vdev allocations and the
da_to_va matches the first entry with no va set causing the crash.

Here's my debugfs output of the carveout_memories for reference,

Carveout memory entry:
        Name: vdev0buffer
        Virtual address: 00000000
        DMA address: 0x00000000
        Device address: 0xc3000000
        Length: 0x1000000 Bytes

Carveout memory entry:
        Name: vdev0vring0
        Virtual address: c3000000
        DMA address: 0xc3000000
        Device address: 0xc3000000
        Length: 0x3000 Bytes

Carveout memory entry:
        Name: vdev0vring1
        Virtual address: c3004000
        DMA address: 0xc3004000
        Device address: 0xc3004000
        Length: 0x3000 Bytes

Carveout memory entry:
        Name: DSP_MEM_DATA
        Virtual address: c3100000
        DMA address: 0xc3100000
        Device address: 0xc3100000
        Length: 0xf00000 Bytes

You can drop both this patch and the keystone_remoteproc patch from the
series. I did not run into any issues there since I did not have any
RSC_CARVEOUT entries there. Also, see my comments on the next patch (the
changes in ST) in general regarding these API. Looks like this needs
some more time in ironing out the issues.

regards
Suman



> +
>  static const struct rproc_ops da8xx_rproc_ops = {
>  	.start = da8xx_rproc_start,
>  	.stop = da8xx_rproc_stop,
>  	.kick = da8xx_rproc_kick,
> +	.parse_fw = da8xx_rproc_parse_fw,
> +	.load = rproc_elf_load_segments,
> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> +	.sanity_check = rproc_elf_sanity_check,
> +	.get_boot_addr = rproc_elf_get_boot_addr,
>  };
>  
>  static int da8xx_rproc_get_internal_memories(struct platform_device *pdev,
> 

