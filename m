Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13D9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A789F217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0fjRE1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeLSJVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:21:00 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39747 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeLSJVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:21:00 -0500
Received: by mail-vs1-f67.google.com with SMTP id h78so11817590vsi.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 01:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jwOSPIUkvMHHMPtyYu3h7UE1mGniOMIiehMNCntfcJ0=;
        b=T0fjRE1+ehyFnhUt4Nwj4qeRnmdxUcKSEPvMrvoSa2VNO+kvLz96HWX7Z2etNInEgF
         MIU2Bwnrjs30d45aR9B9cWAFyf25/M1GVu5JIS+EEdYUfYI9R2HekHYhI1zQEyMVY0Ez
         Y3WRM48IovGdUH7n2QAeYKQA+/qpNMbl4GuJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jwOSPIUkvMHHMPtyYu3h7UE1mGniOMIiehMNCntfcJ0=;
        b=s2vNuqkjKlYbp9an1oquDk8FUB3RxlnD0erUa2zZXBhYYXp2f2HQklPO6cVqgKDwyb
         uk43sAd2gNU1eeuRCHNg6Lnk8WmwA90Bn6Hugy2LBKUaWoQ9bhXJYBP/1LV2IfSKST3i
         KZYPYrQ9/rcPl9yxBU3qqhPBnfcThuEM8SQx2/eKIRJr3oFP08gFyLHN8VAwrGkwXTQE
         AA1pIyra85JDTKzrPWlh+NiVHo3CmYTPUBGk1cl1VBRHLb8Qk0tpgvtmMbxZKom1e1VG
         aR/YGmXWeY8Q4ORA/Z2CKyrqyuWEc2K2F4VT2sUbl68qNFXsxIrZV/9J0B9NaA0NCFAk
         0P8g==
X-Gm-Message-State: AA+aEWYKOmnUUoLHU1U7wFQrPqIbMyfJESmwiX0ozw1sLxs9u/ezJqP/
        YQFwTfbACREpZvqB9zWoKvlcnbFh9yq5BBQev+irdw==
X-Google-Smtp-Source: AFSGD/UCnKXJkWdNQXs4UoGbU7AXbsC2v/Y8VQOygO4VSjKVXAQUECmuyiq1ODLLXuHyZ1TmRG5ampR+rTLVqom3NFg=
X-Received: by 2002:a67:7685:: with SMTP id r127mr9727630vsc.35.1545211258971;
 Wed, 19 Dec 2018 01:20:58 -0800 (PST)
MIME-Version: 1.0
References: <20181215084526.27210-1-tiny.windzz@gmail.com> <CAPDyKFq5oxDc1drn-0Tj-aBJCPCXcd_AO0q=56s9sumgiY4Dpg@mail.gmail.com>
 <20181219083223.GC31670@kroah.com> <CAJZ5v0hW_SFsQ-oGaHUtxTEXTdNRkDjp4ZpS_MxEp9-jTYvoew@mail.gmail.com>
In-Reply-To: <CAJZ5v0hW_SFsQ-oGaHUtxTEXTdNRkDjp4ZpS_MxEp9-jTYvoew@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Dec 2018 10:20:22 +0100
Message-ID: <CAPDyKFpZkmVOCOdkcOuF_4nGcy-mwW8BdYeE7CBR2eJH5Qn0cg@mail.gmail.com>
Subject: Re: [RESEND] PM / Domains: remove define_genpd_open_function() and define_genpd_debugfs_fops()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 10:17, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Dec 19, 2018 at 9:32 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Dec 17, 2018 at 09:19:07AM +0100, Ulf Hansson wrote:
> > > On Sat, 15 Dec 2018 at 09:45, Yangtao Li <tiny.windzz@gmail.com> wrote:
> > > >
> > > > We already have the DEFINE_SHOW_ATTRIBUTE, There is no need to define
> > > > such a macro, so remove define_genpd_open_function and
> > > > define_genpd_debugfs_fops.
> > > >
> > > > Convert them to DEFINE_SHOW_ATTRIBUTE.
> > > >
> > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > ---
> > > >  drivers/base/power/domain.c | 71 +++++++++++++------------------------
> > > >  1 file changed, 24 insertions(+), 47 deletions(-)
> > > >
> > > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > > index 7f38a92b444a..10a61d6147d0 100644
> > > > --- a/drivers/base/power/domain.c
> > > > +++ b/drivers/base/power/domain.c
> > > > @@ -2671,7 +2671,7 @@ static int genpd_summary_one(struct seq_file *s,
> > > >         return 0;
> > > >  }
> > > >
> > > > -static int genpd_summary_show(struct seq_file *s, void *data)
> > > > +static int summary_show(struct seq_file *s, void *data)
> > >
> > > Why rename the function(s)?
> >
> > Because the macro requires it?
>
> Yeah.
>
> Ulf, this looks like a good cleanup to me, any objections to this one
> given the explanation above?

It looks good to me, I just didn't go into the details of how the
macro works. Now I know, so please add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
