Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3186EC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4BB2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4BB2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeJPQoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:44:37 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36957 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeJPQoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:44:37 -0400
Received: by mail-oi1-f194.google.com with SMTP id e17-v6so17397303oib.4;
        Tue, 16 Oct 2018 01:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAc4DQ4g6pTctg6U1LF51BeAUwiIMWWioDKKMAAuBr0=;
        b=JTwZI8hsEQMPMgiinCRdIm8QyHKz014ybn9aO1bq/Kpy9VJwbJlKMalyClROQOPEFH
         zVLekhaoQfnd7X2LRtE+56M0xK4SspScnBMPNjx1SFcxEqGs0o7zAYl61qjuELQH3LK0
         NZaKEFD5eZuDwh2hJgelIHZVPo+vmpYZtjVCYKXvUP7By9UYOcUv9gWfaVVysNQfoiJU
         9AcanqwoCYAo30vofmTeXkwCRrBczgJMs6CF7mZ9VN34XXa4auckkHCgGelI3ZqNoCX0
         X2EE2guAlqgzm3FXHjwZGKlnH2vp45Xu++/G1WpBPyyz46i581jrXR8wKXzHaljyFqZr
         RqfQ==
X-Gm-Message-State: ABuFfohYkZSLOgLq/5IGU7l351JFuSR6vePevFhiexKuSEt8BFLi5NX8
        PsbtFhtU+BXoN0pBkCFUcFY2vmzM2WefiLkLViM=
X-Google-Smtp-Source: ACcGV60Svv8+hzcskAtXddWyJGKE8Hb3WnWsLycduqbpOMcVZw4zPqfAAQDjb2jqmrIYXNion7kVdtDAaPIP3NsvhF8=
X-Received: by 2002:aca:d785:: with SMTP id o127-v6mr11307953oig.33.1539679497273;
 Tue, 16 Oct 2018 01:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
 <CACRpkdZddvkgL1qwO=35y_Jps0+=QD3nPKQwgMEH+zcCH2NPdg@mail.gmail.com>
 <CAJZ5v0h3uENUqbcb=0HH1wT_0MYQzcHct2d19tiarvXEdRay+Q@mail.gmail.com> <20181016084050.GF24771@kuha.fi.intel.com>
In-Reply-To: <20181016084050.GF24771@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Oct 2018 10:44:45 +0200
Message-ID: <CAJZ5v0gYk1=jOkmF5z2WCCyHCu6ZWX8zOoLSkStvYqHMY2PZnA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:40 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Oct 16, 2018 at 09:36:33AM +0200, Rafael J. Wysocki wrote:
> > On Tue, Oct 16, 2018 at 9:35 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > On Fri, Oct 12, 2018 at 1:39 PM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > > To continue the discussion started by Dmitry [1], this is my proposal
> > > > that I mentioned in my last mail. In short, the idea is that instead
> > > > of trying to extend the support for the currently used struct
> > > > property_set, I'm proposing that we introduce a completely new,
> > > > independent type of fwnode, and replace the struct property_set with
> > > > it. I'm calling the type "software node" here.
> > >
> > > I'm a big fan of this approach.
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > for all patches.
> > >
> > > I don't know who can finally review and merge this though,
> > > I guess Rafael?
> >
> > Yes, that would be me. :-)
> >
> > I no one speaks up against them, I'll pick them up.
>
> Let me send a final version of these.
>
> I need to add one more patch to the series where I remove an extra
> device_remove_properties() call from platform_device_del().
>
> It's unnecessary in any case as device_del() calls
> device_remove_properties() for every device, but as the properties are
> removed there before the device is removed, we're unable to deduct
> the final ref count in the "remove" platform notification since our
> node is no longer bind to the device.

OK, I'll wait for an update, then.

Thanks,
Rafael
