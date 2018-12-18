Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9D8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EE2218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx60SSKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeLRPPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:15:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41905 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeLRPPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:15:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so7949079plm.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ql5UQqkPsmc6hjEQiMVZaRSE5McJsjTh1vL28v+6tU=;
        b=Nx60SSKlr2xZFQpL8uAKvMqa3/t/TBCVSrgg+HUwkl86VegzhLrBJIwEuBxjtYAfeL
         gt2jLVEaHD2uOiUk/VcEvumjTI1Dg229/K2ac4gPTkrncG73sT8s6SeETaJJLAR6U0bQ
         RwwXM+kgIIZzSiAKnBNCJrDriCtSKZCuYTSV8mRPXpe+iOsJLObwJbFlYjGt4Vs01nNe
         k92P2nhQAb3JO+pJXgzxHCo4hqvywVc4IRCARfpzpIzbN3CI2/fmTwCkSDkR9WYbtfab
         CnPb8RM1yl7+X3RWtEICFQpEBQRlJ5zPNO6A706oAftU9fygrNDg9I0In6VZjaRLUjls
         BmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ql5UQqkPsmc6hjEQiMVZaRSE5McJsjTh1vL28v+6tU=;
        b=r24wGY53ZNgruhTL7HPH8Iuvvpp+lAnCos59Ou1jGR+JJpo+oNHAfiJUD7ZVQR+1GF
         D9VW1Bcw9q7KYwSTwiD/gnr4WjUNdE72F89ktEqInrf1z1QiVkMdRaAZO0A0mf0eEEXl
         h6Oc2/iorlJXJ2hPfpKoDB8UQoa6WhmdxEnDnspsggHtJPy/IfiL7N7yjgPmHoK8tgGO
         jm3o8+nUuMrUvzHtN8F5fAM7h0DFtf8TiW9KM2qEIcKjaaOW8Z0Y6LIwULHEusI1EB+E
         OZDNqs2C9L1DheM6/N8kc5Nold3EZuh/4051Mz1RS44w4gN9ROdWLm42qwGTex5TwVNk
         QFcw==
X-Gm-Message-State: AA+aEWa5d1Ua0x2F907FAl1BtO+/sYN9OZMqIRMELrHg+cMQXw7UPce9
        ULUkCmNV93/4c5NIc/k5wxQ=
X-Google-Smtp-Source: AFSGD/Vi+5HnAv+AaAm758EiFt7VybpmjPNxLSHf136+Mx6PP09lj39fCty1SeGT8RVaXhLaVguCEA==
X-Received: by 2002:a17:902:7b88:: with SMTP id w8mr16672347pll.320.1545146099107;
        Tue, 18 Dec 2018 07:14:59 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id t21sm22288690pgg.24.2018.12.18.07.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 07:14:58 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 19 Dec 2018 00:14:55 +0900
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218151455.GE665@tigerII.localdomain>
References: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
 <20181218104812.GC15430@hirez.programming.kicks-ass.net>
 <20181218111701.GA32522@jagdpanzerIV>
 <20181218114709.GF7485@zn.tnic>
 <20181218130750.GA665@tigerII.localdomain>
 <20181218142623.GH7485@zn.tnic>
 <20181218145558.GD665@tigerII.localdomain>
 <20181218150313.GI7485@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218150313.GI7485@zn.tnic>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/18/18 16:03), Borislav Petkov wrote:
> On Tue, Dec 18, 2018 at 11:55:58PM +0900, Sergey Senozhatsky wrote:
> > Good question. Theoretically, there can be some interesting stuff.
> > Examples: https://bugzilla.redhat.com/show_bug.cgi?id=1515373#c6
> > or        https://github.com/systemd/systemd/issues/5433
> 
> Just like that last page says, people should use the printk.devkmsg=
> option when they wanna see all messages. Normally, we do add cmdline
> options to the kernel cmdline when debugging, like
> 
> debug ignore_loglevel log_buf_len=16M ...

Right, but unlike log_buf_len, devkmsg is a bit close to a "binary" knob:
either all messages or none; it's not like we can say "printk.devkmsg=100
messages per 5 * HZ max".

	-ss
