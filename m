Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeDIJ7W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:59:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeDIJ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:59:20 -0400
Date: Mon, 9 Apr 2018 02:59:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: Race-free unlinking of directory entries
Message-ID: <20180409095919.GA9621@infradead.org>
References: <20171220191844.wnb3bgkpreg2tjia@pali>
 <20180409074241.2ibvhh3g5lzxnt4g@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180409074241.2ibvhh3g5lzxnt4g@pali>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 09:42:41AM +0200, Pali Rohár wrote:
> Hi! I would like to remind this my older email about race free
> unlinking. Is there any plan to provide such support?

Given that in Linux we know which directory entry a given fd refers to,
we shouldn't even need a new syscall, but simply support the
AT_EMPTY_PATH flag for funlinkat.
