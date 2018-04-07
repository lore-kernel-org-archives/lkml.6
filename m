Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeDGBRU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 21:17:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46442 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDGBRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 21:17:18 -0400
X-Google-Smtp-Source: AIpwx4+3S1xRTSCZa4Q1UAv89OzoG9XMCRzS2KvBroCzd2sJiNUljr8Jhtoi/iywkc3iuowUTHxdxw==
Date: Sat, 7 Apr 2018 10:17:14 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown pointer
 specifiers
Message-ID: <20180407011714.GC386@tigerII.localdomain>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-5-pmladek@suse.com>
 <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
 <1522971908.11185.46.camel@perches.com>
 <1522972535.11185.49.camel@perches.com>
 <20180406235214.GA386@tigerII.localdomain>
 <1523059179.6127.45.camel@perches.com>
 <20180407003301.GB386@tigerII.localdomain>
 <1523062859.6127.59.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523062859.6127.59.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/06/18 18:00), Joe Perches wrote:
[..]
> This finds the current two bad uses in addition to
> the existing similar message for string concatenation
> without a space char between concatenated fragments.
> 
> For example:
> 
> WARNING: break quoted strings at a space character
> #3550: FILE: drivers/scsi/megaraid/megaraid_sas_base.c:3550:
> +			dev_notice(&instance->pdev->dev, "moving cmd[%d]:%p:%d:%p"
> +					"on the defer queue as internal\n",
> 
> WARNING: vsprintf %p<extension> string concatenation
> #3550: FILE: drivers/scsi/megaraid/megaraid_sas_base.c:3550:
> +			dev_notice(&instance->pdev->dev, "moving cmd[%d]:%p:%d:%p"
> +					"on the defer queue as internal\n",
> 
> I think the new message is not that useful really as the
> existing warning is probably enough.

Oh, so we already have it... Didn't know that. Yes, I think the existing
one is good enough. Thanks for the pointers.

	-ss
