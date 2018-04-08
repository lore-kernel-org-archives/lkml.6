Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeDHCU1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 22:20:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39180 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbeDHCU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 22:20:26 -0400
Date: Sun, 8 Apr 2018 03:19:56 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mateusz Guzik <mguzik@redhat.com>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20180408021945.GF30522@ZenIV.linux.org.uk>
References: <20180319170627.04eae43b@canb.auug.org.au>
 <20180403122629.688f2cab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403122629.688f2cab@canb.auug.org.au>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 12:26:29PM +1000, Stephen Rothwell wrote:
> Hi Al,
> 
> On Mon, 19 Mar 2018 17:06:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the vfs tree, today's linux-next build (x86_64 allnoconfig)
> > failed like this:
> > 
> > fs/super.c: In function 'do_thaw_all_callback':
> > fs/super.c:942:3: error: implicit declaration of function 'emergency_thaw_bdev'; did you mean 'emergency_remount'? [-Werror=implicit-function-declaration]
> >    emergency_thaw_bdev(sb);
> >    ^~~~~~~~~~~~~~~~~~~
> >    emergency_remount
> > 
> > Caused by commit
> > 
> >   92afc556e622 ("buffer.c: call thaw_super during emergency thaw")
> > 
> > I have reverted that commit for today.
> 
> I am still doing that revert ...

That's interesting, seeing that this commit is *not* in #for-next and
08fdc8a0138a should not have that problem...
