Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbeEBRcL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:32:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBRcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:32:10 -0400
Date: Wed, 2 May 2018 10:32:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, bcrl@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-abi-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: add RWF_IOPRIO
Message-ID: <20180502173207.GA27997@infradead.org>
References: <20180430165740.2842-1-adam.manzanares@wdc.com>
 <20180430165740.2842-2-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430165740.2842-2-adam.manzanares@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 09:57:39AM -0700, adam.manzanares@wdc.com wrote:
> From: Adam Manzanares <adam.manzanares@wdc.com>
> 
> This is the per-I/O equivalent of the ioprio_set system call.
> 
> When the RWF_IOPRIO flag is set then the aio_reqprio field of the iocb
> is interpreted as an I/O scheduling class and priority.

I think this belongs into the IOCB_FLAG_* flags namespace for aio_flags
field as it isn't a field valid for plain read/write.

Also you probably want to merge both patches as they only really
make sense together.
