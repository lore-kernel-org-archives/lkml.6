Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7298C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A3A20877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tGVFIhYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A3A20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbeIXRW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:22:27 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54850 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeIXRW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:22:26 -0400
Received: by mail-it1-f196.google.com with SMTP id f14-v6so9990044ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 04:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jG7pn5RDX2M9asE3ullvRPSRzQJM15FiaiJdXE3ztk4=;
        b=tGVFIhYzwgBEny9ihcvrsx/JTFT3mmuqY74wbbYs7UBm4UuF7mtYJ+iAOiZza1UPRq
         8ryfyGrjPHQoiPCFYGaarh87DjMvzwGGvXO3oX0ymb4z0zfOv0uJsQUq7GrWU7qI4oJB
         EYWIu4zBZB5Wnco46hpACUTDOZl7t4ytYtiR6ifLsCKrYPu8N+FQOjQqFIoDP56K3bnE
         X/5VlzxnaKT22GVC+pCtgXu6boAXnk5/JYxWBo/34o/ZIv0EOX/ndu9y4ibrBU25X7M/
         hi6E9DTXSCkHBSWD4HrlFYGd31CBEf+Lrw2GB5fxSYr0OLRy8JThWWIJ+UfUPWAC+TT6
         KP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jG7pn5RDX2M9asE3ullvRPSRzQJM15FiaiJdXE3ztk4=;
        b=LUNERRcAYLjSFzc9zIofW4ScXcGTzjfpHzlTdRu840/wWMZmh4K6Pi4bZgn5tLPs1B
         0jtBUitRoho1gXEys3b5J8RkoiuR2AHYDUfzSBT541rJeqF0GE6Qon6eszo8qTk8+tXa
         3KhkESbpyH64781BWRt3Wkd39DxWVf/TDg6vA5x0I775ns6Nbf6TmBnpiOl/dOZ8e7X6
         B2kWKbAZQRnQYmJtJZB2ALAsB5lvb8JwNkP3/mIwW8EeHRpEnXUdo8E6noMzKA0pU3BN
         XtVnua2J5U7vHIrylPGSsopILZxvdSi/lBkeBPzvgmR4DIYQFhjPJYlkxyV47V51RHTd
         xVzw==
X-Gm-Message-State: ABuFfogSyy4RCvarOPs85iAMmewVt/myPAeWtRqBP0KBJxM3hda4Myik
        KuMo+ljoSIjVR6yVneo1iNE/1VQbx0e2RWFsHPVPTQ==
X-Google-Smtp-Source: ACcGV6063JWFX4lEfjS+xc76MrLTmQOZXsFs4aDhVXzGjatUpJawZm+mVo+7KcvibaMBp/lbwbBMHyQPlP57f5CC0So=
X-Received: by 2002:a24:a20f:: with SMTP id j15-v6mr2057130itf.125.1537788051308;
 Mon, 24 Sep 2018 04:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180924101150.23349-1-brgl@bgdev.pl> <20180924111601.GL15943@smile.fi.intel.com>
In-Reply-To: <20180924111601.GL15943@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 24 Sep 2018 13:20:40 +0200
Message-ID: <CAMRc=MdKAoWscwJR4=3DLMGA-DTHU1wJg0SSSgo=7KbgPa_9DA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] devres: provide and use devm_kstrdup_const()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 24 wrz 2018 o 13:16 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Mon, Sep 24, 2018 at 12:11:46PM +0200, Bartosz Golaszewski wrote:
> > This series implements devm_kstrdup_const() together with some
> > prerequisite changes and uses it in pmc-atom driver.
> >
>
> Through which tree you are assuming this would be directed?
>

I think that patches 1-3 would be best picked up by Andrew Morton.
Patch 4 looks like it should go through the clock tree unless Stephen
is fine with Acking it and it going through the mm tree together with
others.

Bart

> > v1 -> v2:
> > - fixed the changelog in the patch implementing devm_kstrdup_const()
> > - fixed the kernel doc
> > - moved is_kernel_rodata() to asm-generic/sections.h
> > - fixed constness
> >
> > v2 -> v3:
> > - rebased on top of 4.19-rc5 as there were some conflicts in the
> >   pmc-atom driver
> > - collected Reviewed-by tags
> >
> > Bartosz Golaszewski (4):
> >   devres: constify p in devm_kfree()
> >   mm: move is_kernel_rodata() to asm-generic/sections.h
> >   devres: provide devm_kstrdup_const()
> >   clk: pmc-atom: use devm_kstrdup_const()
> >
> >  drivers/base/devres.c          | 43 ++++++++++++++++++++++++++++++++--
> >  drivers/clk/x86/clk-pmc-atom.c | 19 ++++-----------
> >  include/asm-generic/sections.h | 14 +++++++++++
> >  include/linux/device.h         |  5 +++-
> >  mm/util.c                      |  7 ------
> >  5 files changed, 63 insertions(+), 25 deletions(-)
> >
> > --
> > 2.18.0
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
