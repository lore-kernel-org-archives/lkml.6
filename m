Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCVRH1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:07:27 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:44307 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCVRHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:07:25 -0400
X-Google-Smtp-Source: AG47ELtgXBTStDU/o1pTNWl0e+ph+ZZ4hbpuLonusfNFsJDU2ZMew2k9Vzsf7kTMwUPKCB3soVCLRSWi4HEMdtdX0Ag=
MIME-Version: 1.0
In-Reply-To: <b4658ee26be34c47807de0e5e13e7b31@AcuMS.aculab.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com> <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com> <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com> <CA+55aFybTvLz47mw=AG21jCJv_hE2vaVyiJP_F-4vAD-3Gnc7Q@mail.gmail.com>
 <20180321074634.dzpyjz3ia46snodh@gmail.com> <CA+55aFyK6uJopBjZGyeDz0O+qzCac6AwPkJyOpuaT69inPgVgw@mail.gmail.com>
 <2f5cb27711e741fba77846574e72eb62@AcuMS.aculab.com> <b4658ee26be34c47807de0e5e13e7b31@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Mar 2018 10:07:23 -0700
X-Google-Sender-Auth: xI78y8ATaJJI0gbg7tAJY_cshEI
Message-ID: <CA+55aFwdC4bK6aEM-h4z=EtRvYg1uG7uu9sSu25M5FnSCcakMQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
To: David Laight <David.Laight@aculab.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Fenghua Yu <fenghua.yu@intel.com>, Eric Biggers <ebiggers3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 5:48 AM, David Laight <David.Laight@aculab.com> wrote:
>
> So if we needed to do PIO reads using the AVX2 (or better AVX-512)
> registers would make a significant difference.
> Fortunately we can 'dma' most of the data we need to transfer.

I think this is the really fundamental issue.

A device that expects PIO to do some kind of high-performance
transaction is a *broken* device.

It really is that simple. We don't bend over for misdesigned hardware
crap unless it is really common.

> I've traced writes before, they are a lot faster and are limited
> by things in the fpga fabric (they appear back to back).

The write combine buffer really should be much more effective than any
AVX or similar can ever be.

               Linus
