Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0980CC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C042086B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5jw3mAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C042086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbeFTBzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:55:32 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46549 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeFTBza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:55:30 -0400
Received: by mail-pg0-f65.google.com with SMTP id d2-v6so695543pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 18:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OuvBfndeGk2bUFzhKctxXhezMsreB0RrB+0AYNF8mso=;
        b=A5jw3mAaa321Uk/Bf9oVEFtBE1HeG98Ub7RzaN7kX54ioZp3HZ/j+39iQT/vYOXX3c
         2UNc5lv+isufmuViZPDfScMLpjfucFgZIq1ny3OhXiuDUVo6Ao4imBnQTzDbjoiFY0DZ
         XIXxNKMcYW495g68iqPZFobEAwY32Kbb3+uxuGrDh307ra2XKtqsxBcYY4cp3LpB719e
         +Gg41cXY1xte67tdNjBwnUuEjx+/r6NjrJEcZrLrax95F/DZyeg1wjPhhn7PVOOwRQTr
         o/92edwrwz0qxynseqe1JsI0hykWXa959t6KsuhVxu5cA+s0bYYol5UmiTlX/I3x/WKv
         fBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OuvBfndeGk2bUFzhKctxXhezMsreB0RrB+0AYNF8mso=;
        b=eZWWso7bIZf3QU1X44s3WAA1YJlgpZI9yxymAn2GidvMp0wCrM8cgK+xj7yPxt4qSw
         NOyTh3nJClIU7IbHJ/QDnY8FGKAh262TI222Com22OXqNxLkmC679iZQG/Sdy1fiuOix
         iLXiOy+caiRUhFzgtJ8ArBynFBz3AkQFLd7j+TbLe95pB/kURb0u5udN7YslyPG/jmw9
         rNVtKgQMCitT+jmTYmv9THubZZHoSuslS0RInE9WGfeLk6AYxlLuxdHhN6o9PussDiqu
         5bz7HeP28bLJKwQrFamxciQInvMZJACsPd++nWj/qqiSPR+7zyhprLwxISS+6JU/NEKD
         lRnQ==
X-Gm-Message-State: APt69E0sXomZxxg+MZPIp8v7Br3A99YCpsleR0G9zn4xOGkMfL84Kcpb
        BtapMb5HRGavdXK0mxEPoSM=
X-Google-Smtp-Source: ADUXVKJjSCjGcJyFIGOnJ6NW7NqR8pPBzpQ5HcG46Lu1junx/QAvFUT7d4/t1KMXn3z3ub4Kg+UG5w==
X-Received: by 2002:a63:7255:: with SMTP id c21-v6mr16397559pgn.99.1529459730269;
        Tue, 19 Jun 2018 18:55:30 -0700 (PDT)
Received: from localhost ([110.70.59.159])
        by smtp.gmail.com with ESMTPSA id m11-v6sm1278291pfk.42.2018.06.19.18.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 18:55:28 -0700 (PDT)
Date:   Wed, 20 Jun 2018 10:55:25 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH v2] printk: make sure to print log on console.
Message-ID: <20180620015525.GC650@jagdpanzerIV>
References: <CGME20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26@epcas5p3.samsung.com>
 <20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26~z-a_jkmrI2993329933epcas5p3q@epcas5p3.samsung.com>
 <20180618061550.GA27996@jagdpanzerIV>
 <20180618062306.GA29683@jagdpanzerIV>
 <20180619093244.ehj34uhpnpv6447f@pathway.suse.cz>
 <20180619094953.GB2631@jagdpanzerIV>
 <20180619105213.uzf6ba3oo3475icz@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619105213.uzf6ba3oo3475icz@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/18 12:52), Petr Mladek wrote:
> > But when I set /sys/module/printk/parameters/ignore_loglevel I naturally
> > expect it to take an immediate action. Without waiting for the consoles
> > to catch up and to discard N messages [if the consoles were behind the
> > logbuf head].
> 
> Yeah, I understand this view. I thought about it as well. But did you
> ever needed this behavior in the real life?
>
> I personally changed ignore_loglevel only before I wanted to reproduce a
> bug. Then it would be perfectly fine to handle it only in
> vprintk_emit(). In fact, it would be even better because it would
> affect only messages that happened after I triggered the bug.

I thought that additionally to sysfs knob we had a console_foo() function
that simply set ignore_loglevel. But it appears to be sysfs or boot-time
configurable only. I confused CONSOLE_LOGLEVEL_MOTORMOUTH and ignore_loglevel
and thought that a console_verbose() call would basically set ignore_loglevel
to true. It's a bit misleading that we have multiple and independent ways of
achieving the same result.

So maybe the patch can stand the way it is, after all. JFI, still haven't
seen those "helps in real life a lot" examples, tho.


> schizophrenic logic.

OUCH! Seriously, what the... Knock it off!

	-ss
