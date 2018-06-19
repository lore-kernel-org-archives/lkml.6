Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AA7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B73320874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5Lheezb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B73320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756405AbeFSIIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:08:21 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:45783 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756342AbeFSIIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:08:17 -0400
Received: by mail-pf0-f180.google.com with SMTP id a22-v6so9527256pfo.12;
        Tue, 19 Jun 2018 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i0bIMyqo9J/Ty9YANdAtmQsM5kC0e+H571I4dWZ6GYA=;
        b=M5LheezbnEDPQFGrQLv8IRhIMJHiGU/kZHmU3pqUuOO4gFGONWmtubwcbvOFijWC/9
         d7qcUSucZedN/gAUpNQztMdHllAL4G9cxGYH8YgsWznEtHzcOyLeBB8tP9v8J+OKmU9Z
         oMQgnZcpxbey+OZGEVZE8yV+VjqJo46WEsbq5Ji///oie+ywDwbBqp26qVVKWOg4srsl
         b0/CTtMS1LIntUiMNb9iOf9skB0I7zmd+ixnBPFgH+O4A0J3xpALrHuBmRxmGma6KRs1
         +wucstc2iYl4FmOBoTItSFRbjDrkQ/B2L/ek8j8aGWg3huw8KauOYmxwxgvJyYGJg8nN
         WBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i0bIMyqo9J/Ty9YANdAtmQsM5kC0e+H571I4dWZ6GYA=;
        b=I+zD/wbcldd3XCeD3qWBZZnfVnzT6i8Ths8GYnYBdE1RdgJmvc8qbMWu2OS80FH4iW
         zaT8C4NkFxn9pbNGrbcJRosmDH1UkvVHh2J5z9T0ofHdnoMFbh2jV4vaZw+0KiGYKRlA
         scmSlG/+UAy4G4PhKBulBU8ZUl7dXA5X2art1AznJb5NbJjd4Os2EitNGn2IWbsLppyv
         PL/YClV5nucbaWst+Jcqrb2Knf+lA4OR+Up7nP7Xc8xCE+HCpmnEInNL1B4u9OEPy9LS
         IFhbPb2w1/uW1jwnS7s9z1XnYwgpdZtpcLeK0ciydpk99B/glvKfr786utm6HL4mSFVU
         rNIQ==
X-Gm-Message-State: APt69E04j13YQORjxhoGb4udeYnIJCFKZBY5p2wpnJiy2PzQMg8exVKc
        PlCEDUsyijtUzrseuxe3kyY=
X-Google-Smtp-Source: ADUXVKJf4cAk2fkMZXd9U0X1o4Vpz4TxmJnN4OOyINPZSwXTzAD+1chXnyL9J8Zik8e7y/x01BMuSw==
X-Received: by 2002:a62:9513:: with SMTP id p19-v6mr16998117pfd.239.1529395696495;
        Tue, 19 Jun 2018 01:08:16 -0700 (PDT)
Received: from localhost ([175.223.26.106])
        by smtp.gmail.com with ESMTPSA id j3-v6sm20890357pgp.47.2018.06.19.01.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 01:08:15 -0700 (PDT)
Date:   Tue, 19 Jun 2018 17:08:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: possible deadlock in console_unlock
Message-ID: <20180619080812.GC405@jagdpanzerIV>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
 <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
 <20180607140100.GA398@tigerII.localdomain>
 <20180608081855.ctqakvwmg27aydby@pathway.suse.cz>
 <20180615083804.GB8964@jagdpanzerIV>
 <20180619080412.zkdanx6bmq5qm3dz@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619080412.zkdanx6bmq5qm3dz@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/18 10:04), Petr Mladek wrote:
> > > 
> > > We could allow nesting. It is just a matter of how many bits we
> > > reserve for it in printk_context variable.
> > [..]
> > > In each case, I would like to keep the printk_safe context usage
> > > at minimum. It has its own problems caused by limited per-cpu buffers
> > > and the need to flush them.
> > 
> > May be. Every new printk_safe flavour comes with increasing memory
> > usage.
> 
> This must be a misunderstanding. My intention was to introduce
> printk_deferred() context. Where any printk() called in this
> context would behave like printk_deferred(). It does not need
> any extra buffers.

Ah, got it. Yes, this can work.

	-ss
