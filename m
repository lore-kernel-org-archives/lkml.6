Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D47C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EB620851
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390763AbfBROYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:24:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35624 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389824AbfBROD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:03:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so19258472qtk.2;
        Mon, 18 Feb 2019 06:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4sONZ6+wIQzAEC4r3Eih9LxrlYi3tim017hVQtTnck=;
        b=O71xPI2Qh42noiRHPaFR9XwZH6RY0hd4AYpCja7c095NtIRGW+5PFqHe52BJunSA9S
         llpxmNN3Bwl14GOZKOZiuzsPrtuD96KkWU8BzU/puM5TeBHOWrClGshiOg6s72g8M4Ua
         DP6uWYw86m6JjgBviMQk/ib0rDb3Z8LlxW85alaa5bRKt5mP0PceKmOcdIUKmdDp9CW/
         qwQ4mhfRnUJF4WJ975aegmmKANcbli9PL2mDNR+hNZjIMSEtYHXXCZyH222loxXDoqTl
         h9h3yRDo93TAgJ81SgsBWL8eXTkd4/mTTDkPvDw94EXBAb2JF7HWqL/9hiG9oftZylQa
         UV8w==
X-Gm-Message-State: AHQUAuaCFbNOltlCa+fnV0RnZGkBTmrfXZWSqAE8pTi7J2n4I1kgDOcC
        gAbeXYNrEs8YhMgWrXJo3R6+g2ntwD9x/t8KaIc=
X-Google-Smtp-Source: AHgI3IZ+nklwfLZIjKglkHxayVQZezn5oCGC5EXEtnPb4rGm9EEfXvShbhNYBK/fTow8slx4feqjpwkK7IAA/+4syVU=
X-Received: by 2002:a0c:98c8:: with SMTP id g8mr17760033qvd.161.1550498638517;
 Mon, 18 Feb 2019 06:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20190124142448.23243-1-mst@redhat.com> <20190210231841-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190210231841-mutt-send-email-mst@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Feb 2019 15:03:41 +0100
Message-ID: <CAK8P3a2cWjSSUJehMGEMCmnjdWJRZcyoegtN1ERqX7Tzkm-DXg@mail.gmail.com>
Subject: Re: [PATCH 0/3] generic asm: mman cleanup
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 5:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Feb 08, 2019 at 01:02:51AM -0500, Michael S. Tsirkin wrote:
> > Now that we have MAP_SHARED, MAP_PRIVATE and MAP_SHARED_VALIDATE on all
> > architectures, it probably makes sense to de-duplicate these
> > and put them into a common header.
> >
> > Please review and consider merging though the generic tree.
> >
> > Build tested on x86 only. Has been in linux-next for a while now.
>
> Arnd, would you consider merging at least the cleanups 2/3 and 3/3?
> In linux-next they had no ill effects and make things
> slightly cleaner IMO.

I applied patches 2 and 3 now, sorry for the late reply.

     Arnd
