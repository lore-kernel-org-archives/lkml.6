Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC93C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02C52147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gLgRb6Yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfBTGL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:11:26 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:28027 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfBTGLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:11:25 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x1K6Ax0v023420;
        Wed, 20 Feb 2019 15:11:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x1K6Ax0v023420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550643060;
        bh=fQ7RoaSQrraEr02ZVRQCXd/IsHb/D4FZ4KSf+AmeP/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gLgRb6Ygy8wyAkYHE2Q2e1bzV5SqEgdkJhH87oUBmvKAQDNfrDX5OyGZN4+gdPYi1
         mA6AFwvbwkMAdpTB3IADpnDW+QfqFiyvGnfjUuEtbdLeHOwJTYEM2akSUy4gZ7zuQD
         rsk5mLpY7khV6tR2ndy37Lxg4AHl0q71NhBTJhzremwg//iqT/8KiFhWFzA5bwrITn
         TgLdwIa8FWPxczedAOPaF2bXofBcbaQLEJBheW14rMhqmZl5BSvTZW9mmWZaw1zrp3
         L3WwJrWj1YeCXq4fYynNo8YVtRivohSPsQrYdBfpLhRDYiTcPtTAPR3vhMmKX/aewu
         6s2vEzl/qDBww==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id y19so8057vsc.4;
        Tue, 19 Feb 2019 22:11:00 -0800 (PST)
X-Gm-Message-State: AHQUAuaidONS1k/zpE0JT0lRx2vex6MN9weruOKAF6dG2wGl1H+MMH5l
        /Njeglpnd1Im7q51IZKfXfxIeoossmPdEqILABU=
X-Google-Smtp-Source: AHgI3IZoKIpiOYROm2rnZGQDoeFgxQK0hGcdo19SD2w0C5bk6MVyCa74ew7npVbipe8DT8WLdCCBHP29qrzyA3QKnGg=
X-Received: by 2002:a67:c913:: with SMTP id w19mr17027785vsk.179.1550643059212;
 Tue, 19 Feb 2019 22:10:59 -0800 (PST)
MIME-Version: 1.0
References: <1547706826-16833-1-git-send-email-yamada.masahiro@socionext.com>
 <CAKwvOdkzSTyiiBmpwGFj6K=1Ang6nsVVahaQstk_GkPAcyBZOg@mail.gmail.com> <CABC7LbQSxB=WuUz22uunWW=YahNd2-By8LKxLcZYo0L17P---A@mail.gmail.com>
In-Reply-To: <CABC7LbQSxB=WuUz22uunWW=YahNd2-By8LKxLcZYo0L17P---A@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 20 Feb 2019 15:10:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNATY8-hJ6QouGjO4wvsw8+W60HhLfNk60RZWyNz4s5fv_w@mail.gmail.com>
Message-ID: <CAK7LNATY8-hJ6QouGjO4wvsw8+W60HhLfNk60RZWyNz4s5fv_w@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: support llvm-ar
To:     Jordan Rupprecht <rupprecht@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jordan,


On Thu, Feb 7, 2019 at 9:56 AM Jordan Rupprecht <rupprecht@google.com> wrote:
>
> I have a patch up for review that fixes the second case of chopping
> off the directory when nesting thin archives:
> https://reviews.llvm.org/D57842. I'll commit it tomorrow if there are
> no more comments.


Sorry for late reply.

Now I tested the latest llvm-ar, and it worked perfectly for kbuild.
Thanks for your work!


-- 
Best Regards
Masahiro Yamada
