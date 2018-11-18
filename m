Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8626C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7910220817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t62GgSZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7910220817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeKSEFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 23:05:40 -0500
Received: from casper.infradead.org ([85.118.1.10]:40838 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeKSEFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 23:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IBaf8UKoKb8i5X/Utt5shApEYwHG0VQ8RHFC2geJvdw=; b=t62GgSZnzjlia+GI9ryw13MbhZ
        Tj9X5l8rt29Hhg2LWyk2V/cHgkUlRPUis1jDe3uOnXtfnihR7RSzaZ6hmkNwbx/O01s1ftMkUiHsk
        NLFoRpSbdJP3lacCbOo68bs5NshVpSB7fM9no4I3B/l1FOlq/NJ6/eh+Oq1sowcZ7seeKYgIVDWpz
        CIRCdl2YweL53rrvGzQt/oBQ3BzDFoX124qnR55NlTXjeLyMBgJ7Ak+Bqwtu6EgHLvY8kjIpxTltX
        IP0r05YUHS6Ndqb/3xN9LSRS4ww4Y5vps37uUke8kExGM8h43MXspp61m8pFHsd4TXtfsqOSKQ9gx
        Bg74DtrQ==;
Received: from 177.17.134.91.dynamic.adsl.gvt.net.br ([177.17.134.91] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOR7h-000821-Jj; Sun, 18 Nov 2018 17:44:42 +0000
Date:   Sun, 18 Nov 2018 15:44:35 -0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, stfrench@microsoft.com,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
Message-ID: <20181118154435.04166423@coco.lan>
In-Reply-To: <CAPcyv4iVKYCdOvbwBFboR_z-Fr-8NyALkvAGCReR8EW2Y0iNmw@mail.gmail.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
        <9f6aece0-da64-78b5-0eda-fe039fc1ad09@gmail.com>
        <20181116040442.3a5ee3b9@silica.lan>
        <CAPcyv4iw78jzLQmX6foUMpVUB4ZSE2ExYhjTd87X2xraaZrkPA@mail.gmail.com>
        <20181118105829.7388cc7d@coco.lan>
        <CAPcyv4hX_B5HZ8Cj8VmjeeteZVkn-Ax8avAcUwUQqzH6J67ryA@mail.gmail.com>
        <CAPcyv4g0wKdLqDr9R3euzNrzNH5v18GJpBJeEGP4Pg+d8VMD2A@mail.gmail.com>
        <CAPcyv4iVKYCdOvbwBFboR_z-Fr-8NyALkvAGCReR8EW2Y0iNmw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 18 Nov 2018 09:34:01 -0800
Dan Williams <dan.j.williams@intel.com> escreveu:

> On Sun, Nov 18, 2018 at 9:31 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > On Sun, Nov 18, 2018 at 9:31 AM Dan Williams <dan.j.williams@intel.com> wrote:  
> [..]
> > > True, will remove. What's the point of stating daily active hours when we already have "Resubmit Cadence" (I think I'll rename it "Follow Cadence") measured in multiple days / weeks.  
> 
> Apologies, fumble-fingered that last mail. I meant to say "Follow-up
> Cadence", and that include a maintainer preference for private pings,
> or full patch set to be sent again to the list.

Yeah, "Follow-up Cadence" sounds a way better.

Thanks,
Mauro
