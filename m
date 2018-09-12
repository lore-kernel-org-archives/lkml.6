Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E515CC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAE620882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="euwN3kfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAE620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeILRPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeILRPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:15:53 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA67420880;
        Wed, 12 Sep 2018 12:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536754299;
        bh=sFyCER0vomW13wXrQLzcNO6KztzE+QZNWK0rZSSJhR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=euwN3kfZv3QHJ53RCw/ZUlr32jkbokP9PuNopWZvU5yXK8NBGWYPhOQ+elE2xDLiP
         t1zs5FH63+K+jDCg9dqxQAU+xCqc8CYzPkxJYM8pHNMgFWubi58jL8HUusHN8dpuqW
         2iBAupLPLWNQsAjfska9NK+jh6fRlyPkOz0uvgvk=
Date:   Wed, 12 Sep 2018 07:11:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joshua Abraham <j.abraham1776@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drivers: pci: remove set but unused variable
Message-ID: <20180912121137.GE118330@bhelgaas-glaptop.roam.corp.google.com>
References: <20180912023908.GA5549@josh-ThinkPad-T460s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912023908.GA5549@josh-ThinkPad-T460s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 04:39:08PM -1000, Joshua Abraham wrote:
> This patch removes a set but unused variable in quirks.c.
> 
> Fixes warning:
> variable ‘mmio_sys_info’ set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Joshua Abraham <j.abraham1776@gmail.com>

Applied to pci/misc for v4.20, thanks!

> ---
>  drivers/pci/quirks.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ef7143a274e0..690a3b71aa1f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4993,7 +4993,6 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
>  	void __iomem *mmio;
>  	struct ntb_info_regs __iomem *mmio_ntb;
>  	struct ntb_ctrl_regs __iomem *mmio_ctrl;
> -	struct sys_info_regs __iomem *mmio_sys_info;
>  	u64 partition_map;
>  	u8 partition;
>  	int pp;
> @@ -5014,7 +5013,6 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
>  
>  	mmio_ntb = mmio + SWITCHTEC_GAS_NTB_OFFSET;
>  	mmio_ctrl = (void __iomem *) mmio_ntb + SWITCHTEC_NTB_REG_CTRL_OFFSET;
> -	mmio_sys_info = mmio + SWITCHTEC_GAS_SYS_INFO_OFFSET;
>  
>  	partition = ioread8(&mmio_ntb->partition_id);
>  
> -- 
> 2.17.1
> 
