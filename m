Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mR0NDW3oGFuITwAAmS7hNA
	; Thu, 07 Jun 2018 08:11:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3EC406089E; Thu,  7 Jun 2018 08:11:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MfdmUX3A"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8F73C60115;
	Thu,  7 Jun 2018 08:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F73C60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932306AbeFGIK4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:10:56 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:41475 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753406AbeFGIKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:10:53 -0400
Received: by mail-yw0-f193.google.com with SMTP id s201-v6so2724229ywg.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 01:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJzqNQF40bRDVI0xsNRlzXs3GK4MH19E32gIgb5QgdI=;
        b=MfdmUX3A3VS+a+uhqxijg2crlZyK5Gqiy3T1a7oC19DnDphFyhUdsVwTaFNKXKJ9Pu
         xhpfTBprfMgSY5z6nKzv74LaD11IrU4FGPQhn6qAhmKPGWGqXWL9k0Rextb7rqlZ5VfL
         k1Ah3fe6KJqUVkbhB80u1azwa2KSxXCIQw9YKov/ni73s4vgythxdJW8WPnuP8qkjbXE
         kVqKnDroIHriEDVnfVl7KbSXUbETlh2nTo5O+JqzCu+vOYo7DQUSrVWbCedcounibcJO
         5jIZ9uJEDLqxQPFjVRFNte/KMExVAqpGOjWjKuhe/w/08OV3mOIe9PQLSONixdROh25u
         lgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJzqNQF40bRDVI0xsNRlzXs3GK4MH19E32gIgb5QgdI=;
        b=gw1b7LuokKDVd2gBx1+7GmlauMqcQBRett3e9milnotGKv///ENngq4CrqKQ2/ECtm
         K4/TFRl64BW7+J5hS9KBFDIaER5PoFGsc0iiHHuzrEFjMVlxj+JxkPEjgqa1U8UbToR1
         7pjz+N+cFIMCUHq6jU6bw+2t884fnr7nZFNP99TNiqqv6kXl/culGkf17XhTyG87L0nl
         fUvaq4PxLlXI6ysFcmtEQ4yI9USLlDWUQvj09AJ7RbCg5RSP0Rsuo1RrHXRs2wHPXMZ2
         iWE7ZIzqOYlUHCIT1zXVWKJUsChSwntBMU9GwxK/JsjoDv78Igrn539zDrsOznQ+AfzI
         Qw+w==
X-Gm-Message-State: APt69E2A7QA8LzQjy81l1bpLcLtksmCuOPG/NHziWO7Nf6PuJEDkBmac
        FsKjcs74lI7XtSfKWC3WE6KTg16/dDLKw1JY07cJzg==
X-Google-Smtp-Source: ADUXVKKXBMaFViaO/Q+80JX22rHS0VJ2NsDTB+f9W7ChGksWShq18t2mHKlYdDbuHnO8RiuSbg6SMYScdZsupXu0aLo=
X-Received: by 2002:a81:19c6:: with SMTP id 189-v6mr427801ywz.500.1528359051912;
 Thu, 07 Jun 2018 01:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180530215826.1343234-1-arnd@arndb.de> <20180530220405.GH30754@ziepe.ca>
 <0be4e0fb-8d8e-b337-fc8d-550c90829d8c@opengridcomputing.com>
 <20180530222520.GJ30754@ziepe.ca> <d2472443-3ae6-63f4-59ad-d6367b837038@opengridcomputing.com>
 <CAK8P3a3HZXTR60ua=cjBHnB5FWWKve9F-JqcNwn0ujks+=FsNg@mail.gmail.com>
 <20180530230136.GK30754@ziepe.ca> <CAHH2K0ZLDmsPNw=sOobL=+R54yRFrnG4syWcW43UEbwxsvFehw@mail.gmail.com>
 <d23e215a30f1277c941973043262cdfc60c71315.camel@redhat.com> <20180604230745.GG24926@ziepe.ca>
