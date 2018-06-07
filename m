Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7aZfIuw5GVsCEAAAmS7hNA
	; Thu, 07 Jun 2018 14:01:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4F8B5608C8; Thu,  7 Jun 2018 14:01:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF8fLSrN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C3C74607E7;
	Thu,  7 Jun 2018 14:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3C74607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932578AbeFGOBI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:01:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40896 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753535AbeFGOBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:01:04 -0400
Received: by mail-pl0-f66.google.com with SMTP id t12-v6so6197268plo.7;
        Thu, 07 Jun 2018 07:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KaSxbIg7nSJxUIomksIh5MGb4G5+ctVsD2J47N1gSGI=;
        b=fF8fLSrNCA8M6OZPoSg+YVSdqySh6Xbq3tyzsDv4AO1UTzLuZg51PdS1E6FCiCgWRq
         w7IuVXFt/osLc4dF0BbKhtZ1nxGbEIJLq9IUczoIhpdq3QlbHgEWVZeWvceBze/ilmsp
         Y7tuMOSE5f1LAVv6uNXLN+KcNx9xw1VTGMNWzf8InCgzRbKEEvA/5X6SURP8pM4hgs9I
         DVUXy7PoNkeuQVyJw/bvSfXtJsz4oF1v9ZhHtvj5Ymz0waDfvkGPtrlTREONlBkno93Q
         LFjBDRjwUNIlFgzZOoNVrX5ecRnHTmxb0tcGsxUM0faVmGh+es1ldoqfk+XRMxbynVoE
         Z49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KaSxbIg7nSJxUIomksIh5MGb4G5+ctVsD2J47N1gSGI=;
        b=jSSqvNjev9qXMIUTHS2fIK4pZMMiIXsfcv3HpJbT6/Y1uEWXUCfklY8Do4GYZrRE2M
         HeJqaERJrF7rhHoMr4VYgCkwXnjvQSSjwtgWVxBorXfDlmNVS6CqxGdRtp0KLbc1xXFh
         +vS+Ee8Jk7qN+OXaezenZOclrOWIHfdfcXL1MsIuXFStfDL+ZeoEq2/ySkIwyWXbxc0Z
         h3BqwcKWn/flpSYhfHxjHHhONOb4CIFXkzqyWlYiJQGGynEyfyGCADjTj7UU5rNvu0J0
         c1aPt5aelO9dh9rp1K7XF/HgcqA2bxWeOZOKMCEbx12AibfGrfftcXEuXet9B/dti9QO
         5EXw==
X-Gm-Message-State: APt69E1sv9nEEMUBVowLXRyA2dGmX99t+IO7WEwKC+ZrYGbM/U3xsdpN
        MeG2dhoDH+JDGLOhIzKDOqi36UxR
X-Google-Smtp-Source: ADUXVKIxugGty+P8ozREmZUjrv1zdAd//+45WuVogeVW4gUx5b3ER6ZOBMkHAMIzcMpA7vyrMNj4/g==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12-v6mr2147338plk.159.1528380064346;
        Thu, 07 Jun 2018 07:01:04 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id b84-v6sm66460944pfm.123.2018.06.07.07.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 07:01:03 -0700 (PDT)
Date: Thu, 7 Jun 2018 23:01:00 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: possible deadlock in console_unlock
Message-ID: <20180607140100.GA398@tigerII.localdomain>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
 <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/07/18 13:00), Petr Mladek wrote:
> > IOW
> > 
> >     tty ioctl
> >     tty_port->lock		IRQ
> >     printk			uart_port->lock
> >     console_owner
> >     uart_port->lock		tty_port->rlock
> 
> Great analyze!

Thanks!

> I am just afraid that there are many other locations like this.

Yep, agree. That's why I suggested the printk_safe context for
most critically important locks.

> > Another way could be - switch to printk_safe mode around that
> > kmalloc():
> > 
> > 	__printk_safe_enter();
> > 	kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> > 	__printk_safe_exit();
> > 
> > Or, may be, we even can switch to printk_safe mode every time we grab
> > tty_port lock.
>  
> > Perhaps something like this should be done for uart_port->lock
> > as well. Because, technically, we can have the following
> 
> Yeah, we would need this basically around any lock that can be taken
> from console write() callbacks. Well, this would be needed even
> around locks that might be in a chain with a lock used in these
> callbacks (as shown by this report).

Yep. So the plan for now is to wrap the tty_port->lock. Pretty much
an automatic conversion.

Then to convert [may be some for now on] uart_port->lock. Once again,
pretty much can be done a script.

Afterwards just sit down and be humbl^W^W wait for new reports. Then
move those newly discovered unsafe locks under printk_safe context.

Basically, the same macros as we use for logbuf lock in printk.c

A bit of a lazy approach. Can't think of anything better.

I think it's finally the time to start dealing with these
"external" locks, it's been a while.

> BTW: printk_safe context might be too strict. In fact,
> printk_deferred() would be enough. We might think about
> introducing also printk_deferred context.

Could be.
The good thing about printk_safe is that printk_safe sections can nest.
I suspect there might be locks/printk_safe sections nesting at some
point. In any case, switching to a new flavor of printk_safe will be
pretty easy - just replace printk_safe_enter() with printk_foo_enter()
and the same for printk_save_exit().

I'll wait for some time, to see what people will say.
I guess we also need to check if Linus is OK with the proposed solution.

	-ss
