Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ABFECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A449B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="pCdt4cl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A449B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbeGTQW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:22:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42135 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbeGTQW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:22:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4-v6so10086335edp.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z7tq0VxI3qLTyTwXHfh/AHJgPhNR7j02PztW4shh4wc=;
        b=pCdt4cl83glxaqhN9iva6+D+BO7sQW97g5GQMyZ1Ki2qb7phu270sATOXLZLeyDkfy
         LGViTiHJAt2JxIxmIjTAa84MBp5ZVqpSlKowvOw3CwkmIqJMt1iC9Odh9NxNXl6k6sR/
         1i7pzAc0T1MWUqRASmywGgmC9mBvqr9KjhsEQMrymHT2KkQwRtMQ/fZeyK4BTMgRokak
         Xk6xG5ZmzGn5HdhKLGAsraP/rabGIP66pfTBTgeo1hzQAz4X79IqF/oMLliXiXdfUxXa
         ehNFgWcU7AUlvFG4/OzsN6c/PNzs9gwDinZGrZYL1Hip+iS8oa4RwDhYRTtyk3++w1/H
         DDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7tq0VxI3qLTyTwXHfh/AHJgPhNR7j02PztW4shh4wc=;
        b=C91EU8JDjVvw3DLOVklu4y4tt/QXvsaToYxSmO3J0ncuRbR//wcfzQYhYPHOyP9l5U
         Ango7+p7XEVbsebVIxU2q0KkII8/ktxV6PPmYdzNDGX2ldmca5RWAOcoNPb86KqVEFdJ
         ZvInM8Kr63HeVEnvYIprstNWP07a07Cn/0uUjw7B/CqkhngfliLDg57OLPjjGjrRsycQ
         GFhvy4/OEZOFO+N/4WpWObXQDy9NaP9dhWTGDZNr3SvXkoXRh/dfTHm8m09158nTGxuA
         9M5HV7yiUanveAOtcFwVTmz+B/bqLMvZgXxt2pJZTAMf9w7xhrJRSOI9dobH/mCjLCiB
         vEVw==
X-Gm-Message-State: AOUpUlEfuZRPR7ROSxv6p17e13ZW4xMvcDVvUdO6/mOVSJjzugXScJC2
        +pBS7uxwRCqQ9cyzNyYG1EJeOw==
X-Google-Smtp-Source: AAOMgpctOtodeWY3vnPg8u80IzEKV7UDTmch0igdoiZee5qbg00cvWRv5+rukloTmXK32dVFYJFW0w==
X-Received: by 2002:a50:fd93:: with SMTP id o19-v6mr3013510edt.73.1532100817944;
        Fri, 20 Jul 2018 08:33:37 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a53-v6sm2608357edd.35.2018.07.20.08.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:33:37 -0700 (PDT)
Message-ID: <1532100816.18720.44.camel@arista.com>
Subject: Re: [PATCHv3] lib/ratelimit: Lockless ratelimiting
From:   Dmitry Safonov <dima@arista.com>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Date:   Fri, 20 Jul 2018 16:33:36 +0100
In-Reply-To: <20180720150948.nv57fjmmrmo2r7rx@pathway.suse.cz>
References: <20180703225628.25684-1-dima@arista.com>
         <1531789154.18720.3.camel@arista.com>
         <CAHp75VdmQ1YLzWpYb7878zKOCCyOEicdLAtpohbmY2hL1h1RNg@mail.gmail.com>
         <20180720150948.nv57fjmmrmo2r7rx@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-20 at 17:09 +0200, Petr Mladek wrote:
> > > On Tue, 2018-07-03 at 23:56 +0100, Dmitry Safonov wrote:
> > > > Currently ratelimit_state is protected with spin_lock. If the
> > > > .lock
> > > > is
> > > > taken at the moment of ___ratelimit() call, the message is
> > > > suppressed
> > > > to
> > > > make ratelimiting robust.
> > > > 
> > > > That results in the following issue issue:
> > > >       CPU0                          CPU1
> > > > ------------------           ------------------
> > > > printk_ratelimit()           printk_ratelimit()
> > > >         |                             |
> > > >   try_spin_lock()              try_spin_lock()
> > > >         |                             |
> > > > time_is_before_jiffies()          return 0; // suppress
> > > > 
> > > > So, concurrent call of ___ratelimit() results in silently
> > > > suppressing
> > > > one of the messages, regardless if the limit is reached or not.
> > > > And rc->missed is not increased in such case so the issue is
> > > > covered
> > > > from user.
> > > > 
> > > > Convert ratelimiting to use atomic counters and drop spin_lock.
> > > > 
> > > > Note: That might be unexpected, but with the first interval of
> > > > messages
> > > > storm one can print up to burst*2 messages. So, it doesn't
> > > > guarantee
> > > > that in *any* interval amount of messages is lesser than burst.
> > > > But, that differs lightly from previous behavior where one can
> > > > start
> > > > burst=5 interval and print 4 messages on the last milliseconds
> > > > of
> > > > interval + new 5 messages from new interval (totally 9 messages
> > > > in
> > > > lesser than interval value):
> > > > 
> > > >    msg0              msg1-msg4 msg0-msg4
> > > >     |                     |       |
> > > >     |                     |       |
> > > >  |--o---------------------o-|-----o--------------------|--> (t)
> > > >                           <------->
> > > >                        Lesser than burst
> > > > 
> 
> I am a bit confused. Does this patch fix two problems?
> 
>    + Lost rc->missed update when try_spin_lock() fails
>    + printing up to burst*2 messages in a give interval

What I tried to solve here (maybe I could better point it in the commit
message): is the situation where ratelimit::burst haven't been hit yet
and there are calls for __ratelimit() from different CPUs.
So, neither of the messages should be suppressed, but as the spinlock
is taken already - one of them is dropped and even without updating
missed counter.

> It would make the review much easier if you split it into more
> patches and fix the problems separately.

Hmm, not really sure: the patch changes spinlock to atomics and I'm not
sure it make much sense to add atomics before removing the spinlock..

> Otherwise, it looks promissing...
> 
> Best Regards,
> Petr
> 
> PS: I have vacation the following two weeks. Anyway, please, CC me
> if you send any new version.

Surely, thanks for your attention to the patch (and time).

-- 
Thanks,
             Dmitry
