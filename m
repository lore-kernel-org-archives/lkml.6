Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B0BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B0620852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bvV00rYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B0620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbeGYVkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:40:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59444 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730536AbeGYVkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:40:32 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6PKRAr1018025;
        Wed, 25 Jul 2018 15:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532550430;
        bh=DAQEMApjfH+/47sZA7yp1eU6RoqPHuwR+IkemIvvo4o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bvV00rYYM/h16lfLkC8KwY+T1pcj+1UW5PtuJ+v2wXqhIlbey31Y0FwDI0G1cjTZ7
         Sm+okQnPium5rEAbX3rmQu9eAkjxztLNVQW5DszXYxoGV8+IirDRamCMlNSwaNgGgm
         7NaG5Uvwl4WAG/mt45AEi6jeudoEvKpUIrmwK98k=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6PKRA7R009059;
        Wed, 25 Jul 2018 15:27:10 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 25
 Jul 2018 15:27:09 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 25 Jul 2018 15:27:09 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6PKR9qm026396;
        Wed, 25 Jul 2018 15:27:09 -0500
Subject: Re: [PATCH 1/1] remoteproc: replace "%p" with "%pK"
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>
References: <1530880707-29333-1-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <4ca468d8-046e-b7ee-1505-f7d0e85c5101@ti.com>
Date:   Wed, 25 Jul 2018 15:27:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1530880707-29333-1-git-send-email-loic.pallardy@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 07:38 AM, Loic Pallardy wrote:
> The format specifier "%p" can leak kernel addresses.
> Use "%pK" instead.
> 
> This patch proposes changes for remoteproc core only.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
>  drivers/remoteproc/remoteproc_core.c    | 6 +++---
>  drivers/remoteproc/remoteproc_debugfs.c | 4 ++--
>  drivers/remoteproc/remoteproc_virtio.c  | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index a9609d9..c597f0c 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -241,7 +241,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>  	if (notifyid > rproc->max_notifyid)
>  		rproc->max_notifyid = notifyid;
>  
> -	dev_dbg(dev, "vring%d: va %p dma %pad size 0x%x idr %d\n",
> +	dev_dbg(dev, "vring%d: va %pK dma %pad size 0x%x idr %d\n",
>  		i, va, &dma, size, notifyid);
>  
>  	rvring->va = va;
> @@ -497,7 +497,7 @@ static int rproc_handle_trace(struct rproc *rproc, struct fw_rsc_trace *rsc,
>  
>  	rproc->num_traces++;
>  
> -	dev_dbg(dev, "%s added: va %p, da 0x%x, len 0x%x\n",
> +	dev_dbg(dev, "%s added: va %pK, da 0x%x, len 0x%x\n",
>  		name, ptr, rsc->da, rsc->len);
>  
>  	return 0;
> @@ -635,7 +635,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  		goto free_carv;
>  	}
>  
> -	dev_dbg(dev, "carveout va %p, dma %pad, len 0x%x\n",
> +	dev_dbg(dev, "carveout va %pK, dma %pad, len 0x%x\n",
>  		va, &dma, rsc->len);
>  
>  	/*
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index a204883..a5c29f2 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -231,7 +231,7 @@ static int rproc_rsc_table_show(struct seq_file *seq, void *p)
>  			}
>  			break;
>  		default:
> -			seq_printf(seq, "Unknown resource type found: %d [hdr: %p]\n",
> +			seq_printf(seq, "Unknown resource type found: %d [hdr: %pK]\n",
>  				   hdr->type, hdr);
>  			break;
>  		}
> @@ -260,7 +260,7 @@ static int rproc_carveouts_show(struct seq_file *seq, void *p)
>  
>  	list_for_each_entry(carveout, &rproc->carveouts, node) {
>  		seq_puts(seq, "Carveout memory entry:\n");
> -		seq_printf(seq, "\tVirtual address: %p\n", carveout->va);
> +		seq_printf(seq, "\tVirtual address: %pK\n", carveout->va);
>  		seq_printf(seq, "\tDMA address: %pad\n", &carveout->dma);
>  		seq_printf(seq, "\tDevice address: 0x%x\n", carveout->da);
>  		seq_printf(seq, "\tLength: 0x%x Bytes\n\n", carveout->len);
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index b0633fd..bbecd44 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -96,7 +96,7 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
>  	size = vring_size(len, rvring->align);
>  	memset(addr, 0, size);
>  
> -	dev_dbg(dev, "vring%d: va %p qsz %d notifyid %d\n",
> +	dev_dbg(dev, "vring%d: va %pK qsz %d notifyid %d\n",
>  		id, addr, len, rvring->notifyid);
>  
>  	/*
> 

