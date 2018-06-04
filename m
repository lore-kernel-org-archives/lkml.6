Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeFDWjR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 18:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbeFDWjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 18:39:16 -0400
Date: Mon, 4 Jun 2018 18:39:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, joel@jms.id.au, me@tobin.cc,
        corbet@lwn.net
Subject: Re: ptrval hiding -- first kernel messages look rather
 "interesting"
Message-ID: <20180604183913.381bb45c@gandalf.local.home>
In-Reply-To: <20180601103144.GD31639@amd>
References: <20180601103144.GD31639@amd>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2018 12:31:44 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> v4.17 on n900:
> 
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xd0000000 - 0xff800000   ( 760 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xcff00000   ( 255 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)

Looks like the above is pointer values. Grant it, they are dynamic, but
still.


> [    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (8160 kB)
> [    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
> [    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 309 kB)
> [    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 333 kB)
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> 
> I mean -- security is nice, but perhaps we should adjust the messages
> so this does not look like we are making fun of the user?

Hmm, do we hash even when the kernel isn't relocatable? Seems rather
pointless if a kernel will always load in the same memory locations to
hash the pointer values that address them.

-- Steve
