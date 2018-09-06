Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD518C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA5A2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyNNAAmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA5A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeIFSpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbeIFSpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:45:13 -0400
Received: from localhost (207.sub-174-234-153.myvzw.com [174.234.153.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A364F20645;
        Thu,  6 Sep 2018 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536242970;
        bh=qgoon6Y67VDJnp24RKPbzyuC2Cpcs0L6EwzENlRWKzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uyNNAAmLs0d2tVIQUtBB63V0ZNDo3dRfth7gOn/ZTdpM5jPwRPPYASatCedjrFyJC
         RZStVPRpAkWiMa1sDLJY8DAANfMuJ4hHVDkMtVRW1B9/bgoklJ17UANsQ58KAybily
         0IJv4BAxlq9WGP7rz+E06JVqGsJu6zCSJAID5GxI=
Date:   Thu, 6 Sep 2018 09:09:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 2/2] pci: dwc: add UniPhier PCIe host controller support
Message-ID: <20180906140926.GB214747@bhelgaas-glaptop.roam.corp.google.com>
References: <1536114731-28630-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20180905172529.GO107892@bhelgaas-glaptop.roam.corp.google.com>
 <20180906103819.252A.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906103819.252A.4A936039@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:38:20AM +0900, Kunihiko Hayashi wrote:
> > > +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> > > @@ -0,0 +1,464 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +//
> > > +// PCI-express host controller driver for UniPhier SoCs
> > > +// Copyright 2018 Socionext Inc.
> > > +// Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > 
> > Use /* ... */ comments except for the SPDX line.
> 
> Okay, although I wondered which way to put, I'll replace the header next.

The easiest thing is to look at similar files already in the tree and
follow their style.  The details are here:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n540
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst#n74
