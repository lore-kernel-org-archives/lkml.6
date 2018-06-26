Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79324C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5A526E1B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2vSGtOWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5A526E1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933995AbeFZUja (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933719AbeFZUj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:39:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2EF020836;
        Tue, 26 Jun 2018 20:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530045567;
        bh=nJtp3IMWr92STv5aO38C3vZVErDspAkg1ratFzCIOrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2vSGtOWUK8eejwlSNVBJbxWudmVKuLfVQi50BiWKk+Dyf/hu5G7V/W9MnKlFZ65ZM
         Gu1OmU5+RDQ8e/uEG6eLf3A2wBgWPWmmhz/W7R6MGkLDSrnRRiO9wS5o48q6QmyNL7
         tF36lP8nZzyDxe2hbNCKWZmpFc5Zo54SHr8O0ZJo=
Date:   Tue, 26 Jun 2018 15:39:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] PCI: shpchp: NULL pointer fix and cleanups
Message-ID: <20180626203926.GB181504@bhelgaas-glaptop.roam.corp.google.com>
References: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 05:59:33PM -0500, Bjorn Helgaas wrote:
> The first patch fixes a NULL pointer dereference reported by Marc and would
> be targeted for v4.18.
> 
> The others simplify the shpchp probe path and would be for v4.19.
> 
> ---
> 
> Bjorn Helgaas (4):
>       PCI: shpchp: Manage SHPC unconditionally on non-ACPI systems
>       PCI: shpchp: Separate existence of SHPC and permission to use it
>       PCI: shpchp: Inline shpchp_is_native()
>       PCI: hotplug: Implement hotplug_is_native() only when CONFIG_ACPI=y

I applied the first (with Marc's tested-by and Mika's reviewed-by) to
for-linus for v4.18.

I applied the others with Mika's reviewed-by to pci/hotplug for v4.19.

>  drivers/pci/hotplug/acpi_pcihp.c  |   40 +++++++++++++++++++++++--------------
>  drivers/pci/hotplug/shpchp_core.c |   21 +++++++++++++++++++
>  drivers/pci/pci-acpi.c            |   29 ---------------------------
>  include/linux/pci.h               |    1 +
>  include/linux/pci_hotplug.h       |   20 ++++++++++---------
>  5 files changed, 58 insertions(+), 53 deletions(-)
