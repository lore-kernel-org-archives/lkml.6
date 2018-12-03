Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6696C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D63208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D63208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=s5r6.in-berlin.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeLCR54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:57:56 -0500
Received: from einhorn-mail.in-berlin.de ([217.197.80.20]:50505 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLCR54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:57:56 -0500
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2018 12:57:55 EST
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id wB3HplKa028835
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Dec 2018 18:51:56 +0100
Date:   Mon, 3 Dec 2018 18:51:46 +0100
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 resend] firewire: Remove depends on HAS_DMA in case
 of platform dependency
Message-ID: <20181203185146.71a01d85@kant>
In-Reply-To: <20181203122712.12751-1-geert@linux-m68k.org>
References: <20181203122712.12751-1-geert@linux-m68k.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 03 Geert Uytterhoeven wrote:
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
> 
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
> 
> This simplifies the dependencies, and allows to improve compile-testing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks for resending.  Applied to linux1394.git #for-next.

> ---
> v4:
>   - Rebase to v4.18-rc1 (applies to next-20180622, too),
> 
> v3:
>   - Rebase to v4.17-rc1,
> 
> v2:
>   - Add Reviewed-by, Acked-by,
>   - Drop RFC state,
>   - Split per subsystem.
> ---
>  drivers/firewire/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/firewire/Kconfig b/drivers/firewire/Kconfig
> index 145974f9662b63e6..4199849e37585181 100644
> --- a/drivers/firewire/Kconfig
> +++ b/drivers/firewire/Kconfig
> @@ -1,5 +1,4 @@
>  menu "IEEE 1394 (FireWire) support"
> -	depends on HAS_DMA
>  	depends on PCI || COMPILE_TEST
>  	# firewire-core does not depend on PCI but is
>  	# not useful without PCI controller driver

-- 
Stefan Richter
-======---=- ==-- ---==
http://arcgraph.de/sr/
