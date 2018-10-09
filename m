Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452E2C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070B5214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GewtDOpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070B5214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeJITsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:48:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37688 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeJITsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:48:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so780416pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 05:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5+e9Fp3nfFGT2lmEK+9tb39wNz/CEQeUaVCTdb8nQYg=;
        b=GewtDOpch1kvTipefV+pj12I8Sx+DYtNT6XGC8pVez3rMboWCE3vLBgg/nCUXDXPF3
         x2bY/h32kIWzQsoot3i5SBJSgNBnZUVzBvH/q7NvE8Ve3DnRwyilb5L1GiIuslqhrjgv
         5U5gIYbDXN4MVYvRoPyaUVGCkBNED3C/Z9iJDAVbrn6SJRceIaSYRuawOQDd4NjJZKeH
         cJbYY2ovxQxmu5605EyxjzB4ZsXAXYrXT04Qxc6rSoHCxoz6t6/AeHrcSPev1TMelRml
         qiQKpIgXga7Fy+7KTgvvsVxygZJkXG6WaXhxe7QA7l8UlZnEaL8y8yos1hMzz8cKZ4AJ
         xY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5+e9Fp3nfFGT2lmEK+9tb39wNz/CEQeUaVCTdb8nQYg=;
        b=BI9ZBIvusYZ4p2HGvXTzab8cET6E8dnfjWhQr4FTLVcNf9HDhhEJyKEjYGbPDj0ALo
         JcQ12Z8VuHsBf2ePH3oSwYWLSQ4tYl9hYCnA+YNESoHNNGXGSAoB+wHAkCFYtJriniHo
         lL1U9k5+IvH1sZi8+MhDs3vBMRNyYZNG8XUdeDTszra26h4d/FvLwx+luM5Ijm4U0mHh
         MYSySVW5N8quQ6IuMWjneMNVUO3ForX4d6vHY215nY5Elpk2d3r6q1X5qC7ECY5uDFPN
         dwdQGwkedINVY4lzGxbgUObn2WikdO2rguu9e2nEYTeX+dF267hn1bgY6glk9BQrReQq
         Er6g==
X-Gm-Message-State: ABuFfogpufYWnw/6QqBzR8is58HnpijjBEYvEBCv29zYHzGqq7QvrEXk
        tANDncPs3HHJrIR2qCo0ano=
X-Google-Smtp-Source: ACcGV63Ea1Sy3gqAl2zE5+RpgL8Sf8pV0dHlVVNpASgN2aBQ3IA7oCO7LYwyJKOq2scBoH1quVafJA==
X-Received: by 2002:a63:7744:: with SMTP id s65-v6mr25478751pgc.197.1539088327695;
        Tue, 09 Oct 2018 05:32:07 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id x20-v6sm36169021pfe.131.2018.10.09.05.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 05:32:06 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 9 Oct 2018 21:31:51 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 3/3] printk: do not preliminary split up cont buffer
Message-ID: <20181009123151.GA471@tigerII.localdomain>
References: <20181002023836.4487-1-sergey.senozhatsky@gmail.com>
 <20181002023836.4487-4-sergey.senozhatsky@gmail.com>
 <20181009084241.tlmsjxnyxf4zx2fh@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009084241.tlmsjxnyxf4zx2fh@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/09/18 10:42), Petr Mladek wrote:
> On Tue 2018-10-02 11:38:36, Sergey Senozhatsky wrote:
> > We have a proper 'overflow' check which tells us that we need to
> > split up existing cont buffer in separate records:
> > 
> > 	if (cont.len + len > sizeof(cont.buf))
> > 		cont_flush();
> > 
> > At the same time we also have one extra flush: "if cont buffer is
> > 80% full then split it up" in cont_add():
> > 
> > 	if (cont.len > (sizeof(cont.buf) * 80) / 100)
> > 		cont_flush();
> > 
> > This looks to be redundant, since the existing "overflow" check
> > should work just fine, so remove this 80% check and wait for either
> > a normal cont termination \n, for preliminary flush due to
> > possible buffer overflow or for preliminary flush due to cont race.
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> I wonder if this check ever triggered ;-) It is a nice clean up:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks.

	-ss
