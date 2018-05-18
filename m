Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeERH0f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:26:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeERH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:26:33 -0400
Date: Fri, 18 May 2018 00:26:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: longli@microsoft.com
Cc: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 09/09] Introduce cache=rdma moutning option
Message-ID: <20180518072631.GA19250@infradead.org>
References: <20180518002214.5657-1-longli@linuxonhyperv.com>
 <20180518002214.5657-10-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518002214.5657-10-longli@linuxonhyperv.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 05:22:14PM -0700, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> When cache=rdma is enabled on mount options, CIFS do not allocate internal data
> buffer pages for I/O, data is read/writen directly to user memory via RDMA.

I don't think this should be an option.  For direct I/O without signing
or encryption CIFS should always use get_user_pages, with or without
RDMA.
