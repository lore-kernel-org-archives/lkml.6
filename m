Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbeBERgc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:36:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49074 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbeBERgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:36:25 -0500
Subject: Re: [PATCH] vsprintf: avoid misleading "(null)" for %px
To: Steven Rostedt <rostedt@goodmis.org>,
        Adam Borowski <kilobyte@angband.pl>
Cc: "Tobin C. Harding" <me@tobin.cc>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20180204174521.21383-1-kilobyte@angband.pl>
 <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
 <20180205100305.GO29988@eros> <20180205152218.hxgozi67zka4hgkf@angband.pl>
 <20180205114952.6af99dff@gandalf.local.home>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <49fbcc8b-9522-f19c-d51c-d0059445abdc@infradead.org>
Date: Mon, 5 Feb 2018 09:36:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180205114952.6af99dff@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2018 08:49 AM, Steven Rostedt wrote:
> On Mon, 5 Feb 2018 16:22:19 +0100
> Adam Borowski <kilobyte@angband.pl> wrote:
> 
>> My change touches %px only, where your concern doesn't apply.
>>
>> You're right, though, when it comes to %pK:
>>     printk("%%pK: %pK, %%px: %px\n", 0, 0);
>> says
>>     %pK: 00000000ba8bdc0a, %px: 0000000000000000
>>
>> So what should we do?  Avoid hashing 0?  Print a special value?
> 
> My personal opinion is that NULL should stay NULL and not be hashed.
> What security issue could be leaked by a NULL? I'm not a security
> person, that's a real question.

Agree.


-- 
~Randy
