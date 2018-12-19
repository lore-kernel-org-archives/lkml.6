Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D1CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8E120874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545208347;
	bh=zCZ0xP5yRbDsZi63HgRCyEbacbErSSAA4Q5FWY5OC7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zJlrsV6/eU1psxOzTM+aybZ48l1DtWRDOPcw93AH9OFYxVisSSWXLqWXNQwDeOrg7
	 v+wzf88NtxL61CkFA6OYSz8ZyK5taVWVzgRHB49VbrVCm4uTU3y5wuY5QL6wfJgK6g
	 fVDh8ypQNDCJ24CH+E5mLdPvhju+s9P+jMhSc2H4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeLSIc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:32:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbeLSIcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:32:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D987120675;
        Wed, 19 Dec 2018 08:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545208345;
        bh=zCZ0xP5yRbDsZi63HgRCyEbacbErSSAA4Q5FWY5OC7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hLDFYnpHnLJodBzswjvPSLPuCyLftAJnR+6AZ7pLkmFligTYB0deejN+cQrIleWQo
         6XoWdn1Jf7yNr6b7yMCmOoeJ8FrsRRSD+dTLvFNTvzevvwIqLur8IsjWy6DS4JPwZy
         9X73p+U5MdWa50ASByX5BW1XTOMIgkvMECHa6OVk=
Date:   Wed, 19 Dec 2018 09:32:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] PM / Domains: remove define_genpd_open_function() and
 define_genpd_debugfs_fops()
Message-ID: <20181219083223.GC31670@kroah.com>
References: <20181215084526.27210-1-tiny.windzz@gmail.com>
 <CAPDyKFq5oxDc1drn-0Tj-aBJCPCXcd_AO0q=56s9sumgiY4Dpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq5oxDc1drn-0Tj-aBJCPCXcd_AO0q=56s9sumgiY4Dpg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 09:19:07AM +0100, Ulf Hansson wrote:
> On Sat, 15 Dec 2018 at 09:45, Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > We already have the DEFINE_SHOW_ATTRIBUTE, There is no need to define
> > such a macro, so remove define_genpd_open_function and
> > define_genpd_debugfs_fops.
> >
> > Convert them to DEFINE_SHOW_ATTRIBUTE.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/base/power/domain.c | 71 +++++++++++++------------------------
> >  1 file changed, 24 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 7f38a92b444a..10a61d6147d0 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2671,7 +2671,7 @@ static int genpd_summary_one(struct seq_file *s,
> >         return 0;
> >  }
> >
> > -static int genpd_summary_show(struct seq_file *s, void *data)
> > +static int summary_show(struct seq_file *s, void *data)
> 
> Why rename the function(s)?

Because the macro requires it?
