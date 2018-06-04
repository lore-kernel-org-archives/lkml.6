Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeFDIrm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:47:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeFDIrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:47:40 -0400
Date: Mon, 4 Jun 2018 01:47:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/39] vfs: optionally don't account file in nr_files
Message-ID: <20180604084739.GD11333@infradead.org>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-6-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529144339.16538-6-mszeredi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:43:05PM +0200, Miklos Szeredi wrote:
> Stacking file operations in overlay will store an extra open file for each
> overlay file opened.
> 
> The overhead is just that of "struct file" which is about 256bytes, because
> overlay already pins an extra dentry and inode when the file is open, which
> add up to a much larger overhead.

But that overhead is exactly what nr_files accounts for, so this looks
bogus to me.
