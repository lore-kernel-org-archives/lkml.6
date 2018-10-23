Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9B1C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247D920651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kebMjyO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247D920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeJXDxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:53:18 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56812 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXDxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:53:18 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9NJSTpR100957;
        Tue, 23 Oct 2018 14:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540322909;
        bh=xY3w9k8Znn6MngJ/lIbM5k5ANe6U431F48rPSiNzOEI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kebMjyO6E4nXBuRps4WEUCAzkvPWkPMx/ebL1va1GNSgqXEDe/430OjhFnEhVWgVg
         fZgeKZuQOo+3P/z4Oe599/V6Ab8DSiZnIwNhaqnop99Cl6blfFgLy1Geuhh818sbB2
         9tgldWRrRTN897KAjKAg/Mntp7RDuxiQdbeMBlhs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9NJSTGB071835
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Oct 2018 14:28:29 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 14:28:29 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 14:28:29 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9NJST6C008175;
        Tue, 23 Oct 2018 14:28:29 -0500
Subject: Re: [PATCH v4 07/17] remoteproc: introduce
 rproc_find_carveout_by_name function
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-8-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <df17f33f-3ccb-60b6-8d71-9d5170401ba0@ti.com>
Date:   Tue, 23 Oct 2018 14:28:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1532697292-14272-8-git-send-email-loic.pallardy@st.com>
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
> This patch provides a new function to find a carveout according
> to a name.
> If match found, this function returns a pointer on the corresponding
> carveout (rproc_mem_entry structure).
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 42 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index fe6c4e4..77b39ba 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -217,6 +217,48 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, int len)
>  }
>  EXPORT_SYMBOL(rproc_da_to_va);
>  
> +/**
> + * rproc_find_carveout_by_name() - lookup the carveout region by a name
> + * @rproc: handle of a remote processor
> + * @name,..: carveout name to find (standard printf format)
> + *
> + * Platform driver has the capability to register some pre-allacoted carveout

%s/pre-allacoted/pre-allocated/

> + * (physically contiguous memory regions) before rproc firmware loading and
> + * associated resource table analysis. These regions may be dedicated memory
> + * regions internal to the coprocessor or specified DDR region with specific

I guess this is the part that perhaps was being thought of for
representing internal memories as well for removing the da_to_va ops
right. Question is how to handle the different alias views for the same
address space. Anyway, that is perhaps a discussion for later given that
the current series does not remove the ops.

> + * attributes
> + *
> + * This function is a helper function with which we can go over the
> + * allocated carveouts and return associated region characteristics like
> + * coprocessor address, length or processor virtual address.
> + *
> + * Return: a valid pointer on carveout entry on success or NULL on failure.
> + */
> +struct rproc_mem_entry *
> +rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...)
> +{
> +	va_list args;
> +	char _name[32];
> +	struct rproc_mem_entry *carveout, *mem = NULL;
> +
> +	if (!name)
> +		return NULL;
> +
> +	va_start(args, name);
> +	vsnprintf(_name, sizeof(_name), name, args);
> +	va_end(args);
> +
> +	list_for_each_entry(carveout, &rproc->carveouts, node) {
> +		/* Compare carveout and requested names */
> +		if (!strcmp(carveout->name, _name)) {
> +			mem = carveout;

Bjorn had some comments on v3 about returning carveout directly here
instead of break, avoids the mem variable. I am ok either way.

regards
Suman

> +			break;
> +		}
> +	}
> +
> +	return mem;
> +}
> +
>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>  {
>  	struct rproc *rproc = rvdev->rproc;
> 

