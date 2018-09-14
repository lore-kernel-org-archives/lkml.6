Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD27ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D8B20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ov119v2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D8B20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeINRgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:36:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45554 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeINRgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:36:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so4224877pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8BtCLlaPXVPAksidMXtNOr3AjkgxWdSxBK9sAuoGCQo=;
        b=ov119v2C0qIkUU2oVEaMY9x+FDwUKXDUNShij/wBPWxjb5eLiUfawQ2rQCJq9WyQ/Z
         d5HpekhUwP1WvVJIN7UAe6IN72/zTriinbhVob1zxdLfpiBZT02m0d1LcS0hweURYUsZ
         OwpW77rJ6tq9isrqvzODsxp7uSvqV6Eqzn6jqZ4eGczd9s1SBEQwxTBReYyHsxamhXoL
         dCqqv/CKD3tLp25Pi2EPgrrNJCpOH+wJ3PYYgeFXi8N1tcgMZmrlNthkBs5aECgfQm50
         htFNA5EgZAF2O416Fhud4/OH1vZ4DNrGNFyByxu2T2Jw2T417hD2vtGXrhB8gmXmeJmu
         osjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8BtCLlaPXVPAksidMXtNOr3AjkgxWdSxBK9sAuoGCQo=;
        b=nvkEaUGBzPnz6D0n8h78bgvdI2fxLKS3c7mxP5+srdKV2m8TrAteDDU/yCsKRwDJ8k
         G1+XtZ8ZiaoV0SuHAo66tnXWQyyE4TrKu2bkz6E734297sI0+nnK90Gf2NNMkZRuiX7a
         oJ4DrykYZHweFD0M6uwd8Y1uVO6TDIz3Sg2pwlITTUq12njWB4Xvb6FSmIALEOXtaz4e
         EA7dlbNmgE3QUzKsxdT0k0XipJflZ+dgZuQmB7QlMllfuW+wmlmxMKvwlbWkwv8DVGDH
         a4aTRsrdXYe2SZrnDUMUYgtOjyAAhBQWfQQpmgVm2/22mt2OKH5J8djRtkFM1JjA3tTF
         bLCw==
X-Gm-Message-State: APzg51A06xkfPHy5xZhpTpwrjph4BHLuXDH7FPdgf4+YV4wEJ+N3fbFg
        R3dfOmKrmEgtkc6D62ZF2j0=
X-Google-Smtp-Source: ANB0VdY4ObPdqP6szKju2zQjW5/NdGo0GrydTsn5jIt6ifjDjDU2CSdqc/aVN7cf1FbWoXH0pP99xw==
X-Received: by 2002:a63:6c89:: with SMTP id h131-v6mr11541023pgc.237.1536927741662;
        Fri, 14 Sep 2018 05:22:21 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id w81-v6sm13910770pfk.92.2018.09.14.05.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 05:22:20 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 14 Sep 2018 21:22:17 +0900
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180914122217.GA518@tigerII.localdomain>
References: <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
 <20180912065307.GA606@jagdpanzerIV>
 <20180912120548.4280f04a@vmware.local.home>
 <20180913071204.GA604@jagdpanzerIV>
 <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
 <20180913142802.GB517@tigerII.localdomain>
 <20180914065728.GA515@jagdpanzerIV>
 <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/14/18 21:03), Tetsuo Handa wrote:
> > 80 bytes is quite short for OOM, agreed.
> > 
> >>   static char oom_print_buf[1024];
> >>   DEFINE_PR_LINE_BUF(level, oom_print_buf);
> > 
> > Do I get it right that you suggest to drop the "size" param?
> 
> No. I just forgot to add params. ;-)
> 
> > Do OOM people agree on 1024 bytes stack usage?
> 
> I won't allocate oom_print_buf on the stack. Since its usage is serialized
> by oom_lock mutex, we don't need to allocate from stack. Since memory
> allocation request might happen when stack is already tight, we should not
> try to allocate much from stack.

... by "OOM people" I meant "MM people".
"MM people" is a subset of "OOM people".

OK, so I didn't notice the "static" part of the `oom_print_buf'.
I need some rest, I guess.

The "SMP-safe" comment becomes a bit tricky when pr_line is used with a
static buffer. Either we need to require synchronization - umm... and
document it - or to provide some means of synchronization in pr_line().
Let's think what pr_line API should do about it.

Any thoughts?

	-ss
