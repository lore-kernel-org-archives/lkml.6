Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeDZTYu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:24:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40457 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeDZTYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:24:48 -0400
X-Google-Smtp-Source: AIpwx4+1dy1kQ846n64+b1Oit9GC0RTnnUJTtEpNUA2SZcFTJByQtbmLbf567GbAzXHDtLsijJQTQQ==
Date: Thu, 26 Apr 2018 22:24:44 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: use #pragma once
Message-ID: <20180426192444.GA4919@avx2>
References: <20180423213534.GA9043@avx2>
 <20180424135409.GA22709@infradead.org>
 <20180425205531.GA9020@avx2>
 <20180426102629.scwtdeijbo3342gp@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180426102629.scwtdeijbo3342gp@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 12:26:29PM +0200, David Sterba wrote:
> On Wed, Apr 25, 2018 at 11:55:31PM +0300, Alexey Dobriyan wrote:
> > On Tue, Apr 24, 2018 at 06:54:09AM -0700, Christoph Hellwig wrote:
> > > On Tue, Apr 24, 2018 at 12:35:34AM +0300, Alexey Dobriyan wrote:
> > > > Bring /proc into 21st century.
> > > 
> > > Please explain what this actually buys us except for being pointlessly
> > > different from the rest of the kernel?
> > 
> > Negative LOC diff, less junk in preprocessor hashtables.
> 
> There are about 20k header files, none of them has #pragma once.
> Updating that will bring many unnesessry git commits.

If you don't obey sometimes silly rule re splitting patches,
it can be done in much less.

> I doubt that one more define in preprocessor tables is a problem we
> should fix.

Those eat cycles and memory one define at a time.

> The LOC argument also does not sound very convincing.

When was the last time you did -80 kLOC patch for free?

> The include protection is at the top of the file, not mixed among other
> code. Replacing 2-3 lines with one will be barely noticeable.
