Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1D5C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D969221479
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqLS8IfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D969221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJDPrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:47:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42746 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJDPrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:47:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so2835540pgq.9;
        Thu, 04 Oct 2018 01:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gh3ECq3VaZvkexK5JHWw6C3ee8+sG3qrVox2UXqj1oA=;
        b=iqLS8IfQrbqT9pqNRYkfPABUmMc0gSlYp4dXgsiAcdruf7C1Was4sx8hCnQWTbH7YF
         u6+DQW2hFPGlHSL2GTeXvzwQqbvibc+JaEG9xOb5TZJPpqdZ84rOleQqXLqld0Itgo16
         9j+aW9qGPy/F4hTa1LnQrq+CRDXpESeNZX0Ku2W1VW7nU8xH/auwz07YFERB7a718H8+
         N64ZHvgr6+9EjywdL2PLy81kLb1FRZ3pjCUpxz1l/VTxHYdapGJCihL/IEmK0xmPPOpa
         CxtXi3m2y6qJLrQFRflkUs+CG/Mr9Hd4o4NC8yVTKMPsdTCm6N7jgAi9ueOMu7HTHyle
         UldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gh3ECq3VaZvkexK5JHWw6C3ee8+sG3qrVox2UXqj1oA=;
        b=IHOCkIfUIVHit0LZecF/1xVZSMjCbLUSyJX17/YObENGLY7Flx3sUeNIsQ3EqzipgH
         0NIwFvSPdWAgLk1ZXWr1vfQx5Hhfqa1C/7VdM4hj0tgExu3RebTKzBdOgHXeOl9Pm1m1
         fxp3pj9xbAbMxdtkb1X2r679kemdXf8ySw8N9MtKBd+nBlGxFMo45yhg0ShkJMuZDRo7
         vRC4goxmvJC8NyKIHVhv5QFRo9HRRsAnmPP//fcHBhq1t15lMXFsQ9xb24BKt56uAqEw
         rmSu5NVh8/1+C8hT02da9m68KFCqDqz/QOTQ08nDKd9x2ygYrIHh0FY4Veub/Te+syhX
         YnAQ==
X-Gm-Message-State: ABuFfog7ySUhGe3dMfNHa3ZOoshB+/b91ZYEZv8av8kwy1ho1aQDWb2a
        7FOfc/YG3aI2RxpGgWhppac=
X-Google-Smtp-Source: ACcGV62ZkXqFN/02l/pfy/N7EexLdx5P/n7boU/EnOBmyMMHJu3JKeAJP+c3VusqePPCSiczTVNEuA==
X-Received: by 2002:a63:66c3:: with SMTP id a186-v6mr4868123pgc.330.1538643320704;
        Thu, 04 Oct 2018 01:55:20 -0700 (PDT)
Received: from localhost ([175.223.49.70])
        by smtp.gmail.com with ESMTPSA id f83-v6sm5888689pfa.109.2018.10.04.01.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 01:55:19 -0700 (PDT)
Date:   Thu, 4 Oct 2018 17:55:15 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Daniel Wang <wonderfly@google.com>, rostedt@goodmis.org,
        stable@vger.kernel.org, Alexander.Levin@microsoft.com,
        akpm@linux-foundation.org, byungchul.park@lge.com,
        dave.hansen@intel.com, hannes@cmpxchg.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        tj@kernel.org, torvalds@linux-foundation.org, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181004085515.GC12879@jagdpanzerIV>
References: <CAJmjG29Jwn_1E5zexcm8eXTG=cTWyEr1gjSfSAS2fueB_V0tfg@mail.gmail.com>
 <20181002084225.6z2b74qem3mywukx@pathway.suse.cz>
 <CAJmjG2-RrG5XKeW1-+rN3C=F6bZ-L3=YKhCiQ_muENDTzm_Ofg@mail.gmail.com>
 <20181002212327.7aab0b79@vmware.local.home>
 <20181003091400.rgdjpjeaoinnrysx@pathway.suse.cz>
 <CAJmjG2_4JFA=qL-d2Pb9umUEcPt9h13w-g40JQMbdKsZTRSZww@mail.gmail.com>
 <20181003133704.43a58cf5@gandalf.local.home>
 <CAJmjG291w2ZPRiAevSzxGNcuR6vTuqyk6z4SG3xRsbaQh5U3zQ@mail.gmail.com>
 <20181004074442.GA12879@jagdpanzerIV>
 <20181004083609.kcziz2ynwi2w7lcm@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004083609.kcziz2ynwi2w7lcm@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/04/18 10:36), Petr Mladek wrote:
> 
> This looks like a reasonable explanation of what is happening here.
> It also explains why the console owner logic helped.

Well, I'm still a bit puzzled, frankly speaking. I've two theories.

Theory #1 [most likely]

  Steven is a wizard and his code cures whatever problem we throw it at.

Theory #2

  console_sem hand over actually spreads print out, so we don't have one CPU
doing all the printing job. Instead every CPU prints its backtrace, while the
CPU which issued all_cpus_backtrace() waits for them. So all_cpus_backtrace()
still has to wait for NR_CPUS * strlen(bakctrace), which still probably
truggers NMI panic on it at some point. The panic CPU send out stop IPI, then
it waits for foreign CPUs to ACK stop IPI request - for 10 seconds. So each
CPU prints its backtrace, then ACK stop IPI. So when panic CPU proceeds with
flush_on_panic() and emergency_reboot() uart_port->lock is unlocked. Without
the patch we probably declare NMI panic on the CPU which does all the printing
work, and panic sometimes jumps in when that CPU is in busy in
serial8250_console_write(), holding the uart_port->lock. So we can't re-enter
the 8250 driver from panic CPU and we can't reboot the system. In other
words... Steven is a wizard.

> > serial8250_console_write()
> > {
> > 	if (port->sysrq)
> > 		locked = 0;
> > 	else if (oops_in_progress)
> > 		locked = spin_trylock_irqsave(&port->lock, flags);
> > 	else
> > 		spin_lock_irqsave(&port->lock, flags);
> > 
> > 	...
> > 	uart_console_write(port, s, count, serial8250_console_putchar);
> > 	...
> > 
> > 	if (locked)
> > 		spin_unlock_irqrestore(&port->lock, flags);
> > }
> > 
> > Now... the problem. A theory, in fact.
> > panic() sets oops_in_progress back to zero - bust_spinlocks(0) -  too soon.
> 
> I see your point. I am just a bit scared of this way. Ignoring locks
> is a dangerous and painful approach in general.

Well, I agree. But 8250 is not the only console which does ignore
uart_port lock state sometimes. Otherwise sysrq would be totally unreliable,
including emergency reboot. So it's sort of how it has been for quite some
time, I guess. We are in panic(), it's over, so we probably can ignore
uart_port->lock at this point.

	-ss
