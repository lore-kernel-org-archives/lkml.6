Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59309C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADD120854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+Sh6kSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADD120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeIJICE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeIJICE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:02:04 -0400
Received: from dragon (unknown [45.56.155.51])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12C9F20882;
        Mon, 10 Sep 2018 00:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536540073;
        bh=J584T5AoqRS0hcelZn4qG1dlJbdD7TbHEVBDXzQ57Dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+Sh6kSbGHhAKpCJjrqyHPubnDPwQLYwE6pviL20VnSjN28mRpNUGyDPIB5RSVtah
         n3uOIr8q6izr6R7zrvFWm3lMwzcJjR2JQVSMaMrsDglW18thf2aT1PoN/9CHZjk0Q1
         Vd9cGQ8y7qGYNzzCgeYT/hjSqPLLWT4eSj8CRytM=
Date:   Mon, 10 Sep 2018 08:39:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] arm64: dts: fsl: use a generic node name for
 m25p80 flashes
Message-ID: <20180910003946.GE21218@dragon>
References: <20180903140840.23648-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903140840.23648-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series looks good to me.  @Leo, what about you?

Shawn

On Mon, Sep 03, 2018 at 04:08:36PM +0200, Alexandre Belloni wrote:
> Use a generic node name for the m25p80 flashes on ls1043 and ls1046 boards.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> index c7b8d2c009cd..af972e91d6bc 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> @@ -136,7 +136,7 @@
>  	bus-num = <0>;
>  	status = "okay";
>  
> -	qflash0: s25fl128s@0 {
> +	qflash0: flash@0 {
>  		compatible = "spansion,m25p80";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> index e69306e6b0b1..219068220b84 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> @@ -165,7 +165,7 @@
>  	bus-num = <0>;
>  	status = "okay";
>  
> -	qflash0: s25fl128s@0 {
> +	qflash0: flash@0 {
>  		compatible = "spansion,m25p80";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> index 440e111651d5..df676b30357b 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> @@ -103,7 +103,7 @@
>  	bus-num = <0>;
>  	status = "okay";
>  
> -	qflash0: s25fs512s@0 {
> +	qflash0: flash@0 {
>  		compatible = "spansion,m25p80";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -111,7 +111,7 @@
>  		reg = <0>;
>  	};
>  
> -	qflash1: s25fs512s@1 {
> +	qflash1: flash@1 {
>  		compatible = "spansion,m25p80";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -- 
> 2.19.0.rc1
> 
