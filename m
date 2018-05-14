Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeENTEW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:04:22 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:43059 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeENTEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:04:20 -0400
X-Google-Smtp-Source: AB8JxZpf9qvj0ssUzL6D+AOXSQMf7QjxdaYh16IWhwRGiWaUsr8paoUKah2ER+Lty3WmohH4VaiPmhTPVWqwieeN6oQ=
MIME-Version: 1.0
In-Reply-To: <20180226212145.GB742@avx2>
References: <20180226212145.GB742@avx2>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 May 2018 00:34:18 +0530
Message-ID: <CA+G9fYt0ymKKtk7mOgHyHiQHONMWK00Lo14FoRtd8tQM57ymsw@mail.gmail.com>
Subject: Re: [PATCH 2/2] proc: test /proc/self/syscall
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On 27 February 2018 at 02:51, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> Read from /proc/self/syscall should yield read system call and correct
> args in the output as current is reading /proc/self/syscall.

Is this test expected to work on arm32 bit architecture ?
I have tested on arm32 devices and it returns 1 and reported as FAIL.

Strace output:
<snip>
munmap(0xb6f4a000, 13514)               = 0
open("/proc/self/syscall", O_RDONLY)    = 3
read(3, "3 0x3 0xbeacfbe0 0x40 0x3 0xbeac"..., 64) = 64
exit_group(0)                           = ?
+++ exited with 0 +++

Ref:
selftests: proc-self-syscall failed on arm32
https://bugs.linaro.org/show_bug.cgi?id=3783
