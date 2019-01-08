Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D946C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC94218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSJ0+pdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfAHGna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:43:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40218 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAHGna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:43:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so1431186pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 22:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UdHzhJVeJmSIWD79VrtwfdwnEHHkueYkM3uPAgwr6n8=;
        b=LSJ0+pdAlw6SkBv3kB9wrusgeuPZI+N7QtENQeU0Hio3ArEWrQwnZS82GEvOCqxzBJ
         OtDSosfrrY2nlDSSwBCK1g56bALjSfQMTZ3+cyfpHakr22g+UEZ2PB//ctn10JzKL2w8
         iLHPpiR1HmSFaUTEeWXW8tDnpsNQ60F+JnQjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UdHzhJVeJmSIWD79VrtwfdwnEHHkueYkM3uPAgwr6n8=;
        b=CfRqoVNnxQTrFyfRuVDY4NZrcJKt+nKFOhbkU8fUTa5SsidVse5rxgLVaTgPAOPH7o
         eFH61tQvPAHRfyBXMbcWnj7lZWfigxvL0LYliRkjCNi5wnEpcjhW0ta80iLnSArb94R5
         LWe5wWY6G01Y9NrUdaMRL3mBZDfuKDaSSNwEFAr6OQTsqNiIoGwYvQg9UV8qHy1TVnMI
         mbZ9YKO921ODZSu1c/3kAMZ5/qz2KNCfqOxpMWgb/ePPBG44tGp95Ey8TKVaO0UcaQ/z
         osbvSETr9UsSdqxuGoicOi9z7uHURarFJnRdwzNWED79Sr/hb6W9m68eUiv4CeFFsED3
         BXKQ==
X-Gm-Message-State: AJcUukerqKOV4mPW38ITiH0Ko4ko+cEZimioqk2xkiH4zB28qOuKV0vo
        17u9PL5vov2AM4L0i7mX6KQE
X-Google-Smtp-Source: ALg8bN5IkjFor0bRPhper9G7CoUwp+7zC+c564P8JRNy8liNjsZYjYzrlMSk9B/RM35xyLWvgH26fg==
X-Received: by 2002:a62:9913:: with SMTP id d19mr547199pfe.107.1546929809112;
        Mon, 07 Jan 2019 22:43:29 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id h79sm134026080pfj.186.2019.01.07.22.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 22:43:28 -0800 (PST)
Date:   Tue, 8 Jan 2019 12:13:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     dinguyen@kernel.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, amit.kucheria@linaro.org,
        yossi@novtech.com, nazik@novtech.com
Subject: Re: [PATCH 0/2] Add board support for Chameleon96 Board
Message-ID: <20190108064321.GA6543@mani>
References: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 08:31:50AM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds board support for Chameleon96 board from Novetech
> based on Intel Cyclone V SoC FPGA. This board is one of the Consumer
> Edition boards of the 96Boards family and has the following key features:
>     
> * SoC - Intel Cyclone V SoC FPGA
> * GPU - Graphics based on Intel Video Suite for FPGA
> * RAM - 512MB DDR3L
> * USB - 2x USB2.0 Host, 1x USB2.0 OTG
> * Wireless - Wifi, BT
>     
> More information about this board can be found in 96Boards product
> page: https://www.96boards.org/product/chameleon96/
> 
> This patchset has been tested on Chameleon96 board and the board boots
> into a distro on SD card with USB ports working.
>

Hi,

Ping on this series!

Thanks,
Mani
 
> Thanks,
> Mani
> 
> Manivannan Sadhasivam (2):
>   dt-bindings: vendor-prefixes: Add Novtech Vendor Prefix
>   ARM: dts: Add support for 96Boards Chameleon96 board
> 
>  .../devicetree/bindings/vendor-prefixes.txt   |   1 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/socfpga_cyclone5_chameleon96.dts | 130 ++++++++++++++++++
>  3 files changed, 132 insertions(+)
>  create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts
> 
> -- 
> 2.17.1
> 
