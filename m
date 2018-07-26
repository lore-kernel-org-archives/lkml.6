Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8611BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E5C20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PArVZlxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E5C20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbeGZLqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:46:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36235 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbeGZLqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:46:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id d14-v6so448817pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 03:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n7g80IRPVBVNWVm0kW3JvMhhQ5aebDokPXPvlyB/Y5g=;
        b=PArVZlxWuBnUpIe4GQIbt9ZY2npP6v6AUZHF0VVL+hj+/J7x4wioqSiC+KNxNAvfWq
         b+0v4jqzJyaEwJ7fbr8gMvvBs6KftuiJYe8NFn7hrVzZWT4gwUQYV0G3LQC4SBPQqE1g
         HDupUPIu1aEuQ8u4M4nWjMgxVQnU0qsk+OYz0RYiVmHN9FhXDeyI5mdIog6yr2I4IZ3G
         YySyyDGE3Z5+O2zfy9x37Lz/lXpc4JNtcT4xxvLe7tzIHj5iqG9flDJlm+mTp/1Sj8gG
         Rat/OvSJK+MxMoP+yoR3HkfKkaBWQRMy+C6T4ymTXpkLkM9vWpaPZ3JP1mo6cSJ1ymU/
         WMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=n7g80IRPVBVNWVm0kW3JvMhhQ5aebDokPXPvlyB/Y5g=;
        b=pYZwtOgfB9U2qbxHaJ0eJYO/deSU2M1deArnNMvXNK9tC+KXcNJmfymhFETMhWEt/Z
         4HHp907eaNf3zE7BVKdAls+N/1Uhqj9SRLNjxwc/jxKhgEXZRasIpq3jhOcbgB9/eweT
         9tlGlABb+xEHct34TUsI1itK9sCkb5Vt7IUiOm8wgUnuvudVvIqOyLBfUxS9Jt7Fbqf/
         F9vaTHklC8AAivwNmZFmg9D3+KT1tAIq/Rc+j9YQH+a/H2bT8U7glKoAOnXrnh7XGnC6
         nPYM/r/FqowuIka16acpKb31jy5l5PH1B08HznAeC8+QQI1j/n6QnOMNlvw5Cklu8ayY
         pn6Q==
X-Gm-Message-State: AOUpUlGlNiCpwtyxWqLZM/0CtMvi7kw3ff1uG5pEyVVhGwYSe/Qqn0Up
        um3Xg7brf4ft74JxXpsVpL8=
X-Google-Smtp-Source: AAOMgpdWMN2TG1moBpv4PfTHpLE4NX6UWNFAQLCja/UVq6We+yX3rftBPILVH89cFlWwJoFcB2EQqQ==
X-Received: by 2002:a63:710d:: with SMTP id m13-v6mr1408399pgc.66.1532601006962;
        Thu, 26 Jul 2018 03:30:06 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id 70-v6sm1962567pfz.55.2018.07.26.03.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 03:30:05 -0700 (PDT)
Date:   Thu, 26 Jul 2018 19:30:01 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Tino Lehnig <tino.lehnig@contabo.de>
Cc:     ngupta@vflare.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180726103001.GC221405@rodete-desktop-imager.corp.google.com>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725132126.GA2893@rodete-laptop-imager.corp.google.com>
 <d07348bb-3102-30f0-d138-de23449e23df@contabo.de>
 <20180726020351.GA221405@rodete-desktop-imager.corp.google.com>
 <1684cefc-c920-d53c-8d2d-c32da213a045@contabo.de>
 <15e3a0af-7e02-83fb-4b72-b05f6d7ded71@contabo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15e3a0af-7e02-83fb-4b72-b05f6d7ded71@contabo.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 12:00:44PM +0200, Tino Lehnig wrote:
> On 07/26/2018 08:10 AM, Tino Lehnig wrote:
> > > A thing I could imagine is
> > > [0bcac06f27d75, skip swapcache for swapin of synchronous device]
> > > It was merged into v4.15. Could you check it by bisecting?
> > 
> > Thanks, I will check that.
> 
> So I get the same behavior as in v4.15-rc1 after this commit. All prior
> builds are fine.
> 
> I have also tested all other 4.15 rc builds now and the symptoms are the
> same through rc8. KVM processes become unresponsive and I see kernel

Yub, I think it's the pooling routine of swap_readpage. With the patch
I mentioned, swap layer will wait the IO synchronoulsy and I belive the
page was in the backing device, not zram memory.

> messages like the one below. This happens with and without the writeback

Huh, you see it without writeback? It's weird. Without writeback feature,
zram operaion is always synchronous on memory compression/decompression
so you shouldn't see below io_schedule logic which happens only for
asynchronous IO operation.
Could you check one more time that it happens without writeback?

> feature being used. The bad page state bug appears very rarely in these
> versions and only when writeback is active.

Yub, I will review code more. I guess there are some places where assumes
anonymous pages are with swapcache so refcount counting would be broken.

> 
> Starting with rc9, I only get the same bad page state bug as in all newer
> kernels.

So, you mean you couldn't se bad page state bug until 4.15-rc8?
You just see below hung message until 4.15-rc8, not bad page bug?

> 
> --
> 
> [  363.494793] INFO: task kworker/4:2:498 blocked for more than 120 seconds.
> [  363.494872]       Not tainted 4.14.0-zram-pre-rc1 #17
> [  363.494943] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> [  363.495021] kworker/4:2     D    0   498      2 0x80000000
> [  363.495029] Workqueue: events async_pf_execute
> [  363.495030] Call Trace:
> [  363.495037]  ? __schedule+0x3bc/0x830
> [  363.495039]  schedule+0x32/0x80
> [  363.495042]  io_schedule+0x12/0x40
> [  363.495045]  __lock_page_or_retry+0x302/0x320
> [  363.495047]  ? page_cache_tree_insert+0xa0/0xa0
> [  363.495051]  do_swap_page+0x4ab/0x860
> [  363.495054]  __handle_mm_fault+0x77b/0x10c0
> [  363.495056]  handle_mm_fault+0xc6/0x1b0
> [  363.495059]  __get_user_pages+0xf9/0x620
> [  363.495061]  ? update_load_avg+0x5d6/0x6d0
> [  363.495064]  get_user_pages_remote+0x137/0x1f0
> [  363.495067]  async_pf_execute+0x62/0x180
> [  363.495071]  process_one_work+0x184/0x380
> [  363.495073]  worker_thread+0x4d/0x3c0
> [  363.495076]  kthread+0xf5/0x130
> [  363.495078]  ? process_one_work+0x380/0x380
> [  363.495080]  ? kthread_create_worker_on_cpu+0x50/0x50
> [  363.495083]  ? do_group_exit+0x3a/0xa0
> [  363.495086]  ret_from_fork+0x1f/0x30
> 
> -- 
> Kind regards,
> 
> Tino Lehnig
