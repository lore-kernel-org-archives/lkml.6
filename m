Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DADC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1962070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJzY1uLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfAGTwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:52:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38608 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfAGTwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:52:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so2097760wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 11:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4E5IVL2GoplbevTO2WqBBnn7uJ9mULKzXA9/zrnqEVE=;
        b=DJzY1uLKLaAIyeaoSDQN8oMLSVkWmx7A0gS1CRSEtbdTiVqez3MRGy61iz2qMHkl5W
         2yxN39dld4T9wCryw7sqQQ25cLDEQ2jHfxuvF8H4C5C9QhvFGlPg75v32URela+cMMyw
         +3+akTL92QwszwaeINwWUmCOTDKSaGBhH1p76ZwimIQm+oUSSFzp7j5GNhey0kr/pFws
         nmlGJUQcD/DPB/FW6Z+rCMWbzsN+YBme2zLr0VERfmc2tRKv75U5GJJjg4RW/+JWaxz7
         Euc1II3rpai5SRYMuNbWSq7w68J6rKXdSTs4N5FvhO+U+/FnowzjGF6pSDIRj0MJAO1l
         gTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4E5IVL2GoplbevTO2WqBBnn7uJ9mULKzXA9/zrnqEVE=;
        b=aGuKYoqXllXLEkr3/RZGqJ4a34YhgPgfrl/WdySwZbeyUnaCYIDz1PW/TEA11tj4P4
         0JTTbwyhU0yoj+DqcgjeRmaizNo8rbLF3SpVG1hCQp3kOnHFcf730yGn/Q3dyQ1QyF79
         FbbX8K/MYEV5oc93ptYyp6Nnf2RGAlwaHjCeqU7sqfyE9IIDDXRA7LSHGNHGIvdqoA3x
         E/KMuIn6OK2dy0zBAs4U5m26m26b8Zhed8bX+sBDomptMk/HtZQllPeF40yXTYFLPg9f
         SLFg3eor0QNxytguNm04gxn/HuMLmbWktbA7tVN7y84G2X9Bsjl3Fvv9tlA2DyzdH8a+
         DVRA==
X-Gm-Message-State: AJcUukfgnRo5hoBym8SI6v6YnytDLo5BHpmFJa/tXWxShddacSpgtGOy
        v6ufW6OKzSjd+WGsHrSkLg==
X-Google-Smtp-Source: ALg8bN63S7+Rgf2lcQlpejA5c9FgzfR4k4CA3oNlPwnaTHk+I6sXElPUmoBfYtGDLmQ0BxV/ZSBl6w==
X-Received: by 2002:a1c:1cf:: with SMTP id 198mr9399494wmb.5.1546890730503;
        Mon, 07 Jan 2019 11:52:10 -0800 (PST)
Received: from localhost (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id e17sm82221707wri.36.2019.01.07.11.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 11:52:09 -0800 (PST)
Date:   Mon, 7 Jan 2019 20:52:09 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kprobes: Fix kretprobe incorrect stacking order
 problem
Message-ID: <20190107195209.GB5966@xps-13>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
 <20190107183444.GA5966@xps-13>
 <20190107142749.34231bb6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107142749.34231bb6@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:27:49PM -0500, Steven Rostedt wrote:
> On Mon, 7 Jan 2019 19:34:44 +0100
> Andrea Righi <righi.andrea@gmail.com> wrote:
> 
> > On Mon, Jan 07, 2019 at 10:31:34PM +0900, Masami Hiramatsu wrote:
> > ...
> > > BTW, this is not all of issues. To remove CONFIG_KPROBE_EVENTS_ON_NOTRACE
> > > I'm trying to find out other notrace functions which can cause
> > > kernel crash by probing. Mostly done on x86, so I'll post it
> > > after this series.  
> > 
> > Not sure if you found it already, but it looks like some of the
> > _raw_spin_lock/unlock* functions (when they're not inlined) are causing
> > the same problem (or something similar), I can deadlock the system by
> > doing this for example:
> > 
> >  echo "r:event_1 __fdget" >> kprobe_events
> >  echo "r:event_2 _raw_spin_lock_irqsave" >> kprobe_events
> >  echo 1 > events/kprobes/enable
> >  [DEADLOCK]
> > 
> > Sending the following just in case...
> >
> 
> Ug, kretprobe calls spinlocks in the callback? I wonder if we can
> remove them.
> 
> I'm guessing this is a different issue than the one that this patch
> fixes. This sounds like we are calling kretprobe from kretprobe?
> 
> -- Steve

kretprobe_trampoline()
  -> trampoline_handler()
    -> kretprobe_hash_lock()
      -> raw_spin_lock_irqsave()

If we put a kretprobe to raw_spin_lock_irqsave() it looks like
kretprobe is going to call kretprobe...

-Andrea
