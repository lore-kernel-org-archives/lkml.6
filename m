Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A441FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B35206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHuRBKi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B35206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502319AbeKWSRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:17:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33888 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731610AbeKWSRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:17:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so11337634wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 23:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KbcqwGM/ZSvYoxZhZIb7dX3xJvFax4Tdyl2gfA6+llQ=;
        b=HHuRBKi7JpC/m5tSeN+lyWoQF1LN89ad7MizzryJpUS6Zk41FdEPWIeQ2GmTigr4fn
         I1wcCICsdxiWFgT0Xd/ywd+dcz7tWwjdJJZir+KF1qUIE7fZK0PioCHBIGSopBDE5ImS
         XHrHBWGc7hO63N6ErLjILVAsci3LP65ElWZlcyubgOhDzN8l82imBIA9RhXycTDRHMHJ
         LwjpvNAy/ut75s0X5wKE+xtzFj4rzk6fk7fbjnxA5w1EZ4c8ZhZue3yt02pWwkaxpPme
         skOy4+WQKLth8GiDBIFBLrhjBEbK0HgRcYU2RAe3qcd3+4brxf1X1NJbC/X/qQSoazn7
         dPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KbcqwGM/ZSvYoxZhZIb7dX3xJvFax4Tdyl2gfA6+llQ=;
        b=jGNwhngJUeZfKGZWtwzp13mNfcGNN+YkZ6D0zg6GdBVSKsL5GmP6Qiv6e1xlEZYR2T
         Mvys8pukexFKhKoZpchwRH6OuZP+e0fecd+S7Kdw9ItCou4o9++yqjLcavTemKD8pBw5
         P6n2UCl+K/GoJOunU5CD8TvP7v7VAAaXAt8BDLfS0ZkOTzYDce1keq86DhcHWLYSkl10
         UZNNZ6maXAYikwCRaHGLIkVpjfXkICUbX+gvu7rYrEeIroQLP2PKkm+SGKMFLAf9w+dY
         chSYttbqdD/d2mP2z9eueVIISFpVcSgofL4YcHnhtiF4+Dhz6/4bLwUsmHDuYY55mdkU
         4BoQ==
X-Gm-Message-State: AA+aEWaqOV8lB4RsUcMP2oi45kZm07KhGuIAp070crLv/5QljjJ4G8Qm
        WKsaHBNJn9LdqIF+ev2tH7s=
X-Google-Smtp-Source: AFSGD/ViY+qpjtRnVpfHCX8qC37PvSuK2ERsjXefQ8mpOxOy+X8jwoG/gc9lwjz5wJ+nIa3O7jNS/A==
X-Received: by 2002:a5d:4ec4:: with SMTP id s4mr13270786wrv.187.1542958445200;
        Thu, 22 Nov 2018 23:34:05 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a17sm9518954wrs.58.2018.11.22.23.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 23:34:04 -0800 (PST)
Date:   Fri, 23 Nov 2018 08:34:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, stable@kernel.org
Subject: Re: [PATCH] uprobes: Fix handle_swbp() vs. unregister() + register()
 race once more
Message-ID: <20181123073402.GA97250@gmail.com>
References: <20181122161031.15179-1-andrea.parri@amarulasolutions.com>
 <20181122161942.GG28270@redhat.com>
 <20181122162708.GH28270@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122162708.GH28270@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@redhat.com> wrote:

> On 11/22, Oleg Nesterov wrote:
> > On 11/22, Andrea Parri wrote:
> > >
> > > Commit 142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() +
> > > register() race") added the UPROBE_COPY_INSN flag, and corresponding
> > > smp_wmb() and smp_rmb() memory barriers, to ensure that handle_swbp()
> > > uses fully-initialized uprobes only.
> > > 
> > > However, the smp_rmb() is mis-placed: this barrier should be placed
> > > after handle_swbp() has tested for the flag, thus guaranteeing that
> > > (program-order) subsequent loads from the uprobe can see the initial
> > > stores performed by prepare_uprobe().
> > > 
> > > Move the smp_rmb() accordingly.  Also amend the comments associated
> > > to the two memory barriers to indicate their actual locations.
> > > 
> > > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > Cc: stable@kernel.org
> > > Fixes: 142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() + register() race")
> > 
> > Thanks,
> > 
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> 
> Yes, but I am not sure this is the -stable material...

So I left the Cc: stable tag intact, because this is a really low-risk 
fix (it just moves barriers around), and clearly fixes a bug that people 
might or might not have observed.

Even if they observed it the race is probably very hard to reproduce and 
almost impossible to report - so we are better off propagating this fix 
to -stable, as there's no realistic actionable way for users to actually 
complain about the bug if it affects them.

That's the general backporting policy for race fixes, unless they are 
really, really intrusive - which this one isn't really.

Thanks,

	Ingo
