Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D2C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804722147C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJWV5OFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804722147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeIMThz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:37:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35255 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbeIMThy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:37:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7-v6so2840449pgf.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xvfoXrHPe7ea3dZN/E6pi8vHopvaBJ0KysWUAGYUNtM=;
        b=uJWV5OFVDroMIkOtv8d/+EYITgcdmWHgFV77yAikqekGNW75IfiMtD6UwjB3eeqWqX
         ov7EOUbCx8OlBQZ06xmvSooRYv5POGZ0M1V2dIleagQ+nH/HNdjIZ7YtAirXsO7DZxIF
         znCi8ExkOryGkERPvu7KSLHz2uqMBgxnCoZ3TDfQ277M/4cC04MGzTS+xqMgHBZE8cgs
         GMbckZVUmAagYWbAXN1qY2zrIVeBe6gJ9RxGOvAaAYmoCjxFfz9B/K1fQ8xfpkjwjP0d
         lcDcTNKsci6f76sE77l2OL//emyBEd1REfA2aEbSTKNL1Llf47YaxkJQPLCAaj/9uCm1
         uYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xvfoXrHPe7ea3dZN/E6pi8vHopvaBJ0KysWUAGYUNtM=;
        b=lTcVCzmX4Y3u1zN1LFRFN1A/+M3uavRNQAfCJg4SDntAHgyngF4QS+OGMCUN/N6lDs
         SX4iiBTb7Dgxzy90rt7AGkwHgTYswPg8r8rlgVG6yYC6MYSCCn4ZV0W7M8Db+jcGCdT/
         kPrayTRk1VJOYl65iVjiAMd0sJlNjzlNLoRrZw+d9LYK36aHhwrtmAgsD4mmhFYDGngv
         2zXPk9ZPbiECWN9FTxz633EUbs72ChmoaKVpnE6bSekjBUcshuYW+fW0yWfDkv4vZwDH
         Y++ZMbZDPsyC2mWuhSRCyog6YO1/qHCvi5OiuRpEga9Urfw1zzexzExZkZRV4wxir5AA
         eceg==
X-Gm-Message-State: APzg51CVXv7UyjKTrjBdzsc6OIpIf3kIEYvEYfrxHTgaTtcRE5e4tF6J
        KNAXYvkUI0G9nZ+M1Jh3pjU=
X-Google-Smtp-Source: ANB0VdZ2klTZtKz5OuB4jWIsOCq7ztOdANJcCBU/M5DOnpBMgF6BYV1ZRxBjMINOcXIMvRIsKggb+w==
X-Received: by 2002:a63:1a1a:: with SMTP id a26-v6mr7422134pga.449.1536848888421;
        Thu, 13 Sep 2018 07:28:08 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id v82-v6sm5743853pfd.64.2018.09.13.07.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 07:28:06 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 13 Sep 2018 23:28:02 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180913142802.GB517@tigerII.localdomain>
References: <20180620091541.GB444@jagdpanzerIV>
 <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
 <20180620110759.GD444@jagdpanzerIV>
 <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
 <20180620130628.GA1000@tigerII.localdomain>
 <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
 <20180912065307.GA606@jagdpanzerIV>
 <20180912120548.4280f04a@vmware.local.home>
 <20180913071204.GA604@jagdpanzerIV>
 <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/13/18 14:26), Petr Mladek wrote:
> > +
> > +int vpr_line(struct pr_line *pl, const char *fmt, va_list args)
> > +{
> > +	struct seq_buf *s = &pl->sb;
> > +	int ret, len;
> > +
> > +	if (fmt[0] == '\n') {
> > +		pr_line_flush(pl);
> > +		return 0;
> > +	}
> 
> You would need to check if fmt[1] == '\0'. But then you would need
> to be careful about a possible buffer overflow. I would personally
> avoid this optimization.

Good call. It was a fast path for pr_cont("\n").
But it made me wondering and I did some grepping

arch/m68k/kernel/traps.c:                               pr_cont("\n       ");
arch/m68k/kernel/traps.c:                       pr_cont("\n       ");
kernel/trace/ftrace.c:          pr_cont("\n expected tramp: %lx\n", ip);

Lovely.
It will take us some time.

> > +	ret = seq_buf_vprintf(s, fmt, args);
> > +
> > +	len = seq_buf_used(s);
> > +	if (len && s->buffer[len - 1] == '\n')
> > +		pr_line_flush(pl);
> 
> This would cause that pr_line_flush() won't be strictly needed.
> Also it would encourage people to use this feature a more
> complicated way (for more lines). Do we really want this?

Not that I see any problems with pr_line_flush(). But can drop it, sure.
pr_line() is a replacement for pr_cont() and as such it's not for multi-line
buffering.

	-ss
