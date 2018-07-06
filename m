Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F24C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5364720849
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="cSq4j9Wo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5364720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932642AbeGFVW3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:22:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33158 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753450AbeGFVW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:22:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id k7-v6so5356577wrq.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=g6LV/wnd74MnZzb9hqd4HhtTQ4iuCUQ9nTdavrJywKs=;
        b=cSq4j9WoDG78sestEa6npSi3+s1IOjxb5sVrlkVxgAfHFo4NOSSN/t5QCvbgFZV5xO
         tKB8yN15SNqHUKR40Y48lYVkrb/ubgjwHfLrdep+ftWncY2/qaaTG3JasiygVys/DOvR
         lY8U3xKPQRaH6kR82UuKbt6rRYucVR9J4VCL5Q6xWJytFK+633V/Q4F8+T9kM4VwsS3n
         6kx8oxIKNGh1hVCk+wPJVsoMH1WnXoydvYofXITuczJghereENwcCKj4ACQnKzjUVyhj
         bkXEWG6DMxy73RknlN//sgUzERRQfNdRO1PAl4aXVnbX1trBWwxfRshfOiIPHFWGl1jQ
         tjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=g6LV/wnd74MnZzb9hqd4HhtTQ4iuCUQ9nTdavrJywKs=;
        b=cP1adKzVZkl7MyHKmuoz+Mcyd4Dl2B4+9CG/oJLLsf6mLA0EGghoXfsgp27Ao9zEku
         vCifRkTx6546T9l4jxC/b5PI5v3/muV+8rpGoTrN1EkC7cT0wMHr9sePnRPOkz/cpSof
         HCGeRO99UsCOZKP//XmsKlFMZtmBaV8HInPVwBLh0A+fHiHnNgJZAoc+TnJp6EZ3eNCc
         lAw4xhgZ+mSIZ0N24BbNW8w9G9aEZcls/dWMF+1mWauh/+AJo4LEmDHfjaVD0vq8TfQ9
         YIYCwwzUzmV6UGJpCNY55IVPYpTO1rrEb8uBPS4Pysf8HvSYcHjToqFqqRnGNgSLLoFV
         2/og==
X-Gm-Message-State: APt69E12xT13MgRui5Pn2WjFL00mEMz8THG5KyhPfctA/WO6c+AmZTQs
        ZCgwOCY9QaPun5QaK4ahFedqAQ==
X-Google-Smtp-Source: AAOMgpe93C6QWOEYMduJLtj9efzsfpntXa2x5iY8JbRdqwYRAXZ20xCMuOc1TB8fp3ghyrmiG4VUzw==
X-Received: by 2002:a5d:5641:: with SMTP id j1-v6mr8973966wrw.209.1530912145602;
        Fri, 06 Jul 2018 14:22:25 -0700 (PDT)
Received: from cisco.lan ([173.38.220.56])
        by smtp.gmail.com with ESMTPSA id j12-v6sm3315758wrn.29.2018.07.06.14.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:22:24 -0700 (PDT)
Date:   Fri, 6 Jul 2018 15:22:20 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3] uart: fix race between uart_put_char() and
 uart_shutdown()
Message-ID: <20180706212220.GC3583@cisco.lan>
References: <20180706143919.GA2344@kroah.com>
 <20180706162457.20489-1-tycho@tycho.ws>
 <CAHp75Vfbh5SzpqP=2LfeXteEGrBG46dPfeHsU0ac5SiJSjZOXw@mail.gmail.com>
 <20180706183928.GA3583@cisco.lan>
 <CAHp75VeAoL9aN4pX4G9WGPS4Oxi=G6PyF7qCCyZ1fNH=gKHYiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeAoL9aN4pX4G9WGPS4Oxi=G6PyF7qCCyZ1fNH=gKHYiw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:48:58PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 6, 2018 at 9:39 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > On Fri, Jul 06, 2018 at 07:49:09PM +0300, Andy Shevchenko wrote:
> >> On Fri, Jul 6, 2018 at 7:24 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> 
> >  but without the initialization I get,
> >
> >   CC      drivers/tty/serial/serial_core.o
> > In file included from ./include/linux/seqlock.h:36:0,
> >                  from ./include/linux/time.h:6,
> >                  from ./include/linux/stat.h:19,
> >                  from ./include/linux/module.h:10,
> >                  from drivers/tty/serial/serial_core.c:10:
> > drivers/tty/serial/serial_core.c: In function ‘uart_startup.part.20’:
> > ./include/linux/spinlock.h:260:3: warning: ‘flags’ may be used uninitialized in this function  -Wmaybe-uninitialized]
> >    _raw_spin_unlock_irqrestore(lock, flags); \
> >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/tty/serial/serial_core.c:184:22: note: ‘flags’ was declared here
> >   unsigned long page, flags;
> >                       ^~~~~
> 
> Hmm... I didn't see such warning. How you run make?

Just with `make`, although using the specific object file works too.
Perhaps it's gcc versions?

~/packages/linux uart-fix-v4 make drivers/tty/serial/serial_core.o
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
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
~/packages/linux uart-fix-v4 gcc --version
gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

> Btw, you adding the only places with such assignments in this file.
> So, I would not do in your case, until entire file would be fixed.
> 
> (But warning looks bogus, or you have some patches on top of current
> vanilla / next)

I don't have any patches, but I do admit to not thinking about it very hard and
adding initializations. I'll see if I can figure out what's going on.

Thanks,

Tycho
