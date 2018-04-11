Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeDKNAn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:00:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:32309 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753040AbeDKNAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:00:42 -0400
X-RZG-AUTH: :P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9x24dP3Zg1I6xSGfZ
X-RZG-CLASS-ID: mo00
From: Stephan Mueller <smueller@chronox.de>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        Eric Biggers <ebiggers3@gmail.com>,
        syzbot <syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] crypto: DRBG - guard uninstantion by lock
Date: Wed, 11 Apr 2018 14:59:59 +0200
Message-ID: <117191397.rLtE3Es1ot@tauon.chronox.de>
In-Reply-To: <CACT4Y+bRmYMt3WuVHE7e624KgRUTXQWa36wn-pr_gm2STq80bQ@mail.gmail.com>
References: <001a114467482dbc4b05692df8f9@google.com> <2704286.80iLvC0rRL@tauon.chronox.de> <CACT4Y+bRmYMt3WuVHE7e624KgRUTXQWa36wn-pr_gm2STq80bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 11. April 2018, 14:29:45 CEST schrieb Dmitry Vyukov:

Hi Dmitry,
> 
> What do you mean by description of the fault?
> It's kernel standard FAULT_INJECTION facility, it injects faults
> mainly into kmalloc/slab_alloc (also in a bunch of other things, but
> in this case this seems to be kmalloc). In the repro you can see that
> it's injecting a fault into 8-th malloc in the setsockopt syscall.

I am now able to reproduce it.

I think I have a smoking gun, but let me test it first.

Ciao
Stephan
