Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228ECC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D218225249
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Zsob2tkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D218225249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbeGBSsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:48:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55821 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753302AbeGBSsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:48:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so10077251wmv.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Qdpnr9Q/0XtxwiS3nG6TiqAOG6Rn5IKNIGZaEpV+S1M=;
        b=Zsob2tkk9atfE9DxtNQr2ub9L0rjvYrRVJs0PXeiwj7p94StYa+1oPK+hLe097UYT3
         ovW9fUyyg4ycv+gwb3FMVeX38R9dRUeSB7a4YdswauOyPSj1qAHPLIYrz/Yq5XZzK7Sc
         aqbRWoxXHWNcvztpyJ7peaWs5pt8Z9N+8QVGn34aJC4lXBOdNvRSTp6bZSuYJKnmTt2C
         iCh7owE6hgwE/p2h5ler6qAyh4cw7j4u6xJaYY4z9eY8Ohocv2FeaayfkPHaKDTxG9Yh
         PkAkymB2VGfIx6mWN6imfwh1Wqwpi9jUA1/XGMSjfQMt5AEwSvje0XFBV3DdjH526Vcs
         6wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Qdpnr9Q/0XtxwiS3nG6TiqAOG6Rn5IKNIGZaEpV+S1M=;
        b=C+8iqo7b0QVq435eE0cSdVnhusRaE/WseCKzeLougT0rnDGV/UoHH0tsRnh2Ql47Ne
         4mdOpVPK90oi9FhoWyQJVwhrxeHNoRBYnEqdsCwCmzvwAAxzf2ejy0CQraAr8qqcVsKb
         vemQoXrexQNUEJkxcsYb50hjMg+2u4/4mQy4I0e3gWlxnmPmlugUnpW5DpDaYoxH8AAE
         LzR/+iL7SAlthxosX8G6XTdRO3pPjIgiMeuYKkCs1IcZReJJIEBq5Pqjp3kMn06bltHu
         9+pbEeef+6b2caU9sWMEH+AjmNTWV2b1TLxvpqoW9q2Lawly9v5VSfRMf9XrqFtXLxMM
         Oggw==
X-Gm-Message-State: APt69E09wrYum25nGtknkeeUzZbJBul8f3A173ONeCJ0TqwIEMA8o1Xy
        fDRg6mXPO1sBNmZ1aiifEeBUMKRmgNpE7yLMaGuN0g==
X-Google-Smtp-Source: AAOMgpd7dHUzs/Mca3FsAW5ALHYLIikUuJe0YrgjLkvGF+83xjkY0nIjZyuaxK5nblYIQmNj4ukGbnf9g3U1wEiTIoE=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr8485742wmd.144.1530557294076;
 Mon, 02 Jul 2018 11:48:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7e92:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 11:47:53 -0700 (PDT)
In-Reply-To: <CA+55aFz4BiRVKKwdF+y8K4O1jZnig8mmuQZ7prGp6o+DiH_TeQ@mail.gmail.com>
References: <20180630084933.GA15210@gmail.com> <CA+55aFz4BiRVKKwdF+y8K4O1jZnig8mmuQZ7prGp6o+DiH_TeQ@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 2 Jul 2018 11:47:53 -0700
Message-ID: <CALCETrWiTEscV8E--v6=+kkvfWKf_OXzVceMjX7GA51uJo-+DQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86 fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 12:01 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Jun 30, 2018 at 1:49 AM Ingo Molnar <mingo@kernel.org> wrote:
>>
>> --- a/arch/x86/entry/entry_32.S
>> +++ b/arch/x86/entry/entry_32.S
>> @@ -477,7 +477,7 @@ ENTRY(entry_SYSENTER_32)
>>          * whereas POPF does not.)
>>          */
>>         addl    $PT_EFLAGS-PT_DS, %esp  /* point esp at pt_regs->flags */
>> -       btr     $X86_EFLAGS_IF_BIT, (%esp)
>> +       btrl    $X86_EFLAGS_IF_BIT, (%esp)
>>         popfl
>
> Ho humm. Just looking at this patch, my reaction was "why isn't this
> an 'andl $~X86_EFLAGS_IF' instead"?
>
> Yeah, I guess the 'andl' is two bytes longer (due to the 32-bit
> constant - because IF is bit 9, you can't use a byte constant, and you
> don't want to get a partial word write just before the popfl).
>
> But btr is really pretty heavy operation for older CPU's (it's gotten
> better, but 32-bit code presumably cares more about the older CPUs).
>
> It really doesn't matter, I guess. The btr goes back to commit
> c2c9b52fab0d ("x86/entry/32: Restore FLAGS on SYSEXIT").
>
> Andy?
>

BTR is way more leet than AND!

Seriously, though, I've never really tried to shave cycles off the
32-bit code, and BTR is shorter, and I didn't spend more than about
one brain cycle thinking about it.  I guess that BTR has a more
complicated flags pipeline (the output flags depend on the input, not
just the output) and probably uses some more complicated ALU circuit
as compared to ANDL.

--Andy
