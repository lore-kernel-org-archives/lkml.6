Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DEEC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95062098A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="P1XWdiwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95062098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934451AbeGFSjd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:39:33 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54133 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934105AbeGFSjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:39:31 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so17713407itd.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cADmb3tF5S7ViXWrabOnyIjjS/q8GqPsschrpFVB25g=;
        b=P1XWdiwWwQVeclX5Ceq7/mOjEP4hi/FQocJGGGQSVmskMG9IKWiHOECnPbq9qFlRrx
         xn0ftK88GA8dWwCwtqJ2RftVa/A+CxZ0L/2ltQ83Y1KfSQj9c2DazYNgKPaKF7I2nTTP
         ByUoIw1IS3aarcFezEjjtGit51AKu8aMMiFRwU1fOsiaSt2oxpkkDVLsbUcFS/BNPjOT
         GqxJLkzKi+aC/evLRdPH9hhCIxYOf8NLPJ4s3mrLf+LoD19SUrqLBvPxKf1bXUyJV/P8
         KSWt/uktyztcfhRksiLmjRZSTAXWPAOE5mX7hlruTtsF4Om0CxbxBq4snbo1xBdNJJhw
         vIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cADmb3tF5S7ViXWrabOnyIjjS/q8GqPsschrpFVB25g=;
        b=GWIlmCsh4+Z1Xz1bFE7fEGz9ynVYRaiwlUufs3YIgqWWFJpDhePB9LCNIOQOCMgKBY
         OwlCe7zG6qrFZh5wHfYjzVJrSVJyqlpKwSrJ4wsMANw24QpUEsWH9efq6/Uo/v+pFOkK
         pWL27qWfDujn3nX6RET52QUFPf2Pn9GAK/Y6hLJNiE0OhdPdORuEpvnXyR1/LdZfc7vL
         VqZ1ghEPj2QO3KQ0RHSLvkvYJV1ukMkVGyhAYh4xJZLjt47s/LAPHaQmiWOWSQ81+1Kt
         1qdl9+wUMySSbrTNYBoKw4vsRytPW837EZh4hn8Ce6/wpaUIrQbsnGx2RAe1CwC/yPgF
         GSDg==
X-Gm-Message-State: APt69E2ZbJA1yRuGRi15FVAYG1+1RCWx0oHI+MWgAQ7dSGUjr1mvrSKU
        B3tH/0Kxoyc3XVoEAz+RMxcZqWnS
X-Google-Smtp-Source: AAOMgpc1AYKrKShRlpyd8XNlmXkqr50riNPhXI1uk2+DAVVgSg90X+54H8ynJTVr0+JlGxPHrpHVzg==
X-Received: by 2002:a24:6fd3:: with SMTP id x202-v6mr9232951itb.71.1530902370217;
        Fri, 06 Jul 2018 11:39:30 -0700 (PDT)
Received: from cisco.lan ([8.24.24.129])
        by smtp.gmail.com with ESMTPSA id i15-v6sm4263845ioh.80.2018.07.06.11.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 11:39:29 -0700 (PDT)
Date:   Fri, 6 Jul 2018 12:39:28 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3] uart: fix race between uart_put_char() and
 uart_shutdown()
Message-ID: <20180706183928.GA3583@cisco.lan>
References: <20180706143919.GA2344@kroah.com>
 <20180706162457.20489-1-tycho@tycho.ws>
 <CAHp75Vfbh5SzpqP=2LfeXteEGrBG46dPfeHsU0ac5SiJSjZOXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vfbh5SzpqP=2LfeXteEGrBG46dPfeHsU0ac5SiJSjZOXw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:49:09PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 6, 2018 at 7:24 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> 
> > Looking in uart_port_startup(), it seems that circ->buf (state->xmit.buf)
> > protected by the "per-port mutex", which based on uart_port_check() is
> > state->port.mutex. Indeed, the lock acquired in uart_put_char() is
> > uport->lock, i.e. not the same lock.
> >
> > Anyway, since the lock is not acquired, if uart_shutdown() is called, the
> > last chunk of that function may release state->xmit.buf before its assigned
> > to null, and cause the race above.
> >
> > To fix it, let's lock uport->lock when allocating/deallocating
> > state->xmit.buf in addition to the per-port mutex.
> 
> Thanks for fixing this!
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Some nitpicks though.
> 
> > +       unsigned long page, flags = 0;
> 
> I would rather put on separate lines and btw assignment is not needed.
> It all goes through macros.

Sure, I can split it up, but without the initialization I get,

  CC      drivers/tty/serial/serial_core.o
In file included from ./include/linux/seqlock.h:36:0,
                 from ./include/linux/time.h:6,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:10,
                 from drivers/tty/serial/serial_core.c:10:
drivers/tty/serial/serial_core.c: In function ‘uart_startup.part.20’:
./include/linux/spinlock.h:260:3: warning: ‘flags’ may be used uninitialized in this function  -Wmaybe-uninitialized]
   _raw_spin_unlock_irqrestore(lock, flags); \
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/serial_core.c:184:22: note: ‘flags’ was declared here
  unsigned long page, flags;
                      ^~~~~

> > -       if (!state->xmit.buf) {
> > -               /* This is protected by the per port mutex */
> > -               page = get_zeroed_page(GFP_KERNEL);
> > -               if (!page)
> > -                       return -ENOMEM;
> > +       page = get_zeroed_page(GFP_KERNEL);
> > +       if (!page)
> > +               return -ENOMEM;
> > +       if (!state->xmit.buf) {
> >                 state->xmit.buf = (unsigned char *) page;
> >                 uart_circ_clear(&state->xmit);
> > +       } else {
> > +               free_page(page);
> >         }
> 
> I see original code, but since you are adding else, does it make sense
> to switch to positive condition?

Sure, I'll switch it.

> > +       unsigned long flags = 0;
> 
> Ditto about assignment.

And in this case too,

drivers/tty/serial/serial_core.c:184:22: note: ‘flags’ was declared here
  unsigned long page, flags;
                      ^~~~~
In file included from ./include/linux/seqlock.h:36:0,
                 from ./include/linux/time.h:6,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:10,
                 from drivers/tty/serial/serial_core.c:10:
drivers/tty/serial/serial_core.c: In function ‘uart_shutdown’:
./include/linux/spinlock.h:260:3: warning: ‘flags’ may be used uninitialized in this function  -Wmaybe-uninitialized]
   _raw_spin_unlock_irqrestore(lock, flags); \
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/serial_core.c:269:16: note: ‘flags’ was declared here
  unsigned long flags;
                ^~~~~

Tycho
