Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498B3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80B02064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYyUZyh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80B02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeJYRhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:37:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35806 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeJYRhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 13:37:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id 32-v6so3698514pgu.2;
        Thu, 25 Oct 2018 02:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=doNFkkLVfonpc2XIjiZuFo2/0BJURWzbrOsfrQl0ptM=;
        b=gYyUZyh2FeX1suBL4pqKn1aBtYPCWzbWWkABu35in93uBa3BDjyG2UGIlHl+PRImig
         2jS0Mku1u4ifbvU5+PWsaARk6wMcEkzwNLWmRo2vGr+rHhey29zUyYX+/PmEI48hZZLO
         VNjfdQ5yLtVIXOL7ovnSWfElOicm0+fdDFFGV8/2I4NQ5wzo2OQEb50RBy2v2rk3nF03
         xcBt8XR7ZtDx3KIhi0JvIUHcjzmRrfLesmfAPI4daFGJiNvwWqPc6pNPzn33hn/0+lHa
         fPh73iNGBrLdEUxNVOge4pjWlAB06n1vvoppZXM0S/X4FLrUNNCH4Lt+nisd1fB//s2S
         et2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=doNFkkLVfonpc2XIjiZuFo2/0BJURWzbrOsfrQl0ptM=;
        b=Wt2LmHNxBwKOzbRtn4Ha22CtAijqh82C6HqeHQcb8bMdPNi7tpUuC72jEDgGQT43/Z
         5Iqo8gJrZ0UHwScVpiXJyl/kmqJYiRCz7bha86WelMBExDO4Kk5hSsmjhLpsowNyq7gk
         n5z6PTFBZNjQ7yowzAB8t0rn9pfQRFduuhlLsINkebQbQ0HnzhmD6tW1gW8XdYsIq7JM
         Xuyot10sg0UnR/loc6IJ8kNS4TdAw2gQzXA4plRWUrXpPaAGZLEz/+k9tMTfHSzhf8UM
         bqinSm0jifOwVKQzG3YWmMhhuaSW09bOXzsr4qznMeNB3aS0hxx7EdwuKd8Yvccf+n09
         i/WA==
X-Gm-Message-State: AGRZ1gJ7hhMpiYIkAJmjUf7F4MpysdQ5v8n5FOKEWiN8n77WdRvRzc47
        ib/lNQN2Pqhmth3GCjxQSRg=
X-Google-Smtp-Source: AJdET5cQEzjUrRB5vzzb56GCi/DT6Wiyzrn2NBxX2AzxI24G9FqmZA+57Vx3QDyy09EuiGPsonTzWQ==
X-Received: by 2002:a62:34c5:: with SMTP id b188-v6mr738682pfa.65.1540458344894;
        Thu, 25 Oct 2018 02:05:44 -0700 (PDT)
Received: from localhost ([175.223.22.26])
        by smtp.gmail.com with ESMTPSA id 189-v6sm8689959pfe.121.2018.10.25.02.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 02:05:43 -0700 (PDT)
Date:   Thu, 25 Oct 2018 18:05:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Message-ID: <20181025090539.GD20702@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
 <20181023115433.GA10251@jagdpanzerIV>
 <20181025082947.gznv5roj3zxzlw3t@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025082947.gznv5roj3zxzlw3t@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/25/18 10:29), Petr Mladek wrote:
> 
> Yes, klogd is not a big deal. I just think that the bust_spinlocks()
> ping-pong would just confuse the code.

I agree; that's why I put some comments there.

> It might be better to keep the spinlocks busted and make sure that we do
> not cause regressions by not calling bust_spinlocks(0).

Sure, I understand. One reason to keep bust_spinlocks(0) there was "invoke
arch-specific bust_spinlocks(0), which might do something that common
bust_spinlocks() wouldn't do". Without going into details if any arch actually
does anything "special" in bust_spinlocks(0). Another reason was - this patch
looks like a -stable material to me; especially given that we have panic()
deadlock reports now. So I wanted to have a one liner which will not change
things for arch-s that re-define bust_spinlocks() and, at the same time,
fix the deadlock. Other than that I'm all for keeping spinlocks busted all
the time and just doing:

---
#ifdef CONFIG_VT
		unblank_screen();
#endif
		console_unblank();
---

in panic().

BTW, speaking of s390 bust_spinlocks(). It seems that starting from 4.21
all arch-s will use common bust_spinlocks() [1].

[..]
> > Hmm, I don't think I've seen any reports because of this. From printk/console
> > POV the locks which are not taken under oops_in_progress are not released.
> 
> Fair enough. Let's keep debug_locks_off() in panic().

Agreed.

[1] lkml.kernel.org/r/20181025081108.GB26561@osiris

	-ss
