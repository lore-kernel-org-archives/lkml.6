Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217BFC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E152121872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kk2Yz2FU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfBAD21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 22:28:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46654 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBAD20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 22:28:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so2260732pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 19:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4dRjyVg+9JCxNZnpzzEFgbpHtM0rs0G6fZXT2YJHEQM=;
        b=Kk2Yz2FU4UfJhJ1fIvh+PS7Wjzudz9oHdndqTsU5IItNpg8Iy2jroalfsk/9C0NqqZ
         FccPiQhPI5w/qLGhCUtFEYlGu4AnkD/HUuh3RjTJCY/pMlWOBquQITUlKMQq/FLGzee5
         YRNAFStBJGJWtSItcZfkSwnfFhQzjETKfeTh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4dRjyVg+9JCxNZnpzzEFgbpHtM0rs0G6fZXT2YJHEQM=;
        b=SBbQ9F7hf6n9FR4JoS/c4EBx7HItcVFwC6eRhqt51C/wB2Drb1fUU19oxPEbfY0B1a
         qtSf97WH5jqFvMUqtoh5NAeRO4sm7dCD4h79KhFZ4BaTbdflffu8gCa+vmGqquhiO7Kf
         YBG2rzv1iAKoIenWxLTUQ5dGheOt6tstg+sXX0niQ2YwP9t81bRkXI3QwOe8F4FMBzwf
         TkCgeMiFeqMDqPNRkh9BnExM8T/Wods6ozGcppYjS99+Y01F3ucIaMKLa3JQ8ws+jDWj
         xg60vn0AXB4uqEGQhpqySGj6y2X9kAOtVMom2WRxjgBM2U2FgPlsuEoVvtDLHaYvveOJ
         2Z7Q==
X-Gm-Message-State: AHQUAuZKsc+3twgJ6RNlSP9kTRVBPtX/Qtqh9zh13niwoClBRF7Toi+Q
        JwFNMCGR1cmAPPvSosiOJRHT
X-Google-Smtp-Source: AHgI3IYvTnx25Jafk3oczwUF1ifpD5btKXyX895Bwe5PeF7PuT2Bxq3+8CDJz3JuLtG5w/kW0ywc9w==
X-Received: by 2002:a63:5723:: with SMTP id l35mr609137pgb.228.1548991705606;
        Thu, 31 Jan 2019 19:28:25 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72ca:1df8:3db9:68de:e3db:c028])
        by smtp.gmail.com with ESMTPSA id n7sm7684996pff.36.2019.01.31.19.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 19:28:24 -0800 (PST)
Date:   Fri, 1 Feb 2019 08:58:17 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org
Subject: Re: [PATCH v3 0/5] Add Oxalis board support
Message-ID: <20190201032817.GA3008@Mani-XPS-13-9360>
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 09:51:42AM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds Oxalis board support. This board is one of the
> 96Boards Enterprise Edition platform from EBS-SYSTART GmbH. Below are some
> of the key features of this board:
> 
> * SoC: NXP Layerscape LS1012A
> * RAM: 1GB DDR3L
> * PMU: NXP VR5100
> * Storage: 64MByte SPI Flash for bootloader and RCW, MicroSD Card, SATA
> * Connectivity: 2x Ethernet
> * USB: 2x USB3.0
> 
> More information about this board can be found in 96Boards product
> page: https://www.96boards.org/product/oxalis/
> 
> Ethernet and SPI flash are not supported yet!
> 
> Thanks,
> Mani
> 

Hi Shawn,

Any update on this patchset?

Thanks,
Mani

> Changes in v3:
> 
> * Fixed LS1012A and LS1021A bindings
> * Added missing devicetree compatibles for LS1021A based boards
> * Added Rob's Reviewed-by tag for Vendor prefix patch
> 
> Changes in v2:
> 
> As per Rob's review:
> 
> * Adopted the Oxalis board binding to JSON format.
> * Sorted the EBS-SYSTART vendor prefix alphabetically.
> * Used the generic node name for audio codec.
> 
> Manivannan Sadhasivam (5):
>   dt-bindings: arm: fsl: Fix bindings for LS1012A and LS1021A based
>     boards
>   ARM: dts: Add devicetree compatibles for LS1021A based boards
>   dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
>   dt-bindings: arm: fsl: Add devicetree binding for Oxalis
>   arm64: dts: freescale: Add devicetree for Oxalis
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 11 ++-
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts   |  1 +
>  arch/arm/boot/dts/ls1021a-qds.dts             |  1 +
>  arch/arm/boot/dts/ls1021a-twr.dts             |  1 +
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
>  7 files changed, 111 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
> 
> -- 
> 2.17.1
> 
