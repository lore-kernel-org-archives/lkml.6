Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeDENEv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:04:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:46375 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbeDENEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:04:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,411,1517904000";
   d="scan'208";a="214161521"
Message-ID: <1522933485.21176.353.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/9] vsprintf: Consistent %pK handling for
 kptr_restrict == 0
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Date: Thu, 05 Apr 2018 16:04:45 +0300
In-Reply-To: <20180404085843.16050-3-pmladek@suse.com>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-3-pmladek@suse.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-04 at 10:58 +0200, Petr Mladek wrote:
> restricted_pointer() pretends that it prints the address when
> kptr_restrict
> is set to zero. But it is never called in this situation. Instead,
> pointer() falls back to ptr_to_id() and hashes the pointer.
> 
> This patch removes the potential confusion. klp_restrict is checked
> only
> in restricted_pointer().
> 


>  /* Maps a pointer to a 32 bit unique identifier. */
> -static char *ptr_to_id(char *buf, char *end, void *ptr, struct
> printf_spec spec)
> +static char *ptr_to_id(char *buf, char *end,
> +		       const void *ptr, struct printf_spec spec)

I don't think this change belongs to the patch.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
