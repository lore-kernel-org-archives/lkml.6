Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5F7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8AF218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547237499;
	bh=uPuTjinKek9eV0StZCcqkPvfKyCO9A7/WtIjnmq6rxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H7kNtKwXDQfliAV0wqvKzG0gWt7gChrArhxlL088tcQq0vcNmG8wlOgwrFPGdTInG
	 mBr9f3yzdgRRAuzB5mCPWoL1rjWIuX5W1WJi3NloQXs3o+m6k5LhBiLTy/gKCk8jOx
	 17PnxHMqjBaWiwMMHstqXEgGC8x0ALRwb60qJT9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390649AbfAKULi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:11:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46799 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731426AbfAKULh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:11:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so14191010otm.13;
        Fri, 11 Jan 2019 12:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q2ZumaCzeCVRDmWhVySEc2M5WhLU9+Fq+Qj1ZVCepxQ=;
        b=t5f7ho+u3a7wLLzfd/RgTcHurzV7kIpvf7bSNJZrO6eu3JmoCFYIJlrdz2FB+1HNYQ
         b/rVOrFUsHo4MFYpGZHdtKr7AlHdFV6BumFZvEgG1R5mAbjiAjXqNS51OobnXwl3Hrz5
         mSivtNAlMWr9cMJx6DRV/y3oMqZDWr0ttAOxKpMdPTGt2l+HXwVseTPcrT+tCZPxMgQH
         h/zmus6isXb6DDFuZ6WSZVJ2/X1P+cSwnB+kL5WrZkZpvCGamY8bx2sllMxeeIwMTC6L
         HJUQK1iKnd2N4euXaAeLtekaB8er5cZGpxqCPU2SPmmy/FYKS2bLzctOZhK6mZ5jjghI
         yeOQ==
X-Gm-Message-State: AJcUukdwhMPPV9fP1mctMeYgv5O0tp4ttCtWVdmirUgWYFDqoISpAupq
        PVyT0w75SewL/uqQtGptwA==
X-Google-Smtp-Source: ALg8bN6Dbogdgn5X/2YMxjCunA4TO1DiJ5s/kz0HQJm72dJIYkszrUGAeK5zMNPwaH8nwrwWl5209A==
X-Received: by 2002:a9d:4c8b:: with SMTP id m11mr1839239otf.111.1547237496375;
        Fri, 11 Jan 2019 12:11:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w15sm35519928oie.43.2019.01.11.12.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 12:11:35 -0800 (PST)
Date:   Fri, 11 Jan 2019 14:11:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com,
        nava.manne@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: reset: Add bindings for ZynqMP reset
 driver
Message-ID: <20190111201134.GA28900@bogus>
References: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
 <1546638982-12954-4-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546638982-12954-4-git-send-email-jollys@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 01:56:21PM -0800, Jolly Shah wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> Add documentation to describe Xilinx ZynqMP reset driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  .../bindings/reset/xlnx,zynqmp-reset.txt           | 148 +++++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> new file mode 100644
> index 0000000..e9c1af8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> @@ -0,0 +1,148 @@
> +--------------------------------------------------------------------------
> + =  Zynq UltraScale+ MPSoC reset driver binding =
> +--------------------------------------------------------------------------
> +The Zynq UltraScale+ MPSoC has several different resets.
> +
> +See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
> +about zynqmp resets.
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required Properties:
> +- #reset-cells:	Specifies the number of cells needed to encode reset
> +		line, should be 1
> +
> +Reset outputs:
> +	0   :PCIE config reset.
> +	1   :PCIE bridge block level reset (AXI interface).
> +	2   :PCIE control block level,reset.

Presumably, you will have a header for all these? If so, then don't 
define them here.

