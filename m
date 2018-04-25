Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeDYLog (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:44:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:54471 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751528AbeDYLod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:44:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="53519759"
Message-ID: <1524656669.21176.549.camel@linux.intel.com>
Subject: Re: [PATCH v5 04/11] vsprintf: Do not check address of well-known
 strings
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Wed, 25 Apr 2018 14:44:29 +0300
In-Reply-To: <20180425111251.13246-5-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
         <20180425111251.13246-5-pmladek@suse.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 13:12 +0200, Petr Mladek wrote:
> We are going to check the address using probe_kernel_address(). It
> will
> be more expensive and it does not make sense for well known address.
> 
> This patch splits the string() function. The variant without the check
> is then used on locations that handle string constants or strings
> defined
> as local variables.
> 
> This patch does not change the existing behavior.

> -					buf = string(buf, end, ",",
> str_spec);

> +					buf = valid_string(buf, end,
> ",",
> +							   str_spec);

> -				return string(buf, end, "(invalid
> address)", spec);
> +				return valid_string(buf, end,
> +						    "(invalid
> address)", spec);
> 

I wouldn't give a crap about over 80 in above two cases. 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
