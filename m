Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA42C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C54020870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1PnqJ/UE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C54020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeLMOjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:39:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44279 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeLMOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:39:04 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so1717262iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 06:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LtBzFFdX9sGuScQHZibsAe5Y9s9yUMWeHReF+AbJsDg=;
        b=1PnqJ/UEn71brBK/i1h2U3XX9GVsn3GRVYJoU4sTGgGFRZnem7BJFBeSHKwRNh/Qhn
         00C9zyGyFAvpzd3w9RK8kIFat3bTmvMeZEHwKI771TqMOxHrQbmGIUGi210cXnVj9mrX
         2wHQBEQ/YYGINqbAIbQpmInk8VTuoFcFH1oZB0/svN77y878sG3szri52k8/v4pL2kEM
         iEF6mrNGMD6TyZfNGcUjNNxHzBG6y61vf305w1KNT+M32AsGGUUsHRe6s/rZAz5Zp+Qm
         3bFKuOOSpDvcWpPQKoNigNEjBUp4c1N5eoGMRITDNcLfEe55FjeJd9Z/5m321T8qdpbw
         FbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LtBzFFdX9sGuScQHZibsAe5Y9s9yUMWeHReF+AbJsDg=;
        b=XUdb4OTgxjRRRykMUdSkxT/50jH7JZuqhviSzRXuwUv2Z88vtFjITfaQTrjrDCXM53
         Qqf8OFFqe3yAFvqC4jMFS0P1qeN3SOAO1jcUC0KReXlH1QCGl6gGg5C3JG4JuvfQGuP2
         uR7JZpMh36oYMe/FEr/PO0JB6AMUSno8XGVaPO+sPc2w+MaE+lqj46OAYsXujjM+LpfW
         iQQS++GuOxNoNT+N9w9vtPkhFDHKYkCNNsgf8AWNTKLNlLPmFqikDAVGdcro6EsGkXfu
         Y24jc8PoW3Yez4dpVLy09EYRqv1XKsxv850QugkBJdVmoetZAzIo/qRl39P2LS7oUrmh
         vSpQ==
X-Gm-Message-State: AA+aEWZT6QPfBl8yGCHJvx6Qwp0ReWUIPpJRfJnS1F5Z16yqE0CM/ijY
        oUioGoIVziW/0sR6mSKQjE7tY2QbpNtcMZzn2RQXkA==
X-Google-Smtp-Source: AFSGD/WuXAAtl3zG4eD+wGui+//1NQW9FW1FnA+8jk8Kolhj09Q4R/ZnM5kUu1EpfrrpcXaWpXZvlxoxbXsIBdmXZek=
X-Received: by 2002:a6b:1414:: with SMTP id 20mr20241175iou.140.1544711943709;
 Thu, 13 Dec 2018 06:39:03 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
In-Reply-To: <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 13 Dec 2018 22:38:52 +0800
Message-ID: <CAOesGMgu1i3p7XMZuCEtj63T-ST_jh+BfaHy-K6LhgqNriKHAA@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     luto@kernel.org, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, fweimer@redhat.com,
        Mike Frysinger <vapier@gentoo.org>, hjl.tools@gmail.com,
        dalias@libc.org, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 9:40 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Dec 10, 2018 at 5:23 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > I'm seriously considering sending a patch to remove x32 support from
> > upstream Linux.  Here are some problems with it:
>
> I talked to Arnd (I think - we were talking about all the crazy ABI's,
> but maybe it was with somebody else) about exactly this in Edinburgh.
>
> Apparently the main real use case is for extreme benchmarking. It's
> the only use-case where the complexity of maintaining a whole
> development environment and distro is worth it, it seems. Apparently a
> number of Spec submissions have been done with the x32 model.
>
> I'm not opposed to trying to sunset the support, but let's see who complains..

I'm just a single user. I do rely on it though, FWIW.

I hadn't finished my benchmarking in Edinburgh, but for my new machine
that does kernel builds 24/7, I ended up going with x32 userspace (in
a container).

Main reason is that it's a free ~10% improvement in runtime over
64-bit. I.e. GCC-as-a-workload is quite a bit faster as x32,
supposedly mostly due to smaller D cache footprints (I ran out of
cycles to tinker with back and forth perf data collection and settled
down on just running it).

Running classic 32-bit (i386? i686? whatever it's called) is about
half as good. I.e. even then I get a ~5% performance win. Less than
x32, but still better than 64-bit userspace.


-Olof
