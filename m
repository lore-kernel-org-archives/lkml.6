Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeFDIuJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:50:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeFDIuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:50:06 -0400
Date: Mon, 4 Jun 2018 01:50:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/39] vfs: fix freeze protection in
 mnt_want_write_file() for overlayfs
Message-ID: <20180604085005.GG11333@infradead.org>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-33-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529144339.16538-33-mszeredi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:43:32PM +0200, Miklos Szeredi wrote:
> The underlying real file used by overlayfs still contains the overlay path.
> This results in mnt_want_write_file() calls by the filesystem getting
> freeze protection on the wrong inode (the overlayfs one instead of the real
> one).
> 
> Fix by using file_inode(file)->i_sb instead of file->f_path.mnt->mnt_sb.

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
