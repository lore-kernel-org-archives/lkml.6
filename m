Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60565C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3849320661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfB0N6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:58:40 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44922 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730440AbfB0N6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:58:39 -0500
Received: by mail-qk1-f194.google.com with SMTP id r21so9820291qkl.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 05:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d8KlSWGc+FxaDgpFUdHpRtzp4ejIxoadxmn8hkzf1A8=;
        b=Vw0+iQyge6/UakbtRK3M34W99T/IRq74ZNKDXaPmyAmk97Ev6qQ6Xmj6nj8iX9pzJD
         2bBuBfvkAhJjH4OLXcK4P+s8pipcR/ZS6LJwwnufAtxj+Ub7nRcKQkEO3SUZ1ekPrByc
         lNcGaA0Gy7fXmBQtLfE6k1TbaewwXWcnlI3R9Ceb+LA0o7cuuBy1UyNcrQ5j4RypAP7s
         Db8G+dCN82R6Ev/s8JVtifFsLf2f+MFs+PDH1Se1XzH8swTemIku+sSgAqEbAa6KhITp
         sS2fD835eMB8BUhK2hkwb3YxEdax4IkNrmdUPVjm+znoMlfjJEKQA7c6WEhxRw85pE5i
         Y/aw==
X-Gm-Message-State: APjAAAVH5GhsBwcufN0r9BzP8raylrDPFH0fDdoFaAZTJ2JH2I7pEjJJ
        gqhJO0+UAlJts7oNeMw1YBcDjA==
X-Google-Smtp-Source: AHgI3Ibnsh4Z2UAPVimDyX5Tlzqpa7OrCn/h2ReQCzmFcwDXirIrKgybxWdWQS9HMPHzBgHAhZJMGQ==
X-Received: by 2002:a37:85c7:: with SMTP id h190mr2239430qkd.225.1551275918997;
        Wed, 27 Feb 2019 05:58:38 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id j9sm8114590qtb.30.2019.02.27.05.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 05:58:38 -0800 (PST)
Date:   Wed, 27 Feb 2019 08:58:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>
Subject: Re: linux-next: manual merge of the vhost tree with the iommu tree
Message-ID: <20190227085546-mutt-send-email-mst@kernel.org>
References: <20190227152506.4696a59f@canb.auug.org.au>
 <2370af99-9dc1-b694-9f1c-1951d1e70435@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2370af99-9dc1-b694-9f1c-1951d1e70435@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:30:27AM +0000, Jean-Philippe Brucker wrote:
> On 27/02/2019 04:25, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the vhost tree got conflicts in:
> > 
> >   drivers/iommu/Kconfig
> >   drivers/iommu/Makefile
> > 
> > between commit:
> > 
> >   004240dcc222 ("iommu/hyper-v: Add Hyper-V stub IOMMU driver")
> > 
> > from the iommu tree and commit:
> > 
> >   d906f4225497 ("iommu: Add virtio-iommu driver")
> > 
> > from the vhost tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> Thanks Stephen, sorry about the extra work. The virtio-iommu driver was
> helpfully added to the vhost tree to ensure it doesn't break anything,
> but since Joerg has some reservations, only the hyper-v change will be
> merged in v5.1. I'd welcome a change of heart however, in which case the
> driver should probably go via the iommu tree to avoid conflicts.
> 
> Thanks,
> Jean

Even though it's not going into 5.1 I feel it's helpful to keep it in
the vhost tree until the next cycle, it helps make sure unrelated
changes don't break it.

-- 
MST
