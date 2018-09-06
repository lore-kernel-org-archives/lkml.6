Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C651CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7BC2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wyldWP+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7BC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbeIFXpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729445AbeIFXpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:45:21 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF9372075E;
        Thu,  6 Sep 2018 19:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536260910;
        bh=K4JVnu0qPbAKLJJqEI8LRyiIWVwW/DeH0KBldb/8Atg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wyldWP+VBuW7D6JwQWWw71aO2v1FgR8xkX01Lr5BEjSz1MG4iksamyvTYCqEIndMa
         UqxmQdan2G/OWv/MKH2kEm3SwpTK5UyDq42XjPenfIEqzOqkXSM4NXCaOFayJtwtxw
         hhaEiJkZ/WbjLjbNVOiTtQiWXp4bPBRsgNunCkz0=
Date:   Thu, 6 Sep 2018 14:08:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci: fix pci.c kernel-doc parameter warning
Message-ID: <20180906190830.GF214747@bhelgaas-glaptop.roam.corp.google.com>
References: <1fe6f0c6-7ebb-7ddd-af91-659afad2d7da@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fe6f0c6-7ebb-7ddd-af91-659afad2d7da@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 07:32:50PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warning:
> 
> ../drivers/pci/pci.c:218: warning: Excess function parameter 'p' description in 'pci_dev_str_match_path'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Applied to pci/misc for v4.20, thanks!

> ---
>  drivers/pci/pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-419-rc2.orig/drivers/pci/pci.c
> +++ lnx-419-rc2/drivers/pci/pci.c
> @@ -196,7 +196,7 @@ EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
>  /**
>   * pci_dev_str_match_path - test if a path string matches a device
>   * @dev:    the PCI device to test
> - * @p:      string to match the device against
> + * @path:   string to match the device against
>   * @endptr: pointer to the string after the match
>   *
>   * Test if a string (typically from a kernel parameter) formatted as a
> 
