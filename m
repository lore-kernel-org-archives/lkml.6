Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeENUDl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:03:41 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46570 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbeENUDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:03:39 -0400
X-Google-Smtp-Source: AB8JxZpM5ZXO801fQpglkPYsIf3ywgjG8cQx3r0B+8HTLkNA9vwhINC7eH1Tdivfd9IbS9h8JY7oUw==
Date: Mon, 14 May 2018 23:03:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] proc: test /proc/self/syscall
Message-ID: <20180514200335.GA2050@avx2>
References: <20180226212145.GB742@avx2>
 <CA+G9fYt0ymKKtk7mOgHyHiQHONMWK00Lo14FoRtd8tQM57ymsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+G9fYt0ymKKtk7mOgHyHiQHONMWK00Lo14FoRtd8tQM57ymsw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 12:34:18AM +0530, Naresh Kamboju wrote:
> Hi Alexey,
> 
> On 27 February 2018 at 02:51, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > Read from /proc/self/syscall should yield read system call and correct
> > args in the output as current is reading /proc/self/syscall.
> 
> Is this test expected to work on arm32 bit architecture ?
> I have tested on arm32 devices and it returns 1 and reported as FAIL.
> 
> Strace output:
> <snip>
> munmap(0xb6f4a000, 13514)               = 0
> open("/proc/self/syscall", O_RDONLY)    = 3
> read(3, "3 0x3 0xbeacfbe0 0x40 0x3 0xbeac"..., 64) = 64

Yes! Obviously, it was tested on x86_64 only.

arch/arm/tools/syscall.tbl shows read is #3
and pointer looks 32-bit, so what's wrong?
