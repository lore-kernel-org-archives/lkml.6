Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89805C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6052A20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390554AbfAOVjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:39:01 -0500
Received: from ms.lwn.net ([45.79.88.28]:44694 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbfAOVjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:39:01 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 54BC72E5;
        Tue, 15 Jan 2019 21:39:00 +0000 (UTC)
Date:   Tue, 15 Jan 2019 14:38:59 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Joel Nider" <JOELN@il.ibm.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 2/2] docs-rst: userspace: update verbs API details
Message-ID: <20190115143859.4cbd5d9c@lwn.net>
In-Reply-To: <OF76A381CC.2F8183CE-ONC2258383.006FEA4D-C2258383.007140CB@notes.na.collabserv.com>
References: <1547547991-5314-1-git-send-email-joeln@il.ibm.com>
        <1547547991-5314-3-git-send-email-joeln@il.ibm.com>
        <20190115153128.GA6310@bombadil.infradead.org>
        <OF64BB6EB2.8999493B-ONC2258383.0058B5B7-C2258383.005AA2FD@notes.na.collabserv.com>
        <20190115110854.63200119@lwn.net>
        <OF76A381CC.2F8183CE-ONC2258383.006FEA4D-C2258383.007140CB@notes.na.collabserv.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 22:37:01 +0200
"Joel Nider" <JOELN@il.ibm.com> wrote:

> Jonathan Corbet <corbet@lwn.net> wrote on 01/15/2019 08:08:54 PM:
> > The intent behind the user-space API manual is to document the user-space
> > API; it's meant to be read by people writing applications and such.
> > Perhaps they find it with a web search, but it will be there for them, one
> > hopes, when they want it.  
> 
> So is the intent then to duplicate what is already in 'man'? Why would we 
> want 2 different locations for basically the same information? Wouldn't it 
> make more sense to just put these few details into appropriate 'man' 
> pages?

We are not attempting to duplicate the man pages; there's been occasional
talk of bringing them into the kernel tree, but enthusiasm for that is
scarce for a number of good reasons.  But there's a lot of information
about the user-space API that isn't in the man pages, including the piece
you are converting to RST.

For a huge example, look at the massive v4l2 UAPI documentation that's in
the kernel; that will never really fit into the man-page model.  (And yes,
it belongs in the userspace-api directory but isn't there for $REASONS).

> It looks like I misunderstood the purpose of the "userspace API" section 
> then. So is there a section that is meant for a guide on how to write an 
> interface function?

For something like this, driver-api seems like the right place.  Someday,
in some glorious future, it could contain a full manual on how these
drivers are written, using all of the nice kerneldoc comments that already
exist under drivers/infiniband.

> OK, just to be clear - you are asking me to leave the original file as-is 
> (well, after .rst conversion) but move it to the new location 
> (Documentation/userspace-api), and put my new content into a new file in 
> the old location (Documentation/infiniband)?

I'd rather see you put the new stuff under Documentation/driver-api, either
in a standalone file or in a new subdirectory.

Thanks for your patience with this!  We really do want people to contribute
more documentation, and I feel bad when it seems like I'm making it
harder.  My hope is that it will pay off in the long run; I think there are
signs already that this is happening.

Thanks,

jon
