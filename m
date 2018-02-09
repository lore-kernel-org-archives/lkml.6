Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeBIImm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:42:42 -0500
Received: from mail-pl0-f49.google.com ([209.85.160.49]:33607 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeBIIml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:42:41 -0500
X-Google-Smtp-Source: AH8x2260vXtZMXg2cGpTAMrCYJ1t8bZ5LMgikWd8xv9nV5sAVcJzcmOrBr0h0/PjeUsoytOfNt9Iiw==
Date: Fri, 9 Feb 2018 17:42:35 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Dave Young <dyoung@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] printk: move dump stack related code to lib/dump_stack.c
Message-ID: <20180209084235.GF689@jagdpanzerIV>
References: <20180209080624.GA2607@dhcp-128-65.nay.redhat.com>
 <20180209081604.GE689@jagdpanzerIV>
 <20180209082743.GA14845@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209082743.GA14845@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/09/18 16:27), Dave Young wrote:
> > Seems that those functions are still defined in printk header.
> > Did you test !CONFIG_PRINTK build?

Apparently dump_stack(void) is also in printk.h

extern asmlinkage void dump_stack(void) __cold;

so it's "OK" to keep those functions in printk.h, I guess. I thought
that dump_stack() had its own header file...

> !CONFIG_PRINTK will use the dummy functions in printk.h, I did not test
> the build, doing it now to double confirm..

Not sure. Please test.

	-ss
