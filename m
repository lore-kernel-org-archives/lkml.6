Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935605AbeCSQ3a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:29:30 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53464 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935570AbeCSQ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:29:21 -0400
X-Google-Smtp-Source: AG47ELsVeX7km5Q1SEq2C7kS9tl7Fwj5j1ZM7wTGAg3sqe1uE8En6EPXZyYQ1nQ9s1uRzmgfsG6xje+ye9wHHQM3/Ak=
MIME-Version: 1.0
In-Reply-To: <ba8ac1f8c1f444da857b6a46c4153672@AcuMS.aculab.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com> <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com> <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <ba8ac1f8c1f444da857b6a46c4153672@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Mar 2018 09:29:19 -0700
X-Google-Sender-Auth: 29ZyxyaTu9C3cyK7tqq-y_n1Imw
Message-ID: <CA+55aFzOjqaW-hYcAaMJ=2gh4GAqP6jOjnWv6mK0eygAW2wL-A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
To: David Laight <David.Laight@aculab.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 8:53 AM, David Laight <David.Laight@aculab.com> wrote:
>
> The x87 and SSE registers can't be changed - they can contain callee-saved
> registers.
> But (IIRC) the AVX and AVX2 registers are all caller-saved.

No.

The kernel entry is not the usual function call.

On kernel entry, *all* registers are callee-saved.

Of course, some may be return values, and I have a slight hope that I
can trash %eflags. But basically, a system call is simply not a
function call. We have different calling conventions on the argument
side too. In fact, the arguments are in different registers depending
on just *which* system call you take.

                  Linus
