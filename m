Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F76C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975F520665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975F520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeJXBad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:30:33 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47954 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeJXBad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:30:33 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9NH6GHL100319;
        Tue, 23 Oct 2018 12:06:16 -0500
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9NH6GwL047285
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Oct 2018 12:06:16 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 12:06:16 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 12:06:15 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9NH6Gp3005248;
        Tue, 23 Oct 2018 12:06:16 -0500
Subject: Re: [PATCH v4 04/17] remoteproc: add name in rproc_mem_entry struct
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-5-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <0eee8e53-a639-e886-7f23-edc697242be3@ti.com>
Date:   Tue, 23 Oct 2018 12:06:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1532697292-14272-5-git-send-email-loic.pallardy@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/18 8:14 AM, Loic Pallardy wrote:
> Add name field in struct rproc_mem_entry.
> This new field will be used to match memory area
> requested in resource table with pre-registered carveout.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
>  drivers/remoteproc/remoteproc_core.c    | 1 +
>  drivers/remoteproc/remoteproc_debugfs.c | 1 +
>  include/linux/remoteproc.h              | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 24fe11f..d7e3138 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -752,6 +752,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  	carveout->dma = dma;
>  	carveout->da = rsc->da;
>  	carveout->release = rproc_release_carveout;
> +	strlcpy(carveout->name, rsc->name, sizeof(carveout->name));
>  
>  	list_add_tail(&carveout->node, &rproc->carveouts);
>  
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index a5c29f2..e90135c 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -260,6 +260,7 @@ static int rproc_carveouts_show(struct seq_file *seq, void *p)
>  
>  	list_for_each_entry(carveout, &rproc->carveouts, node) {
>  		seq_puts(seq, "Carveout memory entry:\n");
> +		seq_printf(seq, "\tName: %s\n", carveout->name);
>  		seq_printf(seq, "\tVirtual address: %pK\n", carveout->va);
>  		seq_printf(seq, "\tDMA address: %pad\n", &carveout->dma);
>  		seq_printf(seq, "\tDevice address: 0x%x\n", carveout->da);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index bef2e83..0e21098 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -315,6 +315,7 @@ struct fw_rsc_vdev {
>   * @da: device address
>   * @release: release associated memory
>   * @priv: associated data
> + * @name: associated memory region name (optional)
>   * @node: list node
>   */
>  struct rproc_mem_entry {
> @@ -323,6 +324,7 @@ struct rproc_mem_entry {
>  	int len;
>  	u32 da;
>  	void *priv;
> +	char name[32];
>  	struct list_head node;
>  	int (*release)(struct rproc *rproc, struct rproc_mem_entry *mem);
>  };
> 

