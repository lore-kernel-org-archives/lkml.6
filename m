Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7F8C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F842087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbKPDm6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F842087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJIXVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:21:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43541 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIXVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:21:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so2184629eds.10;
        Tue, 09 Oct 2018 09:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvvdkev32BaIlAbDDS17DKGzCuvIU+cyIKqtYO1MPaA=;
        b=BbKPDm6KL9ho8uFsJ7poT1fle5GkGEnijT8acnGO9Oc1DGpx2t1B3oI6J+E8cTY8pK
         dpsBJyYDwmunbdWkrOgX/dspak9zyIuM1ThqSm2NI6zUF/KsnSRzwuOYKlL/YymPWrfP
         e/26j1TCk3BXliSCQGZpnvlWSpMQyjY6Gmh0M48W2uulRL61MRhRgy27mEiP8A4nLun0
         BHwt76GAmEynQUDGlv6Dx0P9RR+MOPPqOv+LoFSidvpcqfbyFtsGXRFxetsjNtT5EkC1
         0vISuo2817fcaFi8//x1oaqJXEJZ05pBuss5rE7DH5mLpm5+Y95iWMjuwV8MVAcsXOf/
         Wrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvvdkev32BaIlAbDDS17DKGzCuvIU+cyIKqtYO1MPaA=;
        b=GT25pgTOPzCCav9YnwzUz3+DRXw9lSQbni/73x6DIoVhH3vV0RWN9TJud8ZIOFQ+f8
         c8Q4ofCoJP/wSlsjrUrvANzAfelOqrkwrHbQGSmXgNR/XEbHDxS56r5rPOtQDGhziOQR
         jtwkM+SJCz/p6Fk2xUZJvyN/FiFBT2wklwBO5+wDR5CNFRSHuXHpTXz/q4ltJq+vYNu7
         I4Nhy/xI6ElwVT9wQO3ckz7RugsAX/V3F9iTvzr2sOf4VcISZiwBgMqirkaWup06fwJr
         Mo22VYAi1WgJ+mUOLqXv1OZArkriXnGuMIaj3Fp2I4O3vZQ8rIHrCMnSUtL67PA0X8kt
         3DwA==
X-Gm-Message-State: ABuFfoi3umA+50KurcpVJGS+bHIPXc3XVa7XAOVw8Z7BkungJXC0lanS
        AIgesd63lgzgEgSTI8cUe8rQioLRgTkuZqj1WVA=
X-Google-Smtp-Source: ACcGV63Jo0FLp/DSlC5RnZ1dduUaYxDY0XGqxLlwPsUw5L/4KeqYCBFqOVyqbDNweHiCv8FfibJGICuDKiBnLofTFA0=
X-Received: by 2002:a50:f9c7:: with SMTP id a7-v6mr34911936edq.138.1539101015196;
 Tue, 09 Oct 2018 09:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009d47b2057782bab4@google.com> <CAF=yD-+7NxN37Ez=3WXG0+2i6j30uSV8u9D7oJXEhp+SxzYCpA@mail.gmail.com>
 <CAF=yD-+Qh5f9kqmYLY5EyUwNPuyhMpBxz6dh_kfzFZsgE3UijQ@mail.gmail.com>
 <87va6bwlfg.fsf@linux.ibm.com> <48d891dd-3f45-c03c-a55b-bb153080881a@gmail.com>
In-Reply-To: <48d891dd-3f45-c03c-a55b-bb153080881a@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 9 Oct 2018 12:02:58 -0400
Message-ID: <CAF=yD-K3BeuUWf_2RhWoC6fx=+A49Nt1TOFOfzdwKfOdsv=TiQ@mail.gmail.com>
Subject: Re: general protection fault in __handle_mm_fault
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     aneesh.kumar@linux.ibm.com,
        syzbot+1577fbe983d20fe2e88f@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 11:00 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 10/09/2018 01:53 AM, Aneesh Kumar K.V wrote:
> ...
>
> >>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cdb67e400000
> ...
>
> >
> > Can you check with this patch

Thanks. With that patch the crash indeed does not occur.

>
> Well, this is a C repro, you can test this yourself instead of asking Willem who
> already did a painful bisection.

Thanks Eric. It does take some effort to get the syzkaller environment
up and running [1] and I happen to have it ready, so I don't mind testing
a few patches.

It just had to wait until I got to the office. Somehow the debug kernel
produces so much output that it consistently locked up my shell over ssh.

[1] for reference:
https://github.com/google/syzkaller/blob/master/docs/linux/setup_ubuntu-host_qemu-vm_x86-64-kernel.md
