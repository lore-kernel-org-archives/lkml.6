Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE783C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDEF208E7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT4CquK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDEF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbeKFWnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:43:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbeKFWng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:43:36 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2809D2085B;
        Tue,  6 Nov 2018 13:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541510306;
        bh=Hn9E/5UZ80nuJQMlNDtgmgZQs+H6TGVPPKb2oBVbS+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HT4CquK+WycEhdkHQ4/RH73E8aMxjiJHnub/HK5lc0Gg+6Ijb3Dh7KFJnCqXCsFzw
         CWZWxpzE/c1hAp7ssjiZ1BuJU4Q3ac3ncW0eIH3a14F2vFGU7M1gQNKQzDQ5DTy8az
         HHuAfp8iHbOxyU8HZTKWHPkKvkmz4vQxIeKX1UBs=
Received: by mail-qt1-f176.google.com with SMTP id z20-v6so2479763qti.9;
        Tue, 06 Nov 2018 05:18:26 -0800 (PST)
X-Gm-Message-State: AGRZ1gK8vdV+qod122jLnMoA2KS9RwwWujAmIvMwUl+ZTmnq0plm1PYJ
        tGol8NEbEEavT0wV0oUEDLnzCw1u3d9V49BiJw==
X-Google-Smtp-Source: AJdET5d7K2h0rqG0zRh1zLCwSzYzUKqk3OejJqYxARXxeCZGHqw40LXUQAkacB5I4PjPXb39G9cddq5PiqaN0b64Wk4=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr25947945qvb.218.1541510305363;
 Tue, 06 Nov 2018 05:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-4-heikki.krogerus@linux.intel.com> <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
 <20181106105803.GS10650@smile.fi.intel.com> <20181106122734.GC13048@kuha.fi.intel.com>
In-Reply-To: <20181106122734.GC13048@kuha.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 6 Nov 2018 07:18:14 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+kspp1GYrMjG1cC=CyCa2_jO1suFdD9fn+gOwKRYdhtw@mail.gmail.com>
Message-ID: <CAL_Jsq+kspp1GYrMjG1cC=CyCa2_jO1suFdD9fn+gOwKRYdhtw@mail.gmail.com>
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 6:27 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Nov 06, 2018 at 12:58:03PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 05, 2018 at 12:50:02PM -0600, Rob Herring wrote:
> > > On Mon, Nov 5, 2018 at 3:17 AM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> >
> > > > +static const char *of_fwnode_name(const struct fwnode_handle *fwnode)
> > > > +{
> > > > +       return to_of_node(fwnode)->name;
> > >
> > > I'm trying to get rid of the DT name ptr, so please don't add one. You
> > > can use of_node_full_name() here instead if "<name>@<unit-address>"
> > > instead of <name> is fine. Otherwise, you've got to allocate your own
> > > storage and use "%pOFn" printf specifier.
> >
> > If we do this here, we will change a behaviour of the entire set of
> > of_fwnode_get_named_child_node() users.
> >
> > I think this is out of scope of the series.

No, because you are adding a firmware op for something that's going away.

> You have a point. We must use the same member that was used in
> of_fwnode_get_named_child_node().
>
> The goal of this series if most likely not clear from this patch
> alone, so I'll send a second version and make sure to CC the DT list
> and Rob.

Looking at patch 4, if matching the name is what you want to do, then
use the DT name matching functions. They were added in 4.19.

Rob
