Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeFAG1B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:27:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeFAG05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:26:57 -0400
Date: Thu, 31 May 2018 23:26:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 30/32] vfs: Allow cloning of a mount tree with
 open(O_PATH|O_CLONE_MOUNT) [ver #8]
Message-ID: <20180601062654.GA32397@infradead.org>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720691829.9073.10564431140980997005.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152720691829.9073.10564431140980997005.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 01:08:38AM +0100, David Howells wrote:
> Make it possible to clone a mount tree with a new pair of open flags that
> are used in conjunction with O_PATH:
> 
>  (1) O_CLONE_MOUNT - Clone the mount or mount tree at the path.
> 
>  (2) O_NON_RECURSIVE - Don't clone recursively.

Err.  I don't think we should use up two O_* flags for something
only useful for your new mount API.  Don't we have a better place
to for these flags?

Instead of overloading this on open having a specific syscalls just
seems like a much saner idea.
