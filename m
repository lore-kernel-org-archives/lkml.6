Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F1013F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA30A20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA30A20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbeG3QGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:06:54 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:55921 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730217AbeG3QGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:06:54 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7DD95100CF12A;
        Mon, 30 Jul 2018 16:31:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 212A42A7EF; Mon, 30 Jul 2018 16:31:36 +0200 (CEST)
Date:   Mon, 30 Jul 2018 16:31:36 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI: Document patch submission hints
Message-ID: <20180730143136.GA4093@wunner.de>
References: <153030390808.57832.2200774416664543563.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153030405971.57832.12860154795039493576.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180701174508.GB28249@wunner.de>
 <20180712155946.GB28466@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712155946.GB28466@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:59:46AM -0500, Bjorn Helgaas wrote:
> But on reflection, I think the overall value of this writeup is
> minimal.  It's a lot of repetition of things already documented
> elsewhere and most of it boils down to "pay attention to existing
> practice and don't do things differently unless you're innovating and
> adding value."  That *should* be obvious, and if it's not, I doubt
> that adding one more thing to read is going to make it more obvious.

So my opinion is that your writeup does contain valid points that are
worth documenting:  For an open source project, a top priority is to
attract and retain contributors who improve the bus factor, who keep
the code base alive and maintained, thereby avoiding bit rot.

Knowledge diffusion, including documentation of best practices and
conventions, goes a long way towards that goal.  Your writeup was
mainly from a maintainer perspective: "consistency makes maintenance
easier".  But consistency is also valuable from a contributor
perspective:  It makes it easier to dive into a code base and find
your way around, and that includes changelogs in the git history.

There are important bits of knowledge in the writeup, if those can
be distilled, the result would very much be valuable to have in the tree.

Example:

> I generally use
> "PCI/XXX" for things in the core (mostly capabilities like MSI, AER,
> DPC, etc) and "PCI: xxx:" for drivers (shpchp, pciehp, etc).

That was in fact unknown to me.

If you find it difficult to put yourself in the shoes of a contributor,
I could try to rework the document and distill the points I find important.

Thanks,

Lukas
