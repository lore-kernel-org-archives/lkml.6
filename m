Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B44C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC662238E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHbpvuvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC662238E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeHIWCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeHIWCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:02:11 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 883792238D;
        Thu,  9 Aug 2018 19:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533843354;
        bh=E3x1iniNupg8cgZkRSOgE6Kl27vf+vz4siI20PLsuRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHbpvuvfBIu3ZDOmPFC/Z7ieTg90TkjeOXVScS5k7koUvbrFE+7A5Ydn8ndZ7P76Y
         Wn7odw+PhMfBMS3ChzuSYFx2IlTYeHI8jsUy9hNf7lM2GHKpgpQxAI6G+E6TueSOpq
         tGsa8nmtvhTM3+BzOcD/fO9MgsPD17fHvKJlnwJ4=
Date:   Thu, 9 Aug 2018 14:35:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 3/3] PCI: Intel DC P3700 NVMe delay after FLR quirk
Message-ID: <20180809193553.GD113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180724160440.2729.75178.stgit@gimli.home>
 <20180724161446.2729.78211.stgit@gimli.home>
 <20180724101849.36f635eb@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724101849.36f635eb@t450s.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:18:48AM -0600, Alex Williamson wrote:
> On Tue, 24 Jul 2018 10:14:46 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > Add a device specific reset for Intel DC P3700 NVMe device which
> > exhibits a timeout failure in drivers waiting for the ready status to
> > update after NVMe enable if the driver interacts with the device too
> > quickly after FLR.  As this has been observed in device assignment
> > scenarios, resolve this with a device specific reset quirk to add an
> > additional, heuristically determined, delay after the FLR completes.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/pci/quirks.c |   22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> 
> I forgot to link the bz in this one, if this somehow becomes the final
> version, please add:
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=159265

Corrected link to: https://bugzilla.redhat.com/show_bug.cgi?id=1592654
