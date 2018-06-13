Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BC294C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67027208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XFma+8m9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67027208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935132AbeFMRFv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:05:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50697 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934717AbeFMRFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:05:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so5994840wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nC4sCDXegUnZKWct62ekpiO17rHDSSE4v8qZ10Rbveo=;
        b=XFma+8m9kS5+HCwB9VztaRtAvLFVdXiggRRtbVLt451RbOpkHu2FjPergQC4sxPoYh
         9hbEXBxx6bCeH1L3Vv4XAfMmeQIJW749JmaLVZPrRbX/yJp45GNtlaXvRVmkBxAKALp8
         nHMo7g6BuYtmy8GEjuMIu4GjWu53RAQY9E+z6ktOT8OhL48QwMp7PKkMNleA0VODXHji
         lH6fhnq9k+V9z+vswFvzbzOhPM76UfEaJbBgDZ8LlgF7hNIXQ4UZsDvdsAVnY3ZT9Arf
         VPVwMR2eooHJfUXBSXE4SzJmt0TyB1P8gZvMqR/BtRnsAjYjdrQel4xYC/+XZ340L+bg
         iq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nC4sCDXegUnZKWct62ekpiO17rHDSSE4v8qZ10Rbveo=;
        b=NwAIUr/bLtVy0sNEXp+UX+gv2fGFCpxnzj6Dc1VdNCGWLA9MFhBMP6NzBAUn85xMMc
         5umIO1ep/Kuo1s+IS3IP44CFAgT2FHbnjnVPRS+uEPVj4ncMCPWaizy8qe1BVdq1j/Lc
         8XGgXdYsIks4/RVl+Q+Pdgvi1JFBhPZVZt2iT20HmX9wb5mFOYqkC7YnDIkrh85baUiZ
         YYXaq5w0yacLjozdrz5WcJr//Cq+JvB+9bCcX0+IICDFVa50jbo4mlkSrQDiT4tNPN1K
         o0yRo9SBlE8s64J0cstsALsVGDKimEMA0kgMWHjENU/sC3YJjTpjH8vGH7w4xzhlysd8
         u9Ug==
X-Gm-Message-State: APt69E2UGfG/zoIguWf8NAe6v1NFxIiFviTqQEpMZhxfn00gyKmfj2Fb
        F3O31S+d6+AYjqU6wFvJKFqEDZVQpA8=
X-Google-Smtp-Source: ADUXVKI9uTdwsWAocovOqSuF02N6mJXe+6IHasKUy4BH/43PwLrmdbuMmQTevAqIbo6ODKVfpNUuHg==
X-Received: by 2002:a1c:8a4b:: with SMTP id m72-v6mr4379804wmd.2.1528909548688;
        Wed, 13 Jun 2018 10:05:48 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 74-v6sm5336050wmt.31.2018.06.13.10.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 10:05:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fT9DL-0000bR-IP; Wed, 13 Jun 2018 11:05:43 -0600
Date:   Wed, 13 Jun 2018 11:05:43 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com>
Cc:     dasaratharaman.chandramouli@intel.com, dledford@redhat.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        roland@purestorage.com, sean.hefty@intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: bad unlock balance in ucma_event_handler
Message-ID: <20180613170543.GB30019@ziepe.ca>
References: <000000000000af6530056e863794@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000af6530056e863794@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 06:47:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    73fcb1a370c7 Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16d70827800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3b4e30da84ec1ed
> dashboard link: https://syzkaller.appspot.com/bug?extid=e5579222b6a3edd96522
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=176daf97800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e7bd57800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com
> 
> 
> =====================================
> WARNING: bad unlock balance detected!
> 4.17.0-rc5+ #58 Not tainted
> kworker/u4:0/6 is trying to release lock (&file->mut) at:
> [<ffffffff8593ecc0>] ucma_event_handler+0x780/0xff0
> drivers/infiniband/core/ucma.c:390
> but there are no more locks to release!
> 
> other info that might help us debug this:
> 4 locks held by kworker/u4:0/6:
>  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:
> __write_once_size include/linux/compiler.h:215 [inline]
>  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:
> arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
>  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at: atomic64_set
> include/asm-generic/atomic-instrumented.h:40 [inline]
>  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at: atomic_long_set
> include/asm-generic/atomic-long.h:57 [inline]
>  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at: set_work_data
> kernel/workqueue.c:617 [inline]
>  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:
> set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
>  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:
> process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
>  #1:         (ptrval) ((work_completion)(&(&req->work)->work)){+.+.}, at:
> process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
>  #2:         (ptrval) (&id_priv->handler_mutex){+.+.}, at:
> addr_handler+0xa6/0x3d0 drivers/infiniband/core/cma.c:2796
>  #3:         (ptrval) (&file->mut){+.+.}, at: ucma_event_handler+0x10e/0xff0
> drivers/infiniband/core/ucma.c:350

I think this is probably a use-after-free race, eg when we do
ctx->file->mut we have raced with ucma_free_ctx() ..

Which probably means something along the way to free_ctx() did not
call rdma_addr_cancel?

Jason
