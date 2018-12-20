Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F3AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24B9218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbeLTVOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:14:02 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49956 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbeLTVOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:14:02 -0500
Received: from 89-77-194-223.dynamic.chello.pl (89.77.194.223) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id c92e7aeba1ec9840; Thu, 20 Dec 2018 22:14:00 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] PM / Domains: remove define_genpd_open_function() and define_genpd_debugfs_fops()
Date:   Thu, 20 Dec 2018 22:13:33 +0100
Message-ID: <3394539.b4fEdePmXH@aspire.rjw.lan>
In-Reply-To: <CAPDyKFpZkmVOCOdkcOuF_4nGcy-mwW8BdYeE7CBR2eJH5Qn0cg@mail.gmail.com>
References: <20181215084526.27210-1-tiny.windzz@gmail.com> <CAJZ5v0hW_SFsQ-oGaHUtxTEXTdNRkDjp4ZpS_MxEp9-jTYvoew@mail.gmail.com> <CAPDyKFpZkmVOCOdkcOuF_4nGcy-mwW8BdYeE7CBR2eJH5Qn0cg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, December 19, 2018 10:20:22 AM CET Ulf Hansson wrote:
> On Wed, 19 Dec 2018 at 10:17, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Dec 19, 2018 at 9:32 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Dec 17, 2018 at 09:19:07AM +0100, Ulf Hansson wrote:
> > > > On Sat, 15 Dec 2018 at 09:45, Yangtao Li <tiny.windzz@gmail.com> wrote:
> > > > >
> > > > > We already have the DEFINE_SHOW_ATTRIBUTE, There is no need to define
> > > > > such a macro, so remove define_genpd_open_function and
> > > > > define_genpd_debugfs_fops.
> > > > >
> > > > > Convert them to DEFINE_SHOW_ATTRIBUTE.
> > > > >
> > > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > > ---
> > > > >  drivers/base/power/domain.c | 71 +++++++++++++------------------------
> > > > >  1 file changed, 24 insertions(+), 47 deletions(-)
> > > > >
> > > > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > > > index 7f38a92b444a..10a61d6147d0 100644
> > > > > --- a/drivers/base/power/domain.c
> > > > > +++ b/drivers/base/power/domain.c
> > > > > @@ -2671,7 +2671,7 @@ static int genpd_summary_one(struct seq_file *s,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > -static int genpd_summary_show(struct seq_file *s, void *data)
> > > > > +static int summary_show(struct seq_file *s, void *data)
> > > >
> > > > Why rename the function(s)?
> > >
> > > Because the macro requires it?
> >
> > Yeah.
> >
> > Ulf, this looks like a good cleanup to me, any objections to this one
> > given the explanation above?
> 
> It looks good to me, I just didn't go into the details of how the
> macro works. Now I know, so please add:
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

So the patch has been applied, thanks!

