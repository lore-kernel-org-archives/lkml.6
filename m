Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeDDXni (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 19:43:38 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:37542 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbeDDXng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 19:43:36 -0400
X-Google-Smtp-Source: AIpwx4+9/LSFnV84pLWmzVtmFKurqZiV6lwLxdnfR+nalHnJyU9ayPPPJp/uDi2kvrUrUmXEWkrKEw==
Date: Thu, 5 Apr 2018 08:43:30 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 7/9] vsprintf: Factor out %pO handler as
 kobject_string()
Message-ID: <20180404234330.GC622@jagdpanzerIV>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-8-pmladek@suse.com>
 <20180404233511.GB622@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404233511.GB622@jagdpanzerIV>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/05/18 08:35), Sergey Senozhatsky wrote:
> 
> Was this your intention?
> 

Ah, it was. You mentioned it in the commit message

: In fact, this avoids leaking the address when invalid %pO format
: specifier is used. The old code fallen back to printing the
: non-hashed value.

Is it so? The default is

	/* default is to _not_ leak addresses, hash before printing */
	return ptr_to_id(buf, end, ptr, spec);

	-ss
