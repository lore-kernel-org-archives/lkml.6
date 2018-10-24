Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284C7C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79412082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fH/+991v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79412082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbeJXL1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:27:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40038 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeJXL1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:27:50 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9O31hMF048805;
        Tue, 23 Oct 2018 22:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540350104;
        bh=yWy4rYUCVtW62lFMlqP9Z1ryLNVq6/FIMM9i3lPVJoU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fH/+991vyvDNNWUwUhNOBT9JCZMk4zAazLrxZYpmqnzH/pTjm/g5cSfwHgOm3jeyV
         bqBvci3MTT4iP6Gjquyj3lOWJUOWSk3aSQK+VTmv2tx/CSdiZmsZvQBZHYz9/F9a/+
         ENy/4/dT56BwlpxTMN0GemOjwYYbRlnpiC1kDglY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9O31hsR005971;
        Tue, 23 Oct 2018 22:01:43 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 22:01:42 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 22:01:42 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9O31g8t026230;
        Tue, 23 Oct 2018 22:01:42 -0500
Subject: Re: [PATCH v4 16/17] remoteproc: st: add reserved memory support
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-17-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <369c47bb-6ef1-d694-cf14-39bce87dfd0c@ti.com>
Date:   Tue, 23 Oct 2018 22:01:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1532697292-14272-17-git-send-email-loic.pallardy@st.com>
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
> ST remote processor needs some specified memory regions for
> firmware and IPC.
> Memory regions are defined as reserved memory and should
> be registered in remoteproc core thanks to rproc_add_carveout
> function before rproc_start. For this, st rproc driver implements
> prepare ops.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/st_remoteproc.c | 96 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 85 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
> index aacef0e..45958d5 100644
> --- a/drivers/remoteproc/st_remoteproc.c
> +++ b/drivers/remoteproc/st_remoteproc.c
> @@ -19,6 +19,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
> @@ -91,6 +92,82 @@ static void st_rproc_kick(struct rproc *rproc, int vqid)
>  		dev_err(dev, "failed to send message via mbox: %d\n", ret);
>  }
>  
> +static int st_rproc_mem_alloc(struct rproc *rproc,
> +			      struct rproc_mem_entry *mem)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	void *va;
> +
> +	va = ioremap_wc(mem->dma, mem->len);
> +	if (!va) {
> +		dev_err(dev, "Unable to map memory region: %pa+%zx\n",
> +			&mem->dma, mem->len);
> +		return -ENOMEM;
> +	}
> +
> +	/* Update memory entry va */
> +	mem->va = va;
> +
> +	return 0;
> +}
> +
> +static int st_rproc_mem_release(struct rproc *rproc,
> +				struct rproc_mem_entry *mem)
> +{
> +	iounmap(mem->va);
> +
> +	return 0;
> +}
> +
> +static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	struct device_node *np = dev->of_node;
> +	struct rproc_mem_entry *mem;
> +	void *va;
> +	struct reserved_mem *rmem;
> +	struct of_phandle_iterator it;
> +	int err, index = 0;
> +
> +	of_phandle_iterator_init(&it, np, "memory-region", NULL, 0);
> +	while ((err = of_phandle_iterator_next(&it)) == 0) {
> +		va = NULL;
> +		rmem = of_reserved_mem_lookup(it.node);
> +
> +		/*  No need to map vdev buffer */
> +		if (strcmp(it.node->name, "vdev0buffer")) {
> +			va = devm_ioremap_wc(dev, rmem->base, rmem->size);
> +			if (!va) {
> +				dev_err(dev, "Unable to map memory region: %pa+%zx\n",
> +					&rmem->base, rmem->size);
> +				return -ENOMEM;
> +			}
> +
> +			/* Register memory region */
> +			mem = rproc_mem_entry_init(dev, va,
> +						   (dma_addr_t)rmem->base,
> +						   rmem->size, rmem->base,
> +						   st_rproc_mem_alloc,
> +						   st_rproc_mem_release,

You seem to be double-mapping, first just above to supply the va to
mem_entry_init and then through the alloc function.

This is DT parsing and is fixed irrespective of firmware and only needs
to be done once really in the platform driver probe. I think this whole
logic is unnecessarily complicated in the name of letting the remoteproc
core handle the alloc and free for fixed memory carveouts during every
boot and shutdown, and having to redo the mapping everytime during the
firmware parse. I am not a big fan of overloading the parse_fw to do
this runtime remapping everytime for something that should have been
done once. I think you have done this in your v2, and somewhere along in
v3 got modified into this.

regards
Suman

> +						   it.node->name);
> +		} else {
> +			/* Register reserved memory for vdev buffer allocation */
> +			mem = rproc_of_resm_mem_entry_init(dev, index,
> +							   rmem->size,
> +							   rmem->base,
> +							   it.node->name);
> +		}
> +
> +		if (!mem)
> +			return -ENOMEM;
> +
> +		rproc_add_carveout(rproc, mem);
> +		index++;
> +	}
> +
> +	return rproc_elf_load_rsc_table(rproc, fw);
> +}
> +
>  static int st_rproc_start(struct rproc *rproc)
>  {
>  	struct st_rproc *ddata = rproc->priv;
> @@ -158,9 +235,14 @@ static int st_rproc_stop(struct rproc *rproc)
>  }
>  
>  static const struct rproc_ops st_rproc_ops = {
> -	.kick		= st_rproc_kick,
> -	.start		= st_rproc_start,
> -	.stop		= st_rproc_stop,
> +	.kick			= st_rproc_kick,
> +	.start			= st_rproc_start,
> +	.stop			= st_rproc_stop,
> +	.parse_fw		= st_rproc_parse_fw,
> +	.load			= rproc_elf_load_segments,
> +	.find_loaded_rsc_table	= rproc_elf_find_loaded_rsc_table,
> +	.sanity_check		= rproc_elf_sanity_check,
> +	.get_boot_addr		= rproc_elf_get_boot_addr,
>  };
>  
>  /*
> @@ -254,12 +336,6 @@ static int st_rproc_parse_dt(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	err = of_reserved_mem_device_init(dev);
> -	if (err) {
> -		dev_err(dev, "Failed to obtain shared memory\n");
> -		return err;
> -	}
> -
>  	err = clk_prepare(ddata->clk);
>  	if (err)
>  		dev_err(dev, "failed to get clock\n");
> @@ -387,8 +463,6 @@ static int st_rproc_remove(struct platform_device *pdev)
>  
>  	clk_disable_unprepare(ddata->clk);
>  
> -	of_reserved_mem_device_release(&pdev->dev);
> -
>  	for (i = 0; i < ST_RPROC_MAX_VRING * MBOX_MAX; i++)
>  		mbox_free_channel(ddata->mbox_chan[i]);
>  
> 

