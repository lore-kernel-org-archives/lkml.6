Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A52C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A71F20871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcx4sEOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A71F20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbeFTLTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:19:43 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33754 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeFTLTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:19:41 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so1614397plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7L79PgrVQrsNXsPnNgVGXh5KwH2F2N+9XGWmUwwPtJI=;
        b=vcx4sEOZYhgTpG0rthlcphJPpmjWjyzURYtEHMvXviu54R+ExkKKSW/5dLK4iUWb2B
         vHmT8GCDPUAXv25lJ6PYbFhIOpmUZkir+rXO/tKURTVqqzjVbBcZv56WLCbCe4+qGPKF
         sTTbZqclZynhttwq7TXRGIZbFTcq9t5rWzAjE89Xtjb0kU2SL09qfJHFQR5iGqwAZb/s
         KLbx5yipO/K7ALtURwhILTKQit8UmFuzssSEq4Aou/YJCx/PlBxCmURF7x1U2x94qMrm
         qQxJFKQORyTY8pi2al4YUxmJu/gpcxEqTscfocZcqUnU05gBHoyW49NCiV7qSbsOWx7l
         7WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7L79PgrVQrsNXsPnNgVGXh5KwH2F2N+9XGWmUwwPtJI=;
        b=giWI/1N6IqAhHOrljBZMIYRqmgAu/Ljv8TMk1fHHMbO9fo22QPViOUSELsdyypBKKx
         cDZBCIvJvdpp14Vtot2yGVMMUxw6nit+8nA5hK2Qxtx/uL8NOHPqc3IEw9NUiiqnMOTm
         bbTGbjzr/aZ+ndYAkaMh0L2DZ+Do+PanOhBSpuKIlg5mIoec+zR/LS4wEaLvO20kXRlL
         iIzftu5AloYj9do5wFN559N0T4KZvzm+1oBBuRw6hlyl04SH9Xjq2y4WsGLmr93AcL6D
         UIDDvFXps3ONITkcXUcYP8g8WbwR9S1VSHv+3CSKIoob+VTIfc3ONQ/iw/B82iwT3ChW
         pvSA==
X-Gm-Message-State: APt69E2yagGnyk62vYVCLjGGAc0v81Q62nHmS2C5iTrbBDiUc5jZMNQt
        6+ez9fpb0hHMTbg2ym4tcFs=
X-Google-Smtp-Source: ADUXVKK7vDxQFx1c/Gvy5U63wF2Myoz88oRpiR/XQP5z9pZ0BYecLqcHJ0J7T3cDdngNCahcXo3mpw==
X-Received: by 2002:a17:902:e187:: with SMTP id cd7-v6mr23564061plb.166.1529493581290;
        Wed, 20 Jun 2018 04:19:41 -0700 (PDT)
Received: from localhost ([110.70.59.159])
        by smtp.gmail.com with ESMTPSA id t6-v6sm2570540pgp.3.2018.06.20.04.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 04:19:39 -0700 (PDT)
Date:   Wed, 20 Jun 2018 20:19:36 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180620111936.GE444@jagdpanzerIV>
References: <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV>
 <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <20180524021451.GA23443@jagdpanzerIV>
 <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
 <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV>
 <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV>
 <CACT4Y+a6nUqdpSyYGGcXKAgVbcw+uQOz2kYx8tUS+8T5-bzqkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a6nUqdpSyYGGcXKAgVbcw+uQOz2kYx8tUS+8T5-bzqkg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/20/18 11:30), Dmitry Vyukov wrote:
> 
> https://gist.githubusercontent.com/dvyukov/1528e86e5139f2fd1bf9902398d48298/raw/3b42148554eefed210f1e626d5befd50405c5487/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/6e08ac521f3e19534970ed97aeee1603/raw/0f0bb361902de94e7ee331ac500a3ceebf812c22/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/6e9db2313e48773ad1cd861da8020008/raw/d5b7c023fc8a38c72b1cf8bb1da85fb1c31cea5f/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/3d1bda4c690414ac027de1da45759751/raw/2c68980eabf4f6be24060e807a75f2d3570b5a42/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/9b8831e9ac73ffafa111a33ad40c5667/raw/f4097fbea8f89b25a282a6ef7e648145e10ae4b7/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/d78a3187a1b4e004820e92efcb16f9e0/raw/5530bcbf009c3fba3c581b2d24c523c673c6ef12/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/da1e42436af9ad2afc7de49f2d503510/raw/7dd4cbcc651c5b87122f066a3c689999ae8c4121/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/4571b94bd8cbd78d759412c560fa395c/raw/964c73fc993fc8a9000571e0b7618000584f3638/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/b6deac5faa958ae3733413b34dd5feed/raw/c4da219e284f7fc55da8c3c3af623a87f31bf653/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/2f54c6a2e45347ea76d9c5ce3c0ff091/raw/45f4873898ec8e0d9aa16b9c5c63a85410fd05e0/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/96cb39e29124dbbe2a65a91ec7a5639e/raw/aa8f7b2b1dfa5b8bb8cf93d8a821ca9938e8fc54/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/424da8282d5b28f8be10eab595d37444/raw/acc2fb1ececc1ea9a8215213f7e37e08b524c096/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/b07f37720c632d6d56ae67d95e5599b3/raw/8624ba47d6eb4e7d4d58e3ae1242ebe6cc46d361/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/bc24a7b92289ec04587fb29fc1085045/raw/3136e9262ee2233b5ab369a4a82e83953fc2d8a2/gistfile1.txt


Just a small remark

I randomly picked some links, and at least in several reports I saw:

** 4495 printk messages dropped ** [   50.830930]  [<ffffffff8123ab47>] do_raw_write_lock+0xc7/0x1d0
** 3816 printk messages dropped ** [   50.839887]  [<ffffffff814fb353>] SyS_read+0xd3/0x1c0
** 3497 printk messages dropped ** [   50.848107]  [<ffffffff81003044>] ? lockdep_sys_exit_thunk+0x12/0x14
** 4057 printk messages dropped ** [   50.857615] 	run_ksoftirqd+0x20/0x60
** 2855 printk messages dropped ** [   50.864318]  [<ffffffff814fb353>] SyS_read+0xd3/0x1c0
** 3490 printk messages dropped ** [   50.872518]  [<ffffffff815bee10>] ? fsnotify+0xe40/0xe40
** 3600 printk messages dropped ** [   50.880974] 	SyS_fcntl+0x5be/0xc70

This will not get any better if we have printk context tracking. The
problem here is that we lose messages: your console is significantly slower
than your CPUs. So while one CPU is doing its best printing pending logbuf
messages to a slow console, the rest of CPUs don't hesitate to append new
messages (printk -> log_store). Since logbuf is limited in size - we wrap
around and this results in lost messages.

	-ss
