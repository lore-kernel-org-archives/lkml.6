Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1211BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AC6218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JlclsspC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfAYEsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 23:48:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40305 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfAYEsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 23:48:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so5991550lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 20:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Xet6Mq2D3lDEQ8/Jf3iEugEeBidurRb1al7+6F7WG8=;
        b=JlclsspCQRHnmIVFakpWXceeopMB1PSBH2zjtvxQ8f1QdLz0Zc9oMFpGP0WttBWVp3
         Q+K978+wNzf2PVu91+Roaz8C2X3hnmeAP771nygGY+V/Z9TVXKw1o+IEKRzpYl20QNmj
         MwNJ55mPebyopuGYQOMv7AvOvIIkUZ1ncekd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Xet6Mq2D3lDEQ8/Jf3iEugEeBidurRb1al7+6F7WG8=;
        b=s9tSyleXunyxzfTQDxiANvNvZOxGtEr6h8ZaFW8OBrDTt89vwVtBpGPsDqnT2JFT4A
         U5RpdviZanaICuXJ0N9TwSgHuvzuz5CNRKkWlZG3COFL3xuyaH1uqzD+Xv+BryIiY1lp
         CkOq371pjZtkKe65ivNxC0/O28SouJNzqA+yJ1NQBv+3stpQJ7ohSug9X8tFzbZ3sI2w
         GhUSqX07vXnuEYPZGBPA5fJ1mr+4x+iKrhBuLMd3Ud5yEHv+MS+Htl4Oxh6D7ZImYjt8
         df83tjyCeT3og+ieZKKCPd56/ypIJYaRP1daCd7+T+2gxcV0rxdjMUEF8ZwLQRjMdNQw
         72Hw==
X-Gm-Message-State: AJcUukdggvDwXLcNSVIgTnBSx04CveKToAwpYbwrdPzLN0/fb4Ns9Azl
        Ec3fdQ2S7cjqaJLOdeifBC8FDFwuP+BOzA==
X-Google-Smtp-Source: ALg8bN5oEUqlhi2m4ZyyT5c+ry0URBFOJUhgXbKqEyniKhJwIHahvF96LhAy47Km2FwhtvMkQzjE2g==
X-Received: by 2002:a19:7006:: with SMTP id h6mr7880778lfc.147.1548391730347;
        Thu, 24 Jan 2019 20:48:50 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id q21-v6sm1308634ljc.5.2019.01.24.20.48.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 20:48:49 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id c19-v6so7264702lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 20:48:48 -0800 (PST)
X-Received: by 2002:a2e:3509:: with SMTP id z9-v6mr8092384ljz.54.1548391728551;
 Thu, 24 Jan 2019 20:48:48 -0800 (PST)
MIME-Version: 1.0
References: <CADfvbxqC1+XoSsn0sEDqFE16tN1Pq46-QDAaCu=AXJdZeY3rDQ@mail.gmail.com>
In-Reply-To: <CADfvbxqC1+XoSsn0sEDqFE16tN1Pq46-QDAaCu=AXJdZeY3rDQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Jan 2019 17:48:32 +1300
X-Gmail-Original-Message-ID: <CAHk-=wh-1wB_X2MG0vW5e755rWJ5pBN8yyXLo2syOdcMV6qYoQ@mail.gmail.com>
Message-ID: <CAHk-=wh-1wB_X2MG0vW5e755rWJ5pBN8yyXLo2syOdcMV6qYoQ@mail.gmail.com>
Subject: Re: kernel panic due to https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2830bf6f05fb3e05bc4743274b806c821807a684
To:     robert shteynfeld <robert.shteynfeld@gmail.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Bob Picco <bob.picco@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Just adding a lot of other people to the cc ]

Robert, could you add a dmesg of a successful boot to that bugzilla,
or just as an attachement in email to this group of people..

This looks to be with the Fedora kernel config. Two people reporting
it, it looks like similar machines.

I assume it's some odd memory sizing detail that happens to trigger a
particular case.

I absolutely *hate* those "let's lazily clear 'struct page' array"
patches. They've caused problems before, and I'm not convinced the
pain has been worth it. Maybe we should revert them (again) and
promise to never ever take things like that again? Andrew?

                  Linus

On Fri, Jan 25, 2019 at 3:21 AM robert shteynfeld
<robert.shteynfeld@gmail.com> wrote:
>
> Hi,
>
> It looks like the above commit is causing an early kernel panic during boot on my system starting with kernel 4.19.13.  Here's the redhat bug regarding this: https://bugzilla.redhat.com/show_bug.cgi?id=1666948.
>
> Cheers,
>
> Robert
