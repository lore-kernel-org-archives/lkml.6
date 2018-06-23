Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB72C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 05:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B8B24B3E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 05:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO7uLoSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B8B24B3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeFWFVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 01:21:55 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44684 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbeFWFVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 01:21:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id b10-v6so151265pgq.11;
        Fri, 22 Jun 2018 22:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kwjgDpwtMuMEo+KPJA4zTLwkC8zxbqbGt1CGObleKV4=;
        b=YO7uLoSxGsAG0mHVtXFslMr5t00XgOkoA/VWqjzGdkva2a2/b5Gt1vmnZmNuGn55xh
         Wk2KAW7PB1+ay83Vffp++sJ52RifC3Ktn5kuo7y09lZ5HbcCLMsJJy0oitC7VvB3Qtd/
         4ainD4PGTI7Xw25ObiIAzdIDApI6N9o1cpgjJiHC/GYT/8CT6u7Vug8vnPMddtUup4U5
         GGrPd9FBlGY7dVewaz+iTLmcI3LM+PTB3YWaMHdZG0FgeQJ2XQQIifFTEP+agpDDAHdF
         MCBGff6IJIGcSj4f6EoKNEthMRnGL1IAPacW3FWGZcC+3D7YHMp1ANqUA6w/Doo7N1bq
         dRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kwjgDpwtMuMEo+KPJA4zTLwkC8zxbqbGt1CGObleKV4=;
        b=ZTMXW1fpnDmJQ1vxX10J2aD8DdCVCb8/LyooVK28iSJD1ZUogFSGwHMltWMI/ZvjNy
         encPBj4DrMqrJWmaq1LFA6WlnbFn4Z3f4bG7+4xZ4C4Jh0UMscfcZpm82p2mtOtLLC2B
         WD8cTCegYs/PX7Q6tibZiHnHp//+C0hAYJeOGGm24DOTDZgrmCq0NXWkFQQT7gVZR4+R
         rM1VXJLBYh0+5sBTxlbcWkkakmVT+Cqce/VuQe8Qe6QoCOwLzzJ+BUjVX21JWFcpUBAQ
         glFcrd3Ft/4U3kPAblNF4eNA5m7foRNRjNxBynHFGowQ50TuP5jxst+cZHSoJ/eT8xFs
         YiQg==
X-Gm-Message-State: APt69E1dvDX+qmxykYN2FpxOBLlHE4wjds66SCSfbT3N2JykYpW9aGRE
        +v7lYOKP11E7Do/8t8wuUZU=
X-Google-Smtp-Source: ADUXVKIgVdrRKvCqANQmg8MzUUWp31lrRKSDEpdvywdM8XcnZLomaXOH2YmdaIxjKcup/dv1sE18DA==
X-Received: by 2002:a65:5a07:: with SMTP id y7-v6mr3623768pgs.177.1529731312496;
        Fri, 22 Jun 2018 22:21:52 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id k13-v6sm17033904pfg.130.2018.06.22.22.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 22:21:51 -0700 (PDT)
Date:   Sat, 23 Jun 2018 14:21:49 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Message-ID: <20180623052149.GA402@tigerII.localdomain>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
 <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
 <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
 <20180619223447.4369748b@vmware.local.home>
 <CA+55aFwpcbNO6FS4=O-BrsC4vMBaT3JeFG-_D9WtgmW+Dof3iA@mail.gmail.com>
 <20180622172100.2293b5e5@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622172100.2293b5e5@alans-desktop>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/22/18 17:21), Alan Cox wrote:
> On Wed, 20 Jun 2018 11:44:13 +0900
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Wed, Jun 20, 2018 at 11:34 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > Perhaps we should do an audit of the console drivers and remove all
> > > printk, pr_* , WARN*, BUG* from them.  
> > 
> > Only the actual _printing_ parts.
> 
> No because they are normally rather useful because that port isn't the
> console. If you trylock

trylock is boring, me wants printk_safe_mask everywhere :)

> Really that's all that you need - log the message to whichever console
> targets you can currently safely do so. If it's none well there was
> always the proposed morse code keyboard light driver 8)

Hm, just discard messages? With printk_safe_mask we keep everything
in a lockless per-CPU buffer, which we flush [per-CPU buffer -> printk logbuf]
from irq_work, so we can print it later.

	-ss
