Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CA0C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624782146E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548430432;
	bh=WjkqafWbRIcHoKvZHTxSFOYP9foD21IA9880hyor6PY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O0ENyJZ95/iiZKt22t6hiMmD7iGgb3SLdImJ+KlaE3TmLt0DvNoiSQQ490WZVgnou
	 ytBtPGJg0/Wp6xakyTgfz1t1Reyg/faRjiZomcG1BddR4RMlmb5WulHNPZ2x4Uj5/F
	 joHFLmoz0+JkDZ49tjinnhAHqKiJ7nipKR8e9kuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfAYPdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:33:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfAYPdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:33:50 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E1F3218DE;
        Fri, 25 Jan 2019 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548430428;
        bh=WjkqafWbRIcHoKvZHTxSFOYP9foD21IA9880hyor6PY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mhToJIad9MPm6BCQWUIguEEwRFF68Iz2qkd6bvNQ7n1evDNx4yTI44We/ASyD2ez6
         HIrkiO59EfWBFoYh1aCA4+Bg9ICR33f6kB/zccX96Q8n27rbiR6gHgsfXtpzt+vp3Z
         joTIpxeTqRZEH8lkFzu/PEKkZtYcEqt2As1jF2is=
Received: by mail-qt1-f174.google.com with SMTP id l11so11127322qtp.0;
        Fri, 25 Jan 2019 07:33:48 -0800 (PST)
X-Gm-Message-State: AJcUukdiq7ZaoavYEoVT1P9URikeM9lqdmddzqUq/VlBz5iS3rbu06u9
        qGeD5fZpvWPx7CTSDUG+d1Ij6rgpsYy+BvhlAQ==
X-Google-Smtp-Source: ALg8bN6TwF7xTsekzlSSvlZVKpFbTOEMZIVoartuxWhCbbIoS2kxZjN1wBC4N4w6y/fqXhU1lXYsrdfmLbJoXhX+tw8=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr11596557qtf.26.1548430427574;
 Fri, 25 Jan 2019 07:33:47 -0800 (PST)
MIME-Version: 1.0
References: <20190124200825.2611-1-f.fainelli@gmail.com> <1a19b5f3-1387-0e6d-2d84-1b61079b4efb@gmail.com>
 <3e63d0c3-cb92-5caa-c0db-a04ef8fb5393@gmail.com> <04286c55-b995-3c5b-dc03-9f3c46d6376b@gmail.com>
 <bb238bed-0183-18b4-0182-fac4a74ed8a2@gmail.com>
