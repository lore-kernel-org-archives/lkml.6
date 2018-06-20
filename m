Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B01CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBB620693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gF9fhWlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBB620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754720AbeFTJ0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:26:20 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:50915 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754583AbeFTJ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:26:17 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6F4401E04A8;
        Wed, 20 Jun 2018 11:26:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529486773; bh=uY+Dy5q6blVcJrXqZfq536v1VnKIEF1Bid/BFf1zJnI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=gF9fhWlSjQsqZxWUFZFEuf2BR/MlEa7Sorq04GFmmFKQhCcpATHTz9Y0+yERZAhYA
         blXdN/XRVYO9WBorsju4b2DqbKEkG1W2IBXgZzC7Uaqtjd770diLq8VbmmpFwyJnbO
         xVRVQmHLOB8zmAOZZoZR52YUdTDbTqXQIyLqLyZrqh9sm4TlKrMFkqmaKw0u+VlZ76
         KRLVJ7mYcLzz0K3EIqRIvzxmLk2obRDK59V7dAFDAknPwEhTno6Q3IJvHrUEW6uFNw
         89RbGJvKeaG7mqUSD5KgU+iuiW86hHztem64tcWIQ/nZLK9HaH1RDDsvtdu+sUb+40
         BTn1IHxnRAGUQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7CD71334C;
        Wed, 20 Jun 2018 02:26:12 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 20 Jun 2018 02:25:44 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 20 Jun 2018 11:25:42 +0200
Received: from [10.107.25.102] (10.107.25.102) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 20 Jun 2018 11:25:42 +0200
Subject: Re: [RFC PATCH] PCI: dwc: dw_pcie_ep_find_capability() can be static
To:     kbuild test robot <fengguang.wu@intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <5beae521c5ee475b1c0e04f5eec07d0120b0fa2b.1529329262.git.gustavo.pimentel@synopsys.com>
 <20180618191207.GA111117@ivb43>
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <23cdc4a8-2d79-826e-8fa3-3877486c2ae1@synopsys.com>
Date:   Wed, 20 Jun 2018 10:23:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618191207.GA111117@ivb43>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.102]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the suggestion.

Regards,
Gustavo

On 18/06/2018 20:12, kbuild test robot wrote:
> 
> Fixes: 43f8cf4686e0 ("PCI: dwc: Add MSI-X callbacks handler")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> ---
>  pcie-designware-ep.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index beee64e..ffc2065 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -59,7 +59,7 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>  	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>  }
>  
> -u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
> +static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
>  {
>  	u8 next_cap_ptr;
>  	u16 reg;
> 

