Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7801C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4F620661
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO9rxOWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfAIAhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 19:37:00 -0500
Received: from mail-vs1-f51.google.com ([209.85.217.51]:33196 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAIAhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 19:37:00 -0500
Received: by mail-vs1-f51.google.com with SMTP id p74so3724505vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 16:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yf6VfMJCkyhGkyRtOpkGcrGu7K1Ywv/nC95vYdFwPO4=;
        b=KO9rxOWByo6OzbDroi8xLBYeZzJqW8PKyXC+GSixSHLMuuDfb6vg0TNQLGtS2w+NGH
         hH4VfD56sBoHcmNyqEAcTwoGBjKGOIL/1yPqCoVU6K8d84WB+ZihN1fZX5nRF5bk6/My
         ZJtHx/8iFlUbE+cVSONqooIXDgxMlZFvJmstBBvZHBMZsFHlwzuOKM4blC+gkBW2Uc8G
         Crnhepnj2FauLpH3fyzNjMRpn82LwG/VINjHL1+UQrSMrjE1B+PwuMQsl6wjYpjEBkSQ
         RqaPw9X6ZeS6RYjDxYT4MhdG2XDW/xGmc0Cnpcc4yGzH/bXyY/zgeuWOVE0az69TUE+n
         o8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yf6VfMJCkyhGkyRtOpkGcrGu7K1Ywv/nC95vYdFwPO4=;
        b=l5K5zP/23SPksv66vovqF0fFTddccoIeVaDxe+5DFR2FdbDeGtA4G6K834XV20vFk6
         MZG+6OGiHvxT5gDGRYHx20BqS28O3B2lM89Asd+bJgcwJYqEWc+dtdtmncZZQkpBlcql
         myJ8oIgm9dcwP1rQOdcZZoIOU1BDin3oFfy0Ryb2CcpEyl8LTyvaTGPUdWD8RfRzPWT8
         c0G9sJyOF8A+VK/9OuIOd2akWWiGVZ7bZz2iYrtsepfDLdd5FkFWyum/GAz5eY3DWKQH
         RYBVi3ZFAMtPWT1p7gYPzSR61QFGbQz/OuNvja9K5HHv/vmDv1toKzxKgWo6IL9LwLpN
         1S+Q==
X-Gm-Message-State: AJcUukdfIftteOAC6nLmYVAhCT8NeVoPoNJOUgLTb/8/coPVf50/JfS0
        dL6lketo673hsADoX3uca8PwsyjNxWUr3j4oOBs=
X-Google-Smtp-Source: ALg8bN6rKi6hSEaShWRaygOMaMjxIX0I58OCJon9hMH8IIpzZmJoQRJiCHxmDBUTjwsJ2qVyqQ7KNLILlo1xTfDiLbQ=
X-Received: by 2002:a67:3e12:: with SMTP id l18mr1659562vsa.53.1546994218551;
 Tue, 08 Jan 2019 16:36:58 -0800 (PST)
MIME-Version: 1.0
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190109000214.GA5907@andrea>
In-Reply-To: <20190109000214.GA5907@andrea>
From:   Anatol Pomozov <anatol.pomozov@gmail.com>
Date:   Tue, 8 Jan 2019 16:36:46 -0800
Message-ID: <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
Subject: Re: seqcount usage in xt_replace_table()
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     fw@strlen.de, Dmitry Vyukov <dvyukov@google.com>,
        Paul McKenney <paulmck@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Tue, Jan 8, 2019 at 4:02 PM Andrea Parri
<andrea.parri@amarulasolutions.com> wrote:
>
> Hi Anatol,
>
> On Tue, Jan 08, 2019 at 11:33:39AM -0800, Anatol Pomozov wrote:
> > Hello folks,
> >
> > A bit of context what I am doing. I am trying to port KTSAN (Kernel
> > Thread Sanitizer) tool to v4.20. That tool tracks shared data usage
> > and makes sure it is accessed in a thread-safe manner.
>
> Interesting!  FYI, some LKMM's maintainers (Paul included) had and
> continued to have some "fun" discussing topics related to "thread-
> safe memory accesses": I'm sure that they'll be very interested in
> such work of yours and eager to discuss your results.

Thread Sanitizer is a great tool to find thread-safety issues with
user-space code. The tool been developed by a team of smart people
from Google [1].

KTSAN is an attempt to bring the same ideas to Linux kernel [2]. A
bunch of work been done there but the project is still at
proof-of-concept point.

I am not a part of Google's dynamic tools team. But I've decided to
pick something to do during the New Year holidays so started porting
KTSAN from v4.2 to v4.20. The work is "almost completed" but I need to
fix a few crashes [3].

[1] https://github.com/google/sanitizers
[2] https://github.com/google/ktsan/wiki
[3] https://github.com/anatol/linux/tree/ktsan_4.20
