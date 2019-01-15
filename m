Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76296C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D63C20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuznGucn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfAOKgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:36:20 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51931 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfAOKgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:36:20 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so4276845ite.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 02:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67GD5/5MPT8BED130WZQ1RfAtBW7Sd6FmUqUYeP1HKY=;
        b=BuznGucnv5qk84qEmNlZPzJtYBR3U2ia8OABMcS7kmAvAdXNSqWASPlYoM/hk9Vs/y
         4AqYhrzprlV+H5lCLtxdur8qwjeuN9cpXrwF072zmtU39YWs7pXGiz2Ee2Wm5RT1uNVQ
         b9aDoSyB1yEI8joB4Q7qGq4Horc41wWVgdabEttsRlhhQlUlmY2Zl+tGgt1Y/XhRHefv
         mlH7YN1t8brzLE9HvzRqqPAnaIrfCWYj+eJHPrUhsINbWjKleWC3bJZJevT7AJKRDmCK
         hcxJqA3Dz6z1dYRijdzAkQPaeuDuORlJI30HnjvVILU28aCQkBQNkkk010xuz5hAfNMe
         Y87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67GD5/5MPT8BED130WZQ1RfAtBW7Sd6FmUqUYeP1HKY=;
        b=LzNUbJr5MBVPXNTxtO0VebmOVhBW33wTyBcipL/ARZkC5TzXM/ckLY8OqjockK1NRf
         irpoFCT9447XGH5kYkvncTm5Vw4T+vGTraJLqxgqnfvug9bcXJxUNzH3f4eoMWalPRbK
         nZbG9N1xLUboJaE9NCdYi4alXieC/IqkplW8r5c182/30vig98JtaI5ypUcLrW3XsOrr
         f9rM1bS/LOLeLTojykftclA8DpRkHqiuFrVF6FQaeuAkcjfW7Mn9sF0J4KpZQdCd38gU
         nZ0uAE+pgsvsRjQUWebgKDOhvBdlGmfmNBClrc6DqOzyL3thXC89Hl2jP4UnY2NZszRT
         1fsw==
X-Gm-Message-State: AJcUukdEcD2lGFZhdPb3zjuSLuTxxk80cMxCDYS7kuTFa5nBrBv9Fdf8
        KPcQJ4mlRe44eiuh6h4YREAQ2cSIITIYpX2Cnt66Ow==
X-Google-Smtp-Source: ALg8bN4NPOfa63VKzrOUUNlpHOtnb0kq1MZAvwayEtctWyODMoJSPqKI9zbRS7bIHv5PvOkbIMqAQ8dTuTt+T59qF+U=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr1934685iti.166.1547548578983;
 Tue, 15 Jan 2019 02:36:18 -0800 (PST)
MIME-Version: 1.0
References: <bc63c776-99f9-ca6e-0e81-f91b1448932b@gmail.com>
 <87fttzaq8k.fsf@xmission.com> <fa46d362-9ced-8376-0770-e39a658c24ec@virtuozzo.com>
 <81dab6a7-a28d-552f-d0d8-f83f9d261200@gmail.com> <87imyuah41.fsf@xmission.com>
 <CALRZ7Utk6NCGRN6mZQnF1v1a=cTWt1-JzRjLdiD14FTQC=fysg@mail.gmail.com>
 <CACT4Y+bPMNGRrvm-VGSmUyXYWcKWGoZY8iUwQt=-9WqxgTb0GA@mail.gmail.com>
 <CALRZ7UvMbrwLb7UVgcVa9+z5yqVfJ6taj2tzpsFhWU1Cdw2J1A@mail.gmail.com> <87h8eb854d.fsf@xmission.com>
In-Reply-To: <87h8eb854d.fsf@xmission.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 15 Jan 2019 11:36:07 +0100
Message-ID: <CACT4Y+aw0e-NLuBqM=WQsdik1VsNKB3J4acdDH6zC3wu0wUoKw@mail.gmail.com>
Subject: Re: net/core: BUG in copy_net_ns()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     zzoru <zzoru007@gmail.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Andrey Vagin <avagin@virtuozzo.com>,
        "dsahern@gmail.com" <dsahern@gmail.com>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "tyhicks@canonical.com" <tyhicks@canonical.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 7:30 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> zzoru <zzoru007@gmail.com> writes:
>
> > I think that it is exactly same to:
> > https://groups.google.com/forum/#!searchin/linux.kernel/cleanup_net$20is$20slow%7Csort:date/linux.kernel/IMJ9OzonDSI/QH86oy1PAQAJ
> > Already, patch was maded, but maybe he forgot to push it.
>
> That patch was made to address speed, and lifetime of network stack
> objects.  At best it will make things go faster (a good thing), and
> reduce the memory consumption during a test (another good thing).
> The patch you point to will not correct your memory corruption.
>
> So right now the best hypothesis seems to be Dmitriy's idea that
> there is stack overflow causing corruption. You have a lot of stack
> debugging already enabled but I don't see CONFIG_VMAP_STACK enabled
> which might catch something ordinary stack overflow checking won't.
>
> Any chance you can enable CONFIG_VMAP_STACK and see if it is stack
> overflow?
>
> With a little luck you will catch the stack overflow in the act and we
> can see the problematic code path.

Most likely the stack overflow should be detectable with
CONFIG_VMAP_STACK. But CONFIG_VMAP_STACK is incompatible with KASAN:
https://bugzilla.kernel.org/show_bug.cgi?id=202009

I reproduced the other stack overflow without KASAN and without
CONFIG_VMAP_STACK and it was detected as "corrupted stack end
detected inside scheduler". We can try the same here. But without
KASAN and with CONFIG_VMAP_STACK should be more reliable.

But how I read it is if we see wb_workfn in stacks, kernel memory is
corrupted. Overflow at that async stack is not dependent on how
exactly low memory condition was provoked.
