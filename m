Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeA3V2O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:28:14 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:43208 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbeA3V2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:28:12 -0500
X-Google-Smtp-Source: AH8x224pH1hQYGXEeCrAsVxx9OD6IrZP2aAlduEv8HVXaxrCsMAw55QAZ6vgxVTxGvbP6fAjKKJmjQ==
Date: Tue, 30 Jan 2018 13:28:09 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: syzbot
        <bot+68bf59b49142965d6454163d7341e617a90139dc@syzkaller.appspotmail.com>,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: stack-out-of-bounds Read in xfrm_state_find (3)
Message-ID: <20180130212809.36egyijbeamelmtv@gmail.com>
References: <089e082d0cb803507c055e6d5318@google.com>
 <001a11445ed4514b28055e947b48@google.com>
 <20171201072743.47ztbmrql7ub327u@gauss3.secunet.de>
 <20171212210031.GC185376@gmail.com>
 <20171213051805.7z74wh7sglaflo4j@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171213051805.7z74wh7sglaflo4j@gauss3.secunet.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2017 at 06:18:05AM +0100, Steffen Klassert wrote:
> On Tue, Dec 12, 2017 at 01:00:31PM -0800, Eric Biggers wrote:
> > Hi Steffen,
> > 
> > On Fri, Dec 01, 2017 at 08:27:43AM +0100, Steffen Klassert wrote:
> > > On Wed, Nov 22, 2017 at 08:05:00AM -0800, syzbot wrote:
> > > > syzkaller has found reproducer for the following crash on
> > > > 0c86a6bd85ff0629cd2c5141027fc1c8bb6cde9c
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/master
> > > > compiler: gcc (GCC) 7.1.1 20170620
> > > > .config is attached
> > > > Raw console output is attached.
> > > > C reproducer is attached
> > > > syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> > > > for information about syzkaller reproducers
> > > > 
> > > > 
> > > > BUG: KASAN: stack-out-of-bounds in xfrm_state_find+0x30fc/0x3230
> > > > net/xfrm/xfrm_state.c:1051
> > > > Read of size 4 at addr ffff8801ccaa7af8 by task syzkaller231684/3045
> > > 
> > > The patch below should fix this. I plan to apply it to the ipsec tree
> > > after some advanced testing.
> > > 
> > > Subject: [PATCH RFC] xfrm: Fix stack-out-of-bounds with misconfigured transport
> > >  mode policies.
> > > 
> > 
> > Are you still planning to apply this?  syzbot is still hitting this bug.
> 
> It is already applied to the ipsec tree, will go upstream by the end of
> this week.
>

Marking this fixed for syzbot:

#syz fix: xfrm: Fix stack-out-of-bounds with misconfigured transport mode policies.
