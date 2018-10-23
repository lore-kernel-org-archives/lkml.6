Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C98C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB392082B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB392082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeJXBSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:18:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51122 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJXBSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:18:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9NGrkeX055584;
        Tue, 23 Oct 2018 11:53:46 -0500
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9NGrki7101153
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Oct 2018 11:53:46 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 11:53:46 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 11:53:46 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9NGrkqn004480;
        Tue, 23 Oct 2018 11:53:46 -0500
Subject: Re: [PATCH v4 03/17] remoteproc: add release ops in rproc_mem_entry
 struct
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-4-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <90b2b81b-a3e1-fcfc-2a14-64050637d440@ti.com>
Date:   Tue, 23 Oct 2018 11:53:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1532697292-14272-4-git-send-email-loic.pallardy@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/18 8:14 AM, Loic Pallardy wrote:
> Memory entry could be allocated in different ways (ioremap,
> dma_alloc_coherent, internal RAM allocator...).
> This patch introduces a release ops in rproc_mem_entry structure
> to associate dedicated release mechanism to each memory entry descriptor
> in order to keep remoteproc core generic.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
>  drivers/remoteproc/remoteproc_core.c | 23 +++++++++++++++++++++--
>  include/linux/remoteproc.h           |  5 ++++-
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 8e5fe1e..24fe11f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -600,6 +600,24 @@ static int rproc_handle_devmem(struct rproc *rproc, struct fw_rsc_devmem *rsc,
>  }
>  
>  /**
> + * rproc_release_carveout() - release acquired carveout
> + * @rproc: rproc handle
> + * @mem: the memory entry to release
> + *
> + * This function releases specified memory entry @mem allocated via
> + * dma_alloc_coherent() function by @rproc.
> + */
> +static int rproc_release_carveout(struct rproc *rproc,
> +				  struct rproc_mem_entry *mem)
> +{
> +	struct device *dev = &rproc->dev;
> +
> +	/* clean up carveout allocations */
> +	dma_free_coherent(dev->parent, mem->len, mem->va, mem->dma);
> +	return 0;
> +}
> +
> +/**
>   * rproc_handle_carveout() - handle phys contig memory allocation requests
>   * @rproc: rproc handle
>   * @rsc: the resource entry
> @@ -733,6 +751,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  	carveout->len = rsc->len;
>  	carveout->dma = dma;
>  	carveout->da = rsc->da;
> +	carveout->release = rproc_release_carveout;
>  
>  	list_add_tail(&carveout->node, &rproc->carveouts);
>  
> @@ -920,8 +939,8 @@ static void rproc_resource_cleanup(struct rproc *rproc)
>  
>  	/* clean up carveout allocations */
>  	list_for_each_entry_safe(entry, tmp, &rproc->carveouts, node) {
> -		dma_free_coherent(dev->parent, entry->len, entry->va,
> -				  entry->dma);
> +		if (entry->release)
> +			entry->release(rproc, entry);
>  		list_del(&entry->node);
>  		kfree(entry);
>  	}
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e3c5d85..bef2e83 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -305,12 +305,15 @@ struct fw_rsc_vdev {
>  	struct fw_rsc_vdev_vring vring[0];
>  } __packed;
>  
> +struct rproc;
> +
>  /**
>   * struct rproc_mem_entry - memory entry descriptor
>   * @va:	virtual address
>   * @dma: dma address
>   * @len: length, in bytes
>   * @da: device address
> + * @release: release associated memory
>   * @priv: associated data
>   * @node: list node
>   */
> @@ -321,9 +324,9 @@ struct rproc_mem_entry {
>  	u32 da;
>  	void *priv;
>  	struct list_head node;
> +	int (*release)(struct rproc *rproc, struct rproc_mem_entry *mem);
>  };
>  
> -struct rproc;
>  struct firmware;
>  
>  /**
> 

