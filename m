Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeFDIs3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:48:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeFDIs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:48:28 -0400
Date: Mon, 4 Jun 2018 01:48:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/39] vfs: add f_op->pre_mmap()
Message-ID: <20180604084827.GE11333@infradead.org>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-7-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529144339.16538-7-mszeredi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:43:06PM +0200, Miklos Szeredi wrote:
> This is needed by overlayfs to be able to copy up a file from a read-only
> lower layer to a writable layer when being mapped shared.  When copying up,
> overlayfs takes VFS locks that would violate locking order when nested
> inside mmap_sem.
> 
> Add a new f_op->pre_mmap method, which is called before taking mmap_sem.

NAK.  We really should not add multiple methods for mmap, and everytime
this came up we found a better way to solve the problem instead.  Most
recent example was the socket zero copy receive code.