In-Reply-To: <bb238bed-0183-18b4-0182-fac4a74ed8a2@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 25 Jan 2019 09:33:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL=N7+mHrAbNotMeQmuyTLkVWTQ0C38Hq22szOk+kOyRg@mail.gmail.com>
Message-ID: <CAL_JsqL=N7+mHrAbNotMeQmuyTLkVWTQ0C38Hq22szOk+kOyRg@mail.gmail.com>
Subject: Re: [PATCH] of: Make of_node_name_eq() case insensitive
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vivien.didelot@gmail.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 11:00 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 1/24/19 6:06 PM, Frank Rowand wrote:
> > On 1/24/19 5:20 PM, Florian Fainelli wrote:
> >>
> >>
> >> On 1/24/19 3:45 PM, Frank Rowand wrote:
> >>> On 1/24/19 12:08 PM, Florian Fainelli wrote:
> >>>> Since c32569e358ad ("regulator: Use of_node_name_eq for node name
> >>>> comparisons") Vivien reported the mc13892-regulator complaining about
> >>>> not being able to find regulators.
> >>>>
> >>>> This is because prior to that commit we used of_node_cmp() to compare
> >>>> the regulator array passed from mc13892_regulators down to
> >>>> mc13xxx_parse_regulators_dt() and they are all defined in uppercase
> >>>> letters by the MC13892_*_DEFINE* macros, whereas they are defined as
> >>>> lowercase in the DTS.
> >>>>
> >>>> Fix this by use strncasecmp() since that makes sure the comparison is
> >>>> case insensitive like what of_node_cmp() did.
> >>>>
> >>>> Reported-by: Vivien Didelot <vivien.didelot@gmail.com>
> >>>> Fixes: c32569e358ad ("regulator: Use of_node_name_eq for node name comparisons")
> >>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >>>> ---
> >>>>  drivers/of/base.c | 3 ++-
> >>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
> >>>> index 5226e898476e..ff47c86277cb 100644
> >>>> --- a/drivers/of/base.c
> >>>> +++ b/drivers/of/base.c
> >>>> @@ -66,7 +66,8 @@ bool of_node_name_eq(const struct device_node *np, const char *name)
> >>>>    node_name = kbasename(np->full_name);
> >>>>    len = strchrnul(node_name, '@') - node_name;
> >>>>
> >>>> -  return (strlen(name) == len) && (strncmp(node_name, name, len) == 0);
> >>>> +  return (strlen(name) == len) &&
> >>>> +          (strncasecmp(node_name, name, len) == 0);
> >>>>  }
> >>>>  EXPORT_SYMBOL(of_node_name_eq);
> >>>>
> >>>>
> >>>
> >>> Node names are case sensitive.  Please fix mc13xxx_parse_regulators_dt() to
> >>> properly handle case instead of changing of_node_name_eq().
> >>
> >> Fair enough, should we issue a warning if np->full_name contains upper
> >> case while name does not (and vice versa) to help troubleshoot cases
> >> like the one we found with Vivien?
> >
> > It seems like a lot of work to detect that specific case.  If anything,
> > maybe just add some text to the existing "Unknown regulator: ..." warning
> > in mc13xxx_parse_regulators_dt() to mention that case matters.
>
> I was not thinking about something very clever, just issue a warning
> like this, completely untested and likely flawed:
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 5226e898476e..2505286c875b 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -58,6 +58,7 @@ DEFINE_RAW_SPINLOCK(devtree_lock);
>  bool of_node_name_eq(const struct device_node *np, const char *name)
>  {
>         const char *node_name;
> +       int ret1, ret2;
>         size_t len;
>
>         if (!np)
> @@ -66,7 +67,12 @@ bool of_node_name_eq(const struct device_node *np,
> const char *name)
>         node_name = kbasename(np->full_name);
>         len = strchrnul(node_name, '@') - node_name;
>
> -       return (strlen(name) == len) && (strncmp(node_name, name, len)
> == 0);
> +       ret1 = strncmp(node_name, name, len);
> +       ret2 = strncasecmp(node_name, len);
> +
> +       WARN(ret1 ^ ret2, "Comparing case sensitive names!");
> +
> +       return (strlen(name) == len && (strncmp(node_name, name, len) == 0);

If it comes to this, I'd rather not always do 3 string compares.

>  }
>  EXPORT_SYMBOL(of_node_name_eq);
>
>
> My concern is that we have identified one place here where the
> conversion to of_node_name_eq() broke that particular driver in fact,
> all other regulator drivers but qcom-rpmh-regulator.c that use
> of_node_name_eq() are broken after that change, but presumably this is
> not the only place in the kernel where things could break, so having a
> warning could potentially help (also adding the backtrace which is neat).

Most modern DT's don't really rely on the node names. Regulators are
the oddball.

I checked all the other affected regulator drivers. da9052 is also
affected. IMO, we should fix the drivers and I'm sending out patches
to do that.

> What should the fix look like though? Add an of_node_casename_eq() and
> use it, revert Rob's commit that changes these regulators to use
> of_node_name_eq()?

No, we don't want to add of_node_casename_eq.

We may have to internally go back to case insensitive compare, but I'd
like to avoid that and fix any specific cases if possible.

> I don't know the regulator framework enough to know whether forcibly
> making the names lowercase is not breaking sysfs/debugfs...

Userspace relying on specific regulator names seems questionable to
me. Certainly, debugfs is not an ABI.

Rob
