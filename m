Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbeCKVfj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 17:35:39 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:51281 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932275AbeCKVfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 17:35:37 -0400
X-Google-Smtp-Source: AG47ELu2zfb0JqSizzT805qkzggxfVg8PG7vKcqw4oG64tPvgc3gwsNjt+GA0TZA9mM3EpUTPIN51w==
Date: Mon, 12 Mar 2018 00:35:34 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com, xiyou.wangcong@gmail.com, fw@strlen.de
Subject: Re: [PATCH] proc: reject "." and ".." as filenames
Message-ID: <20180311213534.GA5171@avx2>
References: <20180310001223.GB12443@avx2>
 <20180311213057.GA3769@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180311213057.GA3769@amd>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 10:30:58PM +0100, Pavel Machek wrote:
> On Sat 2018-03-10 03:12:23, Alexey Dobriyan wrote:
> > Various subsystems can create files and directories in /proc
> > with names directly controlled by userspace.
> > 
> > Which means "/", "." and ".." are no-no.
> > 
> > "/" split is already taken care of, do the other 2 prohibited names.
> 
> Hmm, patch is probably good idea, but now it means that userspace can
> trigger WARN()s, and can hide objects from root by naming them '.' and
> '..'... which is not good.

Patch rejects creation of such entries.

And they should be harmless as VFS lookup won't find them, only readdir
would. It not clear how they could be useful.
