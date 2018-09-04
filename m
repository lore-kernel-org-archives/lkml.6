Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E62DC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB2220867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p04brH9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB2220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeIDRtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbeIDRtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:49:51 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B35620659;
        Tue,  4 Sep 2018 13:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536067483;
        bh=eFcJGrGGXF98mW3InkU1rTjq0NCKp2adwiFw1sOGds4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p04brH9WMjacSY0JRT85nEI5cDmhLcw/oU0DFeIP/NASX9kjNEhboiSnTMO/hbgPu
         w8xbWNs5wM3L/EnVjjpyEvVvHHsfzmsR0epcJEQVWINZP8/zz/iLDbDCSGFIMoz2th
         NEMAICR3nWoU1Siz6rwVxmr3ZJi5wesPoq/bjOCQ=
Date:   Tue, 4 Sep 2018 08:24:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Punit Agrawal <punit.agrawal@arm.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, x86@kernel.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] Drop node-local allocation during host controller
 initialisation
Message-ID: <20180904132442.GB107892@bhelgaas-glaptop.roam.corp.google.com>
References: <20180828150513.32458-1-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828150513.32458-1-punit.agrawal@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 04:05:11PM +0100, Punit Agrawal wrote:
> Hi Bjorn,
> 
> As discussed before[0], here are a couple of patches to drop
> node-local allocations during host contoller initialisation. This set
> covers both arm64 and x86.
> 
> I'm posting early to give the patches time on the list as well in next
> in case there are issues we've missed.
> 
> The patches are based on v4.19-rc1 and has been boot tested on arm64
> and compile tested on x86.
> 
> Thanks,
> Punit
> 
> [0] https://www.spinics.net/lists/arm-kernel/msg669746.html
> 
> Punit Agrawal (2):
>   arm64: PCI: Remove node-local allocations when initialising host
>     controller
>   x86/PCI: Remove node-local allocation when initialising host
>     controller
> 
>  arch/arm64/kernel/pci.c | 5 ++---
>  arch/x86/pci/acpi.c     | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)

Applied with Will's ack on the arm64 patch to pci/enumeration for v4.20,
thanks!
