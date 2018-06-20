Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8934CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F71E20871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Na6CdW66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F71E20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754319AbeFTJYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:24:30 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:50905 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeFTJY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:24:26 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E37BF1E04A8;
        Wed, 20 Jun 2018 11:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529486665; bh=CCyz/ExFdf43ZLfMchVbJtSovRTImq0QhRM011yvlio=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Na6CdW664HaxF3I3aZPtlMDayWdWQazXIjrj29uRlqifWCC8GZIM+wJyYl0t8xcOk
         xSiLsI9rfSTjQiYuYyKvH9AoJSxZSj7+Q+TkO+tJ7iqC3kchkyzqmFmzl4w4LCsWfC
         8ABTofuQtIeOTgEppCncP7qooNrtvss9qaAP2KIuQ+aaCgVMg4uGE9Fkg2g4djpcvc
         Vd2lkIq5uFM4xI/ll70aeUHtKv2LhXHVemrNKIXgCMljVSBBgZJqbFxVih8+kSFytL
         K6iZHTUHIIo6p/ZPeoCwUjUH0PO2mqBtBZmAln6e34oJHlPBF+uyUpK/5GKJm0kjZh
         qhvMmy6WCdfLQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1.internal.synopsys.com [10.12.239.235])
        by mailhost.synopsys.com (Postfix) with ESMTP id E7F043064;
        Wed, 20 Jun 2018 02:24:23 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 20 Jun 2018 02:24:09 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 20 Jun 2018 11:24:07 +0200
Received: from [10.107.25.102] (10.107.25.102) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 20 Jun 2018 11:24:06 +0200
Subject: Re: [PATCH v2] PCI: controller: dwc: Do not let PCIE_DW_PLAT_HOST
 default to yes
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180619171917.19932-1-geert+renesas@glider.be>
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <7d974ab2-27e9-98d7-36bb-91e87d92b7bf@synopsys.com>
Date:   Wed, 20 Jun 2018 10:22:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619171917.19932-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.102]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 19/06/2018 18:19, Geert Uytterhoeven wrote:
> PCIE_DW_PLAT_HOST does not have any platform dependency, so it should
> not default to yes.

That's right, thanks.

Regards,
Gustavo

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> 
> Fixes: 1d906b22076e12cf ("PCI: dwc: Add support for EP mode")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Rebased on top of the big PCI controller move.
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 16f52c626b4bd510..91b0194240a57e8f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -58,7 +58,6 @@ config PCIE_DW_PLAT_HOST
>  	depends on PCI && PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	select PCIE_DW_PLAT
> -	default y
>  	help
>  	  Enables support for the PCIe controller in the Designware IP to
>  	  work in host mode. There are two instances of PCIe controller in
> 
