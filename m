Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759064AbeD1QhM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 12:37:12 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36235 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757893AbeD1QhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 12:37:11 -0400
X-Google-Smtp-Source: AB8JxZr2jRZFgfUiACb2j9MPv/WzWmimBy7juHByqhd2vukCFQhPZzR51912wL3c4HovOzDm6yB2y1WuPhA1WLLy1rE=
MIME-Version: 1.0
References: <alpine.DEB.2.21.1804272122390.1596@nanos.tec.linutronix.de> <20180428091823.h3iajtxkqdwdcpst@gmail.com>
In-Reply-To: <20180428091823.h3iajtxkqdwdcpst@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 28 Apr 2018 16:36:59 +0000
Message-ID: <CA+55aFwgcmpSoNh17Pbtsw8j8KzufdvroC9Rsd3K-UbTTP9qPg@mail.gmail.com>
Subject: Re: [RFD] x86: The future of MPX
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 2:18 AM Ingo Molnar <mingo@kernel.org> wrote:

> I just tried the MPX testcases with the latest kernel:

>   deimos:~/tip/tools/testing/selftests/x86> ./mpx-mini-test_64

They need to be run as root. They try to access

     /sys/kernel/debug/tracing/set_ftrace_pid
     /sys/kernel/debug/tracing/trace

and that's root-only.

> ... and both of them crashed.

That's just because they use "assert()" to check that the file open worked.

"assert()" is evil and bad bad bad.

                      Linus
