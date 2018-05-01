Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeEAVGA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 17:06:00 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:50912 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeEAVF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 17:05:59 -0400
X-Google-Smtp-Source: AB8JxZoR5crxY7yzwAtc7i/S6K28f1c4XFvGV+HcFPjUY1VgrekQosJV//4+OBF4H3LqOBaV16BFHjN172Q5P5HdUmI=
MIME-Version: 1.0
References: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 01 May 2018 21:05:48 +0000
Message-ID: <CA+55aFwoOee_8H-1KRnY1G-Ud4Rez16s8xjVbG8YOPn1jqxxtg@mail.gmail.com>
Subject: Re: [PATCH 0/6] use memcpy_mcsafe() for copy_to_iter()
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 1:55 PM Dan Williams <dan.j.williams@intel.com>
wrote:

> The result of the bypass is that the kernel treats machine checks during
> read as system fatal (reboot) when they could simply be flagged as an
> I/O error, similar to performing reads through the pmem driver. Prevent
> this fatal condition by deploying memcpy_mcsafe() in the fsdax read
> path.

How about just changing the rules, and go the old "Don't do that then" way?

IOW, get rid of the whole idea that MCS errors should be fatal. It's wrong
and pointless anyway.

The while approach seems fundamentally buggered, if you ever want to mmap
one of these things. And don't you want that?

So why continue down a fundamentally broken path?

                  Linus
