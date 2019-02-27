Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EEEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04311218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CopY6rgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfB0Ion (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:44:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33735 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfB0Ion (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:44:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id y10so7693627plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 00:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CazSiCwvaXGcQ7xAr/oeXhU6+vfboWDbWRjo4n2b04Y=;
        b=CopY6rgCOcPKAHf4nmBgxT9Oltl4zi2vioDFeTBeRjhOhwx1LbC5d7UkfmpqyVuw5y
         noMY2+7WkD3KP5AdXZWIs9sa7w1hduoaskXuYc3pSJXB5jstqJvGAQKh7Z6lCVM5Ilkb
         9zObQSWGB/LYawWqXaq92CNFN7J44bC2A6nZvFJ09cmpEAp/cuUt2XZ04Yhitsjizq7I
         6eda/eRsI5SvuVzBVWIF/KLSbsZN/7yKef2uEC9LvhXB8NsXMaU7JleyfvZgRgvWbBTQ
         0VLKx/39mdLmfFdpXmXofSFs8SozfWfEpjD0C1ohwaSeNkZlQmHfEmdTKg0EEAzq//VU
         is5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CazSiCwvaXGcQ7xAr/oeXhU6+vfboWDbWRjo4n2b04Y=;
        b=nOevj6c9CquumdLyOR2mUQHNc8llWaucT2IwjZ9DkVQGxohE9QyIezaRTnXe5C3s6+
         Rk1nesSyi3D2lMbyL/12+h3Porkkls2CmGGeD/84drmxx350/5AwA4detVOgRxnnmN/2
         2GXWWr3rim+lYTJBSEb2X8KZ4I9el8fdItM/1diB0jyFo/OmG1cjp2Kdp6of6tTNi5Xk
         iYR1eINHkF/3uDAM1sTFrl9ELiAvLsx6Dq6TZvUfAUAAzsUGsx+ew/5/onPGjcO3VHRO
         8iQxpT+PhAwRLF5aDQUDDF80/iY8Jn+SL7sC/8FTZC1J9K13OGh2AaeXuuqtFmgaaEmD
         eNfA==
X-Gm-Message-State: AHQUAuYPckJ7Yp5lDu8dV/W9LzimRKyS+258yzsU3asH2eD0ccOR49Ao
        xewLxRFG2rcqbBX1lZeLjKM=
X-Google-Smtp-Source: AHgI3IYaeM4TnuILcIrgQOw1TD4eBoXpg+RQpaQ3hU7XB8XHKXC8CTYJkhPV7nB8ELFJvbX3D0dgjA==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr974472plh.233.1551257082710;
        Wed, 27 Feb 2019 00:44:42 -0800 (PST)
Received: from localhost ([175.223.3.190])
        by smtp.gmail.com with ESMTPSA id j68sm31567687pfc.64.2019.02.27.00.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 00:44:41 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:44:38 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk/console: Do not suppress information about
 dropped messages
Message-ID: <20190227084438.GA14252@jagdpanzerIV>
References: <20190226124945.7078-1-pmladek@suse.com>
 <87k1hmzfam.fsf@linutronix.de>
 <20190227025559.GA18340@jagdpanzerIV>
 <87fts9fy5n.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fts9fy5n.fsf@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/27/19 09:12), John Ogness wrote:
> >> 
> >> My only objection to this is that the "messages dropped" only comes if a
> >> non-supressed message comes. So information about dropped information
> >> may never get printed unless some task prints something non-supressed.
> >> 
> >> Imagine a situation where I am expecting a message to come, but don't
> >> see it because it was dropped. But if no more non-supressed messages
> >> come, I see neither the expected message nor the dropped message.
> >
> > I think this is exactly the problem (and thus the patch) we discussed
> > some 3 years ago.
> 
> I guess you are referring to this [0] thread.

Right.

[..]
> I would agree with the proposed solution from 2016. My experience is
> that the dropped messages are very important. Yes, printing them could
> lead to the loss of even more messages.

Yes, printing out messages does take time. But I think it's easier to
start losing messages due to preemption under console_sem than due to
call_console_drivers() latencies.

> But still, it is important information that needs to get out.

I'd agree. A summary "you lost %d messages somewhere between current
and previous messages" is surely better than what we have now, but is
still a bit less informative than "you lost %d messages just now".

	-ss
