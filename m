Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01690C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBB320652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrXT04VS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBB320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbeFTJJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:09:27 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42497 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754765AbeFTJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:06:44 -0400
Received: by mail-pg0-f67.google.com with SMTP id c10-v6so1186580pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+zMJeLvg9M+qXEaAcahk8RwoZhePMjXySZrsTdVLp14=;
        b=jrXT04VS1wvJ4LtYWivbS8UabHga/4bEDYqXzuh8HIzRvJ+rZ3tB8GVoLmZEHgMZfd
         4cj4ZNt8MZm+2F0OVVHYFnGbZWOkNV5kbLm/129lu3fhE2Y8+SD+Clnzaqw0MpwkbwSY
         yyWyGzEk1LjywecwdoTCHgI/5sRq519ewD3wYlP1X8dmMKHNw140DLUbFoswxr+V7OGT
         rgxgHn+cVKSexxyw1TDXwInSlodYbkdFk0CbB10zo0+fUQKVvpv87h/T/xS/oSMKI39w
         +jtqSeB6cH5y3ywrAD+PbhePhU14bbY38GDBJ03/DaLh74eavq8sFgDTEwKKgIOv/tYE
         f4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+zMJeLvg9M+qXEaAcahk8RwoZhePMjXySZrsTdVLp14=;
        b=IUzX1+30joYcta59P76wcBbgGgjlOl1Co7DtIBczIjbAcV2Xpcl8OJsvAg/nPthp0U
         qG7W9DZAg/2r+OVrfs528Uzh2ARj3yRkmoFPwT8A7yV5FCInN6dTtTrHUMiCZ6JIWql+
         kgp9l9aVdEYUaesHez2no4xuovjiBLYQCIrZ9tAi/XdX8CXyUahXXMap9+YOnYDIMeDX
         5E/E725E6WgIEtlR7U6LpN/icpCEobldAL2twwD5Z3Z/6cGqehcElufpGWcTa8g+pV7q
         ULuMGCaEuJ9gGF08XDnpVcB6ougDmwAXTS/08bchpOcsVFqn+ZZ0yq3wdNbn53083zJw
         xpFg==
X-Gm-Message-State: APt69E0+OV6MZpzgHU7KEW+/BhcUiBRzXZWWlH9lEtWEHQsHpQjQueMO
        Jknr80XpBw8As6cgSDS6IUk=
X-Google-Smtp-Source: ADUXVKKhKhWjP989zR1zohWTyAWD/ZqgwFH88MsVrAeQq+2AS7SFTXy8iYtjNVrO4X1YPCU6ngJA0A==
X-Received: by 2002:a62:a8e:: with SMTP id 14-v6mr21732913pfk.57.1529485603580;
        Wed, 20 Jun 2018 02:06:43 -0700 (PDT)
Received: from localhost ([110.70.59.159])
        by smtp.gmail.com with ESMTPSA id t5-v6sm2682208pfh.32.2018.06.20.02.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 02:06:42 -0700 (PDT)
Date:   Wed, 20 Jun 2018 18:06:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
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
Message-ID: <20180620090413.GA444@jagdpanzerIV>
References: <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
 <20180511095004.GA6575@jagdpanzerIV>
 <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV>
 <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <20180524021451.GA23443@jagdpanzerIV>
 <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
 <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV>
 <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On (06/20/18 10:45), Dmitry Vyukov wrote:
> Hi Sergey,
> 
> What are the visible differences between this patch and Tetsuo's
> patch?

I guess none, and looking at your requirements below I tend to agree
that Tetsuo's approach is probably what you need at the end of the day.

> The only thing that will matter for syzkaller parsing in the
> end is the resulting text format as it appears on console. But you say
> "I'm not pushing for this particular message format", so what exactly
> do you want me to provide feedback on?
> I guess we need to handle pr_cont properly whatever approach we take.

Mostly, was wondering about if:
a) you need pr_cont() handling
b) you need printk_safe() handling

The reasons I left those things behind:

a) pr_cont() is officially hated. It was never supposed to be used
   on SMP systems. So I wasn't sure if we need all that effort and
   add tricky code to handle pr_cont(). Given that syzkaller is
   probably the only user of that functionality.

b) printk_safe output is quite uncommon. And we flush per-CPU buffer
   from the same CPU which has caused printk_safe output [except for
   panic() flush] therefore logging the info available to log_store()
   seemed enough. IOW, once again, was a bit unsure if we want to add
   some complex code to already complex code, with just one potential
   user.

To summarize, I was just wondering where is the waterline: can a small
patch make you happy, or do you need a big one.

> Re format, for us it would be much more convenient if the context is a
> single token that can be used as is, say "T<pid>" for task context,
> "I<cpu>" for interrupts, "N<cpu>" for nmi's

Got it.

	-ss
