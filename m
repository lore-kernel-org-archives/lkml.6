Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbeB1Ogv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:36:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42738 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752441AbeB1Ogt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:36:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED8BC60265
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: bcma: Prevent build of PCI host features in module
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1515767119-17117-1-git-send-email-matt.redfearn@mips.com>
References: <1515767119-17117-1-git-send-email-matt.redfearn@mips.com>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        <linux-wireless@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180228143648.BD42B60390@smtp.codeaurora.org>
Date: Wed, 28 Feb 2018 14:36:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Redfearn <matt.redfearn@mips.com> wrote:

> Attempting to build bcma.ko with BCMA_DRIVER_PCI_HOSTMODE=y results in
> a build error due to use of symbols not exported from vmlinux:
> 
> ERROR: "pcibios_enable_device" [drivers/bcma/bcma.ko] undefined!
> ERROR: "register_pci_controller" [drivers/bcma/bcma.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
> 
> To prevent this, don't allow the host mode feature to be built if
> CONFIG_BCMA=m
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

This does not apply to wireless-drivers-next anymore. Also please CC:

linux-mips@linux-mips.org
James Hogan <jhogan@kernel.org>

Recorded preimage for 'drivers/bcma/Kconfig'
error: Failed to merge in the changes.
Applying: bcma: Prevent build of PCI host features in module
Using index info to reconstruct a base tree...
M	drivers/bcma/Kconfig
Falling back to patching base and 3-way merge...
Auto-merging drivers/bcma/Kconfig
CONFLICT (content): Merge conflict in drivers/bcma/Kconfig
Patch failed at 0001 bcma: Prevent build of PCI host features in module
The copy of the patch that failed is found in: .git/rebase-apply/patch

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/10161087/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
