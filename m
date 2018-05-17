Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeEQU5B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:57:01 -0400
Received: from imap.thunk.org ([74.207.234.97]:46502 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752177AbeEQU47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:56:59 -0400
Date: Thu, 17 May 2018 16:56:55 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Stephan Mueller <smueller@chronox.de>, linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] random: fix crng_ready() test
Message-ID: <20180517205655.GC15263@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        Stephan Mueller <smueller@chronox.de>, linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
References: <20180413013046.404-1-tytso@mit.edu>
 <1699469.KmO53oa8XU@tauon.chronox.de>
 <20180413125313.GA2633@thunk.org>
 <4393662.RPWnPK42dp@tauon.chronox.de>
 <20180413170037.GA28721@thunk.org>
 <84e0c16c-2b48-69e5-4ca4-2ca3bce15dc9@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e0c16c-2b48-69e5-4ca4-2ca3bce15dc9@c-s.fr>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 08:01:04AM +0200, Christophe LEROY wrote:
> 
> On a powerpc embedded board which has an mpc8xx processor running at 133Mhz,
> I now get the startup done in more than 7 minutes instead of 30 seconds.
> This is due to the webserver blocking on read on /dev/random until we get
> 'random: crng init done':
> 
> [    0.000000] Linux version 4.17.0-rc4-00415-gd2f75d40072d (root@localhost)
> (gcc version 5.4.0 (GCC)) #203 PREEMPT Wed May 16 16:32:02 CEST 2018
> [    0.295453] random: get_random_u32 called from
> bucket_table_alloc+0x84/0x1bc with crng_init=0
> [    1.030472] device: 'random': device_add
> [    1.031279] device: 'urandom': device_add
> [    1.420069] device: 'hw_random': device_add
> [    2.156853] random: fast init done
> [  462.007776] random: crng init done
> 
> This has become really critical, is there anything that can be done ?

Figure out why the webserver needs to read /dev/random and is it for a
security critical purpose?

A kernel patch which makes the kernel do a "lalalalala I'm secure"
when it really isn't secure is a simple "solution", but would it
really make you happy?


						- Ted
