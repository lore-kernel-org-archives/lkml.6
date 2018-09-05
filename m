Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C94C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00482075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00482075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeIES5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:57:14 -0400
Received: from nbd.name ([46.4.11.11]:48224 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbeIES5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:57:14 -0400
Subject: Re: [PATCH] MIPS: pci-rt2880: set pci controller of_node
To:     Mathias Kresin <dev@kresin.me>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Tobias Wolf <dev-NTEO@vplace.de>
References: <1536130286-32088-1-git-send-email-dev@kresin.me>
From:   John Crispin <john@phrozen.org>
Message-ID: <250cfc61-5584-0b0a-1b58-16d3ab6af234@phrozen.org>
Date:   Wed, 5 Sep 2018 16:26:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536130286-32088-1-git-send-email-dev@kresin.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/18 08:51, Mathias Kresin wrote:
> From: Tobias Wolf <dev-NTEO@vplace.de>
>
> Set the PCI controller of_node such that PCI devices can be
> instantiated via device tree.
>
> Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
> Signed-off-by: Mathias Kresin <dev@kresin.me>
Acked-by: John Crispin <john@phrozen.org>

> ---
>   arch/mips/pci/pci-rt2880.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/pci/pci-rt2880.c b/arch/mips/pci/pci-rt2880.c
> index 711cdcc..f376a1d 100644
> --- a/arch/mips/pci/pci-rt2880.c
> +++ b/arch/mips/pci/pci-rt2880.c
> @@ -246,6 +246,8 @@ static int rt288x_pci_probe(struct platform_device *pdev)
>   	rt2880_pci_write_u32(PCI_BASE_ADDRESS_0, 0x08000000);
>   	(void) rt2880_pci_read_u32(PCI_BASE_ADDRESS_0);
>   
> +	rt2880_pci_controller.of_node = pdev->dev.of_node;
> +
>   	register_pci_controller(&rt2880_pci_controller);
>   	return 0;
>   }

