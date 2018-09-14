Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8EBFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E07E20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8Iuyid4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E07E20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeINHH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 03:07:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33216 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeINHH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 03:07:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id b30-v6so3442042pla.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 18:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O4OKcV2sMFnGzGzL/9+Cpt1JG7IyKFHG/ze9KlVPzA0=;
        b=d8Iuyid4O4UR0LnbyvNqzDW6kCvfrxb1hG0Q/YhEXX+4tkVd2hJP+894oZoMd1BLhH
         9dI0ZdoI5Wbb0bep1m813xEuBOOrZA/YzCb+CUe7vkaxMyQW/Spsxq0ws1iE9iDFnWvs
         28D62d2DMFbxniR0LFlTxq2idIWY2t4FIK3UWvDDalHwla3lHx2SG8N0TfJG6YwB/7nJ
         4f9DP/OrH5cLnjMiVHEmQ3T7FdbN8Gd68n+2sR34T3KTQ0rhonC4xnKdSGTnmf/U8oaU
         +/Wl4RlbPiLfY0bvcoCbjdK45QlGpNz6ymJKrQ7oNEFzhx0N/KVELxLq4GfsI1LVV1jV
         zmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O4OKcV2sMFnGzGzL/9+Cpt1JG7IyKFHG/ze9KlVPzA0=;
        b=A6JDAgVxzAxgtx4y492T8HfgPgEGKR1CL0bz1IYz49KOlim3AxGzM6A0G0qNJby5/c
         SitUYkLGzwP4waiWW51A3ezrWsER/IPSQfkvueAI3kr3ZP/+tQqBBBz7uO9o5M6lGpky
         qyVt7a+Pd7XMYC4/DAw7wGu6uttThCAYhZUhmyPCRpB58ZG1Lv7Jo0GheYQX5+qz4X72
         B9cdKbomcdc14YGsBmBbORCMkpU4YROc728dErn0xg5+a/79kl335bjKa0Xa4ZlvkbCi
         +iwhWCjKXU/ypzNCQwIKgto+ls6HgolXcToUX6D93fg6GpOHyHgbcHf3AdVP6Hl7aLEQ
         CIZg==
X-Gm-Message-State: APzg51AJ03v0OCMaI6Fx2rH42LOr/UwoSXsJ017nYUebo1XfT4OMyWBs
        YnAEGVaeURj85BwqcI/99PA=
X-Google-Smtp-Source: ANB0VdZ8Ji2mXxU3U2RUHKmTSspC4evHo0JnXRUH2+XQgNfCJ/uRG0JekAGmZ9zuTGL+4bJbcDu1Kw==
X-Received: by 2002:a17:902:246a:: with SMTP id m39-v6mr9516550plg.57.1536890121399;
        Thu, 13 Sep 2018 18:55:21 -0700 (PDT)
Received: from localhost ([39.7.18.191])
        by smtp.gmail.com with ESMTPSA id b21-v6sm13608691pfm.97.2018.09.13.18.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 18:55:20 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:55:16 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        kbuild test robot <fengguang.wu@intel.com>, pmladek@suse.com,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180914015516.GA1108@jagdpanzerIV>
References: <20180620091541.GB444@jagdpanzerIV>
 <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
 <20180620110759.GD444@jagdpanzerIV>
 <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
 <20180620130628.GA1000@tigerII.localdomain>
 <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
 <20180912065307.GA606@jagdpanzerIV>
 <20180912120548.4280f04a@vmware.local.home>
 <20180913071204.GA604@jagdpanzerIV>
 <20180913211232.06e6ad64@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913211232.06e6ad64@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/13/18 21:12), Steven Rostedt wrote:
> >  
> > +#define __SEQ_BUF_INITIALIZER(buf, length) {				\
> > +	.buffer			= (buf),				\
> > +	.size			= (length),				\
> > +	.len			= 0,					\
> > +	.readpos		= 0, }
> 
> Nit, but the end bracket '}' should be on it's own line. Even when
> part of a macro.

No prob, will change.

I thought about putting it on its own line, but then checked
include/linux/wait.h - __WAITQUEUE_INITIALIZER and
__WAIT_QUEUE_HEAD_INITIALIZER.

> > +#define DEFINE_PR_LINE(lev, name)					\
> > +	char		__line[__PR_LINE_BUF_SZ];			\
> 
> To protect against name space collision could you use:
> 
> 	char		__line_##name[__PR_LINE_BUF_SZ];

Yes.

> The rest looks fine to me.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks.

Just, to make sure, we are OK with seq_buf dependency and want
anyone who wants to use pr_line to include linux/seq_buf.h?

	-ss
