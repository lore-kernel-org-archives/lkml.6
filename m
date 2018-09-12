Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ED8C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F063320882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwGFUAUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F063320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeILWEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbeILWEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:04:12 -0400
Received: from localhost (unknown [146.7.4.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE51020880;
        Wed, 12 Sep 2018 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536771527;
        bh=NtFz7Zjhd8eJyxJK3E4YjqMxN+qSTBSZsEQXDHolkRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwGFUAUvm5U1SSkZmzCsNNGl626u5TNg1JEDGccvBCFfhkcupnqFs+0PE/06l1DMZ
         oEITQepdihVz/aHnINZCeEO6+DQMHA9W5NxhvQgjlgbVtCoUY9OovtlA5jxO4vtu+r
         xR0bjMkHvpLqN9AT7dd3mbPO9GK/NdxnDPZBMjsw=
Date:   Wed, 12 Sep 2018 11:58:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
Message-ID: <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The original PCI error recovery functionality was for the powerpc-specific
> IBM EEH feature.  PCIe subsequently added some similar features, including
> AER and DPC, that can be used on any architecture.
> 
> We want the generic PCI core error handling support to work with all of
> these features.  Driver error recovery callbacks should be independent of
> which feature the platform provides.
> 
> Add the generic PCI core error recovery files to the powerpc EEH
> MAINTAINERS entry so the powerpc folks will be copied on changes to the
> generic PCI error handling strategy.

I really want to make sure the powerpc folks are plugged into any PCI core
error handling discussions.  Please let me know if there's a better way
than this patch, or if there are other people who should be added.

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  MAINTAINERS |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e10ba65bfe4..d6699597fd89 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11202,6 +11202,10 @@ PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
>  M:	Russell Currey <ruscur@russell.cc>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
> +F:	Documentation/PCI/pci-error-recovery.txt
> +F:	drivers/pci/pcie/aer.c
> +F:	drivers/pci/pcie/dpc.c
> +F:	drivers/pci/pcie/err.c
>  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
>  F:	arch/powerpc/kernel/eeh*.c
>  F:	arch/powerpc/platforms/*/eeh*.c
> 
