Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80A3C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5368B20890
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMFx3Beu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5368B20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeILWWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeILWWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:22:37 -0400
Received: from localhost (unknown [146.7.4.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF19D2087F;
        Wed, 12 Sep 2018 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536772628;
        bh=oW6N4qWRJk+vP+/3ZxwH7nHBciQL31wilQV9Av9knGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMFx3BeuU+gNNrWAr8mnHP2vWNRIYJO009M0md2PkM5MN2TQuXpjigJE9Dhmm/Hxb
         6k01vhWJ4NSgjaFo9Zg+yQNuhy05HBPfrNdHM8WU+5yWID6UexSuPD6d8r3QLx0IsH
         NumPutGpb2j/pIwFfsezbQRg+f9lwROY9ikjOqq4=
Date:   Wed, 12 Sep 2018 12:17:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/5] PCI: provide pci_match_id() with CONFIG_PCI=n
Message-ID: <20180912171707.GI118330@bhelgaas-glaptop.roam.corp.google.com>
References: <20180910115935.163121-1-lkundrak@v3.sk>
 <20180910115935.163121-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910115935.163121-3-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please capitalize the subject as:

  PCI: Provide pci_match_id() with CONFIG_PCI=n

On Mon, Sep 10, 2018 at 01:59:32PM +0200, Lubomir Rintel wrote:
> This spares drivers from #ifdef-ing on CONFIG_PCI if the driver can be
> optionally built on machines without PCI bus.
> 
> Consistent with acpi_driver_match_device() and similar.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

> ---
>  include/linux/pci.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e72ca8dd6241..d2f14eb23ea4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1702,6 +1702,10 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
>  				      unsigned long *out_hwirq,
>  				      unsigned int *out_type)
>  { return -EINVAL; }
> +
> +static inline const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
> +							 struct pci_dev *dev)
> +{ return NULL; }
>  #endif /* CONFIG_PCI */
>  
>  /* Include architecture-dependent settings and functions */
> -- 
> 2.17.1
> 
