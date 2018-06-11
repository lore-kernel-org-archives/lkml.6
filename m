Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D7950C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8791C20660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAOfTVxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8791C20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934201AbeFKRVK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:21:10 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37151 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934102AbeFKRU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:20:56 -0400
Received: by mail-yw0-f194.google.com with SMTP id j190-v6so6568559ywe.4;
        Mon, 11 Jun 2018 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VVPhSHixEWhv8h5McR/3udtDxX6Z3plH1+G+1tS5m5Y=;
        b=YAOfTVxM5NiTtBvqvcOE+JMzwU5dAg51mEw+27RhLzR5JS24DE6Qjs941/aKsV8De/
         PG9EisM1iEVC1oewODh2xMO4o9KtoZavz74pY3DxUOaT7VaMkPf9R0ALMLyA5EuhXklP
         /QKsMa6ZIwnfeJsqdnrv4PjjtzStHeY/Z7MODetra2CouPjtBx5KuFDPTyk9tdDopllI
         IQSH9KoMK+jKeinOYz8yPX4qlMu2Fltk8PTNtWSDgmkyDItB6FK+M/gX4ahEG44tPJte
         5GFJ7d5YGjXTkX+auWupwL3bzETYcUSxXCb/L9uhtJljvLNWGI5JohnUazi8amQG8HYn
         L27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VVPhSHixEWhv8h5McR/3udtDxX6Z3plH1+G+1tS5m5Y=;
        b=JyZUYNSjMwagLwDa/ElXVBveZStVSJ0wZDDBs9o6kYxyEjkLRb/6g3brJ0b7jYSymt
         g/wYDWsP8RB0r6dC3pcuDkdTY9EKt+ww5ueGHflqwil4IU86Ps5X3ob65uOJ39thQ+y5
         sQL55Ym4dJCAozlem/70U6r5geYPWs6IVM9EOcV92Lk0mZcGTl9C/fv+/vlezCsHLMg8
         VCsMIjpvm4vThQr26plmAHl3AFqmd/7icUDk5n7/5wBddD88LkVA+9NJi9KHFNBtoy54
         sYXpwVKgttdY9oDxvRV26blMzqBM5Z45ziTqLN2UCKzD82Ew7hI0rGDRBac1mM6l5KXF
         THGw==
X-Gm-Message-State: APt69E3+xlTxuU2vBgw1QjblW1H4rhRQDfYCJQKQYlFYL0smxaA34OMy
        l6CBHm1MZLN+HtCidtBtlZE=
X-Google-Smtp-Source: ADUXVKJ2rxckf/J8vM+VrrQgJVKPkQGUNQbSg48YITY76MrlXoqztgzEMQqS4+nViBGFAt3w1qMmNA==
X-Received: by 2002:a0d:cd46:: with SMTP id p67-v6mr65305ywd.44.1528737656044;
        Mon, 11 Jun 2018 10:20:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::fd2a])
        by smtp.gmail.com with ESMTPSA id d22-v6sm30355809ywh.27.2018.06.11.10.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 10:20:54 -0700 (PDT)
Date:   Mon, 11 Jun 2018 10:20:53 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180611172053.GR1351649@devbig577.frc2.facebook.com>
References: <201806080231.w582VIRn021009@www262.sakura.ne.jp>
 <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jun 11, 2018 at 06:29:20PM +0200, Jan Kara wrote:
> > Would something like the following work or am I missing the point
> > entirely?
> 
> I was pondering the same solution for a while but I think it won't work.
> The problem is that e.g. wb_memcg_offline() could have already removed
> wb from the radix tree but it is still pending in bdi->wb_list
> (wb_shutdown() has not run yet) and so we'd drop reference we didn't get.

Yeah, right, so the root cause is that we're walking the wb_list while
holding lock and expecting the object to stay there even after lock is
released.  Hmm... we can use a mutex to synchronize the two
destruction paths.  It's not like they're hot paths anyway.

Thanks.

-- 
tejun
