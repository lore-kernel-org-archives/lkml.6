Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970A4C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F532087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzPsHIJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F532087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeJKP0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:26:15 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54997 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeJKP0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:26:15 -0400
Received: by mail-it1-f194.google.com with SMTP id l191-v6so12124532ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=IS+Qe1yflYjxnUGUxVEesbSqF9cTj5GBtrEheCKgRQ0=;
        b=hzPsHIJB+rCWbuYyTNW7i9SxSTnMtAL2bTfufvTHUVuAJoSf+G0Yvk666p0m9ucuaB
         ImPNa4L2+1VdEINlrG5XLtOfpcSUCDhKDw8loHGNZynzUHRlDZjSXS3XoDT6uWXm4MY4
         yyU0jl2LBMfrrILOjX+Z6DHyGJPNscCuTshjmo/Dr0GSN2dxBkKGVU79oOZP30tCcp9p
         Xzbzsb42mNky7+fQGYj0vDBSU+a8RT0xzj9gOAIij7l5ZebqSoGurw+C3Mgp9DP2RsEf
         rbAcMjVuM3teJBDrD4u0Hz7a+qMSUHl6DezL0eMkEDFQSAtKH524tAQ/o72ZG7EuUkv6
         tAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=IS+Qe1yflYjxnUGUxVEesbSqF9cTj5GBtrEheCKgRQ0=;
        b=btdb32fXkofUhjuhxY6mc/yH4rK666c+GW1607ydDKohxgBNoQUn0MVaeNGaGiUFTp
         +qryIEvgHlYZLaiE7Y0lR6KWFbDQVw4eSP9raaCBxOLh+rQAynudibEWT4OB6EsT/N/d
         AXQr7Mk+7Oh/OJktjS6zSVPrQu9PvPeRevGqAXLXraxsPpA4NuR/8t7DWeDyqdTucqAy
         DM3Cw5a825GeUM5bvggxbk/R0lqMGlNyZb0I9XZKPST28Ikv713YaHOyU9Y7u04oVEKo
         x46yAQDVYNUo/499qfPAmR87qRPkeV27Rz9v3/5E8DZJH0ilJZsvM1OucfAjoT173YFz
         ksZQ==
X-Gm-Message-State: ABuFfohEfTyPUHRv9Dh6TtZM4H2LfPHRpCyVfosnSoX8dpf/NiG+goyt
        df/YAdLCfrjqT4zvioGLtONoYNIMmk2eTleDxiXjRw==
X-Google-Smtp-Source: ACcGV616NCVHUH7QeCYECpJ1choxV1yo8jQZ0FtbhzhYr6N+JIDQkMLH6YB9SFUQ1pY05GZilFTDo+mkrSp1zWS9tNA=
X-Received: by 2002:a02:9716:: with SMTP id x22-v6mr401480jai.82.1539244807442;
 Thu, 11 Oct 2018 01:00:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 00:59:46
 -0700 (PDT)
In-Reply-To: <CACT4Y+bcxEz=P2E5TRj6A1qeCOQ+WtWR44WGLzqdDttLzD393A@mail.gmail.com>
References: <CACT4Y+bcxEz=P2E5TRj6A1qeCOQ+WtWR44WGLzqdDttLzD393A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Oct 2018 09:59:46 +0200
Message-ID: <CACT4Y+Ym3_NuqWrgHXWfTahWTm17xi_2gjy8hvuDeyUCPuYXUQ@mail.gmail.com>
Subject: Re: net/tipc: recursive locking in tipc_link_reset
To:     Jon Maloy <jon.maloy@ericsson.com>,
        David Miller <davem@davemloft.net>,
        Ying Xue <ying.xue@windriver.com>,
        netdev <netdev@vger.kernel.org>,
        tipc-discussion@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 9:55 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> Hi,
