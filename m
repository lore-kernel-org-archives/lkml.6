Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755339AbeDZK3J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:29:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:46907 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754723AbeDZK3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:29:06 -0400
Date: Thu, 26 Apr 2018 12:26:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: use #pragma once
Message-ID: <20180426102629.scwtdeijbo3342gp@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180423213534.GA9043@avx2>
 <20180424135409.GA22709@infradead.org>
 <20180425205531.GA9020@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425205531.GA9020@avx2>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 11:55:31PM +0300, Alexey Dobriyan wrote:
> On Tue, Apr 24, 2018 at 06:54:09AM -0700, Christoph Hellwig wrote:
> > On Tue, Apr 24, 2018 at 12:35:34AM +0300, Alexey Dobriyan wrote:
> > > Bring /proc into 21st century.
> > 
> > Please explain what this actually buys us except for being pointlessly
> > different from the rest of the kernel?
> 
> Negative LOC diff, less junk in preprocessor hashtables.

There are about 20k header files, none of them has #pragma once.
Updating that will bring many unnesessry git commits.

I doubt that one more define in preprocessor tables is a problem we
should fix. The LOC argument also does not sound very convincing. The
include protection is at the top of the file, not mixed among other
code. Replacing 2-3 lines with one will be barely noticeable.
