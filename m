Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF4EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BE520870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8occyx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BE520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeLLFVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:21:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42444 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLLFVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:21:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so8037265plp.9;
        Tue, 11 Dec 2018 21:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UqwenLJYzHR12uK17VPjmYMN4YNmNum/2v6HQWNppBI=;
        b=F8occyx0CO39MOeBWvy1Qo0s964WdOwSp1Bh8AH77tJV7Jfv0J5hrooJ0H73eEsVLG
         T/IWJV/bBHyn9p4zVOsPBwvOi9pWKfFzIG12liCpc6U8w1P6+XkIGpvOtZvFXCbplY6V
         LrR9r1VXY17txS+CSO8UD5ojBgPG1RMu7u5RdLo3QxroHXjdlzH3CCN945vnTO28RBqG
         lU0pktmChOn5+gXv82oDK5SAQRnjyOfOTQUAi4slWncC02Te1TpNanpGKQUpx3bLcA1t
         HAME194G/rF0TfEgvC7ba/ceuZUngxkhU8lyBATlY2C4R75lG/iJyc/oSjEtscPcZMjI
         GJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UqwenLJYzHR12uK17VPjmYMN4YNmNum/2v6HQWNppBI=;
        b=l221ZqEDXgw79MaetKQyLKYqoXsa+vxGC76FI7z3DOwC2aRmSc2UUHqXmHLM1H4ZTd
         +b6U938RwzCyoH1V40uVrrhLUVYnxcq89/TVOXSgVD5pyY2xf9my7/CjKh0DoDsLVlsP
         kQIqOyPrUJQB7LK4DmVGiVnQSGMqOHRi/VzvI7ZyWCUiNukgMQjwwdmcEM7v/bFlDhCA
         4gd+1Z2Y9+KRaJ259TFMtYpEjCpqm+p4xGtxCdIIPnSxcI7DQ/XDyqsqn5neAypRT6v6
         QxLA/g8/YDR/V0GiQDzVwYdsIXsdulQdnucs+k3CET7UWHTTKzteDCvJWpz4/eqrLEW/
         hGsQ==
X-Gm-Message-State: AA+aEWavGubhUAR+x1CRU9FOsbp0HXnH6NGTQ8P0lLOkub4Adw5HSVAY
        nRRBhNauO8kvmQ8MXAAZfyg=
X-Google-Smtp-Source: AFSGD/U9PTBbHSGDQxPrqtqDzAOpba2JFIIPAfuFGTgy2Vf+lwSVZ9jrr9mn+L5Hssqdj66TBa4SIw==
X-Received: by 2002:a17:902:1127:: with SMTP id d36mr5551908pla.299.1544592090302;
        Tue, 11 Dec 2018 21:21:30 -0800 (PST)
Received: from localhost ([211.246.69.141])
        by smtp.gmail.com with ESMTPSA id h19sm19781344pfn.114.2018.12.11.21.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 21:21:29 -0800 (PST)
Date:   Wed, 12 Dec 2018 14:21:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Wang <wonderfly@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp,
        Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181212052126.GF431@jagdpanzerIV>
References: <20181003133704.43a58cf5@gandalf.local.home>
 <CAJmjG291w2ZPRiAevSzxGNcuR6vTuqyk6z4SG3xRsbaQh5U3zQ@mail.gmail.com>
 <20181004074442.GA12879@jagdpanzerIV>
 <20181004083609.kcziz2ynwi2w7lcm@pathway.suse.cz>
 <20181004085515.GC12879@jagdpanzerIV>
 <CAJmjG2-e6f6p=pE5uDECMc=W=81SYyGCmoabrC1ePXwL5DFdSw@mail.gmail.com>
 <20181022100952.GA1147@jagdpanzerIV>
 <CAJmjG2-c4e_1999n0OV5B9ABG9rF6n=myThjgX+Ms1R-vc3z+A@mail.gmail.com>
 <20181109064740.GE599@jagdpanzerIV>
 <CAJmjG28Q8pEpr67LC+Un8m+Qii58FTd1esp6Zc47TnMsw50QEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmjG28Q8pEpr67LC+Un8m+Qii58FTd1esp6Zc47TnMsw50QEw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/11/18 17:16), Daniel Wang wrote:
> > Let's first figure out if it works.
> 
> I would still like to try applying your patches that went into
> printk.git, but for now I wonder if we can get Steven's patch into
> 4.14 first, for at least we know it mitigated the issue if not
> fundamentally addressed it, and we've agreed it's an innocuous change
> that doesn't risk breaking stable.

So... did my patch address the deadlock you are seeing or it didn't?

> I haven't done this before so I'll need your help. What's the next
> step to actually get Steven's patch *in* linux-4.14.y? According to
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> I am supposed to send an email with the patch ID and subject, which
> are both mentioned in this email. Should I send another one? What's
> the process like? Thanks!

I'm not doing any -stable releases, so can't really answer, sorry.
Probably would be better to re-address this question to 4.14 -stable
maintainers.


---
I guess we still don't have a really clear understanding of what exactly
is going in your system. We don't even know for sure which one of the locks
is deadlocking the system. And why exactly Steven's patch helps. If it
is uart_port->lock, then it's one thing; if it's console_sem ->lock then
it's another thing. But those two are just theories, not supported by any
logs/backtraces from your systems.

If it's uart_port->lock and there will be 2 patch sets to choose from
for -stable, then -stable guys can pick up the one that requires less
effort: 1 two-liner patch vs. 3 or 4 bigger patches.

	-ss
