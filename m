Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeEVMob (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:44:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:58781 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbeEVMoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:44:30 -0400
Message-ID: <a625c7812378d656d8c7bce65b5222e000ec3a86.camel@kernel.crashing.org>
Subject: Re: set_fs(KERNEL_DS) vs iovec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date: Tue, 22 May 2018 22:44:08 +1000
In-Reply-To: <20180522102000.GA20067@infradead.org>
References: <8c7ac8af210606f2e4be4bfbb0b2506be53b60e3.camel@kernel.crashing.org>
         <20180522102000.GA20067@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-22 at 03:20 -0700, Christoph Hellwig wrote:
> On Tue, May 22, 2018 at 03:08:35PM +1000, Benjamin Herrenschmidt wrote:
> > Hence my question: Is is still acceptable these days to use
> > set_fs(KERNEL_DS) for simple cases like this ?
> 
> Not at all.
> 
> > Or is it really
> > deprecated and all new users should use the iovec's ?
> 
> Yes, please use iov_iter.  It should actually make your code simpler,
> too.

In this case it really doesn't :-) But that doesn't matter, I get the
message, I'll fix the driver accordingly.

Cheers,
Ben.
