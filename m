Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB1CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2C420671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFtJemb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2C420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeJWUfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:35:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39540 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJWUfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:35:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id e67-v6so528415plb.6;
        Tue, 23 Oct 2018 05:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X+VDBCcN50SuGfbTBlLF8lQKLFDbCRL6cREZHVdGokM=;
        b=HFtJemb+dlhgLRKQLJZzGHvFBTrUDNz9n9v2BSpD5wr7uSoCUa/g+tc66dxexLXQ6F
         fd00nMEnBnsqPYKUkxftC4woKBRn53zXlT0qRPT0T+7Sj5mAPPWP7C7c/7PO2Ap7XR4/
         lVRXbLDLwg2yNKN3vEQiqDMz+fDBmsCuo3dETstnL/Cn0bSb/DkLJvGWkC3s4C6RZ7ra
         h/bqWunOYG2gteq/dGSCKFuEViZA38CWHbC6oWc80Is4pD22pGEPtZc3I+Dc1yJljX/e
         /rTLMCICtlFbqiFkTVjE0DCwV7VCxVoe25jTVIWRiljNMBAwc8KGT/RyhbA5vQplgSgX
         wcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X+VDBCcN50SuGfbTBlLF8lQKLFDbCRL6cREZHVdGokM=;
        b=L2jrozr20gcryhdoqo6fdxwFO4xgS40vfhrFFAztv2Pn/EIFUB9lXEKh/ij0Ln60HE
         cMcaZWdPYFI2fJ5VPyhJr+Lg1Ayukw/xMyIglrFAgoPqtPMuQwWmAUhBHNdywFPANaYH
         kVxAXnYuBf8/0lpoJr/AyNUYXBx03TSBGUZ7K3Bc35u2uaepRqgFa9oQrlSUNELnlgh9
         xDESyOJBQfQBjvGOtL9xdl5w98X6VmE+QNSRiindRRVZnEth213gjHbKt94BK+qJcMIO
         1Ju10ZklieIKQTuHGfNBQKDyfiIgZLhdTwSmofL4IwOkHvLCmkHOqs5DGViMJCV2pm4/
         Jseg==
X-Gm-Message-State: AGRZ1gIwHA3BpuhMC5xDuFttPLeWy3GfOZrDvrKPMMEVFZKw7uapl0sw
        qGL7043bfkigGV7xGmfuSM4=
X-Google-Smtp-Source: AJdET5cyIDQ2qpJM4JwoE4Pkl5zPJMxMpkyrCvAedyhh47sGUGBpgsDf9urt93k+Uqc78zOuI/37+A==
X-Received: by 2002:a17:902:2924:: with SMTP id g33-v6mr11643797plb.76.1540296754637;
        Tue, 23 Oct 2018 05:12:34 -0700 (PDT)
Received: from localhost ([175.223.11.183])
        by smtp.gmail.com with ESMTPSA id p1-v6sm1858032pfj.72.2018.10.23.05.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 05:12:33 -0700 (PDT)
Date:   Tue, 23 Oct 2018 21:12:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Message-ID: <20181023121057.GC10251@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
 <20181023115433.GA10251@jagdpanzerIV>
 <20181023120441.GB10251@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023120441.GB10251@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/23/18 21:04), Sergey Senozhatsky wrote:
> 
> Seems that s390 is the only arch which defines its own bust_spinlocks().
> Not sure why... Just to play games with console_loglevel?
> 
> ---
> 
> void bust_spinlocks(int yes)
> {
> 	if (yes) {
> 		oops_in_progress = 1;
> 	} else {
> 		int loglevel_save = console_loglevel;
> 		console_unblank();
> 		oops_in_progress = 0;
> 		/*
> 		 * OK, the message is on the console.  Now we call printk()
> 		 * without oops_in_progress set so that printk will give klogd
> 		 * a poke.  Hold onto your hats...
> 		 */
> 		console_loglevel = 15;
> 		printk(" ");
> 		console_loglevel = loglevel_save;
> 	}
> }
> 
> ---
> 
> The "printk(" "); without oops_in_progress" part is a bit worrisome.
> This thing technically can deadlock. Unless s390 has no NMI panic().

And console_unblank() is not guaranteed to print anything (unlike
console_flush_on_panic(), but oops is not panic() yet, so we can't
replace it with flush_on_panic()) - console_sem can be locked, so
console_unblank() would do nothing.

That printk(" ") probably wants to be printk_deferred(" ").

	-ss
