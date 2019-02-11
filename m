Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D2C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B6721B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391946AbfBKPXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:23:31 -0500
Received: from ms.lwn.net ([45.79.88.28]:46104 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730282AbfBKPX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:23:26 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CBDD99AE;
        Mon, 11 Feb 2019 15:23:25 +0000 (UTC)
Date:   Mon, 11 Feb 2019 08:23:24 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/DMA-ISA-LPC: fix an incorrect reference
Message-ID: <20190211082324.40baa0cd@lwn.net>
In-Reply-To: <20190211134323.30856-1-hch@lst.de>
References: <20190211134323.30856-1-hch@lst.de>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 14:43:23 +0100
Christoph Hellwig <hch@lst.de> wrote:

> AFAIK we never had a isa_virt_to_phys, it always was
> isa_virt_to_bus.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/DMA-ISA-LPC.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/DMA-ISA-LPC.txt b/Documentation/DMA-ISA-LPC.txt
> index 8c2b8be6e45b..b1ec7b16c21f 100644
> --- a/Documentation/DMA-ISA-LPC.txt
> +++ b/Documentation/DMA-ISA-LPC.txt
> @@ -52,8 +52,8 @@ Address translation
>  -------------------
>  
>  To translate the virtual address to a bus address, use the normal DMA
> -API. Do _not_ use isa_virt_to_phys() even though it does the same
> -thing. The reason for this is that the function isa_virt_to_phys()
> +API. Do _not_ use isa_virt_to_bus() even though it does the same
> +thing. The reason for this is that the function isa_virt_to_bus()
>  will require a Kconfig dependency to ISA, not just ISA_DMA_API which
>  is really all you need. Remember that even though the DMA controller
>  has its origins in ISA it is used elsewhere.

Applied, thanks.

jon
