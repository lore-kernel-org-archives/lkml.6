Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755063AbeDYPdJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:33:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:54970 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754978AbeDYPcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:32:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="49863167"
Message-ID: <1524670366.21176.569.camel@linux.intel.com>
Subject: Re: [PATCH v5 09/11] vsprintf: Prevent crash when dereferencing
 invalid pointers
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
Date: Wed, 25 Apr 2018 18:32:46 +0300
In-Reply-To: <1524669054.21176.566.camel@linux.intel.com>
References: <20180425111251.13246-1-pmladek@suse.com>
         <20180425111251.13246-10-pmladek@suse.com>
         <1524669054.21176.566.camel@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 18:10 +0300, Andy Shevchenko wrote:

Some typos fixed

> I would preserve similar style of buf pointer handling, i.e.
> 
> static char *valid_pointer_access(char **buf, char *end,

char *buf

> 				  const void *ptr, struct printf_spec
> spec)
> {
> 	const char *err_msg;
> 
> 	err_msg = check_pointer_access(ptr);
> 	if (err_msg)
> 		return = valid_string(*buf, end, err_msg, spec);

		return valid_string(buf, end, err_msg, spec);

> 	return NULL;
> }
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
