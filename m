Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4722C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8351720830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wDqdUhOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8351720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbeKGDoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:44:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388158AbeKGDoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:44:34 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2DA720830;
        Tue,  6 Nov 2018 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541528284;
        bh=YWWZgmcGxKYNe7DmkRdqukUX4PMUIEMe4HgfT/6Fyzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wDqdUhOqOWVQK15vc+vhGOw4Q40rEoH5SHMG1LK7+3I+WXY521PCvrECalXaj7Sbr
         csoWd0X6t3DUhwQ9PpZFhlaFLgV8/ZN8Nkfy1LmbLUKhrstpTMjbk9qu1ZXugzyk+z
         rbIFJNxBvagRXu6UUyGWVAGvD+OGrSZ8IAeWCu0w=
Received: by mail-qt1-f181.google.com with SMTP id r14so3722004qtp.1;
        Tue, 06 Nov 2018 10:18:04 -0800 (PST)
X-Gm-Message-State: AGRZ1gIIYsRamcpZlsop2/IExAlRc/XH7v5m9m5Ae9gGE8nH0h8JpLI+
        TGMswwLTqx6xrOho4nHO+HbqGDjDMLpi9TZDgA==
X-Google-Smtp-Source: AJdET5cet2rDlpEuyZfxu/BZH9vxJ0YiTxgyx/WjE0F4Ik8sg87nIBpquXBWDE79spU1/gbmvXpUZt3BVWCMls9JVKo=
X-Received: by 2002:ac8:173d:: with SMTP id w58mr26055606qtj.76.1541528284005;
 Tue, 06 Nov 2018 10:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-4-heikki.krogerus@linux.intel.com> <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
 <20181106105803.GS10650@smile.fi.intel.com> <20181106122734.GC13048@kuha.fi.intel.com>
 <CAL_Jsq+kspp1GYrMjG1cC=CyCa2_jO1suFdD9fn+gOwKRYdhtw@mail.gmail.com> <20181106142810.GX10650@smile.fi.intel.com>
In-Reply-To: <20181106142810.GX10650@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 6 Nov 2018 12:17:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKOC40uEHCrFDMkj_yGDG5VOSOymmJNQ5aSPv9K_W0=3w@mail.gmail.com>
Message-ID: <CAL_JsqKOC40uEHCrFDMkj_yGDG5VOSOymmJNQ5aSPv9K_W0=3w@mail.gmail.com>
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 8:28 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 06, 2018 at 07:18:14AM -0600, Rob Herring wrote:
> > On Tue, Nov 6, 2018 at 6:27 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > On Tue, Nov 06, 2018 at 12:58:03PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Nov 05, 2018 at 12:50:02PM -0600, Rob Herring wrote:
> > > > > On Mon, Nov 5, 2018 at 3:17 AM Heikki Krogerus
> > > > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > > > +static const char *of_fwnode_name(const struct fwnode_handle *fwnode)
> > > > > > +{
> > > > > > +       return to_of_node(fwnode)->name;
> > > > >
> > > > > I'm trying to get rid of the DT name ptr, so please don't add one. You
> > > > > can use of_node_full_name() here instead if "<name>@<unit-address>"
> > > > > instead of <name> is fine. Otherwise, you've got to allocate your own
> > > > > storage and use "%pOFn" printf specifier.
> > > >
> > > > If we do this here, we will change a behaviour of the entire set of
> > > > of_fwnode_get_named_child_node() users.
> > > >
> > > > I think this is out of scope of the series.
> >
> > No, because you are adding a firmware op for something that's going away.
>
> W/o your below explanation it wasn't obvious.
>
> >
> > > You have a point. We must use the same member that was used in
> > > of_fwnode_get_named_child_node().
> > >
> > > The goal of this series if most likely not clear from this patch
> > > alone, so I'll send a second version and make sure to CC the DT list
> > > and Rob.
> >
> > Looking at patch 4, if matching the name is what you want to do, then
> > use the DT name matching functions. They were added in 4.19.
>
> Do you mean of_node_name_eq()?

Yes or maybe move further up and just retrieve child nodes by name.
There's a recent function Johan added for that too.
of_find_child_node_by_name IIRC.

Rob
