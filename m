Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31843C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0FD208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmA8XyQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0FD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJSH5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:57:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43399 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeJSH5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:57:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id d8-v6so3708032pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DO/fVzbSSZNaWKyG4aluGth9amjXj6x4RBOrXvQ4rZ0=;
        b=TmA8XyQ+v4dMRzEH8Jsl37R0O7Qlx5G26yvmHDv6fvMPYKitXzKW8qsR6PV/h5lvaC
         MUuer2jVKgJg2WnChYLDqhBXJ2srm5jEHLdW7iu71VkJk23ekRDfjmEkx6AgFilTboj1
         LcXhgGnXrTNXcCSBUp2E1LDMM/kwtHS7TjFaVXNehxaZ4kIO27rlhQZ2TpOnKkw8YqcW
         HkgnrtPy0f9ljfLrqYlM8M3vwE0KDrQvZpEJ9pKEu6Cm96TwFd9wCiRfPnFlS0sv5S/D
         8SNwhLmlk4m/45G3x03/H+ZQdL2IH/fJnSDELEZxGbpihikGqj4QFcdgChq/aFbZxr2A
         CQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DO/fVzbSSZNaWKyG4aluGth9amjXj6x4RBOrXvQ4rZ0=;
        b=PeAJqpj5pyS5s+gEm6EI1x9nWEjgjl8wP85VEMWO052DT5YjcPFDSCZ1Al3STXWqTS
         cSLBeOcMApn8oO0wCoqqQC/kltHAoUAj7n3grxIvbYlB3+02nHJhcfxmqSw7rwyh63AM
         FLGvqDyBnr1212ngX5r4+aCqEFPgw6izeE4JA5PJvoZUSiMOgZanO51Ck+i6jUjdnFvt
         mZhJ3HKGqQHyqhOwWYyKLbsQxOfi4GscItveq/WWlC1Od+LdoosyrIYpSh35/mzfulue
         cuZPXd+5aQtD6EDpX1Ct6XOy+rc2zUfmKbMiHirzuKVQNSYjKKpMBOVRBb8pq1C6CkXy
         3pjw==
X-Gm-Message-State: ABuFfojXUTn+45rurq0xvno465MVj/FAhdrrY11RWNVOIGYXjZ8J+IBV
        J1q405PY3LAT2wMl1TSg1Ew=
X-Google-Smtp-Source: ACcGV609bfkckzukQBwg2Fsj9qy1Ta2+VQnkKfXww6/MB++1ApYRHyT8CIxA0cYPM1FO1L4WitfmDA==
X-Received: by 2002:a63:4e18:: with SMTP id c24-v6mr25718025pgb.6.1539906872625;
        Thu, 18 Oct 2018 16:54:32 -0700 (PDT)
Received: from localhost ([110.70.52.202])
        by smtp.gmail.com with ESMTPSA id y12-v6sm7388982pga.77.2018.10.18.16.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 16:54:31 -0700 (PDT)
Date:   Fri, 19 Oct 2018 08:54:27 +0900
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
Message-ID: <20181018235427.GA877@jagdpanzerIV>
References: <201810180246.w9I2koi3011358@www262.sakura.ne.jp>
 <20181018042739.GA650@jagdpanzerIV>
 <201810180526.w9I5QvVn032670@www262.sakura.ne.jp>
 <20181018061018.GB650@jagdpanzerIV>
 <20181018075611.GY18839@dhcp22.suse.cz>
 <20181018081352.GA438@jagdpanzerIV>
 <2c2b2820-e6f8-76c8-c431-18f60845b3ab@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c2b2820-e6f8-76c8-c431-18f60845b3ab@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/18/18 20:58), Tetsuo Handa wrote:
> > 
> > A knob might do.
> > As well as /proc/sys/kernel/printk tweaks, probably. One can even add
> > echo "a b c d" > /proc/sys/kernel/printk to .bashrc and adjust printk
> > console levels on login and rollback to old values in .bash_logout
> > May be.
> 
> That can work for only single login with root user case.
> Not everyone logs into console as root user.

Add sudo ;)

> It is pity that we can't send kernel messages to only selected consoles
> (e.g. all messages are sent to netconsole, but only critical messages are
> sent to local consoles).

OK, that's a fair point. There was a patch from FB, which would allow us
to set a log_level on per-console basis. So the noise goes to heav^W net
console; only critical stuff goes to the serial console (if I recall it
correctly). I'm not sure what happened to that patch, it was a while ago.
I'll try to find that out.

[..]
> That boils down to a "user interaction" problem.
> Not limiting
> 
>   "%s invoked oom-killer: gfp_mask=%#x(%pGg), nodemask=%*pbl, order=%d, oom_score_adj=%hd\n"
>   "Out of memory and no killable processes...\n"
> 
> is very annoying.
> 
> And I really can't understand why Michal thinks "handling this requirement" as
> "make the code more complex than necessary and squash different things together".

Michal is trying very hard to address the problem in a reasonable way.
The problem you are talking about is not MM specific. You can have a
faulty SCSI device, corrupted FS, and so and on.

	-ss
