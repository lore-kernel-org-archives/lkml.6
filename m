Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D268BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956092087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QmE97tTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956092087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeKPVvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:51:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeKPVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vjPkiPx/rdJ9H7KqqQtqHZ6pWWUGqLR0jA0sRmdIOnk=; b=QmE97tTFCq39Y6bC3Uo/pDUir
        tFZCZouOOmaEoc9PITJtAZJsX0cZ6Vr25CKhGSoC6FbtCxchTChiIxC7IKQsD6Yvrw8aaJ43FKzJb
        DLCGhlkS/KYWGGQKregvBUD7sqnnG6jdT0ZLFW90DKl8fJ+inz/pYsCN2BZBwlgQ3LpCezx/By3EM
        MvHevb/Y6VK4Gy1e9V/i2GYL8UtykM456jgj+uvNa12jTj8hFyuDq0Qf1sLDa0ImngIaAu3v4NmnP
        k3pIc4E+zk/ZL6mHACZmw7+MrVf/pGtU0G5gZATde2dNCseI7QRNxM4/Cbp9A1KFDLyXNoN3AghR0
        fylttXZmQ==;
Received: from [64.114.255.114] (helo=silica.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNcTW-0000uE-Ao; Fri, 16 Nov 2018 11:39:50 +0000
Date:   Fri, 16 Nov 2018 03:39:47 -0800
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
Message-ID: <20181116033947.5689b51c@silica.lan>
In-Reply-To: <e4efcfd8c99ef197714230cb1eb246b39dc83151.camel@perches.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
        <20181115061036.1575223d@silica.lan>
        <20181115162008.GO3759@mtr-leonro.mtl.com>
        <20181115110919.46978343@silica.lan>
        <20181115193520.GA24359@mtr-leonro.mtl.com>
        <3908561D78D1C84285E8C5FCA982C28F7D459E55@ORSMSX110.amr.corp.intel.com>
        <e4efcfd8c99ef197714230cb1eb246b39dc83151.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 15 Nov 2018 11:43:51 -0800
Joe Perches <joe@perches.com> escreveu:

> On Thu, 2018-11-15 at 19:40 +0000, Luck, Tony wrote:
> > > I would recommend to remove this section at all.
> > > New maintainers won't come out of blue, but will be come
> > > from existing community and such individuals for sure will see
> > > and judge by themselves to whom they trust and to whom not.  
> > 
> > Perhaps this is more of a hint to contributors than to maintainers
> > (see earlier discussion on who is the target audience for these documents).
> > 
> > It would help contributors know some names of useful reviewers (and
> > thus this list should be picked up by scripts/get_maintainer.pl to help
> > the user compose Cc: lists for e-mail patches).  
> 
> Trusted reviewers should be specifically listed
> in the MAINTAINERS file with an "R:" entry.
> 
> get_maintainers should not look anywhere else.

I know that making get_maintainers to look elsewhere can make it more
complex and slower, but IMHO, by having a per-subsystem profile, this is
unavoidable.

The thing is that touching at a single MAINTAINERS file every time a new
reviewer comes is painful. Also, MAINTAINERS file format doesn't allow
adding free text explaining the criteria for someone to become a
reviewer.

IMO, having reviewers on a per-subsystem file, where one could explain
the criteria for being added there will make easier to attract more
reviewers.

Cheers,
Mauro
