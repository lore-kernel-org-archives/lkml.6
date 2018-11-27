Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FC5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE4B21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+tiXw4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE4B21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbeK1DiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:38:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730945AbeK1DiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:38:05 -0500
Received: from localhost (unknown [122.178.235.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2762E208E4;
        Tue, 27 Nov 2018 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543336777;
        bh=ne0wq/HACkNEGEEzLsZ1/vzhSLKhOGk0o1/gcrXOYvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p+tiXw4oFfUF7IQRk3XG3d2MNrC9sOJrgjgRhqpoqSUuLGSfgAS6O/4oDre8GNkma
         nzkyNnbdcsgKw/EhKGlgl5NWsfANop/djnRFOStkaaJ0nEA/eXikd8VZNP9ovSwfVy
         kGc0o0Ewf4KxYyrjHm9AR96qoFj2UKf9D7KStdbs=
Date:   Tue, 27 Nov 2018 22:09:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: qcs404: Add WCN3990 WLAN module
 device node
Message-ID: <20181127163928.GF3175@vkoul-mobl.Dlink>
References: <20181127151716.31992-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127151716.31992-1-govinds@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-11-18, 20:47, Govind Singh wrote:
> Add device node for the ath10k SNOC platform driver probe
> and add resources required for WCN3990 on qcs404 soc.
> Optional clock and regulator controls are not yet available in
> upstream, hence add them once available.
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi |  4 ++++
>  arch/arm64/boot/dts/qcom/qcs404.dtsi     | 20 ++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index 0767389c68c1..36905524b0ff 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -310,6 +310,10 @@
>  	status = "okay";
>  };
>  
> +&wifi {
> +	status = "okay";
> +};

I am assuming this is common to both evb variants, so:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
