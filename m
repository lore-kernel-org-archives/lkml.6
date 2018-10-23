Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3497C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6832207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGAq5d1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6832207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeJWURs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:17:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45329 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWURs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:17:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id s3-v6so509575pga.12;
        Tue, 23 Oct 2018 04:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=feJXTwRcoTmFzCsqPEg/ouTOt635fWmFV4ko86/5ieI=;
        b=JGAq5d1x8P+y2tHV5D3IB8N/+d3vdDWH5DII7AIjW6zhQvg6E9K7Jwapbytm29tT7Q
         qbd27DNmIcw3W5eGD44nJNl6+ji++oOAw9rGTF1qrEfY6CBGo4L5Ua00T2l9oXmlc+Li
         b0OIiiaOogA4JGvCO613V/6Ob38Td5m+pxr1xEpXvQp/QIhJEQ8qd4lbit620frTXohL
         dwCzclqvKjBCAQQ6KnoUxpspUJnlCn1qEESiHC4/J0ryUuXvOgu90uZh2BNBKkkX+PKR
         FzTjfYgbLFI9Ur/9SQ2Uqm3j6bYtvggnbjiao83gItv2fPeD3WLV+GZlKnZBDKTh7g8d
         NDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=feJXTwRcoTmFzCsqPEg/ouTOt635fWmFV4ko86/5ieI=;
        b=oFoggXwatKiV2LHjxHsmMKljop9OLkuQjCVJz1K/93DDNKScOM+8eSPCU4P+SnJYJB
         XHD8PjyvM41IB9NyhIJEPqG6LMXbRFmvUZ2C509ztd03iuTAxtzs+kgCCwx5nl8kRtW0
         baaBfg5K6QfnlUvsqBAWOPdb/TNI+1rrupRJXsso/U0XnHMljgL++U+FnAhvlGVt/hx+
         FK5Fa3CsQG0iw6ZRkpBUTmPbNzac0D39oA4Ww+GrF7N5ym51EICPUd1xvApvFlWTFup0
         QsI30Mdgh27hHrmpfTOoeK/fnGtaFhbgWhDpH7ZnaNS923GkoeLmXdJJwdhK2OKVL78L
         1RIA==
X-Gm-Message-State: ABuFfojTAP2OPfeEfSGO/EPSfmkViEXIsy3DxgwHBNBKZjamgS+3Mhaj
        M/jixmbF/5Vg8lGsH86Q3Az9a2+k
X-Google-Smtp-Source: ACcGV61oEJe3nBhvxC4KsCv8Y++/nEojDwv/nK498IsbG1ESFBJuvDqBVsEOExvsStlcVsdjVxqhFw==
X-Received: by 2002:a62:85cb:: with SMTP id m72-v6mr49285464pfk.173.1540295678075;
        Tue, 23 Oct 2018 04:54:38 -0700 (PDT)
Received: from localhost ([175.223.11.183])
        by smtp.gmail.com with ESMTPSA id x73-v6sm3274887pfk.139.2018.10.23.04.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:54:36 -0700 (PDT)
Date:   Tue, 23 Oct 2018 20:54:33 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Message-ID: <20181023115433.GA10251@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/23/18 13:07), Petr Mladek wrote:
> Though this looks a bit weird.
> 
> I have just realized that console_unblank() is called by
> bust_spinlocks(0) and does basically the same as
> console_flush_on_panic(). Also it does not make much
> sense wake_up_klogd() there. Finally, it seems to be
> too late to disable lockdep there.

Thanks for taking a look.
As of "weird" part I have some explanations:

> @@ -233,17 +233,14 @@ void panic(const char *fmt, ...)
>  	if (_crash_kexec_post_notifiers)
>  		__crash_kexec(NULL);
>  
> -	bust_spinlocks(0);
> -
[..]
> -	debug_locks_off();
> +#ifdef CONFIG_VT
> +	unblank_screen();
> +#endif
>  	console_flush_on_panic();
>  
>  	if (!panic_blink)


So I did look at what lib/bust_spinlocks.c does; and I agree that waking
up klogd makes little sense, on the other hand it just sets per-cpu
pending bit, so not a big deal. console_unlock() should do there the
same thing as console_flush_on_panic(). Yes. However, a bit of a bigger
argument:
   __attribute__((weak)) suggests that bust_spinlocks() is arch-dependent
   and it's up to arch to do some extra stuff there [if needed]. So that's
   why I decided to keep bust_spinlocks(0) in panic() and, thus, call into
   arch-specific code (or common bust_spinlocks); then bump oops_in_progress
   so serial consoles become re-entrant and finally call
   console_flush_on_panic().

>  void __attribute__((weak)) bust_spinlocks(int yes)
>  {
>  	if (yes) {
> +		/*
> +		 * Some locks might get ignored in the Oops situation
> +		 * to get an important work done. Locks debug should
> +		 * be disabled to avoid reporting bad unlock balance.
> +		 */
> +		debug_locks_off();
>  		++oops_in_progress;

Hmm, I don't think I've seen any reports because of this. From printk/console
POV the locks which are not taken under oops_in_progress are not released.

Wrt to uart port we usually have "bool locked" flag and unlock
port->lock only if we locked it:

{
	if (oops_in_progress)
		locked = spin_trylock_irqsave(&port->lock, flags);

	...

	if (locked)
		spin_unlock_irqrestore(&port->lock, flags);
}

Wrt to console_sem we have

{
	if (oops_in_progress)
		if (!down_trylock_console_sem() != 0)
			return;
	...
	console_unlock();
}

So the locks that we care about in this particular patch (console sem
and port->lock) probably should not see any locking imbalance.

If you have strong opinion then we can have debug_locks_off() change
as part of this patch. But maybe I'd prefer to have it as a separate
patch. What do you think?

	-ss
