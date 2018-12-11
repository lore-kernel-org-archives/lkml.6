Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F558C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BD320811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiTzXMAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BD320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeLKIHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:07:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41254 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeLKIHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:07:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so6280095pgh.8;
        Tue, 11 Dec 2018 00:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dtsah3hj3YglgtT4y8wajXfYCGKdjBGIw6dGZnIEYkU=;
        b=fiTzXMAlIVT6mau0PrKHi41nMq4d0t8CIUfdBoe0aiI3xSwNy8FN9n04aTmnVTEaHu
         Z0+MqBhbFc3TdkvRLXPXAX2Xl9gHQHE0Xn1ZQs+ZeTVxxA48hFAnYa9N70lPLTekFTGg
         wg4MrVKuwJUTJ4lUMq9avWa5MO17iD+PjyC+JWbhU8EYV2qhARD2pycr7Pqg+KF5SIjM
         DCbykyzKtivJNJ2h9UbOUE+RcamX4S2nwfO8c4DBA8FcvQccbavZF2Ix/bbDBbU48q7u
         NjSFOq/iqpJcRv0XsMRIXxxzGdCw6cJodcTI6pqASFDjf498CVLthKjUx1heIieIcZ8N
         lf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dtsah3hj3YglgtT4y8wajXfYCGKdjBGIw6dGZnIEYkU=;
        b=c9yUA2XMXt/EM7i4+BwKx+8z/zmrVUYNPRynXynbILAd4LSi7IWMWK5Sfe+2z1MDta
         dDB/Hc9QZoBVYZ5xXxkbK8XEqXHwrlkNlWHNCvfq62bfrfHoSO8lMvHR/GwDWoL0R2Dw
         dOtN3ZgqmNDjzeUdwbNsYYTqQyiR0vakwis87p7NGI8rTnUWVwS3GHPlH4k+E1jpIO8l
         lZmwcNhf+qWW0n7xszN5ikc5c3Lk27v30W9hokL+z3ibLwfzf6rOklbEQc90OroR1a6v
         sEJfJSB6yG9Atnurw5oyKRDLFD3jlujLmbORDAMXxBWg+HTlA2oabIso9MV0REjOpDat
         WLZw==
X-Gm-Message-State: AA+aEWZolXoShSoU7TlDfHx9yChkoIv7ojLj8Tk1+NC9d5oC/HiK9FZt
        FdcpTL8qsCcFeOGMif+udx/t8F0D
X-Google-Smtp-Source: AFSGD/U4lQ2c8GF0emWKUResBZIQzORfuKBg+e61AT9gX7H7jJ31cKFLiTfLljgbEJzt0I9dgLVxqQ==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr13949394pgh.164.1544515668497;
        Tue, 11 Dec 2018 00:07:48 -0800 (PST)
Received: from localhost ([175.223.2.144])
        by smtp.gmail.com with ESMTPSA id m67sm22251090pfm.73.2018.12.11.00.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 00:07:47 -0800 (PST)
Date:   Tue, 11 Dec 2018 17:07:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        akpm@linux-foundation.org, bp@suse.de, keescook@chromium.org,
        mm-commits@vger.kernel.org, sergey.senozhatsky@gmail.com,
        stable@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: + panic-avoid-the-extra-noise-dmesg.patch added to -mm tree
Message-ID: <20181211080743.GB521@jagdpanzerIV>
References: <20181205022654.GA503@jagdpanzerIV>
 <20181205024713.nqyt6qiamokq7qtl@shbuild888>
 <20181205025728.GC503@jagdpanzerIV>
 <20181205052912.GA423@jagdpanzerIV>
 <20181205080044.GA11190@jagdpanzerIV>
 <20181205154620.4dqtledc2duhrp2c@shbuild888>
 <20181206035825.jz2bfh3errj23rjq@shbuild888>
 <20181207095004.GB3729@jagdpanzerIV>
 <20181210094554.z5n7dmkrnlcpygg4@shbuild888>
 <20181210155705.qowbi7xvszzfonzk@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210155705.qowbi7xvszzfonzk@pathway.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/10/18 16:57), Petr Mladek wrote:
> > > (masked out) and on panic_cpu disables only SDEI (interrupts from firmware,
> > > if I got it right); so it seems that arm64 can handle IRQs after panic. And
> > > if there are platforms that handle IRQ (including sysrq) after panic, then
> > > both options - making printk a noop or keeping local irqs off - maybe can
> > > cause some problems. Or maybe not. We better ask arch people.
> > 
> > Yes, this is very valid concern. And after Petr and you raised it, I did
> > some experiments with 3 x86 platforms at my hand, one Apollolake IOT device
> > with serial console, one IvyBridge laptop and one Kabylake NUC, the magic key
> > all works well before panic, and fails after panic. But I did remember the
> > PageUp/PageDown key worked on some laptop years ago. And you actually raised a
> > good question: what do we expect for the post-panic kernel?
> 
> I am not sure why it does not work. But it would be nice if sysrq
> worked.

Absolutely.

[..]
> I still think that calming down printk() is acceptable when
> it can be restored from sysrq.

I would agree; peeking one of the two solutions, printk patch is
probably preferable.

> I think that only few people might be interested into debugging
> post-panic problems. We could print a warning for them about
> that printk() has got disabled.

Dunno. This _maybe_ (speculation!) can upset folks on those platforms
that have sysrq working after panic. printk is a common code.

I'm probably missing a lot of things here, but just in case, I'm not
sure at which point the idea of patching some files under arch/x86
directory was ruled out and why.

	-ss
