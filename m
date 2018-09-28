Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA695C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593C82172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgWtVpaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593C82172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbeI1Pcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:32:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36819 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbeI1Pcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:32:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so3903639pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xwKl6oATMYiUQjXIKrLEXZ9JEmh9An9XiH/0K/lHB3U=;
        b=OgWtVpaRxtNyURYxKxKnpXEgZ99hwNGmLaCEnGh+8R63eGpcBI9pIG3WlIBJS8wvpS
         ts/rqzse5OnxySRJ+/xeKpYOfpjidH8aGURvyAex2WeV7SADxhAsx/5ZOc44sBAV11fi
         /a0Rh0F+OTnmZziGxM0i9eAaVMj2h3S1PNTyJO4kbiUf9ndeENHorZPPTndr7oUN5raQ
         cc+PBiDzin+keDY+7Xui6ECf9bye1KvPtiK5kqBUYI9wp6eYNz5KwbOpie9GNC66f6J+
         iaBotuFNHD6qyUaVaiFJYhW8jm6ru0pf2ykmqb0uNBOaTEnGx8i2EzCBBYpkrrxjo7tq
         CdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xwKl6oATMYiUQjXIKrLEXZ9JEmh9An9XiH/0K/lHB3U=;
        b=HE9Zw/sqHFvKsGAH0CRsnBB1UewoWhOXDH7s2RlF99/l0HoZgmrFXdjmAih0Guum5M
         rIjf+Fgc4irvZB2AuA45S+42VOpqtWQVwHZZYsTfKm8Eri/rIPR0RWjQlD/r2SCqUL5z
         UTfUVpdwEfyuxRuKJZemoYJkUCaKodWmzUu5A54IuYQo7hAuoeZd6m8MNZ2aJHCVt+EM
         OCGQrUSAXxn/Fj95rnbZyjFZXy/BCQqGaypCAc6Et1a/7sdQt3DbfHRcfbHYUACVygSr
         r/EWdxxX5ZgW7/KYnYdZacUMFEJxGiuVYR+tVDo+oYv9SyqVdOh0+WD1zJsrGoWpU4Q+
         aa/g==
X-Gm-Message-State: ABuFfogE0iDzZII8pzYBOZJdswpWRsiZ6pUVrNueulyJGwqqbbTKfZZS
        k++tQzpKRmWF9hHJq5Rt3Js=
X-Google-Smtp-Source: ACcGV63xmwZN0aJ3KIh6sMlDGGWPjvjTpytch1SXVMiLXyVytT/wBdyk6DD/nSR0DdaDM3Qt0xPVAw==
X-Received: by 2002:a63:9a02:: with SMTP id o2-v6mr14069803pge.440.1538125784781;
        Fri, 28 Sep 2018 02:09:44 -0700 (PDT)
Received: from localhost ([110.70.14.151])
        by smtp.gmail.com with ESMTPSA id a190-v6sm6888743pge.47.2018.09.28.02.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 02:09:43 -0700 (PDT)
Date:   Fri, 28 Sep 2018 18:09:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
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
Message-ID: <20180928090939.GE1160@jagdpanzerIV>
References: <20180913071204.GA604@jagdpanzerIV>
 <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
 <20180913142802.GB517@tigerII.localdomain>
 <20180914065728.GA515@jagdpanzerIV>
 <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/24/18 17:11), Tetsuo Handa wrote:
> The reason of using statically preallocated global buffers is that I think
> that it is inconvenient for KERN_CONT users to calculate necessary bytes
> only for avoiding message truncation. The pr_line might be passed to deep
> into the callchain and adjusting buffer size whenever the content's possible
> max length changes is as much painful as changing printk() to accept only
> one "const char *" argument. Even if we guarantee that any context can
> allocate buffer from kernel stack, we cannot guarantee that many concurrent
> printk() won't trigger lockup. Thus, I think that trying to allocate from
> finite static buffers with a fallback to unbuffered printk() upon failure
> is sufficient.

Yes, this makes sense. At the same time we can keep pr_line buffer
in .bss

	static char buffer[1024];
	static DEFINE_PR_LINE_BUF(..., buffer);

just like you have already mentioned. But that's going to require a
case-by-case handling; so a big list of printk buffers is a simpler
option. Fallback, tho, can be painful. On a system with 1024 CPUs can
one have more than 16 concurrent cont printks? If the answer is yes,
then we are looking at the same broken cont output as before.

	-ss
