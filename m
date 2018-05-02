Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeEBTKK convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 15:10:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50162 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeEBTKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 15:10:09 -0400
Date: Wed, 2 May 2018 21:10:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] proc: restore seekdir("/proc", 256) semantics
Message-ID: <20180502191006.a4sizopciou2bfm5@devuan>
References: <20180423215009.GE9043@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180423215009.GE9043@avx2>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Long time ago "/proc/self" was an honest symlink and all not-PID entries
> were output before /proc/$PID. To not lose /proc/self in readdir output
> after it became permanently positive dentry it was stuck before /proc/1.
> 
> One side effect of the change was that the code
> 
> 	d = opendir("/proc");
> 	seekdir(d, 256);
> 
> stopped pointing to the first PID for applications that want to skip all
> the crap.
> 
> Later "/proc/thread-self" was added in the same way.
> 
> It looks like ps and top aren't seeking over /proc but are simply
> skipping over so nobody noticed.
> 
> Restore old behaviour, make seekdir(254) point to /proc/self and
> seekdir(255) point to /proc/thread-self.

Is there anyone relying on the old behaviour?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
