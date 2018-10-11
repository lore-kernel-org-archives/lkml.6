Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E194C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E70D20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQJMLPnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E70D20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeJKNAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 09:00:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33993 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJKNAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 09:00:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so3642598plr.1;
        Wed, 10 Oct 2018 22:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gkj0quUWAD3BjRmvveLsFI92fOMUbmZvFOT2H8KLar0=;
        b=HQJMLPnXEEN4/NiHMkP2q++QogNTYSRuBBPc0fVbWU4LYBHFj/TRUaG9tSWf5bI7oa
         Ez1Pzb7PK0rTQNses5/Wdqg5Bc6WkoHEG3gg4jEFfXPdXIBd0Lc2P5W+32lGkZV+T3tJ
         7lI9FGr8iR/FSJ1gL0K7xc5tgHeKuqSWs/+MiBveYdQk91HMp+a2fez4u7x+zBdQOa4J
         we5ZA4Rp/DCcAFkzH4uY1VK0J4UyInEIUEgiag8zRMIYlF6x4EV9cv+k7Ck1YjWoo4hn
         gJGr1vQ4i8lm4CI7Vq+Tpz7uZc2shn/bEL3nKIy09oXIKv7r+L1ffxAS1mEWJuvtHh8J
         cYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gkj0quUWAD3BjRmvveLsFI92fOMUbmZvFOT2H8KLar0=;
        b=jrIjQ3JLzQ8SDSUQZLBCggUtcvtThIPt67r2A6W9gQWDaOi/cDdL1MhehxQRQRExa9
         uwMdqthGLdMe9l9Zr4oGtFcEzfN+xZ/buWkT2JlhoV4dyUj0sldOUFwdBfwbEzsMl/Ez
         dCrjWgYHLHXdsu2s8b0ZdZXmXZHhUyAZEakyrHJCcd+pOjcfQOaxFCqyIDabpxEoE/ix
         NpYVeKphBM2LayQn00q/3Oq7OHPWqevdMZ95c0ER5s0zOrUqWGZYfTYrpcJIC8wNb3IT
         3EBsaKtzVHmOaejcMyPwUEStLE2VSfaftgm3t3Zo40gPLwPfvzzxZNUzoXrZY0gmUPJT
         nlTQ==
X-Gm-Message-State: ABuFfoiIGIv0GlQ3Abujjr+BIb7qvajR0MUvORnwavrEkzD/qgs/ejr8
        W9k4v/3JqV6ImzJsEfyYeOXO+JoYEA7EBxxo/GH7KyGD
X-Google-Smtp-Source: ACcGV62fwHtGh5UL8AvHFZNzqzgzWTDuH6caCtznCHHWPnhYKJJ0+pZ/2fFsW6zWeDv4aX95sGG+dH5NFWFxgogCm10=
X-Received: by 2002:a17:902:e185:: with SMTP id cd5-v6mr141145plb.224.1539236101127;
 Wed, 10 Oct 2018 22:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <e0611057-1b5b-9990-b9fa-060a9b5eba40@linux.ee>
In-Reply-To: <e0611057-1b5b-9990-b9fa-060a9b5eba40@linux.ee>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 10 Oct 2018 22:34:49 -0700
Message-ID: <CAM_iQpU0+LVwgMea32KQWf8z6Bp1VTmWOGnWNwNSmV0PZzf_ew@mail.gmail.com>
Subject: Re: netconsole warning in 4.19.0-rc7
To:     Meelis Roos <mroos@linux.ee>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Dave Jones <davej@codemonkey.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Cc'ing Dave)

On Wed, Oct 10, 2018 at 5:14 AM Meelis Roos <mroos@linux.ee> wrote:
>
> Thies 4.19-rc7 on a bunch of test machines and got this warning from one.
> It is reproducible and I have not noticed it before.
>
[...]
> [    9.914805] WARNING: CPU: 0 PID: 0 at kernel/softirq.c:168 __local_bh_enable_ip+0x2e/0x44
> [    9.914806] Modules linked in:
> [    9.914808] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc7 #210
> [    9.914810] Hardware name: MicroLink                       /D850MV                         , BIOS MV85010A.86A.0067.P24.0304081124 04/08/2003
> [    9.914811] EIP: __local_bh_enable_ip+0x2e/0x44
> [    9.914813] Code: cc 02 5f c8 a9 00 00 0f 00 75 1f 83 ea 01 f7 da 01 15 cc 02 5f c8 a1 cc 02 5f c8 a9 00 ff 1f 00 74 0c ff 0d cc 02 5f c8 5d c3 <0f> 0b eb dd 66 a1 80 cd 5e c8 66 85 c0 74 e9 e8 87 ff ff ff eb e2
> [    9.914814] EAX: 80010200 EBX: f602b000 ECX: 36346270 EDX: 00000200
> [    9.914815] ESI: f620ecc0 EDI: f620ebac EBP: f600de40 ESP: f600de40
> [    9.914816] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010006
> [    9.914817] CR0: 80050033 CR2: b7f5f000 CR3: 36389000 CR4: 000006d0
> [    9.914818] Call Trace:
> [    9.914819]  <IRQ>
> [    9.914820]  netpoll_send_skb_on_dev+0xa5/0x1b0

This is exactly what I mentioned in my review here:
https://marc.info/?l=linux-netdev&m=153816136624679&w=2

"But irq is disabled here, so not sure if rcu_read_lock_bh()
could cause trouble... "
