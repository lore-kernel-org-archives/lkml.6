Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CADECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864A921473
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRNqVkhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864A921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeJRGjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:39:45 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45007 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJRGjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:39:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so27867062otf.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UdTDYmrD+Y9u0PK5U9K3HvUUu+sgzgVl8WCZEh4jKw0=;
        b=HRNqVkhgxDjMxdm3PTQPcsStkOuweQj368RgImVO+rTI+RWgWystwvKvBZERCUnhDm
         PvYCWTUoKMi5qxTLZ2K1M2pyHPSYiggjKAPVlADoSPGYNUsocTar0ztcTzSBRc5XfkwT
         1zLQrYaLCrVsLb/MGdb6FI4EZ/kH6ZsPczs2fDhRuFQrUS6YYQuta5wwwz7Lh2cETAZk
         LRkGpDb1Vfw3p2K9FeH33b/0wBh8F2XzU2tPdtdklt7Qy0ViJjmuMRFG3nMESyYIIfYb
         Av2qBe4UjsSFg94UltO8IUvbnWBz+mTMisfmJLdn43tAwAjJ3MXkBDtDExUcSX7AdgDo
         0hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UdTDYmrD+Y9u0PK5U9K3HvUUu+sgzgVl8WCZEh4jKw0=;
        b=h0kh/tMrBRk9SLwm2hmajVcPUvVDt+S/8SCVbgfSRLv9NzLq5LfdtCS2xeT8UOKKUf
         VVbGe05BJUfI31zF1yNnC9lP+VEs6P/NhoBJcJamX3/I8LcH3a4rnnNxWafQU+GXVsIX
         iErElg6o1kKqcjWHBrNuq8W9NR+B6/ZUbWd+tLatCc1fpf+JD+SYIR+9FMmBHZxKL8K2
         WjUkr2+W+YXDSvbq8AhW7QQa86CQ77ZCKuAvLiyl/gVVI7PkvZjn33iYQ3snzTs5YS2q
         f3M7gV1V3fAoo5eT8zvt1StK6quJDBS4OTejXagHbL0320nw0TXxd/sFXMtVs8XA71BS
         7FXw==
X-Gm-Message-State: ABuFfohBb7Ivl/ugIlsoILnFYZo4dx8JUt8EPRQSucJe9CZNfZWvLuhf
        2fX9ZOyI27kYk8YrRnsIxET4gdQzoiVMVMtXCzs=
X-Google-Smtp-Source: ACcGV60f+swCkoSoCmO6Z3O7HJIwv5XW1GvQWOKq3F3T/rgLsp+k68gw6VOYMemCo9i7QFY2sVCDUo4GM9Pgmw8T0lU=
X-Received: by 2002:a9d:cb0:: with SMTP id b45mr18299107otb.2.1539816115137;
 Wed, 17 Oct 2018 15:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180906152859.7810-1-tycho@tycho.ws> <20180906152859.7810-4-tycho@tycho.ws>
 <CALCETrXGBZyqDb7DEysHmOkxaBrXUp4s2X08HfqZkpjM28s3Hg@mail.gmail.com>
 <CAMkWEXNN2_saQN-yQ7Pwgau1YTYQQuih+KLnKj5-cOYa6CyMPw@mail.gmail.com>
 <20181017150022.GA7544@cisco> <CAMkWEXM1c7AGTH=tpgoHtPnFFY-V+05nGOU90Sa1E3EPY9OhKQ@mail.gmail.com>
In-Reply-To: <CAMkWEXM1c7AGTH=tpgoHtPnFFY-V+05nGOU90Sa1E3EPY9OhKQ@mail.gmail.com>
From:   Michael Tirado <mtirado418@gmail.com>
Date:   Wed, 17 Oct 2018 18:15:47 +0000
Message-ID: <CAMkWEXOywaUUy3=G+26G1uYOPw-pq-Wq68xSPmShuAMCGwfcbQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] seccomp: add a way to get a listener fd from ptrace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tycho, Sorry for the duplicate, I forgot to CC the list :(

On Wed, Oct 17, 2018 at 3:00 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
>
> That's one of the use cases, but there are a large number of others. I
> discuss a few in patch 1:
> https://www.spinics.net/lists/linux-containers/msg33956.html
>

Thanks this is making more sense to me now.

I haven't been keeping up with the list and just did a bunch
of reading. It seems that stackable LSM's are making some real
progress now, and I wonder if those patches are merged would
using a stacked security module approach be worth exploring if
it provides the same or greater flexibility, and assuming all
syscalls of interest can be hooked somehow?

>FWIW, I'm dropping the ptrace bits (and the fd passing bits)
>from the next version, because they seem fairly controversial.

Yeah ptrace can be difficult to work with, no doubt it is
controversial; <3 Yama. I've used the ptrace method for counting
syscall failures, and ignoring the non-trivial amount of time it
took me to learn the API then write working code, the performance
loss (in a syscall heavyweight program like web browser) is a
noticeable problem, outside of a debugging or analysis context.
