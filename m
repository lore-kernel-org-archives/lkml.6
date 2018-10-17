Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596B3ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE542150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8e4fy8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE542150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeJQTMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:12:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41086 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeJQTMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:12:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id m77-v6so13044187pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Fnui3J9Mw3d/jPUyzNryp7ca7wKy5LtfhZ5CfPEzzM=;
        b=W8e4fy8xsJmKfIjqWOmyhcDETP+f1b+BHQxgQ/kuavzLEc4MIeQkSk9aYCrwhbyquq
         8PYn0J1LS3+adxkduv2kz5HeMpVfOEeh2+SsMySucijJcfCoIM8wTgsU/WBZOEKo9c4W
         bdBFbQbZob/oUni4E1JKMXz1G8yFuBVLkPufIwg9Lt8VYfv0S2Jk+0DXHrI0hsNuL3SN
         5kspcBeLjh521ESZQ9OqYTIPGdUR9InQDdC5db1b8RQUV07jtg+Adruk1HtaF9UGzpjR
         JuQc1KcviEXsGCBBHv+rYEqEIkIwJB7pX5PexRPnIsYRSsvwGFIlvM8jUcBThNGIuaav
         7R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Fnui3J9Mw3d/jPUyzNryp7ca7wKy5LtfhZ5CfPEzzM=;
        b=qwQV/ZJVr5BBA7an1wx76/2mOYIwzsybtAdJEm8Pt34sXb5oXDBmAgP5j7UdRPyZZp
         TehDDWSrS1ja9HyVbZjn3RnP5K+GWpdVHxtvsjPpKMAdg7Ir2/G910QZYDey2gStca5M
         g6KgI4wDULZ/sv8hnt3Anz6171RiSiFnIr/8Q76Js8ms65VrH4m9E6z7xyV9VRR2BFHK
         wnkek38RDZDBQUR3tiC1PXHak+/b256IrRE97iHDf5al2tpthCzcI6Ok6e5R6EhIw5SH
         L0+ZISEPcciGu6Zexu+xXUcE5dcNPzo33LUY7LHQWjExfEo5ivKdsarTVRUUzesajHcT
         x+Sw==
X-Gm-Message-State: ABuFfohIFMesTd8LuKhblJ4mmaRuFMogQ2jmz5uLTt8R+IKp2T5OvkTb
        vSlAGSQadPz/f5B+rLgxegYBU5pG
X-Google-Smtp-Source: ACcGV62Z7peDMDtGWrxvE/hs7O+zSa0iN6T4LvgRfwWPkPQ1DnyM4LaGltt+FJYXSxuI8ay5mnnHFw==
X-Received: by 2002:a63:a42:: with SMTP id z2-v6mr23544723pgk.209.1539775049917;
        Wed, 17 Oct 2018 04:17:29 -0700 (PDT)
Received: from localhost ([110.70.53.52])
        by smtp.gmail.com with ESMTPSA id o9-v6sm23536219pgn.30.2018.10.17.04.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 04:17:28 -0700 (PDT)
Date:   Wed, 17 Oct 2018 20:17:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no
 eligible task.
Message-ID: <20181017111724.GA459@jagdpanzerIV>
References: <1539770782-3343-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181017102821.GM18839@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017102821.GM18839@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/17/18 12:28), Michal Hocko wrote:
> > Michal proposed ratelimiting dump_header() [2]. But I don't think that
> > that patch is appropriate because that patch does not ratelimit
> > 
> >   "%s invoked oom-killer: gfp_mask=%#x(%pGg), nodemask=%*pbl, order=%d, oom_score_adj=%hd\n"
> >   "Out of memory and no killable processes...\n"
[..]
> > Let's make sure that next dump_header() waits for at least 60 seconds from
> > previous "Out of memory and no killable processes..." message.
> 
> Could you explain why this is any better than using a well established
> ratelimit approach?

Tetsuo, let's use a well established rate-limit approach both in
dump_hedaer() and out_of_memory(). I actually was under impression
that Michal added rate-limiting to both of these functions.

The appropriate rate-limit value looks like something that printk()
should know and be able to tell to the rest of the kernel. I don't
think that middle ground will ever be found elsewhere.


printk() knows what consoles are registered, and printk() also knows
(sometimes) what console="..." options the kernel was provided with.
If baud rates ware not provided as console= options, then serial
consoles usually use some default value. We can probably ask consoles.

So *maybe* we can do something like this

//
// WARNING: this is just a sketch. A silly idea.
//          I don't know if we can make it usable.
//

---

int printk_ratelimit_interval(void)
{
       int ret = DEFAULT_RATELIMIT_INTERVAL;
       struct tty_driver *driver = NULL;
       speed_t min_baud = MAX_INT;

       console_lock();
       for_each_console(c) {
               speed_t br;

               if (!c->device)
                       continue;
               if (!(c->flags & CON_ENABLED))
                       continue;
               if (!c->write)
                       continue;
               driver = c->device(c, index);
               if (!driver)
                       continue;

               br = tty_get_baud_rate(tty_driver to tty_struct [???]);
               min_baud = min(min_baud, br);
       }
       console_unlock();

       switch (min_baud) {
       case 115200:
               return ret;

       case ...blah blah...:
               return ret * 2;

       case 9600:
               return ret * 4;
       }
       return ret;
}

---

	-ss
