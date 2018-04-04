Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeDDX6W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 19:58:22 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:39364 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeDDX6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 19:58:21 -0400
X-Google-Smtp-Source: AIpwx49HQNcM+TNE6I5KfSKl19GvZW/Q/AGQrq/W8vPrrS7jUmVsRlM4z4pRqn93qG3+UKQ/ngserA==
Date: Thu, 5 Apr 2018 08:58:16 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/9] vsprintf: Factor out %p[iI] handler as
 ip_addr_string()
Message-ID: <20180404235816.GD622@jagdpanzerIV>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-6-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404085843.16050-6-pmladek@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/04/18 10:58), Petr Mladek wrote:
> 
> Also it is better to warn about unknown specifier instead of falling
> back to the %p behavior. It will help people to understand what is
> going wrong. They expect the IP address and not a pointer anyway
> in this situation.
>

May be. If one sees a hashed value where IP address/device name/etc
was meant to be then it's already a sign that something is wrong.
Those WARN_ONCE that you have added make things simpler, I agree.
A quick question, what happens on !CONFIG_BUG systems (where we have
no_printk() WARN)?

	-ss
