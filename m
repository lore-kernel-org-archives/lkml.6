Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4C9C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B6B20862
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDcnqyZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B6B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeKHMDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:03:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39674 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbeKHMDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:03:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so8784901pla.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 18:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vDVA0cuhs/xcgfSpxJ1wQyRO6SeAUDyu/8TCIou8J+s=;
        b=iDcnqyZwuTOXrtUK/ArW7lC91akwZdt/LoVgrA32zPcOu7dl0WQpiONcisPW0e7uwD
         tOyfgepsvdjH+VXFnmlG4V82Y/CY+fORahJ8XWCCncM4f83z2MKMRg9U0tubnFOP4Bbs
         uqKpwOHzez+W3ZlXW3LK3YNoielHhDdUTULyPxNx9cH6k3Fq5VI4nHYEGeY/kwlJ7iN8
         ID45O6f527UqwCPeWnXz+CD6qWTs9vRwx2nJvStljXlK/OrHSZXPOHwtkxToSorBKdBM
         q+ob0IxQKaj8++LFA5kO1CUuKmdDOr5Mt5/flP6DabFwORA7ZYeGnAA+3ybc5SDVuapt
         i24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vDVA0cuhs/xcgfSpxJ1wQyRO6SeAUDyu/8TCIou8J+s=;
        b=gg7Ol4zTda5B2EDX9R9OSkHx+1f5psGpWLrDzqtORwB/T3HsG/rmFQYNKt5daUT4I8
         KtK5ozgEbIxLF/ORcLk0h7qCD261w5gNsY0iwrem21WX3yHV1IGtRJg4dwl+8yMLBfqB
         snkOPjRBuN92sSWK+r2vXpH0tXz/e6QTnmr6c8jtnFQlIOPjukAfSWszvsit7FYB+w8J
         k/IlvlQSGAu4aN4C32gebq2BS8835+bh0pybZcZVRywS7YZcD7Qf7nwhKXrultZt2DAP
         5iiGQvUjwB6w9EwpPuD6+vGB3CGbYvw2YPxEJE5aqE5zO2mG8X1iFmwY8Y/M5aOgHVCf
         8oCw==
X-Gm-Message-State: AGRZ1gJgm2jrKnBB30BGoGK5KT/csw+g6btddyZrmnGslngnsOExrhE0
        5Kt1Pwp/LsqfrhSSnsMl4gM=
X-Google-Smtp-Source: AJdET5dRFIF5v2MVUgJzB25avpJAG2knnsmmfkWqZUYrbBuWg8JjJHOqNg10PHADedDBksTfoiXNhw==
X-Received: by 2002:a17:902:f24:: with SMTP id 33-v6mr2862567ply.228.1541644211694;
        Wed, 07 Nov 2018 18:30:11 -0800 (PST)
Received: from localhost ([39.7.58.178])
        by smtp.gmail.com with ESMTPSA id 18sm1672512pgl.50.2018.11.07.18.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 18:30:10 -0800 (PST)
Date:   Thu, 8 Nov 2018 11:30:07 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
Message-ID: <20181108023007.GB2343@jagdpanzerIV>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181106143502.GA32748@tigerII.localdomain>
 <42f33aae-a1d1-197f-a1d5-8c5ec88e88d1@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f33aae-a1d1-197f-a1d5-8c5ec88e88d1@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/07/18 19:52), Tetsuo Handa wrote:
> > A question.
> > 
> > How bad would it actually be to:
> > 
> > - Allocate seq_buf 512-bytes buffer (GFP_ATOMIC) just-in-time, when we
> >   need it.
> >     // How often systems cannot allocate a 512-byte buffer? //
> 
> It is a very bad thing to do GFP_ATOMIC without __GFP_NOWARN.

Absolutely, __GFP_NOWARN.

> "it does not sleep". Not suitable for printk() which might be called from
> critically dangerous situations.

So I'm really not convinced that we can use buffered printk in critically
dangerous situations. Premature 'cont' flushes and 'cont' flushes on panic
are nice and right in critically dangerous situations.

[..]
> > - Do not allocate seq_buf if we are in printk-safe or in printk-nmi mode.
> >   To avoid "buffering for the sake of buffering". IOW, when in printk-safe
> >   use printk-safe.
> 
> Why? Since printk_safe_flush_buffer() forcibly flushes the partial line

We need to leave printk_safe and enable local IRQs for that partial
flush to occur. I'm not sure that those "partial flushes" from printk_safe
actually happen.

	-ss
