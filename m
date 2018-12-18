Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AF8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE28521841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZKeF3/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeLRQwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:52:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34981 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeLRQwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:52:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so8093301plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RC6igaPC5sJuqguvu/xuJTYNBN7mp0ebO6g02cnPcW4=;
        b=fZKeF3/tYsPg4y0mSnWYTJAQt043Ngv/rXnhMyvxnX/16mTZRwK3Ag5xAb2/X4bWOn
         e7WN2TaKSDYbEWKHLU7hoa8tsmHt+WySKtfOCtKyWBV7LJZP8L9KHnKfgZiviByNMzjh
         XBZdMKF3SKMJaPoJkNF1bBktgwIwmod15BDE1ZxtV5ZxD9eWEIJ3mKV+bHRqEz0E2OD8
         nQ1DIwk8w1rY3C6EjZDvb/xo/rcn9LHZ2ALd3drLieq/Qny6Yb3yK4hTrBvzt2med/bl
         TPJrsbdyV0Zo459gtz4bTo/DmoAHy/oh+H56OJk/jkfHj8kQiN6YNsp5CcWqnx+AWz6M
         BEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RC6igaPC5sJuqguvu/xuJTYNBN7mp0ebO6g02cnPcW4=;
        b=dNemWs16hQV4Lmq4eRY7Uziqg71gkHrgPBSdOrxmJbqiCi6cxMqLPhmCWmsNmMbUgE
         Lveepi6iO/y1Bh1hMzFdToaLMveQMMcABVZ5N/rrTMOU8kQ6MBk1BdMLj49iHTTpcG0R
         mKHKLfJ5WdsvAIQXt0QyR3zP7e6U/bSgELxYtwgL8DyVI47DXQSg8m1g0FYji1iO0sFg
         Pj/Gf4w4GIuy01q0QcJcjpm6Xh/QP9uNc1wi2NItO0abpC5N1PBGBbWtSFMgzT8IRzVV
         LYjK/J9SbUnMiYs8E/rPgWkqCLg2aaBmJeVKpp7fOExhmmzFV58nK6aXWuaMzYHNw85e
         QomA==
X-Gm-Message-State: AA+aEWZoDTmZS7kvyjBe+IfZ75CXo2mYuMMZHA5zUzfeIEEFli7jT7tM
        hsqLPXTXxZ04lZ1tHScA6z8=
X-Google-Smtp-Source: AFSGD/WlhpV4Rn2JZip3ONeJXd0AYRVxAjZZrY3enprPfLKKa3lmD5ptP8DD7WN7+jSr13dwA+mWiA==
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr17507340plb.335.1545151942099;
        Tue, 18 Dec 2018 08:52:22 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id v62sm27640347pfd.163.2018.12.18.08.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 08:52:20 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 19 Dec 2018 01:52:17 +0900
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218165217.GA534@tigerII.localdomain>
References: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
 <20181218104812.GC15430@hirez.programming.kicks-ass.net>
 <20181218111701.GA32522@jagdpanzerIV>
 <20181218114709.GF7485@zn.tnic>
 <20181218130750.GA665@tigerII.localdomain>
 <20181218142623.GH7485@zn.tnic>
 <20181218145558.GD665@tigerII.localdomain>
 <20181218150313.GI7485@zn.tnic>
 <20181218151455.GE665@tigerII.localdomain>
 <20181218152413.GJ7485@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218152413.GJ7485@zn.tnic>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/18/18 16:24), Borislav Petkov wrote:
> On Wed, Dec 19, 2018 at 12:14:55AM +0900, Sergey Senozhatsky wrote:
> > Right, but unlike log_buf_len, devkmsg is a bit close to a "binary" knob:
> > either all messages or none;
> 
> ... which is perfectly fine for a debugging session.

But devkmsg ratelimits systemd errors, so one does not even know that
"some debugging is required". For instance from my x86 box:

 Unmounting /home...
 [..]
 home.mount: Mount process exited, code=exited status=32
 Failed unmounting /home.

I don't want to debug systemd, I want to know that something didn't
work out. 10 messages max and 5 seconds interval looks a bit too strict.

	-ss