> +	3   :Display Port block level reset (includes DPDMA).
> +	4   :FPD WDT reset.
> +	5   :AF_FM5 block level reset.
> +	6   :AF_FM4 block level reset.
> +	7   :AF_FM3 block level reset.
> +	8   :AF_FM2 block level reset.
> +	9   :AF_FM1 block level reset.
> +	10  :AF_FM0 block level reset.
> +	11  :GDMA block level reset.
> +	12  :Pixel Processor (GPU_PP1) block level reset.
> +	13  :Pixel Processor (GPU_PP0) block level reset.
> +	14  :GPU block level reset.
> +	15  :GT block level reset.
> +	16  :Sata block level reset.
> +	17  :ACPU3 power on reset.
> +	18  :ACPU2 power on reset.
> +	19  :ACPU1 power on reset.
> +	20  :ACPU0 power on reset.
> +	21  :APU L2 reset.
> +	22  :ACPU3 reset.
> +	23  :ACPU2 reset.
> +	24  :ACPU1 reset.
> +	25  :ACPU0 reset.
> +	26  :DDR block level reset inside of the DDR Sub System.
> +	27  :APM block level reset inside of the DDR Sub System.
> +	28  :soft reset.
> +	29  :GEM 0 reset.
> +	30  :GEM 1 reset.
> +	31  :GEM 2 reset.
> +	32  :GEM 3 reset.
> +	33  :qspi reset.
> +	34  :uart0 reset.
> +	35  :uart1 reset.
> +	36  :spi0 reset.
> +	37  :spi1 reset.
> +	38  :sdio0 reset.
> +	39  :sdio1 reset.
> +	40  :can0 reset.
> +	41  :can1 reset.
> +	42  :i2c0 reset.
> +	43  :i2c1 reset.
> +	44  :ttc0 reset.
> +	45  :ttc1 reset.
> +	46  :ttc2 reset.
> +	47  :ttc3 reset.
> +	48  :swdt reset.
> +	49  :nand reset.
> +	50  :adma reset.
> +	51  :gpio reset.
> +	52  :iou_cc reset.
> +	53  :timestamp reset.
> +	54  :rpu_r50 reset.
> +	55  :rpu r51 reset.
> +	56  :rpu_amba reset.
> +	57  :ocm reset.
> +	58  :rpu_pge reset.
> +	59  :usb0_core reset.
> +	60  :usb1_core reset.
> +	61  :usb0_hiber reset.
> +	62  :usb1_hiber reset.
> +	63  :usb0_apb reset.
> +	64  :usb1_apb reset.
> +	65  :ipi reset.
> +	66  :apm reset.
> +	67  :rtc reset.
> +	68  :sysmon reset.
> +	69  :afi_fm6 reset.
> +	70  :lpd_swdt reset.
> +	71  :fpd_reset.
> +	72  :rpu_dbg1 reset.
> +	73  :rpu_dbg0 reset.
> +	74  :dbg_lpd reset.
> +	75  :dbg_fpd reset.
> +	76  :apll reset.
> +	77  :dpll reset.
> +	78  :vpll reset.
> +	79  :iopll reset.
> +	80  :rpll reset.
> +	81  :gpio_pl_0 reset.
> +	82  :gpio_pl_1 reset.
> +	83  :gpio_pl_2 reset.
> +	84  :gpio_pl_3 reset.
> +	85  :gpio_pl_4 reset.
> +	86  :gpio_pl_5 reset.
> +	87  :gpio_pl_6 reset.
> +	88  :gpio_pl_7 reset.
> +	89  :gpio_pl_8 reset.
> +	90  :gpio_pl_9 reset.
> +	91  :gpio_pl_10 reset.
> +	92  :gpio_pl_11 reset.
> +	93  :gpio_pl_12 reset.
> +	94  :gpio_pl_13 reset.
> +	95  :gpio_pl_14 reset.
> +	96  :gpio_pl_15 reset.
> +	97  :gpio_pl_16 reset.
> +	98  :gpio_pl_17 reset.
> +	99  :gpio_pl_18 reset.
> +	100 :gpio_pl_19 reset.
> +	101 :gpio_pl_20 reset.
> +	102 :gpio_pl_21 reset.
> +	103 :gpio_pl_22 reset.
> +	104 :gpio_pl_23 reset.
> +	105 :gpio_pl_24 reset.
> +	106 :gpio_pl_25 reset.
> +	107 :gpio_pl_26 reset.
> +	108 :gpio_pl_27 reset.
> +	109 :gpio_pl_28 reset.
> +	110 :gpio_pl_29 reset.
> +	111 :gpio_pl_30 reset.
> +	112 :gpio_pl_31 reset.
> +	113 :rpu_ls reset.
> +	114 :ps_only reset.
> +	115 :pl reset.
> +	116 :ps_pl0 reset
> +	117 :ps_pl1 reset
> +	118 :ps_pl2 reset
> +	119 :ps_pl3 reset
> +
> +-------
> +Example
> +-------
> +
> +firmware {
> +	zynqmp_firmware: zynqmp-firmware {
> +		...
> +		#reset-cells = <1>;
> +		...
> +	};
> +};
> -- 
> 2.7.4
> 
