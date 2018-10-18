Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3695C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7BF2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQXBT8eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7BF2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeJRM0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:26:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34167 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeJRM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:26:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id f18-v6so13725923plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 21:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5pfu05udHnH1V44TWBGSOex3asOJMVORE6XkaOCUrNs=;
        b=qQXBT8ehg/A075OXndPr3dC2Tf25O/lCZhV2n2CA2/G6LbyIEiYiRHG6KZmSbzU/Xr
         g6BSO9Fe/Ime2xIbsBeefd5KiGzJlU0tbc1cQGvvIf/I1oHx/scgd7qIqnBywxknRo2l
         I5P/IprjSswEFmil18KQsUCkNrKw19egcUkn3nupiHdToM+s48reHt3IVnupEbPHQEhg
         g8a+XjUuiBUazlravYvxfD5USC5jhCEMSqEPB4Nqa+WHg1EsHpx/KHZjEVcmh28fWGep
         U2htOBQjLpY4OfvOR2LQw2IUKx3/SVcfGdxiK4OvydGyTLQnVMpAODYV2fJUxudHLhfF
         p75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5pfu05udHnH1V44TWBGSOex3asOJMVORE6XkaOCUrNs=;
        b=p525yIW9bXFoADEsaF64IMZl0ck7rUwx9u7csYnTlwYf2bl0IfDKfMhiAYsCfDL8Lq
         u0tR7bJgRwgK9FAYwSXdkdPTPSnXg1Vo9cQDzY+OKORfXQQ3uXdcXn51KWIsst22s8QJ
         Gh/KgkqwH0veVjbL0Pc6Nn2XPEcUVCCgQYtyDjpvdzB2S4jdS8vK6fpNylDoNdGgGD2/
         Yj+ZV/a/c39UAWyeYkeVQGA3s5/Zk9FU/q7ssAq9oYKMMBf0C5+sC9FThczO2G/FXLPA
         K88M29c4CzHa5sFK14H0DB8MHIfkJTqBWoZJ2n50M1tPG1KIB4P7QBf2+NwcMWGAwqCx
         XQow==
X-Gm-Message-State: ABuFfojLUjlAn/3XeCsTqWbCBf8Dz4sgihn/qVhmqPw6T2TvaoiGbvU3
        CU2ad/WPqFL2ecnfSn3RLYI=
X-Google-Smtp-Source: ACcGV61z3MMXVMIALgwWWO0CpMEOfwLWIRPjNqTtfQLyfCavv7ss3jfCg9dxScRZjgiCon+Bybj9VQ==
X-Received: by 2002:a17:902:76c3:: with SMTP id j3-v6mr28840664plt.339.1539836864400;
        Wed, 17 Oct 2018 21:27:44 -0700 (PDT)
Received: from localhost ([175.223.3.251])
        by smtp.gmail.com with ESMTPSA id s85-v6sm28914670pfi.15.2018.10.17.21.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 21:27:43 -0700 (PDT)
Date:   Thu, 18 Oct 2018 13:27:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no
 eligible task.
Message-ID: <20181018042739.GA650@jagdpanzerIV>
References: <20181017102821.GM18839@dhcp22.suse.cz>
 <20181017111724.GA459@jagdpanzerIV>
 <201810180246.w9I2koi3011358@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810180246.w9I2koi3011358@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/18/18 11:46), Tetsuo Handa wrote:
> Sergey Senozhatsky wrote:
> > 
> > int printk_ratelimit_interval(void)
> > {
> >        int ret = DEFAULT_RATELIMIT_INTERVAL;
> >        struct tty_driver *driver = NULL;
> >        speed_t min_baud = MAX_INT;
> > 
> >        console_lock();
> >        for_each_console(c) {
> >                speed_t br;
> > 
> >                if (!c->device)
> >                        continue;
> >                if (!(c->flags & CON_ENABLED))
> >                        continue;
> >                if (!c->write)
> >                        continue;
> >                driver = c->device(c, index);
> >                if (!driver)
> >                        continue;
> > 
> >                br = tty_get_baud_rate(tty_driver to tty_struct [???]);
> >                min_baud = min(min_baud, br);
> >        }
> >        console_unlock();
> > 
> >        switch (min_baud) {
> >        case 115200:
> >                return ret;
> > 
> >        case ...blah blah...:
> >                return ret * 2;
> > 
> >        case 9600:
> >                return ret * 4;
> >        }
> >        return ret;
> > }
> 
> I don't think that baud rate is relevant. Writing to console messes up
> operations by console users. What matters is that we don't mess up consoles
> to the level (or frequency) where console users cannot do their operations.
> That is, interval between the last moment we wrote to a console and the
> first moment we will write to a console for the next time matters. Roughly
> speaking, remember the time stamp when we called call_console_drivers() for
> the last time, and compare with that stamp before trying to call a sort of
> ratelimited printk(). My patch is doing it using per call-site stamp recording.

To my personal taste, "baud rate of registered and enabled consoles"
approach is drastically more relevant than hard coded 10 * HZ or
60 * HZ magic numbers... But not in the form of that "min baud rate"
brain fart, which I have posted.

What I'd do:

-- Iterate over all registered and enabled serial consoles
-- Sum up all the baud rates
-- Calculate (*roughly*) how many bytes per second/minute/etc my
   call_console_driver() can push

        -- we actually don't even have to iterate all consoles. Just
	   add a baud rate in register_console() and sub baud rate
	   in unregister_console() of each console individually
	-- and have a static unsigned long in printk.c, which OOM
	   can use in rate-limit interval check

-- Leave all the noise behind: e.g. console_sem can be locked by
   a preempted fbcon, etc. It's out of my control; bad luck, there
   is nothing I can do about it.
-- Then I would, probably, take the most recent, say, 100 OOM
   reports, and calculate the *average* strlen() value
   (including \r and \n at the end of each line)

	(strlen(oom_report1) + ... + strlen(omm_report100)) / 100

   Then I'd try to reach an agreement with MM people that we will
   use this "average" oom_report_strlen() in ratelimit interval
   calculation. Yes, some reports will be longer, some shorter.

	Say, suppose...
	
	I have 2 consoles, and I can write 250 bytes per second.
	And average oom_report is 5000 bytes.
	Then I can print one oom_report every (5000 / 250) seconds
	in the *best* case. That's the optimistic baseline. There
	can be printk()-s from other CPUs, etc. etc. No one can
	predict those things.

	Note, how things change when I have just 1 console enabled.

	I have 1 console, and I can write 500 bytes per second.
	And average oom_report is 5000 bytes.
	Then I can print one oom_report every (5000 / 500) seconds
	in the *best* case.

Just my $0.02. Who knows, may be it's dumb and ugly.
I don't have a dog in this fight.

	-ss
