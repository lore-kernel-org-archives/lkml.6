Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA98C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B5320657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfANXAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:00:50 -0500
Received: from ec2-34-208-57-251.us-west-2.compute.amazonaws.com ([34.208.57.251]:46056
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726769AbfANXAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:00:49 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2019 18:00:48 EST
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id 69BD24043D; Mon, 14 Jan 2019 14:54:12 -0800 (PST)
Date:   Mon, 14 Jan 2019 14:54:12 -0800
From:   Daniel Walker <dwalker@fifo99.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: manual merge of the cisco tree with the vfs tree
Message-ID: <20190114225412.GD18707@fifo99.com>
References: <20181002162923.13f3f8b1@canb.auug.org.au>
 <20190115093330.1cbb0625@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115093330.1cbb0625@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 09:33:30AM +1100, Stephen Rothwell wrote:
> Hi Daniel,
> 
> On Tue, 2 Oct 2018 16:29:23 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the cisco tree got a conflict in:
> > 
> >   arch/x86/kernel/setup.c
> > 
> > between commit:
> > 
> >   dcf8001d292b ("vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled")
> > 
> > from the vfs tree and commit:
> > 
> >   2c070709ea75 ("This updates the x86 code to use the CONFIG_GENERIC_CMDLINE")
> > 
> > from the cisco tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> > 
> > diff --cc arch/x86/kernel/setup.c
> > index e493202bf265,ee109f490b22..000000000000
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@@ -51,7 -51,7 +51,8 @@@
> >   #include <linux/kvm_para.h>
> >   #include <linux/dma-contiguous.h>
> >   #include <xen/xen.h>
> >  +#include <uapi/linux/mount.h>
> > + #include <linux/cmdline.h>
> >   
> >   #include <linux/errno.h>
> >   #include <linux/kernel.h>
> 
> This is now a conflict between the cicso tree and Linus' tree.

I did a rebase after your original made this. I'm not sure it's needed any
longer. However, I was planning to rebase my tree again on top of the latest
Linus tree. How would you like to proceed ?

Daniel
