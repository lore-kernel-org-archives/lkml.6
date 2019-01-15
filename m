Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436E8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B37F20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbfAOSI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:08:56 -0500
Received: from ms.lwn.net ([45.79.88.28]:43898 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729737AbfAOSI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:08:56 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4602272D;
        Tue, 15 Jan 2019 18:08:55 +0000 (UTC)
Date:   Tue, 15 Jan 2019 11:08:54 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Joel Nider" <JOELN@il.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] docs-rst: userspace: update verbs API details
Message-ID: <20190115110854.63200119@lwn.net>
In-Reply-To: <OF64BB6EB2.8999493B-ONC2258383.0058B5B7-C2258383.005AA2FD@notes.na.collabserv.com>
References: <1547547991-5314-1-git-send-email-joeln@il.ibm.com>
        <1547547991-5314-3-git-send-email-joeln@il.ibm.com>
        <20190115153128.GA6310@bombadil.infradead.org>
        <OF64BB6EB2.8999493B-ONC2258383.0058B5B7-C2258383.005AA2FD@notes.na.collabserv.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 18:29:59 +0200
"Joel Nider" <JOELN@il.ibm.com> wrote:

> > I think this is a horrible direction to take.  The current document is
> > clearly for _users_.  All this documentation you've added is for kernel
> > hackers.  It needs to go in a different file, or not be added at all.
> >   
> Hmm, that's a bit heavy-handed in my opinion. If you look at what is 
> currently under "Userspace API", there are a total of 4 files - not 
> exactly what I would call comprehensive documentation of the Linux kernel 
> interface. 

One has to start somewhere - I'm glad to see you adding to it.

> So the option of not adding more documentation simply because 
> it is in the wrong section seems a bit defeatist (I think we can all agree 
> more kernel docs is a good thing). So let's assume for the moment that it 
> _should_ be added, and that we are discussing _where_.

I think we definitely want to add it.

> Yes, the document I 
> am modifying has a bit of a mash of pure userspace API - functions and 
> details that application developers must know - and the lower level 
> details that are more useful for someone who wishes to extend this 
> interface. The existing documentation (specifically unshare) also suffers 
> from the same problem. There is a section (7) called "Low Level Design" 
> which documents very much the same level of detail as the Infiniband doc, 
> so this seems to be at least consistent.
> I think there is a deeper issue - as an application developer, I would 
> only look at this kernel documentation as a last resort. #1 is the 'man' 
> pages, #2 is web search for an example (I know for many it's the other way 
> around). So who really looks at this documentation? I say the vast 
> majority is kernel hackers. So yes, this is about the user-facing API, but 
> not from the application writer's perspective - it should be about how to 
> create a consistent API for users, from the kernel hacker's perspective.

The intent behind the user-space API manual is to document the user-space
API; it's meant to be read by people writing applications and such.
Perhaps they find it with a web search, but it will be there for them, one
hopes, when they want it.

The project of reworking the kernel documentation to be more comprehensive
and more focused on its readers, rather than, as Rob Landley once put it,
"a gigantic mess, currently organized based on where random passers-by put
things down last" is still in an early stage.  But that doesn't mean that
we shouldn't try to always move in the right direction.  So I agree with
Willy that this particular text is better suited to the driver-API
manual.  Even if a bare bit of information on its own there for now, it's
a starting place.  Can I ask you to do that, please?

Thanks,

jon
