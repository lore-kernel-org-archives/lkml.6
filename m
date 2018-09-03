Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B591C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75E020861
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiwqHhTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75E020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbeICFYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 01:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeICFYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 01:24:17 -0400
Received: from dragon (unknown [45.56.155.166])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A58572077C;
        Mon,  3 Sep 2018 01:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535936794;
        bh=F4EDLogteuR/CXKkNwOI47LLGDN1LkzoYHdFY5Lw9Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiwqHhTkt0r6bV9HCrItAL0d6E3ysuQOHn0LWrrefVbFUFl9YKGwQygNnyVDo5vvN
         E6fBQZ8S2Lkki8VvmPAATwHbvYkiTxIIUzunstEAtSrTp2OPti6uTgLuRqCA2cusam
         vkKSSBhOdZ6EMXV8RG3kGlfLY0iCVcjDLoeO1kuQ=
Date:   Mon, 3 Sep 2018 09:05:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ran Wang <ran.wang_1@nxp.com>, linux-kernel@vger.kernel.org,
        xiaobo.xie@nxp.com, Minghuan Lian <Minghuan.Lian@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Changming Huang <jerry.huang@nxp.com>,
        Sumit Garg <sumit.garg@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rajesh Bhagat <rajesh.bhagat@freescale.com>
Subject: Re: [PATCH v2] arm64: dts: ls1043a: Add configure-gfladj property to
 USB3 node
Message-ID: <20180903010517.GY3850@dragon>
References: <20180829033055.22245-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829033055.22245-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 11:30:55AM +0800, Yinbo Zhu wrote:
> From: Rajesh Bhagat <rajesh.bhagat@freescale.com>
> 
> Add "configure-gfladj" boolean property to USB3 node. This property

I do not see where this property is documented as bindings and how
driver is using it.

Shawn

> is used to determine whether frame length adjustment is required or
> not
> 
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
> Change in v2:
> 		Modified some word misspellings in commit information
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 7881e3d..ed3fa79 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -609,6 +609,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			configure-gfladj;
>  		};
>  
>  		usb1: usb3@3000000 {
> @@ -618,6 +619,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			configure-gfladj;
>  		};
>  
>  		usb2: usb3@3100000 {
> @@ -627,6 +629,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			configure-gfladj;
>  		};
>  
>  		sata: sata@3200000 {
> -- 
> 1.7.1
> 