>
> I am getting the following error while booting the latest kernel on
> bb2d8f2f61047cbde08b78ec03e4ebdb01ee5434 (Oct 10). Config is attached.
>
> Since this happens during boot, this makes LOCKDEP completely
> unusable, does not allow to discover any other locking issues and
> masks all new bugs being introduced into kernel.
> Please fix asap.
> Thanks

-parthasarathy.bhuvaragan address as it gives me bounces
but this is highly likely due to:

commit 3f32d0be6c16b902b687453c962d17eea5b8ea19
Author: Parthasarathy Bhuvaragan
Date:   Tue Sep 25 22:09:10 2018 +0200

    tipc: lock wakeup & inputq at tipc_link_reset()


> WARNING: possible recursive locking detected
> 4.19.0-rc7+ #14 Not tainted
> --------------------------------------------
> swapper/0/1 is trying to acquire lock:
> 00000000dcfc0fc8 (&(&list->lock)->rlock#4){+...}, at: spin_lock_bh
> include/linux/spinlock.h:334 [inline]
> 00000000dcfc0fc8 (&(&list->lock)->rlock#4){+...}, at:
> tipc_link_reset+0x125/0xdf0 net/tipc/link.c:850
>
> but task is already holding lock:
> 00000000cbb9b036 (&(&list->lock)->rlock#4){+...}, at: spin_lock_bh
> include/linux/spinlock.h:334 [inline]
> 00000000cbb9b036 (&(&list->lock)->rlock#4){+...}, at:
> tipc_link_reset+0xfa/0xdf0 net/tipc/link.c:849
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&(&list->lock)->rlock#4);
>   lock(&(&list->lock)->rlock#4);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 2 locks held by swapper/0/1:
>  #0: 00000000f7539d34 (pernet_ops_rwsem){+.+.}, at:
> register_pernet_subsys+0x19/0x40 net/core/net_namespace.c:1051
>  #1: 00000000cbb9b036 (&(&list->lock)->rlock#4){+...}, at:
> spin_lock_bh include/linux/spinlock.h:334 [inline]
>  #1: 00000000cbb9b036 (&(&list->lock)->rlock#4){+...}, at:
> tipc_link_reset+0xfa/0xdf0 net/tipc/link.c:849
>
> stack backtrace:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7+ #14
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1af/0x295 lib/dump_stack.c:113
>  print_deadlock_bug kernel/locking/lockdep.c:1759 [inline]
>  check_deadlock kernel/locking/lockdep.c:1803 [inline]
>  validate_chain kernel/locking/lockdep.c:2399 [inline]
>  __lock_acquire+0xf1e/0x3c60 kernel/locking/lockdep.c:3411
>  lock_acquire+0x1db/0x520 kernel/locking/lockdep.c:3900
>  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
>  _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
>  spin_lock_bh include/linux/spinlock.h:334 [inline]
>  tipc_link_reset+0x125/0xdf0 net/tipc/link.c:850
>  tipc_link_bc_create+0xb5/0x1f0 net/tipc/link.c:526
>  tipc_bcast_init+0x59b/0xab0 net/tipc/bcast.c:521
>  tipc_init_net+0x472/0x610 net/tipc/core.c:82
>  ops_init+0xf7/0x520 net/core/net_namespace.c:129
>  __register_pernet_operations net/core/net_namespace.c:940 [inline]
>  register_pernet_operations+0x453/0xac0 net/core/net_namespace.c:1011
>  register_pernet_subsys+0x28/0x40 net/core/net_namespace.c:1052
>  tipc_init+0x83/0x104 net/tipc/core.c:140
>  do_one_initcall+0x109/0x70a init/main.c:885
>  do_initcall_level init/main.c:953 [inline]
>  do_initcalls init/main.c:961 [inline]
>  do_basic_setup init/main.c:979 [inline]
>  kernel_init_freeable+0x4bd/0x57f init/main.c:1144
>  kernel_init+0x13/0x180 init/main.c:1063
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
