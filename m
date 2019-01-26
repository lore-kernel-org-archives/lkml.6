Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FC0C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16331218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1S+YcFKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfAZPDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:03:31 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:56384 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfAZPDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 10:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vAImYk36YexvkurQtK36V1nE8m1xtMVCvCr4V3KmHvA=; b=1S+YcFKLiy7aQ7J4gIefAv9iPx
        C8XFomPpQXMca1YXnlkEkXLuFDlYpT4dv5kengNELRpGSsR3CylbeLAN3iFvIpEzYSitjxd8U03SN
        A6DDMi/4d0x4JBveI51Q14tFL2L1eTJAIvxlxL/r/3IGtW+mLkk/maS8GnJMGA/U4jrs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gnPUO-0005iK-Gz; Sat, 26 Jan 2019 16:03:20 +0100
Date:   Sat, 26 Jan 2019 16:03:20 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        darren.tsao@bitmain.com, haitao.suo@bitmain.com
Subject: Re: [PATCH 0/5] Add initial Bitmain BM1880 SoC/Board support
Message-ID: <20190126150320.GB20679@lunn.ch>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 09:40:36AM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds initial support for Bitmain BM1880 SoC and Sophon
> Edge board. BM1880 SoC consists of a Dual Core ARM Cortex A53 Application
> processor subsystem, a single core RISC-V subsystem and a Tensor
> Processor subsystem.

Hi Manivannan

Interesting combination of CPUs. 

> This patchset adds support for only ARM Cortex A53 Application
> processor subsystem with UART, which enables the board to boot into
> initramfs with 2 CPUs.

Looking forward, what sharing do you expect at the device tree level?

Looking at 

https://sophon-file.bitmain.com.cn/sophon-prod/drive/18/11/06/19/BM1880%20product%20brief%20V0.04_Chinese%20versionV0.06.pdf

it appears all the devices can be shared between the CPUs. So do you
plan to have a shared .dtsi file somewhere? 

Is ARCH_BITMAIN going to be both ARM64 and RISC-V?

   Thanks
	Andrew
