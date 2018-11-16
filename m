Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ADBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89892089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VSXrsCNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89892089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389591AbeKPVpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:45:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389447AbeKPVpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X+dkFdfvJkhSv/ksSaZVvwcSQ3+jxlXQWxil+/dwsZ4=; b=VSXrsCNy+FlKcPGMNm02IJtKo
        thpb9wjx1N11LmhVkQNqx/sZz34DNTV2woLq9C+3Nit3h7Prv7gxuA8HawCmRxYzYIN3BceHWDzGJ
        /3z8vB9JKPT/0soDRMwTTHDSu4oOGIafCflLqvj7UKoDAFCL7YaL0ySXFS1A/P9e4NT9VdO4IE8zF
        WMhJ9roAUBp5FlRPLn59Cc/AUxzqrTmxgXgn85lYdJ14kViaaGEp0N0mhgLgm86YVJNQByw7l9cIt
        SqsrARzFGedVm/7Z5CkeN6S0wJyY/I3LPqQ3zY6594KiApcO5ZSPZJv1520nzRKa1CcQ6urOgiTFK
        gIZ0PmLOg==;
Received: from [64.114.255.114] (helo=silica.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNcNH-0007Yc-5Y; Fri, 16 Nov 2018 11:33:23 +0000
Date:   Fri, 16 Nov 2018 03:33:17 -0800
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        vishal.l.verma@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zwisler@kernel.org
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
Message-ID: <20181116033258.23992cde@silica.lan>
In-Reply-To: <20181115193520.GA24359@mtr-leonro.mtl.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
        <20181115061036.1575223d@silica.lan>
        <20181115162008.GO3759@mtr-leonro.mtl.com>
        <20181115110919.46978343@silica.lan>
        <20181115193520.GA24359@mtr-leonro.mtl.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 15 Nov 2018 21:35:20 +0200
Leon Romanovsky <leon@kernel.org> escreveu:

> On Thu, Nov 15, 2018 at 11:09:34AM -0800, Mauro Carvalho Chehab wrote:
> > Em Thu, 15 Nov 2018 18:20:08 +0200
> > Leon Romanovsky <leon@kernel.org> escreveu:
> >  
> > > On Thu, Nov 15, 2018 at 06:10:36AM -0800, Mauro Carvalho Chehab wrote:  
> > > > Em Thu, 15 Nov 2018 09:03:11 +0100
> > > > Geert Uytterhoeven <geert@linux-m68k.org> escreveu:
> > > >  
> > > > > Hi Dan,
> > > > >
> > > > > On Thu, Nov 15, 2018 at 6:06 AM Dan Williams <dan.j.williams@intel.com> wrote:  
> > > > > > Document the basic policies of the libnvdimm subsystem and provide a
> > > > > > first example of a Subsystem Profile for others to duplicate and edit.
> > > > > >
> > > > > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > > > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > > > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > > > >
> > > > > Thanks for your patch!
> > > > >  
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/nvdimm/subsystem-profile.rst  
> > > > >  
> > > > > > +Trusted Reviewers
> > > > > > +-----------------
> > > > > > +Johannes Thumshirn
> > > > > > +Toshi Kani
> > > > > > +Jeff Moyer
> > > > > > +Robert Elliott  
> > > > >
> > > > > Don't you want to add email addresses?
> > > > > Only the first one is listed in MAINTAINERS.  
> > > >
> > > > IMO, it makes sense to have their e-mails here, in a way that it could
> > > > easily be parsed by get_maintainers.pl.  
> > >
> > > I personally think that list of "trusted reviewers" makes more harm than
> > > good. It creates unneeded negative feelings to those who wanted to be in
> > > this list, but for any reason they don't. Those reviewers will feel
> > > "untrusted".  
> >
> > Yeah, perhaps something like "most active reviewers" would sound
> > better.  
> 
> I would recommend to remove this section at all.
> New maintainers won't come out of blue, but will be come
> from existing community and such individuals for sure will see
> and judge by themselves to whom they trust and to whom not.

I see your point, but, on the other hand, having a list with the ones
that are actively doing reviews helps newcomers.

I would keep, but perhaps it makes sense to add some notice about a
criteria about how to be included at the "active reviewers" list,
(the criteria probably belongs to the subsystem profile), e. g. 
something like:

	"Active reviewers are developers that contribute with more than 25
	 patches per year and do more than 50 reviews per year on 
	 on patches written for drivers that they're not usual contributors" 
Cheers,
Mauro
