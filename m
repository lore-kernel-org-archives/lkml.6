Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3426C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F45C20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaCgGm9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F45C20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeG3Xdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731606AbeG3Xdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:33:47 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 744BD20890;
        Mon, 30 Jul 2018 21:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532987807;
        bh=DlWE536LTbxp025/4JGxB7zD/0iu3EBEMrtbntkPTSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gaCgGm9+X/Quw3NtLeABCBpOB06elKvviWW52w+iKmV4Nfg7WbAr0EK3G6gycwivO
         T4QbCpogcKp8JAAn9OuSw38xAkc1MdPufAGxVMEC9dXbQxAKsxzQV7zpTVkZB2MVb0
         xsn8T9Zy1JJ7MIbYk1Gh4tr2c4WlZ3pCC6OvlUdE=
Date:   Mon, 30 Jul 2018 16:56:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI: Document patch submission hints
Message-ID: <20180730215646.GD45322@bhelgaas-glaptop.roam.corp.google.com>
References: <153030390808.57832.2200774416664543563.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153030405971.57832.12860154795039493576.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180701174508.GB28249@wunner.de>
 <20180712155946.GB28466@bhelgaas-glaptop.roam.corp.google.com>
 <20180730143136.GA4093@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730143136.GA4093@wunner.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 04:31:36PM +0200, Lukas Wunner wrote:
> On Thu, Jul 12, 2018 at 10:59:46AM -0500, Bjorn Helgaas wrote:
> > But on reflection, I think the overall value of this writeup is
> > minimal.  It's a lot of repetition of things already documented
> > elsewhere and most of it boils down to "pay attention to existing
> > practice and don't do things differently unless you're innovating and
> > adding value."  That *should* be obvious, and if it's not, I doubt
> > that adding one more thing to read is going to make it more obvious.
> 
> So my opinion is that your writeup does contain valid points that are
> worth documenting:  For an open source project, a top priority is to
> attract and retain contributors who improve the bus factor, who keep
> the code base alive and maintained, thereby avoiding bit rot.
> 
> Knowledge diffusion, including documentation of best practices and
> conventions, goes a long way towards that goal.  Your writeup was
> mainly from a maintainer perspective: "consistency makes maintenance
> easier".  But consistency is also valuable from a contributor
> perspective:  It makes it easier to dive into a code base and find
> your way around, and that includes changelogs in the git history.
> 
> There are important bits of knowledge in the writeup, if those can
> be distilled, the result would very much be valuable to have in the tree.
> 
> Example:
> 
> > I generally use
> > "PCI/XXX" for things in the core (mostly capabilities like MSI, AER,
> > DPC, etc) and "PCI: xxx:" for drivers (shpchp, pciehp, etc).
> 
> That was in fact unknown to me.
> 
> If you find it difficult to put yourself in the shoes of a contributor,
> I could try to rework the document and distill the points I find important.

I definitely want to make it easy and attractive for people to
contribute to Linux in general.  I'd be glad for any hints.  You're
right, it's hard for me to put myself in the shoes of a contributor,
at least a new one.

I guess I'm hesitant because a lot of the things I included there seem
like they border on the obsessive, and I don't want to ask
contributors to make trivial changes to fit in with my personal
quirks.  Since they're my quirks, I'd rather just silently fix them up
as I apply patches.

If there were a wider consensus on some things and they could be
folded into Documentation/process/ somehow, that would be ideal, but
I'm not sure there would be enough of a consensus, and I don't really
want to start a big discussion about it.  But maybe there are a few
things that wouldn't be controversial, I dunno.

Bjorn
