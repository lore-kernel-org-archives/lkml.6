Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A722C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3461420842
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfBZKZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:25:30 -0500
Received: from 8bytes.org ([81.169.241.247]:41386 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfBZKZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:25:30 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4048641A; Tue, 26 Feb 2019 11:25:29 +0100 (CET)
Date:   Tue, 26 Feb 2019 11:25:27 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Julia Cartwright <julia@ni.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] iommu/dmar: fix buffer overflow during PCI bus
 notification
Message-ID: <20190226102527.GF20740@8bytes.org>
References: <20190220164630.11087-1-julia@ni.com>
 <20190220191744.GC1076@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220191744.GC1076@jcartwri.amer.corp.natinst.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 07:17:45PM +0000, Julia Cartwright wrote:
> On Wed, Feb 20, 2019 at 10:46:31AM -0600, Julia Cartwright wrote:
> > -	size = sizeof(*info) + level * sizeof(struct acpi_dmar_pci_path);
> > +	size = sizeof(*info) + level * sizeof(info->path[0]);
> 
> This is probably a candidate for struct_size() instead, if that's what
> is preferred.

No, patch is fine as-is. Thanks a lot, applied to iommu/fixes branch.


	Joerg
