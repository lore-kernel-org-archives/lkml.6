Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764C8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4663B2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545211071;
	bh=9aSN3aAgtnDH6zxyKtnM/vV6qgBeVNf23Ec6rLd0W8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DsXzpZnFcw6RJyvikCz89ooilEpKMq2y6JsXY7neuNVoKjusRNfeofrYIMqPuruNj
	 y8Oye7/JsmCq1tnEe8djYPM0g63D0RdfoK4vOBAdJbdVJxl5gV+NatY+TdS9wtE7um
	 xWrG+HhW+4H3IwXOVattVLc2LME2uesnmDb0adb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeLSJRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:17:50 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43058 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeLSJRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:17:50 -0500
Received: by mail-oi1-f193.google.com with SMTP id u18so1042017oie.10;
        Wed, 19 Dec 2018 01:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qsUkNlUIMMNRxs4Qf1zwhD5XASIKnmUZSMG6XvCAZ/o=;
        b=m9zplyMzA3Swu+h4tnUmppPP3TJ2JYuGQ3uyk6NFRoqhyif6w62tqQPG6mhZML8kTH
         8MvI04S+azzPdOQLs+lijOsr1V13k5qLEThH+CqAJv3pa/F6l92uwcM79pEgqn6BICWt
         PX3Y8FFe5gtim8wGyYUXsmjgW1asLYttwMZANbqs01SRfxs7wdvip+tp/9h6Ymbo9B/g
         cVFVM0zekdREzZC1MXRChNR5P3JLon8TzU7YoyIahdbM1LUJZpuR9+kBhKMstGkLBmni
         AHNsr+3BANK9jI2Vw7huT6hFq9iph/XY/IXq2rA63NUk1Tvd7rZQWKyPS+9akkZwaDjL
         faSA==
X-Gm-Message-State: AA+aEWZhQ50JNdNTPrc/2dkt6vRgbJ9yasYSAzgdESOTACpiMgSMrxv5
        ws63HHesTMGdzjbWTa0wDQp6MZrQIdoTxe0nLvE=
X-Google-Smtp-Source: AFSGD/VjB8et0XszcDX6QipeVeEZNsoQle9axGs41MOmxZ96fF6gUqVwpTeEf8Tqv4nyoppvSF7Spvd0newi1Dpe1jo=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr623680oix.246.1545211069124;
 Wed, 19 Dec 2018 01:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20181215084526.27210-1-tiny.windzz@gmail.com> <CAPDyKFq5oxDc1drn-0Tj-aBJCPCXcd_AO0q=56s9sumgiY4Dpg@mail.gmail.com>
 <20181219083223.GC31670@kroah.com>
In-Reply-To: <20181219083223.GC31670@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Dec 2018 10:17:38 +0100
Message-ID: <CAJZ5v0hW_SFsQ-oGaHUtxTEXTdNRkDjp4ZpS_MxEp9-jTYvoew@mail.gmail.com>
Subject: Re: [RESEND] PM / Domains: remove define_genpd_open_function() and define_genpd_debugfs_fops()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     tiny.windzz@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 9:32 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 17, 2018 at 09:19:07AM +0100, Ulf Hansson wrote:
> > On Sat, 15 Dec 2018 at 09:45, Yangtao Li <tiny.windzz@gmail.com> wrote:
> > >
> > > We already have the DEFINE_SHOW_ATTRIBUTE, There is no need to define
> > > such a macro, so remove define_genpd_open_function and
> > > define_genpd_debugfs_fops.
> > >
> > > Convert them to DEFINE_SHOW_ATTRIBUTE.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  drivers/base/power/domain.c | 71 +++++++++++++------------------------
> > >  1 file changed, 24 insertions(+), 47 deletions(-)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index 7f38a92b444a..10a61d6147d0 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -2671,7 +2671,7 @@ static int genpd_summary_one(struct seq_file *s,
> > >         return 0;
> > >  }
> > >
> > > -static int genpd_summary_show(struct seq_file *s, void *data)
> > > +static int summary_show(struct seq_file *s, void *data)
> >
> > Why rename the function(s)?
>
> Because the macro requires it?

Yeah.

Ulf, this looks like a good cleanup to me, any objections to this one
given the explanation above?
