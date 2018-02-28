Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbeB1OjF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:39:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43464 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752571AbeB1OjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:39:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0601760271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ssb: Prevent build of PCI host features in module
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1515767159-17226-1-git-send-email-matt.redfearn@mips.com>
References: <1515767159-17226-1-git-send-email-matt.redfearn@mips.com>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Michael Buesch <m@bues.ch>, <linux-wireless@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180228143901.4799760272@smtp.codeaurora.org>
Date: Wed, 28 Feb 2018 14:39:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Redfearn <matt.redfearn@mips.com> wrote:

> Attempting to build ssb.ko with CONFIG_SSB_DRIVER_PCICORE=y results in
> a build error due to use of symbols not exported from vmlinux:
> 
> ERROR: "pcibios_enable_device" [drivers/ssb/ssb.ko] undefined!
> ERROR: "register_pci_controller" [drivers/ssb/ssb.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
> 
> To prevent this, don't allow the host mode feature to be built if
> CONFIG_SSB=m
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Patch applied to wireless-drivers-next.git, thanks.

882164a4a928 ssb: Prevent build of PCI host features in module

-- 
https://patchwork.kernel.org/patch/10161131/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
