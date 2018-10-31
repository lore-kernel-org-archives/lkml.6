Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F12BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC5D20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="P1xeNk4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC5D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeJaPkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:40:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47090 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbeJaPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 11:40:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id x3-v6so13758114lji.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 23:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fwqQ9aRSAqM7zyF84//NoXF0ruX4u0DGZ2rO3Fr/rk=;
        b=P1xeNk4VZ2KONvH+f9hoBPd4w8hoFJ3ho6asLuiQfPz/1gOlM8GOb1HWvnv3IyuaUs
         xdUD9dZ25ywaOUI/2UIaUzneVDFG4XV5kmYwoN1ZNelQHirZR5q0A+W9ENPnDLg6Sukg
         ZSsfWmZg33D/dG2pFOa3aliC1wnw6buoIfVHeEuJz5tqU6PR2beagVWL781dCc0y31yo
         j7ORoWIoprQ27QSj586FlINuTbQZM4aNYXbqEbG8y5CDmazazSe0r3GcqYCrwQMPAvj+
         dDT42wKrLWzFoqbzUFbgJRvdCuma8lXmxmlV0AAF0ey4L5J9Kgk3hPvxANsyUIU6LNcK
         SYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fwqQ9aRSAqM7zyF84//NoXF0ruX4u0DGZ2rO3Fr/rk=;
        b=BkQbXh7JdjTmDvcb/knwcDloBjCi0pi6w71Di2fyy8kNU0zzlm3MhhL9SyEecG1pzc
         sX1w7lgiEwzQ2Sj3vkdaUNPaTvwHhMKbmxJciE+iTUtGh50Xy9wBEnbpTzBpHuTh2gz/
         KQYp9YWuo4gLTSVID+ioGcVezwDiEJVlTNx0f0ckBqu11WLB9tgWWf7jSPHsNge/UzJE
         XYO4B8uuWx1mm6RevU8S7TAIaO5t4fv4Fnqr2zbMD0b33Y/dU+vOOkn7UzFROUjdfaRL
         ciENra0inhJwhmU03kcdwPanYiEBvWiwtEPmV85oMZLC1TlHur68hSlwOAOgQV6mx8cW
         4NMA==
X-Gm-Message-State: AGRZ1gLJEY3NJGfUEUbjMknVNsmKV33uOG9vmlxd1mLdOx140CAKNiBA
        /8kpHZf6AjR+sGC3TcTWqaQbP4mF7deFbdsvrZot8w==
X-Google-Smtp-Source: AJdET5cTRyqdz43/LBrXLek8MAxzVpnXYE/Q19xoaIaH3hii/9lInHPt858A3Q61EhZe4cY6iPxDJeeFdQKZo3y2NqA=
X-Received: by 2002:a2e:b1d2:: with SMTP id e18-v6mr1113525lja.34.1540968204058;
 Tue, 30 Oct 2018 23:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181031000413.30123-1-olof@lixom.net> <CAOesGMg6L8+=ZFbH_ThUG3VrePrbBY0Bg5HWi+AiaEbNSOn_qA@mail.gmail.com>
In-Reply-To: <CAOesGMg6L8+=ZFbH_ThUG3VrePrbBY0Bg5HWi+AiaEbNSOn_qA@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 30 Oct 2018 23:43:12 -0700
Message-ID: <CAOesGMh8zq=vK0ARqK-1S4MYn7kg541u+dziKqnGuswrCi=n1A@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: lib: Fix build error for 64-bit
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Zong Li <zongbox@gmail.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 5:05 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Tue, Oct 30, 2018 at 5:04 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > Fixes the following build error from tinyconfig:
> >
> > riscv64-unknown-linux-gnu-ld: kernel/sched/fair.o: in function `.L8':
> > fair.c:(.text+0x70): undefined reference to `__lshrti3'
> > riscv64-unknown-linux-gnu-ld: kernel/time/clocksource.o: in function `.L0 ':
> > clocksource.c:(.text+0x334): undefined reference to `__lshrti3'
>
> Err, fixed the whitespace in tishift.S while I was at it. Undo if you want.

Ended up with a few more fixes, so I split this in two and will repost
as a series. Apologies for the noise.


-Olof
