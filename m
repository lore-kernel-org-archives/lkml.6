Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeDFGh4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 02:37:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeDFGhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 02:37:55 -0400
Date: Thu, 5 Apr 2018 23:37:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/20] afs: Implement @sys substitution handling
Message-ID: <20180406063754.GA9835@infradead.org>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
 <152296020457.31027.11109314533967989357.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152296020457.31027.11109314533967989357.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 09:30:04PM +0100, David Howells wrote:
> Implement the AFS feature by which @sys at the end of a pathname component
> may be substituted for one of a list of values, typically naming the
> operating system.  Up to 16 alternatives may be specified and these are
> tried in turn until one works.  Each network namespace has[*] a separate
> independent list.
> 
> Upon creation of a new network namespace, the list of values is
> initialised[*] to a single OpenAFS-compatible string representing arch type
> plus "_linux26".  For example, on x86_64, the sysname is "amd64_linux26".
> 
> [*] Or will, once network namespace support is finalised in kAFS.

Good luck making that work with the dcache without creating a total
mess.
