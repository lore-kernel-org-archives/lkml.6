Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DF0C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7992089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ERd01XQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7992089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJICqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:46:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJICqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FZe1sLBWk+/pKLome/CJHSZ2aX/RsvVArxY2740hYt4=; b=ERd01XQkrbo/YFNb6EuyznDDQ
        g6CgPNwQX5Uvxtu9dcvwXANgu70W7bSec5yUWIN/sO6G5Yja5zMvZiMYIFdKrNpdM0JQDQEG2Cpjv
        qNsQZaJRveHSIrZL9duReqO3JYUbV+4jVriMb4UYCe/tEKS6k7sVzx4f1D9DItHOi6fR0CA15+52o
        cWKUluRbtOOv/qL87YBEtZ+1v6RpmsFZBAqvBE2DIiKQ4rT+emLVB2WXvHbj7kA5Aq+BeAi7z0PL1
        jIfZMIo8n+L96aEOkCOITPiSBj8vuaAaEHzJZjJV8mw1r5bg6RjuCdVPwNYbnL+/rwX6MYkE4l32h
        uln/4aFOg==;
Received: from [179.183.98.126] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9bGo-0001es-OA; Mon, 08 Oct 2018 19:32:47 +0000
Date:   Mon, 8 Oct 2018 16:32:43 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the
 ambiguity about collecting email addresses
Message-ID: <20181008163243.72825e05@coco.lan>
In-Reply-To: <CAPM=9tzU_wy77j=sx9u9gFsJp-M4ktH7hLQE5=_wKbow9p+iuQ@mail.gmail.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
        <1538861799.4088.6.camel@HansenPartnership.com>
        <CAPM=9tz3Z=vD6qWUL2boZGEAgMeC_o9euBXFu2V58RHOn6gR9g@mail.gmail.com>
        <20181007225613.GZ32577@ZenIV.linux.org.uk>
        <CAPM=9tzU_wy77j=sx9u9gFsJp-M4ktH7hLQE5=_wKbow9p+iuQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 8 Oct 2018 09:37:59 +1000
Dave Airlie <airlied@gmail.com> escreveu:

> On Mon, 8 Oct 2018 at 08:56, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Mon, Oct 08, 2018 at 08:25:35AM +1000, Dave Airlie wrote:
> >  
> > > This isn't a legally binding license or anything, but departing from
> > > the upstream wording makes it tricker to merge new upstream versions
> > > if they are considered appropriate.  
> >
> > Nicely done, that - gotta love the passive voice use.  Considered appropriate
> > *by* *whom*?  
> 
> Good question, do we have a CoC maintainer? Is Linus it, Greg, TAB?
> 
> Maybe step one is to find the person who can make changes to the
> kernel CoC (has anyone checked if Linus or Greg will merge this).

If we add it to the MAINTAINERS file (with makes perfect sense to me),
I would like to have a R: entry there, in order to be notified when
people propose changes to it. My personal understanding is that it may 
have legal value under the legislation of the Country I live, and I'd
like to understand changes there that might affect my workflow.

Thanks,
Mauro
