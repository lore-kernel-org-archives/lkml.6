Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FFDC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E6221725
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmLe1pRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E6221725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeHHM7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:59:53 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36648 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbeHHM7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:59:52 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so862562plb.3;
        Wed, 08 Aug 2018 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k6K+nIoUbB83TGdr0CeIi0FM/px8QlHt/X78oIJnFKU=;
        b=pmLe1pRDeg0whNHCkmPpcZu2qglH3hGqlpVSRn1CdCbhn5XyMt5gYMkn2egtzr5dlz
         JXAQKpLygJdKd3X5+Br3m7ZwXBSZ4BfBQ9r9lF81H214zduZN7V0ZDS0yQ0nsqNJdTOx
         Ys5TUFcWXDcJ4ogzkndSKjgCWzRZp5qyvbY6XQM+2rzbelCM4ZqvN1/iaIgc8zQC35u2
         Ku2UXbbklsoeK9Ya/FxX+UMmk2/NeH3eRX5Hh8eV4SWM3j5+8hqU+lG+6YtDU3JrPbYY
         q32jDc06/1gwtOd8Iwl04S5JuDfjQUosYpeUdj/+KKf+lSqcOovByOZ7k6OiYhyQ8MCh
         tY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k6K+nIoUbB83TGdr0CeIi0FM/px8QlHt/X78oIJnFKU=;
        b=kb09AZW/yZclvbDYP72bcI4Dt2yU1nW/TIb8ghVMlLus4K6ekAnnm/0fh2OlOC8g9y
         +zu/GoxpsG9op30qIDjvvnD2GdsvVX05EYExDTr+z/ToFRiZAtAyyinKupJZVr4pjorO
         /ZHnQcGXe80LWC0DWS6LFFigoAVfIuh3+GQaZ8hWPLwh4GCw7WYarJQJWkVvcPVjMX8I
         S/Rtsw3mvg++sE6Jr/xIjEczWw+lNTFPArL1jjzIUY6S0URll1a/hdX9bGJU5ydB4L/I
         1fVPW/xMHqtZLEVhC6y+D5wgIadqGxkRKZsHmXcX7N3fkpjX6KSF9pRLBmvEpHhwplc4
         8ITQ==
X-Gm-Message-State: AOUpUlFAEKHZpBMF0rt9ZwADuQR3CwT6tk2tq5yjCDNiLS0/0AxuWl4f
        YS9T8zgVrDZ2oLWzkvJN/UQ=
X-Google-Smtp-Source: AA+uWPwOUlbKNShLImp63yjYerE1ys3l8BQkH3+bYb8U6UfuPf12oGLpAVXae42YQYsK5c3zrUOpFQ==
X-Received: by 2002:a17:902:b709:: with SMTP id d9-v6mr2092976pls.138.1533724845650;
        Wed, 08 Aug 2018 03:40:45 -0700 (PDT)
Received: from localhost ([175.223.10.126])
        by smtp.gmail.com with ESMTPSA id s3-v6sm12929080pgj.84.2018.08.08.03.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 03:40:44 -0700 (PDT)
Date:   Wed, 8 Aug 2018 19:40:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [4.18 rc7] BUG: sleeping function called from invalid context at
 mm/slab.h:421
Message-ID: <20180808104041.GA873@jagdpanzerIV>
References: <CABXGCsNAjrwat-Fv6GQXq8uSC6uj=ke87RJt42syrfFi0vQUmg@mail.gmail.com>
 <bd7f3ea4-d9a8-e437-9936-ee4513b47ac1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd7f3ea4-d9a8-e437-9936-ee4513b47ac1@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On (08/08/18 11:01), Vlastimil Babka wrote:
> On 08/08/2018 05:50 AM, Mikhail Gavrilov wrote:
> > Hi guys.
> > I am catched new bug.
> > Can anyone look?
> 
> fbcon_startup() calls kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL) so
> it tells slab it can sleep. The problem must be higher in the stack,
> CCing printk people.

Cc-ing fbcon/vt people. I'm not sure I know how exactly console
takeover is expected to work.

printk must be atomic, we can't sleep in console drivers [e.g. printk
from IRQs, etc.]

> > [226995.988988] BUG: sleeping function called from invalid context at
> > mm/slab.h:421
> > [226995.988988] in_atomic(): 1, irqs_disabled(): 1, pid: 22658, name: gsd-rfkill
> > [226995.988989] INFO: lockdep is turned off.
> > [226995.988989] irq event stamp: 0
> > [226995.988990] hardirqs last  enabled at (0): [<0000000000000000>]
> >        (null)
> > [226995.988991] hardirqs last disabled at (0): [<ffffffffa00b6b4a>]
> > copy_process.part.32+0x72a/0x1e60
> > [226995.988991] softirqs last  enabled at (0): [<ffffffffa00b6b4a>]
> > copy_process.part.32+0x72a/0x1e60
> > [226995.988992] softirqs last disabled at (0): [<0000000000000000>]
> >        (null)
> > [226995.988993] CPU: 6 PID: 22658 Comm: gsd-rfkill Tainted: G        W
> >         4.18.0-0.rc7.git1.1.fc29.x86_64 #1
> > [226995.988993] Hardware name: Gigabyte Technology Co., Ltd.
> > Z87M-D3H/Z87M-D3H, BIOS F11 08/12/2014
> > [226995.988994] Call Trace:
> > [226995.988994]  dump_stack+0x85/0xc0
> > [226995.988995]  ___might_sleep.cold.72+0xac/0xbc
> > [226995.988995]  kmem_cache_alloc_trace+0x202/0x2f0
> > [226995.988996]  ? fbcon_startup+0xae/0x300
> > [226995.988996]  fbcon_startup+0xae/0x300
> > [226995.988997]  do_take_over_console+0x6d/0x180
> > [226995.988997]  do_fbcon_takeover+0x58/0xb0
> > [226995.988997]  fbcon_output_notifier.cold.35+0x5/0x23
> > [226995.988998]  notifier_call_chain+0x39/0x90
> > [226995.988999]  vt_console_print+0x363/0x420
> > [226995.988999]  console_unlock+0x422/0x610
> > [226995.988999]  vprintk_emit+0x268/0x540
> > [226995.989000]  printk+0x58/0x6f
> > [226995.989000]  rfkill_fop_release.cold.16+0xc/0x11 [rfkill]
> > [226995.989001]  __fput+0xc7/0x250
> > [226995.989001]  task_work_run+0xa1/0xd0
> > [226995.989002]  exit_to_usermode_loop+0xd8/0xe0
> > [226995.989002]  do_syscall_64+0x1df/0x1f0
> > [226995.989003]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

	-ss
