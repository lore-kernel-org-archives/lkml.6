Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C5CC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FED20820
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Vvy/No3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387904AbfA3VXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:23:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45802 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731425AbfA3VXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:23:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so393184plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tM1a7yhYhXG8s2eHu7gjDoFR8t2UkuoCVZDqriCJf6c=;
        b=Vvy/No3sw31vQD3I9jcNt9+VntbVJxy8nxBhPB1q9IsDkCHkoGmYXYA1wxh64pInyO
         okonii/1K5yqLrKgPWv8ovfByVep2L3MUNXKTaY18gsq1js0OHUwjg6ZjHqUozMbBzxy
         bhbZZKIEn2j9IVC7SL07rEnfkUpgRJ2c9f3o3PKBm7ys30OF2mr51PuxZtRMwhWOQSnn
         30iYtAVyQhnHtbI2/dPvI4Z/nledSZ5nC5Vm3YVa/mfMXnyWorxM+zy0WWN/V7cClM5O
         WGeTv6pmzwxFCixMewEqWVnZSHb5jBeSGv6MwCszVnGtgP663PXHvQlR6FNmmxzOSnjp
         iz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tM1a7yhYhXG8s2eHu7gjDoFR8t2UkuoCVZDqriCJf6c=;
        b=WiNxFbZ1SpaSYTHVcvapYjKRL8wIkxPhPUQbYdYtkOF9amzP1i5vwr3kg2qRe0fwfv
         9qKL0Pegt4MWPI4Kkcr7h91O3/r1sihnU3EjN6bMG5UA1rFoac3u2TSj2oQvw7D7vsl9
         epnpuLOOejnXGWMhIatPxMVll9aTZ5Bt5UzsgyhAjaEKDfRPD/uP4t82mrWmXbRRHBN7
         MhMOmNhtZcPeVnsTtII25K7JvwgdW4cftdRF4C41tt8egHagjzsI3CWOtgVx2F/LbIEL
         hIRF6JSLdPZMpjg9PIVXDaREb7zA3TR1IKF9Bd1E31Sm6+ryAaA1PqoqxtTrklWsuD4l
         mymA==
X-Gm-Message-State: AJcUukc7MJ/xnV1//8hLpbyy4AXCBTu6Xh8WMMa2HwEQknVQLNluYuw/
        NFVXPedAGGQIqrVCFiOPkzQTOg==
X-Google-Smtp-Source: ALg8bN5au/zaPAMq+H2kGMZ8j5Im9MWm614jRrv2lw9bwcqCVnORAOcUmJlEaPmIwlRVFJVF0PhAYg==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr32029794plo.162.1548883428287;
        Wed, 30 Jan 2019 13:23:48 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id z9sm8093420pfd.99.2019.01.30.13.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 13:23:47 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1goxKk-0006QL-O8; Wed, 30 Jan 2019 14:23:46 -0700
Date:   Wed, 30 Jan 2019 14:23:46 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joel Nider <JOELN@il.ibm.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, linux-rdma-owner@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 5/5] RDMA/uverbs: add UVERBS_METHOD_REG_REMOTE_MR
Message-ID: <20190130212346.GD17066@ziepe.ca>
References: <1548768386-28289-1-git-send-email-joeln@il.ibm.com>
 <1548768386-28289-6-git-send-email-joeln@il.ibm.com>
 <20190129170406.GD10094@ziepe.ca>
 <OF8090F111.AEB0B591-ONC2258392.002E4215-C2258392.002F0FDE@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8090F111.AEB0B591-ONC2258392.002E4215-C2258392.002F0FDE@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:34:02AM +0200, Joel Nider wrote:
> linux-rdma-owner@vger.kernel.org wrote on 01/29/2019 07:04:06 PM:
> 
> > On Tue, Jan 29, 2019 at 03:26:26PM +0200, Joel Nider wrote:
> > > Add a new handler for new uverb reg_remote_mr. The purpose is to 
> register
> > > a memory region in a different address space (i.e. process) than the
> > > caller.
> > > 
> > > The main use case which motivated this change is post-copy container
> > > migration. When a migration manager (i.e. CRIU) starts a migration, it
> > > must have an open connection for handling any page faults that occur
> > > in the container after restoration on the target machine. Even though
> > > CRIU establishes and maintains the connection, ultimately the memory
> > > is copied from the container being migrated (i.e. a remote address
> > > space). This container must remain passive -- meaning it cannot have
> > > any knowledge of the RDMA connection; therefore the migration manager
> > > must have the ability to register a remote memory region. This remote
> > > memory region will serve as the source for any memory pages that must
> > > be copied (on-demand or otherwise) during the migration.
> > > 
> > > Signed-off-by: Joel Nider <joeln@il.ibm.com>
> > >  drivers/infiniband/core/uverbs_std_types_mr.c | 129 
> +++++++++++++++++++++++++-
> > >  include/rdma/ib_verbs.h                       |   8 ++
> > >  include/uapi/rdma/ib_user_ioctl_cmds.h        |  13 +++
> > >  3 files changed, 149 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/
> > infiniband/core/uverbs_std_types_mr.c
> > > index 4d4be0c..bf7b4b2 100644
> > > +++ b/drivers/infiniband/core/uverbs_std_types_mr.c
> > > @@ -150,6 +150,99 @@ static int 
> UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
> > >     return ret;
> > >  }
> > > 
> > > +static int UVERBS_HANDLER(UVERBS_METHOD_REG_REMOTE_MR)(
> > > +   struct uverbs_attr_bundle *attrs)
> > > +{
> > 
> > I think this should just be REG_MR with an optional remote PID
> > argument
> 
> Maybe I missed something.  Isn't REG_MR only implemented as a write() 
> command? In our earlier conversation you told me all new commands must be 
> implemented as ioctl() commands.

Yes - but we are also converting old write() commands into ioctl()
when they need new functionality. So in this case it should convert
reg_mr to ioctl() then add an optional report PID argument
> 
> > >  DECLARE_UVERBS_NAMED_OBJECT(
> > >     UVERBS_OBJECT_MR,
> > >     UVERBS_TYPE_ALLOC_IDR(uverbs_free_mr),
> > >     &UVERBS_METHOD(UVERBS_METHOD_DM_MR_REG),
> > >     &UVERBS_METHOD(UVERBS_METHOD_MR_DESTROY),
> > > -   &UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR));
> > > +   &UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR),
> > > +   &UVERBS_METHOD(UVERBS_METHOD_REG_REMOTE_MR),
> > > +);
> > 
> > I'm kind of surprised this compiles with the trailing comma?
> Personally, I think it is nicer with the trailing comma. Of course 
> syntactically it makes no sense, but when adding a new entry, you don't 
> have to touch the previous line, which makes the diff cleaner. If this is 
> against standard practices I will remove the comma.

Well, it is just that this is a macro call, and you usually can't have
a trailing comma in a function-macro call, at least I thought this was
the case.. Without some study I'm not sure what it expands to, or if
that expansion is even OK..

Jason
