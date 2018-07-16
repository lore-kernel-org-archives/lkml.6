Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C228ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB652084E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cw/gH28P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB652084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeGPR0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:26:18 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38949 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeGPR0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:26:17 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so76074263oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qITqN1AyvmUyXfsLJn2usMaBSXOLGhQRbmzlLtvnl4s=;
        b=cw/gH28PZcVkL4d5ED/GaZTqXDe2c5rwyucBFxFYVldbNNLaxgwMeMxoBvcSqPMYeC
         o92OJFxPUFdX4IPsYMvZooIwgTf69g+wL5D1QtztrhVlYSALtLSqSxSQzdFsU6By5YGM
         eMfF0yp3KtwHM1yHZULBqAYx6jlNaMbTd0rjJWmNEA7FYlIg2TjrjA9plXkOzWttWyfZ
         HYXSZtq8rYfMcjOuhCqe8k0lOFcSeNPkt0EJ0Vi9YAPO6cC51Rzj0sBloH9E7eLDQrSz
         VH88eV0dQdWtzPU9SRHsnFCm1ZitKfRorYa6YnFNExR2NRsB7EGjqxcsCNL8ADo5ruL/
         Emow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qITqN1AyvmUyXfsLJn2usMaBSXOLGhQRbmzlLtvnl4s=;
        b=k9na3W61ZaqhxHXUQPVjtq98GQlWdnE/GG9Cjreg5FOXvZct+OJsBGAMCaJ8tAEVty
         bib8SfDouEeK0lyeadYfBOeIXuCYh+NpkhW5ec2+/NUCiy2gWdg3ZrQ2fKxVaskaifKL
         5TgliQFZsh1Qh1P/mdwJGTXL5NGPoRzqiFOvNCKxbkO1vlFSkQ+nK2BBUcKLe4WcdkS7
         lH6rFrk5DR8JrCexMTOwNg6RsIvWUH6zDYpjxZ3GKJ5Rcwm6/X+TmzqjZvbwXol+8d8P
         +ZteNondkMWa+3gaHgBJhBmn31tYoTn9Ss7rlVDGXQhx7KbUg77p6CKGgAlqrW489bNG
         dUJw==
X-Gm-Message-State: AOUpUlHD99oRYf1iSC1rXot/ro8M11TB2vBvJCdxESJQtLeIcQnCD9VS
        Be5IidtjLPKCCJ5bcrsKix3HCpsocnoMGAS0G1hy5A==
X-Google-Smtp-Source: AAOMgpffUIgcKDLo2lay3N4jVzsLNA5AaGjm3gZzidsWOqFwg8sEUEdCUY7mu0fdFNWNV1hLmFn1TvcJr2tEzsYD8Ak=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr98767oig.221.1531760280455;
 Mon, 16 Jul 2018 09:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180716165154.58794-1-jannh@google.com> <CA+55aFy21E78DTF-3+1P3bTtX_89-nFUSpYHUELT0WCOZ-ccjw@mail.gmail.com>
In-Reply-To: <CA+55aFy21E78DTF-3+1P3bTtX_89-nFUSpYHUELT0WCOZ-ccjw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 16 Jul 2018 18:57:34 +0200
Message-ID: <CAG48ez3HEcp-hE=JF4T+7wjLju_NtLXqh8fvroEPBmx1P2D9Hw@mail.gmail.com>
Subject: Re: [PATCH v4] bsg: mitigate read/write abuse, block uaccess in release
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        fujita.tomonori@lab.ntt.co.jp, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Al Viro <viro@zeniv.linux.org.uk>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 6:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jul 16, 2018 at 9:52 AM Jann Horn <jannh@google.com> wrote:
> >
> > But bsg doesn't just do it on ->write(), also on ->read() and ->release().
>
> I think Jens already applied Christoph's patch to just remove the bsg
> read/write entirely into the 4.19 tree.

I thought Christoph wanted this one for stable. Maybe I misunderstood.
