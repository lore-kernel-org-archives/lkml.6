Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755461AbeEaPTv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755134AbeEaPTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:19:50 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CA+55aFxasUXmLwb9Mj1j8WSJbmfO1oGkcsZ2hxxbkz_p1gkUfQ@mail.gmail.com>
Cc: baijiaju1990@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>
References: <ba98332d-7013-f5cb-7d49-645ee6f49156@gmail.com>
 <20180531100457.fncibp5cxdozvbjh@pathway.suse.cz>
 <CA+55aFxasUXmLwb9Mj1j8WSJbmfO1oGkcsZ2hxxbkz_p1gkUfQ@mail.gmail.com>
Message-ID: <152777998940.144038.2717154952249020053@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: Can printk() sleep at runtime?
Date: Thu, 31 May 2018 08:19:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4VFJveE019987

Quoting Linus Torvalds (2018-05-31 07:32:10)
> On Thu, May 31, 2018 at 5:05 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > Anyway, we need to fix or remove this format. vsprintf-like functions
> > are called in any context and nobody expect that they might sleep.
> 
> Ack. I guess the argument is that "%pCr" is rare, and none of *those*
> users may care, but I do think that doing things wrong as-is.
> 
> It's too subtle to have to know you're in a particular locking context
> when you use a particular %p modifier.
> 

Agreed. Removing the format seems to be the best approach. It looks like
only Geert has used it in the last few years and it hasn't been used
much otherwise.
