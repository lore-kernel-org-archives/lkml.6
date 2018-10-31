Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B70FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D249720821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnur5nrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D249720821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbeKABZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:25:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33904 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeKABZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:25:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id k1-v6so6202246pgq.1;
        Wed, 31 Oct 2018 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tjScDnCkVYgtVc9va2dtzEbLAtOhqWoRkPUVl2J9p5Y=;
        b=jnur5nrDRl3mpJ15jQCJDR8muXAqxaAQQNtubcMdFPCMP1gXnJTVKT1r6KO7cScy24
         kL+I2GGaFwFlSjRrpm4fP1G8sDqj+nHJtdgwFyGRqOdbKwRalSS6IH/BfVARhYT4VbQo
         WZUSJ56GXWBF2liKTRYKT3bLL92MPcBZQI+PoLK9fk07W+d4q+ekHtPPfD8QbNtAi7pi
         WqczxdScA4+4orn1c3d+86S+TdlM/j2y1pReAl3z4cKa0zftyjxvWCey5yPOucKOG+ym
         DziSK/PhAfVDG+uGD6rblb7SI+CL85hm4omE4Ofh7iaUrBU+eFxVrJE5SF0Vpu85ik8n
         6COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tjScDnCkVYgtVc9va2dtzEbLAtOhqWoRkPUVl2J9p5Y=;
        b=pqP6RtvcZxAWYMNIkLz++43JiQ72LA2phW9ruJHQ/wPUwWpdY7gxZbZ2NAvqxAx34Z
         5ppSzqgpyHc7K0kgWjGhw1gz0mEoTIlIfO/j4wii3cRP6lLjF7My7hTSeSM8ZDa1ChYJ
         7L252bmY+QraxUe4PwIndhoCwLAdzC35bvtjsS46yBHpKA0xipHYsTou4BLPkkXijTQC
         JPRelt76iPfF32pGetUCpI3X11sA/YRoTFZgCBn6tpXcF2z7/0vzQwfMsbctqehdCG98
         /r0CLYCrcRSFbTTDzGLEtZY+D7MgALl8u0nUmvBQi/G+tMX+cFYMRfYJ2LGcyTRye2Bg
         vQyQ==
X-Gm-Message-State: AGRZ1gIZ9+PbhOpAbhOiyf5mFEByVkqbGX/mpQOoegmR6CxH0ZJf/TX3
        JCKNCo519r/riMoJmAK2q78=
X-Google-Smtp-Source: AJdET5dQQHD8F5EsIVv2vW42HaK7XJP94J8pv6hPeeONCOEoTSFHbYaZO6XKCb78A3Uo8gFZgu5XvQ==
X-Received: by 2002:a63:164d:: with SMTP id 13-v6mr3812640pgw.103.1541003216751;
        Wed, 31 Oct 2018 09:26:56 -0700 (PDT)
Received: from gmail.com ([2620:0:1008:fd00:78b4:3a07:980a:287b])
        by smtp.gmail.com with ESMTPSA id q76-v6sm59765465pfa.18.2018.10.31.09.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 09:26:56 -0700 (PDT)
Date:   Wed, 31 Oct 2018 09:26:53 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "criu@openvz.org" <criu@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 00/20] ns: Introduce Time Namespace
Message-ID: <20181031162650.GB26067@gmail.com>
References: <20180919205037.9574-1-dima@arista.com>
 <874lej6nny.fsf@xmission.com>
 <20180924205119.GA14833@outlook.office365.com>
 <874leezh8n.fsf@xmission.com>
 <20180925014150.GA6302@outlook.office365.com>
 <87zhw4rwiq.fsf@xmission.com>
 <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>
 <87mus1ftb9.fsf@xmission.com>
 <20181021014121.GA23474@gmail.com>
 <alpine.DEB.2.21.1810292026040.5984@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810292026040.5984@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 09:33:14PM +0100, Thomas Gleixner wrote:
> Andrei,
> 
> On Sat, 20 Oct 2018, Andrei Vagin wrote:
> > When a container is migrated to another host, we have to restore its
> > monotonic and boottime clocks, but we still expect that the container
> > will continue using the host real-time clock.
> > 
> > Before stating this series, I was thinking about this, I decided that
> > these cases can be solved independently. Probably, the full isolation of
> > the time sub-system will have much higher overhead than just offsets for
> > a few clocks. And the idea that isolation of the real-time clock should
> > be optional gives us another hint that offsets for monotonic and
> > boot-time clocks can be implemented independently.
> > 
> > Eric and Tomas, what do you think about this? If you agree that these
> > two cases can be implemented separately, what should we do with this
> > series to make it ready to be merged?
> > 
> > I know that we need to:
> > 
> > * look at device drivers that report timestamps in CLOCK_MONOTONIC base.
> 
> and CLOCK_BOOTTIME and that's quite a few.
> 
> > * forbid changing offsets after creating timers
> 
> There are more things to think about. What about interfaces which expose
> boot time or monotonic time in /proc?

We didn't find any proc files where boot or monotonic time is reported,
but we will double check this.

> 
> Aside of that (I finally came around to look at the series in more detail)
> I'm really unhappy about the unconditional overhead once the Time namespace
> config switch is enabled. This applies especially to the VDSO. We spent
> quite some time recently to squeeze a few cycles out of those functions and
> it would be a pity to pointlessly waste cycles for the !namespace case.

It is a good point. We will work on it.

> 
> I can see the urge for this, but please let us think it through properly
> before rushing anything in which we are going to regret once we want to do
> more sophisticated time domain management, e.g. support for isolated clock
> real time. I'm worried, that without a clear plan about the overall
> picture, we end up with duct tape which is hard to distangle after the
> fact.

Thomas, there is no rush at all. This functionality is critical for
CRUI, but we have enough time to solve it properly.

The only thing what I want is that this functionality continues moving
forward and will not be put in the back burner.

> 
> There have been a few other things brought up versus time management in
> general, like the TSN folks utilizing grand clock masters which expose
> random time instead of proper TAI. Plus some requirements for exposing some
> sort of 'monotonic' clocks which are derived from external synchronization
> mechanisms, but should not affect the regular time keeping clocks.
> 
> While different issues, these all fall into the category of separate time
> domains, so taking a step back to the drawing board is probably the best
> thing what we can do now.
> 
> There are certainly a few things which can be looked at independently,
> e.g. the VDSO mechanics or general mechanisms to avoid plastering the whole
> kernel with these name space functions applying offsets left and right. I
> rather have dedicated core functionality which replaces/amends existing
> timer functions to become time namespace aware.
> 
> I'll try to find some time in the next weeks to look deeper into that, but
> I can't promise anything before returning from LPC. Btw, LPC would be a
> great opportunity to discuss that. Are you and the other name space wizards
> there by any chance?

Dmitry and I are going to be there.

Thanks!
Andrei

> 
> Thanks,
> 
> 	tglx
> 
> 
