Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeCQB3l (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 21:29:41 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:38201 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbeCQB3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 21:29:39 -0400
X-Google-Smtp-Source: AG47ELtg711KAwdGL4WBl76b6b3tunqEGX2FlqEpjmvMQa0YQH7f6CmHkmu4FD6Ix4K+qtwwo4fs1w==
Date: Sat, 17 Mar 2018 10:29:35 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
Message-ID: <20180317012935.GA6691@tigerII.localdomain>
References: <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
 <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
 <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
 <20180315075842.GD3628@jagdpanzerIV>
 <20180315080309.GF3628@jagdpanzerIV>
 <20180315130117.7c2fb761@vmware.local.home>
 <20180316011852.GA5139@jagdpanzerIV>
 <CA+55aFzLQvPCB-A2ZN9h86pBDbNC1RXwzB=URRKFcJpXFzanig@mail.gmail.com>
 <20180316055346.GB5139@jagdpanzerIV>
 <20180316085556.t3j65zyuyjzro3n3@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316085556.t3j65zyuyjzro3n3@pathway.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/16/18 09:55), Petr Mladek wrote:
[..]
> I am not sure if it is worth it. I think that we would catch 99% of
> problems by checking the first byte.
> 
> This patch was motivated by a code clean up rather than bug reports.

OK. Then I think we really need this "the patch is just good enough" line
in the commit message and a big comment in the source code.

Another idea (just an idea) - for some pointers we know the address range
we are going to access and can check the first and the last byte. E.g. for
UUID it's check_access(ptr) and check_access(ptr + len), and so on. Won't
work for string() in general case, tho.

	-ss
