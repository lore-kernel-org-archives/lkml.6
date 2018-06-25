Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC46AC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AED3253A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siNt4abR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AED3253A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeFYBl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 21:41:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40145 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbeFYBl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 21:41:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so5676220pfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 18:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r/5HPanB+EgSbzHZAngaYkLt/i80VDFqqgNr+DMi/SU=;
        b=siNt4abRzlFGTy8cBZ16ltoIo2JYdOkSv3r8XzavlUEl59C5gxZTC00OYx63kF5Lpt
         OR93KxHwkd+c91zDd3qhz7yqWSYvtooOWdnBEGYGSUJ3XfJri7pm90e/dIJMWscLBsBN
         yiy/+8h+cuiwQv71T4t2716Vu8TdDyI0QTKP9RADjK7TJdhzORXHmCxSDq2Tt3SHs674
         zokMw7W1R2HXOf92qbIa4sJRx0ZU3jy71TXhoapJ85SyQgtS4IqfkArLsaZjRfuBuX1P
         9efWtuoCi1rGwQ/Abqlz5VxE3SOfXFc1sjLt8VFYpxgviHkF1TfrFdGjH+NysyAf+bVw
         AoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/5HPanB+EgSbzHZAngaYkLt/i80VDFqqgNr+DMi/SU=;
        b=hvpV1RvcOg+DrkW5++mh8hOmpXsSXc/1HYsuoAsempkI6JpbqcvH3hXgShsezmkdg1
         rlv43+1zakXOUTu32IJD7iHPzeP/0UOcLZT6silf4xe030/o/pm6TXmFJNfT0prMr/pl
         U11WFNN+v5RQAJd9RMJRnenN/VHkrjRlehdhxPSFjJAtXzXPo/CVVs20mT4yZSz3r4IK
         moxQ2ds3p521ipR65DrEurYJ1RXyGrMR4T8Bu0N9hPIFRMog9dbaTz6zYC4ra6zmck/a
         qv/vhMIBrtOAXDwsxVeO9rdL5Yi5/N9VOE3V9IYYtI7Prs10xI3iDz3PmFxxq/hBrdID
         hEyw==
X-Gm-Message-State: APt69E3YEOD4a6VGPRaoOXUBR89Ug/IBSCD4FG17fS9wX47syoXV2QJX
        CCK6JnglYhdWWx45BCgS7rg=
X-Google-Smtp-Source: ADUXVKIZ8d7fYqLkfK+DulCtcANTOf6428h6mubHd+ZmR+hxnsamAAGLUAfe9vmFJBvdauYYQ4SIKA==
X-Received: by 2002:a63:7a07:: with SMTP id v7-v6mr8857540pgc.444.1529890887154;
        Sun, 24 Jun 2018 18:41:27 -0700 (PDT)
Received: from localhost ([39.7.19.250])
        by smtp.gmail.com with ESMTPSA id s87-v6sm8813825pfa.106.2018.06.24.18.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 18:41:25 -0700 (PDT)
Date:   Mon, 25 Jun 2018 10:41:22 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180625014122.GB557@jagdpanzerIV>
References: <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV>
 <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV>
 <20180620091541.GB444@jagdpanzerIV>
 <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
 <20180620110759.GD444@jagdpanzerIV>
 <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
 <20180620130628.GA1000@tigerII.localdomain>
 <197be25e-c841-bf3c-7081-61f0a9653c8c@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197be25e-c841-bf3c-7081-61f0a9653c8c@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/22/18 22:06), Tetsuo Handa wrote:
> >
> > Awesome. If you and Fengguang can combine forces and lead the
> > whole thing towards "we couldn't care of pr_cont() less", it
> > would be really huuuuuge. Go for it!
> 
> Can't we have seq_printf()-like one which flushes automatically upon seeing '\n'
> or buffer full? Printing memory information is using a lot of pr_cont(), even in
> function names (e.g. http://lkml.kernel.org/r/20180622083949.GR10465@dhcp22.suse.cz ).
> Since OOM killer code is serialized by oom_lock, we can use static buffer for
> OOM killer messages.

I'm not the right guy to answer this question. Sorry. We need to Cc MM
people on this.

Does OOM's pr_cont() usage cause too much disturbance to syzkaller? I thought
that OOM was slightly out of sight.

	-ss
