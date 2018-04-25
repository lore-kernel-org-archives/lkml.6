Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754840AbeDYO44 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:56:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:52461 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753632AbeDYO4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:56:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="223261437"
Message-ID: <1524668194.21176.557.camel@linux.intel.com>
Subject: Re: [PATCH v5 07/11] vsprintf: Factor out %pV handler as va_format()
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
Date: Wed, 25 Apr 2018 17:56:34 +0300
In-Reply-To: <20180425111251.13246-8-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
         <20180425111251.13246-8-pmladek@suse.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 13:12 +0200, Petr Mladek wrote:
> Move the code from the long pointer() function. We are going to add a
> check
> for the access to the address that will make it even more complicated.
> 
> This patch does not change the existing behavior.
 
> +static char *va_format(char *buf, char *end, struct va_format
> *va_fmt)
> +{
> +	va_list va;
> +
> +	va_copy(va, *va_fmt->va);

> +	buf += vsnprintf(buf, end > buf ? end - buf : 0,
> +			 va_fmt->fmt, va);

One line?

> +	va_end(va);
> +
> +	return buf;
> +}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
