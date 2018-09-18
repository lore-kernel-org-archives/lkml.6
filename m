Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2967C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDC621471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdsTrw30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDC621471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeISDdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbeISDdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:33:32 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5753B2146D;
        Tue, 18 Sep 2018 21:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537307935;
        bh=JlVG88e+3giRnmFhujpHOm8iBLLgnTekXuXVYFxGgWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdsTrw30w65b6/LOug3lxt9NlRJG7J8s4nayZmunHa4IWg1poSyFFtQVD+2QrqeSp
         dNmrYuzKNoKzjkppbvjaj8UYKEu0YZilQUKx3AdejXF74r3UWLkbxBfZeUlFAz10hX
         uZqeSVUJaei5mWbS7+v4eWIzONg4wsVv6q7Zh0aI=
Date:   Tue, 18 Sep 2018 16:58:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
Message-ID: <20180918215854.GH13616@bhelgaas-glaptop.roam.corp.google.com>
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
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I applied the following to for-linus for v4.19.  Russell, if you want
to be removed, let me know and I'll do that.

commit 3fed0e04026c
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Sep 12 11:55:26 2018 -0500

    MAINTAINERS: Update PPC contacts for PCI core error handling
    
    The original PCI error recovery functionality was for the powerpc-specific
    IBM EEH feature.  PCIe subsequently added some similar features, including
    AER and DPC, that can be used on any architecture.
    
    We want the generic PCI core error handling support to work with all of
    these features.  Driver error recovery callbacks should be independent of
    which feature the platform provides.
    
    Add the generic PCI core error recovery files to the powerpc EEH
    MAINTAINERS entry so the powerpc folks will be copied on changes to the
    generic PCI error handling strategy.
    
    Add Sam and Oliver as maintainers for this area.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ece30f15777..f23244003836 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11203,8 +11203,14 @@ F:	tools/pci/
 
 PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
 M:	Russell Currey <ruscur@russell.cc>
+M:	Sam Bobroff <sbobroff@linux.ibm.com>
+M:	Oliver O'Halloran <oliveroh@au1.ibm.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
+F:	Documentation/PCI/pci-error-recovery.txt
+F:	drivers/pci/pcie/aer.c
+F:	drivers/pci/pcie/dpc.c
+F:	drivers/pci/pcie/err.c
 F:	Documentation/powerpc/eeh-pci-error-recovery.txt
 F:	arch/powerpc/kernel/eeh*.c
 F:	arch/powerpc/platforms/*/eeh*.c
