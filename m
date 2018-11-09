Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C5C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938B82086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFKU9Xi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938B82086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeKIQ1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:27:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41869 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeKIQ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:26:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id p16-v6so491103plr.8;
        Thu, 08 Nov 2018 22:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7nHh+0TwFk91NgvrGTFF3LoMskhUBh2w9Bte8yUfnA0=;
        b=RFKU9Xi3Yp7YCfNhsIPTJbv4o0IJi+S7PkI+LmIvqwAiCqyhXrBuvJTmzhM9zlw6Ir
         WzxkoAcciw+uvyPKITduXMHBhvsTupJxcN/s2NvKHsTRATBH8zBBA9Vf2srHPt2lWxcy
         8i9ZVnPWYH7KtnatiNhPgo1rrFBNycRj4kdZT9/fRm+/d8Fi6RXGVwmNfkv2ekkIIIrp
         HcaO7ewU694DZwZpyRaTq7e5FU/9GaVv81kAXKRWnUp+vV2fxE7LsR33IP6vZGRriDlf
         MJz4heqFXFfvOv2cymYeo72N7SKRrkafY8hfRAZzC8cwamk5LjbSUoUmuc/mXePCngz7
         8CFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7nHh+0TwFk91NgvrGTFF3LoMskhUBh2w9Bte8yUfnA0=;
        b=naiIzg2k+NdBS0cuISi/aAT90bcr9/E+UVrKZq0J8wk4llKF/OzUvH2rJXhEU/yxWZ
         mna2UUIeHfIJm8jdeak/X/LHaZdvzKbFt0SBTCg1+n+iaufbxRS17kJPow3K2FL9ACeG
         v923T6TewetSyLCarlY3jZYgRJSCJLSYP3YpzQEm4Vw4mEdJc8IxSUNc2H5B0Z49yYuT
         wIjTjIWukvFjzS3UdPVNCP0D/MwAhede6+muH0V31hRpL/yvXEvn7Bt02h+TVui+/M9l
         H1mhn/nmOtzb6C9ViHa1sP3xghFhudMLQR2Qtb13P83KtN4y4uN4FN5OfyYfcaCUhEdA
         NAyQ==
X-Gm-Message-State: AGRZ1gLSClXBQLG8H3O6bCDzYuMZ7IlvlGwijnn8iHfBf0idri5EsyRw
        +7N3qMxvXCySjq9pQ5tGaX0=
X-Google-Smtp-Source: AJdET5cSeg6AziPZlKY+z+eKf99vuS8f1VgEmHYIlkrwMwjNNbVMpEVRlTrUkou86T2d1KP4ZUKAjg==
X-Received: by 2002:a17:902:3a5:: with SMTP id d34-v6mr7727657pld.110.1541746065505;
        Thu, 08 Nov 2018 22:47:45 -0800 (PST)
Received: from localhost ([110.70.55.191])
        by smtp.gmail.com with ESMTPSA id v20-v6sm11429198pfj.107.2018.11.08.22.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 22:47:44 -0800 (PST)
Date:   Fri, 9 Nov 2018 15:47:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Wang <wonderfly@google.com>
Cc:     sergey.senozhatsky.work@gmail.com, Petr Mladek <pmladek@suse.com>,
        rostedt@goodmis.org, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com, akpm@linux-foundation.org,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        tj@kernel.org, torvalds@linux-foundation.org, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181109064740.GE599@jagdpanzerIV>
References: <20181003091400.rgdjpjeaoinnrysx@pathway.suse.cz>
 <CAJmjG2_4JFA=qL-d2Pb9umUEcPt9h13w-g40JQMbdKsZTRSZww@mail.gmail.com>
 <20181003133704.43a58cf5@gandalf.local.home>
 <CAJmjG291w2ZPRiAevSzxGNcuR6vTuqyk6z4SG3xRsbaQh5U3zQ@mail.gmail.com>
 <20181004074442.GA12879@jagdpanzerIV>
 <20181004083609.kcziz2ynwi2w7lcm@pathway.suse.cz>
 <20181004085515.GC12879@jagdpanzerIV>
 <CAJmjG2-e6f6p=pE5uDECMc=W=81SYyGCmoabrC1ePXwL5DFdSw@mail.gmail.com>
 <20181022100952.GA1147@jagdpanzerIV>
 <CAJmjG2-c4e_1999n0OV5B9ABG9rF6n=myThjgX+Ms1R-vc3z+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmjG2-c4e_1999n0OV5B9ABG9rF6n=myThjgX+Ms1R-vc3z+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/01/18 09:05), Daniel Wang wrote:
> > Another deadlock scenario could be the following one:
> >
> >         printk()
> >          console_trylock()
> >           down_trylock()
> >            raw_spin_lock_irqsave(&sem->lock, flags)
> >             <NMI>
> >              panic()
> >               console_flush_on_panic()
> >                console_trylock()
> >                 raw_spin_lock_irqsave(&sem->lock, flags)        // deadlock
> >
> > There are no patches addressing this one at the moment. And it's
> > unclear if you are hitting this scenario.
> 
> I am not sure, but Steven's patches did make the deadlock I saw go away...

You certainly can find cases when "busy spin on console_sem owner" logic
can reduce some possibilities.

But spin_lock(&lock); NMI; spin_lock(&lock); code is still in the kernel.

> A little swamped by other things lately but I'll run a test with it.
> If it works, would you recommend taking your patch alone

Let's first figure out if it works.

	-ss
