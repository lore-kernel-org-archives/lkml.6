Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qOnqLJ14HluSMgAAmS7hNA
	; Mon, 11 Jun 2018 13:27:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 193C8607A4; Mon, 11 Jun 2018 13:27:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rS9BL42i"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A8547601C3;
	Mon, 11 Jun 2018 13:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8547601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933342AbeFKN04 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933323AbeFKN0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:26:54 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35F6320869;
        Mon, 11 Jun 2018 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528723614;
        bh=lEiAld0UDSvDyErmaN9hnYkPr5A85Cs0/xGTd1A1N6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rS9BL42i2wR340zbIkyDh+AK8Fn2RYalTh6eyG50cM0E5WyBNeHpsypkaZBxvUBjb
         DTP4Dz2mgzg2x/dwNgmZWKCR2ywENwJHEK13C0QuA3JuIa8YYti5iB4NhN7lZPF7f2
         /XTa/ARj0dTE91IeKdSdQDblZoUhvwC9u+QAcQjo=
Date: Mon, 11 Jun 2018 08:26:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 00/13] PCI/AER: Squash into one file
Message-ID: <20180611132653.GB75679@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 03:04:45PM -0500, Bjorn Helgaas wrote:
> The AER code is scattered across several files and buried a little too deep
> in the hierarchy, which makes it a bit of a hassle to browse.  Consolidate
> it all in a single file (plus the optional aer_inject module) and move it
> up one level to drivers/pci/pcie/aer.c.
> 
> This is all pure code moves; no functional changes intended.
> 
> ---
> 
> Bjorn Helgaas (13):
>       PCI/AER: Remove forward declarations
>       PCI/AER: Reorder code to group probe/remove stuff together
>       PCI/AER: Squash aerdrv_core.c into aerdrv.c
>       PCI/AER: Squash aerdrv_errprint.c into aerdrv.c
>       PCI/AER: Squash aerdrv_acpi.c into aerdrv.c
>       PCI/AER: Squash ecrc.c into aerdrv.c
>       PCI/AER: Remove duplicate pcie_port_bus_type declaration
>       PCI/AER: Move pcie_aer_get_firmware_first() to portdrv.h
>       PCI/AER: Move aer_irq() declaration to portdrv.h
>       PCI/AER: Move private AER things to aerdrv.c
>       PCI/AER: Squash Kconfig.debug into Kconfig
>       PCI/AER: Hoist aerdrv.c, aer_inject.c up to drivers/pci/pcie/
>       PCI/AER: Use "PCI Express" consistently in Kconfig text

Applied to pci/aer-squash with Keith's reviewed-by for v4.18.
