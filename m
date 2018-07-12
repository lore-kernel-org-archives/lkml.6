Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9D4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041F42147D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="e+2Kje6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041F42147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbeGLOXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:23:03 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:45501 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeGLOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:23:03 -0400
Received: by mail-qt0-f171.google.com with SMTP id y5-v6so24155234qti.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c6e5mv5qZbiMykO/PA+TCD2xH5BtimFkI3u0CakJflw=;
        b=e+2Kje6rk9ydoXyJ0AgIX6ccVNlw2yGeqreC40agwvm8iEYEp6G9U2pGbvP3C0yLTJ
         twjWzKZ+9ZbS6y9JdgeqoDe3SXuwu5a3rKHNdFvXkirHHvwNNdlmvkaJEZp0uTXhqlZU
         QcfLwmp2h5y0ixePMSgY4LHvFMSlqYCcBPe4Qd2+i+T42Lzxew50QOaV8DHtZpwFXb2c
         7S4rF/9zZC9veWdEpdWNtsFWb8aXCe7mtftcGdtqKwd4f53RSOAZ9dY5bmpy2tbxDpho
         cl0xv8di3VX5jTEFFXXVW/0TRjBjDek63LvVPa4U78ntAQZ3GmnvKxmdoGyz/Je0uL72
         iDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c6e5mv5qZbiMykO/PA+TCD2xH5BtimFkI3u0CakJflw=;
        b=NUFIAE2JlgvQk9t8I5AGkBYVz6AMXpqiEG372caWGrLPw2P3c2RUsEeqAAUVaiV4Yb
         xPSwSJvmgk7Y/OvbI0Wzc2WysStCZfqTDA28auDccTYM0rWYXLBaPyVYS1UM8JlVxMiA
         W5uetuBu6KM6HkJvV0LEemg9xdojuf2B0vFrDD01ZSziu/dWpoAnbdQ/jQQi/MQwyQ1F
         e/P+gHyTJSIQL2gOIntjv15PGURaLTglysrB5MWkd77iA1ohQN6PupeIzNqLGHwGSryx
         YAO/eXZ27eiiFPb3oldg42rGS8lHjVDKq2C6diK3z30YitoDe463p7ow1GH5uGR0Y6HZ
         ioZA==
X-Gm-Message-State: AOUpUlF9Zkx/MJ5RlU87/53zGKOlcIoevA6WDJo8AJfuaXhJzMresjNs
        85inL1fWb/Gj0aWENIMlOhRtO8h6
X-Google-Smtp-Source: AAOMgpdNtgctu3cVNC7+bHN/NHM+ZJLVL93y24jUbB819rLvwC5OF+u+YpM07yHFq8x+S2k3CZLQxg==
X-Received: by 2002:a0c:a9c4:: with SMTP id c4-v6mr2526396qvb.119.1531404797207;
        Thu, 12 Jul 2018 07:13:17 -0700 (PDT)
Received: from cisco.cisco.com ([8.24.24.129])
        by smtp.gmail.com with ESMTPSA id f2-v6sm4671085qkm.51.2018.07.12.07.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 07:13:16 -0700 (PDT)
Date:   Thu, 12 Jul 2018 08:13:14 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v4] uart: fix race between uart_put_char() and
 uart_shutdown()
Message-ID: <20180712141314.GB13192@cisco.cisco.com>
References: <20180706212220.GC3583@cisco.lan>
 <20180711160744.32074-1-tycho@tycho.ws>
 <CAHp75VfQe4p_z1uAoq87F6zqaCbqKG1ZgHeK55fjwkFGNtMK0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfQe4p_z1uAoq87F6zqaCbqKG1ZgHeK55fjwkFGNtMK0A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Jul 12, 2018 at 12:03:08PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 11, 2018 at 7:07 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> 
> > Anyway, since the lock is not acquired, if uart_shutdown() is called, the
> > last chunk of that function may release state->xmit.buf before its assigned
> > to null, and cause the race above.
> >
> > To fix it, let's lock uport->lock when allocating/deallocating
> > state->xmit.buf in addition to the per-port mutex.
> 
> >     * use the result of uart_port_lock() in uart_shutdown() to avoid
> >       uninitialized warning
> >     * don't use the uart_port_lock/unlock macros in uart_port_startup,
> >       instead test against uport directly; the compiler can't seem to "see"
> >       through the macros/ref/unref calls to not warn about uninitialized
> >       flags. We don't need to do a ref here since we hold the per-port
> >       mutex anyway.
> 
> > +       if (uport)
> > +               spin_lock_irqsave(&uport->lock, flags);
> 
> > +       if (uport)
> > +               spin_unlock_irqrestore(&uport->lock, flags);
> 
> At some point it It was uart_port_lock()/uart_port_unlock(), and you
> changed to simple spin lock. The macro also take reference to the
> port. Do we aware about that here?

I don't think so, the commit message you quoted above says,

> We don't need to do a ref here since we hold the per-port mutex
> anyway.

Cheers,

Tycho
