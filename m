Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299C7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABB7223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eQ4yVsQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABB7223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388219AbeKPASw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:18:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbeKPASw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SnYnzoOFTWbR4aDfq75s5cI4Y2vWWsWAta9dBjE2ERI=; b=eQ4yVsQcCHAe7FrESK6P8VZ11
        w0W2u5SP8UbbzIVWrdGlwHxZMEUw6m8s2ED+7BjRRSsEbFco4L+XLPemczgt9vZar9lh56nkj7I8/
        WhLbMrkArLaM1bk2VgpXskvVeF75b0GZ09ZBkLNbiC7k85Fbo9QdrGXGMZX1dcHK1BWoAg48lMWYK
        r0pJ4Y/6qnqsQvMvjoGygr85y+q5F9m+LmQ8Iu8XUkATMR0iRJKvkEKtV1ahSdnR9msG71WzSHXCO
        +d4PzPb3UAjBnBNFgXRztjWbzdQ043BDHiHzJcQoYs+IqW/1fm+gn3dFFWaMSAcPTBqlg9cuxO5eg
        oC5tNxVBQ==;
Received: from 189.27.28.95.dynamic.adsl.gvt.net.br ([189.27.28.95] helo=silica.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNIM5-0000z6-0I; Thu, 15 Nov 2018 14:10:50 +0000
Date:   Thu, 15 Nov 2018 06:10:36 -0800
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        vishal.l.verma@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zwisler@kernel.org
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
Message-ID: <20181115061036.1575223d@silica.lan>
In-Reply-To: <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 15 Nov 2018 09:03:11 +0100
Geert Uytterhoeven <geert@linux-m68k.org> escreveu:

> Hi Dan,
> 
> On Thu, Nov 15, 2018 at 6:06 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > Document the basic policies of the libnvdimm subsystem and provide a
> > first example of a Subsystem Profile for others to duplicate and edit.
> >
> > Cc: Ross Zwisler <zwisler@kernel.org>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> 
> Thanks for your patch!
> 
> > --- /dev/null
> > +++ b/Documentation/nvdimm/subsystem-profile.rst  
> 
> > +Trusted Reviewers
> > +-----------------
> > +Johannes Thumshirn
> > +Toshi Kani
> > +Jeff Moyer
> > +Robert Elliott  
> 
> Don't you want to add email addresses?
> Only the first one is listed in MAINTAINERS.

IMO, it makes sense to have their e-mails here, in a way that it could
easily be parsed by get_maintainers.pl.

That's said, IMO a given subsystem should either use the R: tag at
MAINTAINERS or have a list of reviewers or sub-maintainers here, as
maintaining duplicated information will be painful.

If we go to this path, we should probably document it at MAINTAINERS
file.

> 
> > +Time Zone / Office Hours
> > +------------------------
> > +8:00am to 5:00pm Pacific Time Zone  
> 
> UTC-???
> 
> People are not familiar with all time zones.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 




Cheers,
Mauro