In-Reply-To: <20180604230745.GG24926@ziepe.ca>
From: Greg Thelen <gthelen@google.com>
Date: Thu, 7 Jun 2018 01:10:39 -0700
Message-ID: <CAHH2K0baMto7A75YxvP9LWtR9wgAFY76n_2q3fX_b=qcnuX1mw@mail.gmail.com>
Subject: Re: [PATCH] iw_cxgb4: add INFINIBAND_ADDR_TRANS dependency
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Doug Ledford <dledford@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        swise@opengridcomputing.com, swise@chelsio.com,
        yuval.shaia@oracle.com, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tarick Bedeir <tarick@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 4:07 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, May 31, 2018 at 02:40:59PM -0400, Doug Ledford wrote:
> > On Wed, 2018-05-30 at 21:03 -0700, Greg Thelen wrote:
> > > On Wed, May 30, 2018 at 4:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > > On Thu, May 31, 2018 at 12:40:54AM +0200, Arnd Bergmann wrote:
> > > > > > On 5/30/2018 5:25 PM, Jason Gunthorpe wrote:
> > > > > > > On Wed, May 30, 2018 at 05:10:35PM -0500, Steve Wise wrote:
> > > > > > > >
> > > > > > > > On 5/30/2018 5:04 PM, Jason Gunthorpe wrote:
> > > > > > > > > On Wed, May 30, 2018 at 11:58:18PM +0200, Arnd Bergmann wrote:
> > > > > > > > > > The newly added fill_res_ep_entry function fails to link if
> > > > > > > > > > CONFIG_INFINIBAND_ADDR_TRANS is not set:
> > > > > > > > > >
> > > > > > > > > > drivers/infiniband/hw/cxgb4/restrack.o: In function
> > >
> > > `fill_res_ep_entry':
> > > > > > > > > > restrack.c:(.text+0x3cc): undefined reference to `rdma_res_to_id'
> > > > > > > > > > restrack.c:(.text+0x3d0): undefined reference to `rdma_iw_cm_id'
> > > > > > > > > >
> > > > > > > > > > This adds a Kconfig dependency for the driver.
> > > > > > > > > >
> > > > > > > > > > Fixes: 116aeb887371 ("iw_cxgb4: provide detailed
> > >
> > > provider-specific CM_ID information")
> > > > > > > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > > > > >  drivers/infiniband/hw/cxgb4/Kconfig | 1 +
> > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > >
> > > > > > > > > Oh, I think we need to solve this with maybe a header fill null
> > >
> > > stub
> > > > > > > > > instead..
> > > > > > > > >
> > > > > > > > > We don't want to disable drivers just because a user interface is
> > > > > > > > > disabled.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Why does CONFIG_INFINIBAND_ADDR_TRANS disable building rdma_cm.ko?
> > >
> > > That
> > > > > > > > is not correct.
> > > > > > >
> > > > > > > That seems like a reasonable thing to do..
> > > > > >
> > > > > > rdma_ucm.ko is for usermode users, rdma_cm.ko is for kernel users, and
> > > > > > is required for iwarp drivers.  It seems rdma_cm.ko is not being
> > > > > > compiled if ADDR_TRANS is not set.
> > > > I think the intention was to completely disable rdma-cm, including all
> > > > support for rx'ing remote packets? Greg?
> > >
> > > Yes.  That's my goal when INFINIBAND_ADDR_TRANS is unset.
> > >
> > > > If this is required for iwarp then Arnd's patch is probably the right
> > > > way to go..
> > > > Jason
> > >
> > > Agreed.
> > > Acked-by: Greg Thelen <gthelen@google.com>
> >
> > If that's the case, then there should be a NOTE: in the Kconfig that
> > disabling the connection manager completely disables iWARP hardware.
> >
> > I don't really think I like this approach though.  At a minimum if you
> > are going to make iWARP totally dependent on rdmacm, then there is zero
> > reason that iw_cm.o should be part of the obj-$(CONFIG_INFINIBAND)
> > Makefile recipe when ADDR_TRANS is disabled.
>
> This makes sense, Greg, can you send a followup patch with these
> items? I know this series has been tough..
>
> Thanks,
> Jason

Ack.  Sorry for delay.  I'll take a look at this in a day or two.  Let
me know if it's more urgent.
