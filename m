Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755608AbeCSPFe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:05:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60479 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754731AbeCSPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:05:31 -0400
Date: Mon, 19 Mar 2018 16:05:23 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Laight <David.Laight@ACULAB.COM>
cc: "'Rahul Lakkireddy'" <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>
Subject: RE: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
In-Reply-To: <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com> <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018, David Laight wrote:
> From: Rahul Lakkireddy
> In principle it ought to be possible to get access to one or two
> (eg) AVX registers by saving them to stack and telling the fpu
> save code where you've put them.

No. We have functions for this and we are not adding new ad hoc magic.

> OTOH, for x86, if the code always runs in process context (eg from a
> system call) then, since the ABI defines them all as caller-saved
> the AVX(2) registers, it is only necessary to ensure that the current
> FPU registers belong to the current process once.
> The registers can be set to zero by an 'invalidate' instruction on
> system call entry (hope this is done) and after use.

Why would a system call touch the FPU registers? The kernel normally does
not use FPU instructions and the code which explicitely does has to take
care of save/restore. It would be performance madness to fiddle with the
FPU stuff unconditionally if nothing uses it.

Thanks,

	tglx
