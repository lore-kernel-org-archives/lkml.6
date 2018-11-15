Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1789BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AF620815
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="scs2mcbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AF620815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeKPFSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:18:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=phpz53oAk3BrfAou+uAd/nvd0paqE5W8JdY45FMbq0Q=; b=scs2mcbRIKQLpfPZuNZPfF4Y4
        ONtP2C/88u82ATZjoQ8Cw6riQwprTPmah/XYtoEwYnp4ZULoUzIHDtAXq9m8GxGkbu/aYnJNK6j6s
        RNLqFekW0jmF8ikyaxeIvtxWMkuiF//titKQ2v5CFCSOCst8oqmqBlpIKp0JjLtaedRqLA9zaKjjf
        KPZ+qcsv7cuWE1jCp5qLqQ/Q9jcuVsB6DXVD5yPur0I1s/pngyhycjn06ls51QphpLcmH7AztVkxD
        eW9jmmPujYRqz+KXD1O7rJdCxceXX8hRNot8xUKgCS4Dfm09kL8iBnhXRT3zcLvUSrgEem10HYwW4
        276Pp76QQ==;
Received: from [64.114.255.114] (helo=silica.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNN1F-0000Oz-EO; Thu, 15 Nov 2018 19:09:38 +0000
Date:   Thu, 15 Nov 2018 11:09:34 -0800
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        vishal.l.verma@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zwisler@kernel.org
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
Message-ID: <20181115110919.46978343@silica.lan>
In-Reply-To: <20181115162008.GO3759@mtr-leonro.mtl.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
        <20181115061036.1575223d@silica.lan>
        <20181115162008.GO3759@mtr-leonro.mtl.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 15 Nov 2018 18:20:08 +0200
Leon Romanovsky <leon@kernel.org> escreveu:

> On Thu, Nov 15, 2018 at 06:10:36AM -0800, Mauro Carvalho Chehab wrote:
> > Em Thu, 15 Nov 2018 09:03:11 +0100
> > Geert Uytterhoeven <geert@linux-m68k.org> escreveu:
> >  
> > > Hi Dan,
> > >
> > > On Thu, Nov 15, 2018 at 6:06 AM Dan Williams <dan.j.williams@intel.com> wrote:  
> > > > Document the basic policies of the libnvdimm subsystem and provide a
> > > > first example of a Subsystem Profile for others to duplicate and edit.
> > > >
> > > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > >
> > > Thanks for your patch!
> > >  
> > > > --- /dev/null
> > > > +++ b/Documentation/nvdimm/subsystem-profile.rst  
> > >  
> > > > +Trusted Reviewers
> > > > +-----------------
> > > > +Johannes Thumshirn
> > > > +Toshi Kani
> > > > +Jeff Moyer
> > > > +Robert Elliott  
> > >
> > > Don't you want to add email addresses?
> > > Only the first one is listed in MAINTAINERS.  
> >
> > IMO, it makes sense to have their e-mails here, in a way that it could
> > easily be parsed by get_maintainers.pl.  
> 
> I personally think that list of "trusted reviewers" makes more harm than
> good. It creates unneeded negative feelings to those who wanted to be in
> this list, but for any reason they don't. Those reviewers will feel
> "untrusted".

Yeah, perhaps something like "most active reviewers" would sound
better.

Cheers,
Mauro
