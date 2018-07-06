Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867FFC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF9D23FFA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF9D23FFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933578AbeGFQSs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:18:48 -0400
Received: from foss.arm.com ([217.140.101.70]:39606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932483AbeGFQSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:18:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F47418A;
        Fri,  6 Jul 2018 09:18:45 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E66D3F2EA;
        Fri,  6 Jul 2018 09:18:43 -0700 (PDT)
Date:   Fri, 6 Jul 2018 17:20:34 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Improve Broadcom PAXC support
Message-ID: <20180706162034.GA14923@red-moon>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 05:21:02PM -0700, Ray Jui wrote:
> This patch series improves the Broadcom PAXC support by 1) adding more
> quirks for specific versions of PAXC controllers; 2) adding logic to
> reject internally unconfigured physical functions from the embedded
> network processor acting as endpoint; 3) reducing verbose print level
> in the outbound/inbound mapping code

Nit: commit log sentences must be terminated with periods, that's valid
for all patches in your series inclusive of this cover letter, I can
change them myself but pointing this out so that you will be able
to do it yourself next time.

Lorenzo

> This patch series is based off v4.17 and is available on GIHUB:
> repo: https://github.com/Broadcom/arm64-linux.git
> branch: sr-paxc-v2
> 
> Changes since v1:
>  - consolidate 2 PAXC related patch series into 1
>  - change the way how the capability list corruption is handled, per
> recommendation from Bjorn. Now handle and fix up the corruption at
> the config register read
>  - rebase to v4.17
> 
> Ray Jui (5):
>   PCI: iproc: Activate PAXC bridge quirk for more devices
>   PCI: iproc: Fix up corrupted PAXC root complex config registers
>   PCI: iproc: Disable MSI parsing in certain PAXC blocks
>   PCI: iproc: Reject unconfigured physical functions from PAXC
>   PCI: iproc: Reduce inbound/outbound mapping print level
> 
>  drivers/pci/host/pcie-iproc.c | 159 +++++++++++++++++++++++++++++++++++-------
>  drivers/pci/host/pcie-iproc.h |   8 +++
>  drivers/pci/quirks.c          |   3 +
>  3 files changed, 144 insertions(+), 26 deletions(-)
> 
> -- 
> 2.1.4
> 
