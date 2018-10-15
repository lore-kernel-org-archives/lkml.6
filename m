Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E7FC71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DE520881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5X1n2wa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DE520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeJPCSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbeJPCSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:18:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C039B20881;
        Mon, 15 Oct 2018 18:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539628341;
        bh=rN+XNL/GZ67Y0p4C2f41NUEFOhw9wVcr+gRkdGhWfW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5X1n2waxlLNdPgDhVIGg+7o5DEOX6WkHRrG60/a6YDcNz1Rmda5ohoQ4BaAXRFUi
         dSdabe2BoKx2z6eAr748Z++P6KmBhrsDpGuk00EmCRpSiBsMONyqryjhuEaUA2gn2k
         wal7WI4buAGIb3qYwLulLTBLP8hk1RMrWelZ0KwI=
Date:   Mon, 15 Oct 2018 20:32:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH] slimbus: ngd: QCOM_QMI_HELPERS has to be selected
Message-ID: <20181015183218.GA16900@kroah.com>
References: <20181003175236.20039-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003175236.20039-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 06:52:36PM +0100, Srinivas Kandagatla wrote:
> From: Niklas Cassel <niklas.cassel@linaro.org>
> 
> QCOM_QMI_HELPERS is a hidden kconfig, so the proper usage is
> to select it, not depend upon it.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Reviewed-by: Alex Elder <elder@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/slimbus/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
> index 9d73ad806698..9cca2c3559f2 100644
> --- a/drivers/slimbus/Kconfig
> +++ b/drivers/slimbus/Kconfig
> @@ -22,8 +22,8 @@ config SLIM_QCOM_CTRL
>  
>  config SLIM_QCOM_NGD_CTRL
>  	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
> -	depends on QCOM_QMI_HELPERS
>  	depends on HAS_IOMEM && DMA_ENGINE
> +	select QCOM_QMI_HELPERS
>  	help
>  	  Select driver if Qualcomm's SLIMbus Satellite Non-Generic Device
>  	  Component is programmed using Linux kernel.
> -- 
> 2.19.0
> 

This adds the following build warning when applied:

WARNING: unmet direct dependencies detected for QCOM_QMI_HELPERS
  Depends on [n]: ARCH_QCOM && NET [=y]
  Selected by [m]:
  - SLIM_QCOM_NGD_CTRL [=m] && SLIMBUS [=m] && HAS_IOMEM [=y] && DMA_ENGINE [=y]


