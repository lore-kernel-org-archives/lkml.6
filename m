Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD9EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705E120652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGo7yrT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705E120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932547AbeFTJS1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:18:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46119 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754308AbeFTJSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:18:15 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so1419498pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F6oucZoVVPxdVPmLsjhwZSX7Dd88cfeKGMNnHEPaFDg=;
        b=LGo7yrT8b5XNhAk0FXtbLMeT6/oA83rXm1GgHgKqMyJpAXvYWDAAIcyNhpjk2bue5a
         WjLfUIufWIM7/qRafHq1aKvKVEJ4HeVRp6ee5bE1QtpVvmUVHuzq8Z0uysB4kfybxnKe
         ehTmUPKRihYf2VNBBXTGRd44UkZGofODzW5K/J0W3z22Ot2ikKwZSdo+ioY5po6SZvpj
         a+yMF3P0DqT6l+qYR6d3EmjaHPMSq4uL8OPHb17iBO0byMGi51HwEzApi5//J0xkaYaj
         X1sIUZqMm9KhJnF/sQ3Vv/jkp4Ns/2cmpQZIpUWCRi+O5Qh5G2j8jlq0zBaZE+a7NHhR
         J6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F6oucZoVVPxdVPmLsjhwZSX7Dd88cfeKGMNnHEPaFDg=;
        b=eXm3agrmqDG/n+hmY8SJaPjAt7DOvQdbJdKon+X69SbhLekQp1pQxlxTnN+2uQH+/e
         Uj5w30EeVUE0H5zqM7TVRPuP4VK5JVbDFTMQkk+jbtwKPCm75fnPo8i9r6f9YBi6dELZ
         H8F/kaGWosabDDgaYO1Pk2xMs8nC8KENIk2T7t9jlvB+gqU+oce3n9gNnC0Gbhgtqj4j
         9pxE2gGABNxp2BOo0vY9bhlcFh/33mV1qFZmtauptlba0zO8sp7oq6cTNJtA5XcP9C+x
         CZ2YzbK9/T7qmXcXov/35LKWxwTJP5ae74+5y0okxaI4OocnxRHG+JWCZaCSMqHDnwHJ
         RRvQ==
X-Gm-Message-State: APt69E341fUF5DEkU68ESCPxGekahG9TQKgORtc7i9b8K50Kw9/Mh1z7
        OA4K4KTDjVUy2fZUcfqNAC0=
X-Google-Smtp-Source: ADUXVKKhvN1u5D336j9VWKSM2wNHvRwMpRq/lXirowZQ9S6zr1mDxzd9IO6DfNxQDVIh/DsOingzXg==
X-Received: by 2002:a17:902:8f82:: with SMTP id z2-v6mr22776168plo.203.1529486294823;
        Wed, 20 Jun 2018 02:18:14 -0700 (PDT)
Received: from localhost ([110.70.59.159])
        by smtp.gmail.com with ESMTPSA id q82-v6sm3660849pfg.170.2018.06.20.02.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 02:18:13 -0700 (PDT)
Date:   Wed, 20 Jun 2018 18:18:10 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180620091541.GB444@jagdpanzerIV>
References: <20180511095004.GA6575@jagdpanzerIV>
 <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV>
 <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <20180524021451.GA23443@jagdpanzerIV>
 <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
 <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV>
 <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620090413.GA444@jagdpanzerIV>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/20/18 18:06), Sergey Senozhatsky wrote:
> 
> b) printk_safe output is quite uncommon. And we flush per-CPU buffer
>    from the same CPU which has caused printk_safe output [except for
>    panic() flush] therefore logging the info available to log_store()
>    seemed enough. IOW, once again, was a bit unsure if we want to add
>    some complex code to already complex code, with just one potential
>    user.

BTW, pr_cont() handling is not so simple when we are in printk_safe()
context. Unlike vprintk_emit() [normal printk], we don't use any
dedicated pr_cont() buffer in printk_safe. So, at a glance, I suspect
that injecting context info at every printk_safe_log_store() call for
`for (...) pr_cont()' loop is going to produce something like this:
	I<10> 23 I<10> 43 I<10> 47 ....

	// Hmm, maybe the line will endup having two prefixes. Once
	// from printk_safe_log_store, the other from normal printk
	// log_store().

While the same `for (...) pr_cont()' called from normal printk() context
will produce
	I<10> 32 43 47 ....

It could be that I'm wrong.
Tetsuo, have you tested pr_cont() from printk_safe() context?

	-ss
