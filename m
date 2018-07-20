Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21695ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81D320854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="oZJJsiyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81D320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388480AbeGTNT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:19:57 -0400
Received: from 8bytes.org ([81.169.241.247]:60382 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732142AbeGTNT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:19:56 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AC0802F9; Fri, 20 Jul 2018 14:31:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532089913; bh=exLbZl6ke4xgGi35nXPdmiW1GRvWQaRLKK5kyfgNhQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZJJsiyAwLQdDO2pGp+19C0JQkG0u5Si51sqijDPQ7e/yOkgjSO8W19Z7ehTY904s
         YtQzjHXyR3EYtKvZyWhLiJ7zEQRe39w7IBH1ztBaMNOd31zbhPC6xLEgNejb45mAhK
         mIKz5e7HQAcw6itqfAKuWkGH9aSbJpJu6GxXoout94N1wXpgwvMj0Z+OS8KQEJyXWT
         dXEsIjQOyU5CCs04OWaRe5QiyJzbPFHfTMkCR7H5cYLtI0E5vP59MjPO5169mSC9aB
         J4ZfbWw5Nr8aFYNqC2t/uOo3URjMFfmPofs2OF78x7MmQ//jVFPyGzUkmcq9/TU8fI
         dCwQYW/PpQ60g==
Date:   Fri, 20 Jul 2018 14:31:53 +0200
From:   =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To:     Paul Menzel <pmenzel+linux-iommu@molgen.mpg.de>
Cc:     iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MSI B350M MORTAR: `AMD-Vi: Unable to write to IOMMU perf
 counter.` and `pci 0000:00:00.2: can't derive routing for PCI INT A`
Message-ID: <20180720123153.GC18541@8bytes.org>
References: <605ca165-0071-eb7f-4c0d-b1e76ddd0e05@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <605ca165-0071-eb7f-4c0d-b1e76ddd0e05@molgen.mpg.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Jul 17, 2018 at 06:02:07PM +0200, Paul Menzel wrote:
> $ dmesg
> […]
> [    0.145696] calling  pci_iommu_init+0x0/0x3f @ 1
> [    0.145719] AMD-Vi: Unable to write to IOMMU perf counter.

This is likely a firmware issue. Either the IVRS ACPI table is incorrect
or the BIOS did not enable the performance counter feature in the IOMMU
hardware. Are you running on the latest BIOS?


	Joerg

