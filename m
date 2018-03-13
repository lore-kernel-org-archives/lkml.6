Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeCMED6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 00:03:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34576 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeCMED4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 00:03:56 -0400
Date: Tue, 13 Mar 2018 04:03:54 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Zdenek Kabelac <zkabelac@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: Timing performance regression 4.15 to 4.16-rc1
Message-ID: <20180313040354.GW30522@ZenIV.linux.org.uk>
References: <31a4b0d7-2c9e-ce76-a486-48ed18b96cc6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31a4b0d7-2c9e-ce76-a486-48ed18b96cc6@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 02:02:03PM +0100, Zdenek Kabelac wrote:
> Hi
> 
> I've noticed quite some drop of performance (around 15% in some cases) where
> execution of lvm2 tests took longer time - and while tests itself should not
> really load CPU system  - the overall running time just got bigger.
> 
> Running bisect game pointed clearly to this commit:
> 
> ---
> 
> commit 44c02a2c3dc55835e9f0d8ef73966406cd805001
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Thu Oct 5 12:59:44 2017 -0400
> 
>     dev_ioctl(): move copyin/copyout to callers
> 
> 
> ---
> 
> clear revert of this commit on top of 3266b5bd97eaa72793df0b6e5a106c69ccc166c4
> (recent  ~4.16-rc4)  restored timing of tests back.
> 
> 
> I'm not sure why - so at this moment this is just a patch causing 15% longer
> running times on lvm2 test suite.

I find it very hard to believe, TBH.  It doesn't go anywhere near drivers/md;
could you profile the damn thing and see where does it spend that extra time?

It really doesn't touch anything on non-sockets...
