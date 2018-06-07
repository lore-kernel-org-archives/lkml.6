Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hyG2NHSqGVv3KQAAmS7hNA
	; Thu, 07 Jun 2018 21:58:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BB9876089E; Thu,  7 Jun 2018 21:58:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1TEc1af"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 347D760452;
	Thu,  7 Jun 2018 21:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 347D760452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeFGV6K (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:58:10 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44730 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbeFGV6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:58:08 -0400
Received: by mail-pf0-f194.google.com with SMTP id h12-v6so5562303pfk.11;
        Thu, 07 Jun 2018 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qHgaPTzqqxL25OcwUVkVLEymw1c9neFhJVm2QjhMxGk=;
        b=H1TEc1afsch+QW1422J6JnEYHq56l8y30mOAp5vXNLYfVKolAKRCyC8v9MqhLyeXAr
         xCx4gpC2+llxSN2xk3jP5u61173Rj/vDLxd9eLjY3YfgEDTRofwCf5pxTBoy6aXnw6//
         QVdkqwu0UmzjWe9QSONkJcFoizqJ70RZBIn7U876GZWnUwlaWbp9xqHctEypMyWJAdS+
         WZ6VQ98yI9ayIFLzwdhpSzVvtKBVCBqHCrYxl2OsU5GmmXiUVbEhhC8fJ/3NSp48cgbQ
         9LhxsYW9rNbWxlAC8TcG0sB7GEDNZdbhpY4WvuJLpxyJd6G2xFYx3WLkuSABeYVZDGFu
         bi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qHgaPTzqqxL25OcwUVkVLEymw1c9neFhJVm2QjhMxGk=;
        b=DcNglNZsp7/uEaUNaO3mS5Cihx41tsuy96puTTBYsUbYgcEUWj8tb3PynhjbA1g2WJ
         190brC8PfzgKWVAntkqj7x0ZuB/lSo2HMwVzNc+/hXYjuVYki3L6V4M+/NwBDnsWO3il
         muyH3keK6fT7cG31PVP/HXtw+TLmyU8Y2rGlQimpnuOSPLTcvTjglHlNGkANNRC51bgZ
         TrPOL47gU05+oVFjqA6DZIxlvAQmJQC1KPfmzXttbx/4MOQTvdwDnERp0gIyg8ndDKDQ
         hvW8DllMiH75PhTnp6JqUwsxxYh/1MA8/Ta2x68CyhXyPq/3Eo+34c0rx3pfwQPQb57q
         TF4g==
X-Gm-Message-State: APt69E0wfQLPn97EtwR77bsu4xLgd587bvWclJuHOp8rmjUbkPKkWH5c
        JjH7LB0JhlNDV7Ndsw/eylk=
X-Google-Smtp-Source: ADUXVKKBhI3dfYTvY2jJXuGa+6GdOldPDYmf1fNHVNXDSVrXLwELyLcGRWZW+EP6rxD5Fh8hnfunlQ==
X-Received: by 2002:a65:5c89:: with SMTP id a9-v6mr2924409pgt.51.1528408687709;
        Thu, 07 Jun 2018 14:58:07 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::1:3bc6])
        by smtp.gmail.com with ESMTPSA id m12-v6sm7748083pgp.88.2018.06.07.14.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 14:58:06 -0700 (PDT)
Date: Thu, 7 Jun 2018 14:58:04 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: syzbot <syzbot+7ade6c94abb2774c0fee@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: general protection fault in __vfs_write
Message-ID: <20180607215759.5jt2rin652xnrk3h@ast-mbp>
References: <000000000000973c2c056e0ecddd@google.com>
 <20180607152846.GB27079@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607152846.GB27079@bombadil.infradead.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 08:28:46AM -0700, Matthew Wilcox wrote:
> 
> I would suggest this is a BPF problem, not a VFS problem.
> 
> On Thu, Jun 07, 2018 at 08:19:01AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    7170e6045a6a strparser: Add __strp_unpause and use it in k..
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14bde74f800000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a601a80fec461d44
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7ade6c94abb2774c0fee
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+7ade6c94abb2774c0fee@syzkaller.appspotmail.com
> > 
> > bpfilter: read fail -512
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] SMP KASAN
> > Dumping ftrace buffer:
> >    (ftrace buffer empty)
> > Modules linked in:
> > CPU: 1 PID: 4590 Comm: syz-executor7 Not tainted 4.17.0-rc7+ #82
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > RIP: 0010:file_write_hint include/linux/fs.h:1925 [inline]
> > RIP: 0010:init_sync_kiocb include/linux/fs.h:1935 [inline]
> > RIP: 0010:new_sync_write fs/read_write.c:470 [inline]
> > RIP: 0010:__vfs_write+0x4a6/0x960 fs/read_write.c:487
> > RSP: 0018:ffff88019b5c7850 EFLAGS: 00010202
> > RAX: dffffc0000000000 RBX: ffff8801d2117c80 RCX: ffffffff81bfc6bb
> > RDX: 0000000000000019 RSI: ffffffff81bfc6ca RDI: 00000000000000c8
> > RBP: ffff88019b5c79c8 R08: ffff88019b5ba540 R09: fffffbfff12cae69
> > R10: ffff88019b5c7a10 R11: ffffffff8965734b R12: 0000000000000000
> > R13: ffff88019b5c79a0 R14: 0000000000000000 R15: ffff88019b5c7a88
> > FS:  0000000002a11940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000700138 CR3: 000000019b410000 CR4: 00000000001406e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  __kernel_write+0x10c/0x380 fs/read_write.c:506
> >  __bpfilter_process_sockopt+0x1d8/0x35b net/bpfilter/bpfilter_kern.c:66

I think I see the problem. Will send the fix soon.
