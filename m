Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeEVKUH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:20:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeEVKUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:20:03 -0400
Date: Tue, 22 May 2018 03:20:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: set_fs(KERNEL_DS) vs iovec
Message-ID: <20180522102000.GA20067@infradead.org>
References: <8c7ac8af210606f2e4be4bfbb0b2506be53b60e3.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c7ac8af210606f2e4be4bfbb0b2506be53b60e3.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 03:08:35PM +1000, Benjamin Herrenschmidt wrote:
> Hence my question: Is is still acceptable these days to use
> set_fs(KERNEL_DS) for simple cases like this ?

Not at all.

> Or is it really
> deprecated and all new users should use the iovec's ?

Yes, please use iov_iter.  It should actually make your code simpler,
too.
