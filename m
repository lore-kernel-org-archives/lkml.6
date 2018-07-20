Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF79ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A035206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="aau+KY+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A035206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388875AbeGTNWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:22:54 -0400
Received: from 8bytes.org ([81.169.241.247]:60588 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388215AbeGTNWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:22:54 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A14EB2DE; Fri, 20 Jul 2018 14:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532090090; bh=pv+hXLEyxJVCWUwDHM6EV7VOIf8ZpK/7ztTeo5JxZlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aau+KY+adg5upiD9pMQSxlxF5J5UXvJQHCFBlGi+/bp+UspMzWsTrP40DGANDK+BO
         SRrm8ZE0a++/vgDlB4hub+ZGJBCiD1cl7erdEGvdCTLYpUNss9E/zRql7GxhqrMoNS
         y36Fk9kC4w8eMzAE69RwRvFCb+Ui/BvlFJID2Ot4wJTUhEH8swzDL5qdSteQtykCQo
         zAlg6BlE5UnP+EQE1TR9Efc67I7T4HoiuTp8WDQCnOeglOXk5UD1FdgjzsKfX5FYja
         HqBLfO+MKoy5KrAEqfVD+YUf/BlBZqcIsgoIx81X0dZAGBgbi/1jG7SRaKSEGLP+pv
         l7Shot6ORfoKg==
Date:   Fri, 20 Jul 2018 14:34:50 +0200
From:   =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To:     Paul Menzel <pmenzel+linux-iommu@molgen.mpg.de>
Cc:     iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AMD-Vi: Decrease time of enabling lazy IO/TLB flushing
Message-ID: <20180720123450.GD18541@8bytes.org>
References: <f7edc791-7e30-6fce-02ff-a5d2b52d2a69@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7edc791-7e30-6fce-02ff-a5d2b52d2a69@molgen.mpg.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 06:07:07PM +0200, Paul Menzel wrote:
> On a MSI B350M MORTAR with AMD Ryzen 3 2200g (Raven) with Linux 4.18-rc5+
> and Debian Sid/unstable `pci_iommu_init` takes 40 ms according to
> `initcall_debug`.

40ms is a lot indeed, but IOMMU initialization is also a complex process
which includes scanning ACPI tables, allocating memory, flushing
hardware caches (which probably accounts for a fair amount of the time
needed).

Would be good if someone can come up with patches to improve the
situation here, as I don't know when I will find the time to look into
that.


Thanks,

	Joerg
