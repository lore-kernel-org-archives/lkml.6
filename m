Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C290C46470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D4C21898
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jQITvRpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D4C21898
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbeHMRyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:54:50 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51918 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbeHMRyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:54:49 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7DFBqlY097264;
        Mon, 13 Aug 2018 10:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534173112;
        bh=GZ1TFJuw0WOXmrmfOlrE4J2j5LxipG5BTvJg9e50+vc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jQITvRpfLZJWSRq/VxZJmghJYLS2et1Ip/QJiqpnDu2D/f7LMuEtp88WLOdlNL8Dc
         YoOcDZk1lL8l3D7FJFm8X+sAGHtv1x6/3ruJfpc/8zTzAV66zzgyeIGfC17iZcgzF8
         SSIwKjkujWfyKMcE3J8fb2Zx4TCFgLEyJRSwu+5k=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7DFBqpo011285;
        Mon, 13 Aug 2018 10:11:52 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 13
 Aug 2018 10:11:52 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 13 Aug 2018 10:11:52 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7DFBp6H005659;
        Mon, 13 Aug 2018 10:11:52 -0500
Subject: Re: [PATCH] remoteproc/davinci: Mark error recovery as disabled
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180723232757.9147-1-s-anna@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <0550997f-8e32-fb56-2a70-74235b969ce2@ti.com>
Date:   Mon, 13 Aug 2018 10:11:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723232757.9147-1-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 07/23/2018 06:27 PM, Suman Anna wrote:
> The Davinci remoteproc driver does not support error recovery at
> present, so mark the corresponding remoteproc flag appropriately
> so that the debugfs flag shows the value as 'disabled' by default.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Can you pick up this minor patch for 4.19 please, I do not see this in
your rproc-next branch?

Thanks,
Suman

> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index b668e32996e2..53160d5ed543 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -284,6 +284,9 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  		goto free_mem;
>  	}
>  
> +	/* error recovery is not supported at present */
> +	rproc->recovery_disabled = true;
> +
>  	drproc = rproc->priv;
>  	drproc->rproc = rproc;
>  	drproc->dsp_clk = dsp_clk;
> 

