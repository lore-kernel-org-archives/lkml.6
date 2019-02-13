Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730B0C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB17222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR4wYxzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbfBMBlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:41:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40457 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfBMBlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:41:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so349931pgp.7;
        Tue, 12 Feb 2019 17:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NzkwmkVz5oU1xpV7JOcXij1a00PAyQd+cP0wD+5zUwE=;
        b=mR4wYxzvi6TXLJZoW3LOKHW/QcYo44Hm2eNhKOOe+YtLrE/sm4bOBwrHz6gUG3JSXZ
         V8N/OS0al1NqcvmCwv4Y08O1QFdNaZ23J23WJ7c/AkvrVz3UqAdC2Ph9fTwQ3QRE/wlG
         BSBzoASaE4xQSiF/wefdu+Gm7EA5EjLXFrDfIVESF9aUYfqeAOpJkbG3gptNcrrtLb0T
         Pi+HG3XigVkPCAEmv7TBHnpZ10TZ24bOiV41euK0dz79ZdWg3JucN3xM3e0v7si/ns57
         ZD6dht2Zcgp9gFib4fHgVVKynzPmpmFkcWvVx45rIMFKUrUeByDnyg3k3eQuitQbH/2k
         d7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NzkwmkVz5oU1xpV7JOcXij1a00PAyQd+cP0wD+5zUwE=;
        b=mdk3PTYqOtUFbJ98CPYDar64KUZUXq/ESLhbCLrDvNPplezNevHBgpHW1ACu7T+3CI
         dOE1UJbJNT+mcMdRnHDm4UqVr6i/djwpH5t7GVVq7EJsWoc6shFFYiSHrcadvCQ2pHER
         FUrm/0mxueoJ0Ew5Ep3ByDQb9RTXY9n9FySuhd876bUq0vyfH2OJz83AEq1YZMY1eaGV
         aCFMl8h1WY+3ieAQ9+kr8m1u8JRoVr2VuTo9SEMgDgJ3g6S1TpcvzW5gdrHwSGQXmVdt
         WU7M5wdgdTYfetqJa+EwJJRDeg5WuKoY0g7PFEZL+nIURpB8KjYCK170WfCjlf8fbZOJ
         j8Rg==
X-Gm-Message-State: AHQUAuZ6kJ69c4AKIDbzcMQno7uQA0p1o9pOApTfNmt9Ea3BbOZGqbWp
        4nng+me5l2r5L/SkdcyAgmfm+F7r
X-Google-Smtp-Source: AHgI3IadHoKc21ku89jVRcGqyGthWV6DWjzP62YNe6ghJ0l661WkmM+YV05/1eoiLVbPXUuhS2wL5A==
X-Received: by 2002:a62:53c5:: with SMTP id h188mr6841531pfb.190.1550022105970;
        Tue, 12 Feb 2019 17:41:45 -0800 (PST)
Received: from localhost ([39.7.15.189])
        by smtp.gmail.com with ESMTPSA id f12sm17676392pgo.13.2019.02.12.17.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 17:41:45 -0800 (PST)
Date:   Wed, 13 Feb 2019 10:41:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Message-ID: <20190213014141.GB8097@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/12/19 15:29), John Ogness wrote:
> - console_flush_on_panic() currently is a NOP. It is pretty clear how
>   this could be implemented if atomic_write was available. But if no
>   such console is registered, it is not clear what should be done. Is
>   this function really even needed?

If you now rely on a fully preemptible printk kthread to flush
pending logbuf messages, then console_flush_on_panic() is your
only chance to see those pending logbuf messages on the serial
console when the system dies.

Non-atomic consoles should become atomic once you call bust_spinlocks(1),
this is what we currently have:

	panic()
	bust_spinlocks(1)                       // sets oops_in_progress
	console_flush_on_panic()
	 call_console_drivers()
	  -> serial_driver_write()
	      if (oops_in_progress)
	        locked = spin_trylock_irqsave(&port->lock);
	      uart_console_write();
	      if (locked)
	        spin_unlock_irqrestore(&port->lock);

	-ss
