Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739A5C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBC0205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pykxUcjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBC0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754168AbeFTB6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:58:42 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33553 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752836AbeFTB6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:58:39 -0400
Received: by mail-pg0-f67.google.com with SMTP id e11-v6so717687pgq.0;
        Tue, 19 Jun 2018 18:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ydd0dgh985AQJdrjnGD2UXBBJc2Ji6+DAGILhnLi4NE=;
        b=pykxUcjyHyVEP1rhbRmPuIoASOWvL/Dwv6M210pQeusfawo367+E0f6TgRtxNZFfQq
         KYDJaqeR8Lj8sZOjn6GL5LVZgXu15d6jL3iPlhFzT2LKYyiCNDPzlsfYktg4939B+vvs
         ZjfTk58CkAYKdFHwb1DJ8K0aLeVBovZgs8nsuSLxdMb8+2YxfhooT86pbAtOY6bRMA+M
         ZgUQ7Dn+aKZo0CjJLZYPqkpwObXgD9BFCv8bpgLJJqYIKNdi5Gc0cJcegt1UD4gYPtgQ
         /q3yEdsot5Q47/K/nkttI75NNGX6+6gOdBwZvEZmVv9/Iynq9u0aBhKYqui3zD2HScjn
         F9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ydd0dgh985AQJdrjnGD2UXBBJc2Ji6+DAGILhnLi4NE=;
        b=iPoD97XARPPVR5PdnnCFRMOkjf3h3noO6QgNO3YHZdMNcZ661SD4b+vfMvEBdbMAoc
         oZGMp3O9atnhihHs++mG9xxQX3zD0UO6pO6I9iQsY4deXDdzcKs7Pc1FUyuBgP5deRU4
         BDzxF6LcI+sjh5zRbDfyXXbg5Hy091WhfGjJC3XzVaBvg4f4QdZpa2RKHjxL/bM8y8W5
         eRjXT5Gm2PRB73gqekOJZPoVEcrW0pPYgQWgKQs40JzSSsCJ0i9aD6Vh19OqOl7TYpm6
         1BR2iD7f2BmXP4D13Zny4PKxIrVhBTZNcdOwj8mnU+24PL0syiOek9AlVc1ofv22+L0i
         hs0Q==
X-Gm-Message-State: APt69E2w+fAgcw+wawPC9UkDwnZDin4a5gH89djIxBmE9lc5s3sOYKJ9
        tlnwRgzVOgnAwANF1/T4/Ba+HDJ2
X-Google-Smtp-Source: ADUXVKIjhE7PcDDqnUVzACBjMNaTYXETryW8BYF7oyfT0ki1koYBy/NqCgplbgZkLsqmM+cg3WVeTA==
X-Received: by 2002:a65:4587:: with SMTP id o7-v6mr16756466pgq.386.1529459919145;
        Tue, 19 Jun 2018 18:58:39 -0700 (PDT)
Received: from localhost ([110.70.59.159])
        by smtp.gmail.com with ESMTPSA id y20-v6sm872249pge.46.2018.06.19.18.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 18:58:37 -0700 (PDT)
Date:   Wed, 20 Jun 2018 10:58:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180620015834.GD650@jagdpanzerIV>
References: <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
 <20180606051029.GA19211@tigerII.localdomain>
 <20180606103356.GB19211@tigerII.localdomain>
 <20180608104825.e7xoxteelaxnwx66@pathway.suse.cz>
 <20180618063738.GC27996@jagdpanzerIV>
 <20180618093917.qeaatnlqh5if6t3r@pathway.suse.cz>
 <20180618100718.GA555@jagdpanzerIV>
 <20180619075219.iq7ztwu43bn4uua7@pathway.suse.cz>
 <20180619082716.GD405@jagdpanzerIV>
 <20180619092304.6b6ba390@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619092304.6b6ba390@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/18 09:23), Steven Rostedt wrote:
> > On (06/19/18 09:52), Petr Mladek wrote:
> > > On Mon 2018-06-18 19:07:18, Sergey Senozhatsky wrote:  
> > > > On (06/18/18 11:39), Petr Mladek wrote:
> > > > [..]
> > > > 
> > > > Hmm. Can't answer right now :)  
> > > 
> > > Please, let me know what name you would like ;-)  
> > 
> > :) Wow, it's hard. Maybe we can derive some bits from the ftrace_dump()
> > function name? Dunno... Does printk_dump_nmi_enter() sound terrible?
> > 
> > Maybe Steven has some opinions on this?
> > 
> 
> What exactly is the question?

Which one of these you'd prefer to see in ftrace_dump():

- printk_nmi_direct_enter() / printk_nmi_direct_exit()
- printk_chatty_nmi_enter() / printk_chatty_nmi_exit()
- printk_large_nmi_enter() / printk_large_nmi_exit()
- printk_dump_nmi_enter() / printk_dump_nmi_exit()

> Also, from a previous email in this thread, if you have to risk
> interleaved output to solve a deadlock, then just do that.

Yep.

	-ss
