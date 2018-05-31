Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755413AbeEaOcX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:32:23 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:56081 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755297AbeEaOcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:32:22 -0400
X-Google-Smtp-Source: ADUXVKLVCJMhHUc3LDfDije6DL01SY15WJLzFTO4lSt3Z8yJ9giYjPcM2MERG5DEa8LKR7axKOPAASy//mYC5ZstI9g=
MIME-Version: 1.0
References: <ba98332d-7013-f5cb-7d49-645ee6f49156@gmail.com> <20180531100457.fncibp5cxdozvbjh@pathway.suse.cz>
In-Reply-To: <20180531100457.fncibp5cxdozvbjh@pathway.suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 May 2018 09:32:10 -0500
Message-ID: <CA+55aFxasUXmLwb9Mj1j8WSJbmfO1oGkcsZ2hxxbkz_p1gkUfQ@mail.gmail.com>
Subject: Re: Can printk() sleep at runtime?
To: Petr Mladek <pmladek@suse.com>
Cc: baijiaju1990@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>, sboyd@kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 5:05 AM Petr Mladek <pmladek@suse.com> wrote:
>
> Anyway, we need to fix or remove this format. vsprintf-like functions
> are called in any context and nobody expect that they might sleep.

Ack. I guess the argument is that "%pCr" is rare, and none of *those*
users may care, but I do think that doing things wrong as-is.

It's too subtle to have to know you're in a particular locking context
when you use a particular %p modifier.

                   Linus
