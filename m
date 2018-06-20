Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFB7C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36ABA20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byLS1uPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36ABA20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754468AbeFTSMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:12:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40908 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754226AbeFTSMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tuNxlu4AVaVOl+OHzSCoPZBBkIh/xEbBSLvvd30Cl6c=; b=byLS1uPMM3b9rCD3MTN3dlTyMn
        RL0JZy3Kf9t8BdPCInjRe/Iyry/JbCk9vOmt+HXF50FCD2eHWNUeT+uxL6bzp0Z60KB1ckAwu9Tcm
        DnbH+emnnOgDypgRJm8gAr0ZtaP2n4DnNT7rEAdFrRpt/hS2Sz98sGYfTNavLGMtaw5yex/EsJTM9
        2kNolcWaKpn5ZPhQ6U2llRNqtomaXEuYH6oQeQzwba9W/x7AtW4la++8xVGEPczzfWoQGvtUBlpnm
        Mazw9x715FEZm04DrPU6dMCI1gsZU4q6L2BqgpmoSFt1DhxlCTJBLz3b1ffmFuOB92NkuEnZS3fYM
        FDO8UCeQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVhaU-0001ja-D8; Wed, 20 Jun 2018 18:12:11 +0000
Subject: Re: [PATCH v5 09/11] pci_endpoint_test: Add 2 ioctl commands
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com, sboyd@codeaurora.org
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
 <8695864db0191b2e85ed81e97a8990baea3468fa.1529507416.git.gustavo.pimentel@synopsys.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dd75ced1-e4c3-8c94-3bab-200e2ecdd8b8@infradead.org>
Date:   Wed, 20 Jun 2018 11:12:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8695864db0191b2e85ed81e97a8990baea3468fa.1529507416.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 09:28 AM, Gustavo Pimentel wrote:
> Add MSI-X support and update driver documentation accordingly.
> 
> Add 2 new IOCTL commands:
>  - Allow to reconfigure driver IRQ type in runtime.
>  - Allow to retrieve current driver IRQ type configured.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v2->v3:                                                                              |  --------------------------------------------------------------------------------------------
>  - New patch file created base on the previous patch                                        |  --------------------------------------------------------------------------------------------
> "misc: pci_endpoint_test: Add MSI-X support" patch file following                           |  --------------------------------------------------------------------------------------------
> Kishon's suggestion.                                                                        |  --------------------------------------------------------------------------------------------
> Change v3->v4:                                                                              |  --------------------------------------------------------------------------------------------
>  - Rebased to Lorenzo's master branch v4.18-rc1.
> Change v4->v5:
>  - Nothing changed, just to follow the patch set version.
> 
>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>  drivers/misc/pci_endpoint_test.c                 | 177 +++++++++++++++++------
>  2 files changed, 132 insertions(+), 48 deletions(-)
> 
> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
> index fdfa0f6..58ccca4 100644
> --- a/Documentation/misc-devices/pci-endpoint-test.txt
> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
> @@ -28,6 +28,9 @@ ioctl
>  	      to be tested should be passed as argument.
>   PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
>  	      to be tested should be passed as argument.
> + PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ type
> +	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
> + PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
>   PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
>  		as argument.
>   PCITEST_READ: Perform read tests. The size of the buffer should be passed
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 2b58887..82fa0c2 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c

Hi,

The ioctl "type" (as "type" is used in <uapi/asm-generic/ioctl.h>),
value of 'P' in this case, should be documented in
Documentation/ioctl/ioctl-number.txt.

thanks,
-- 
~Randy
