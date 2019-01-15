Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CF2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0AE20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SDl92Qv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfAOJC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:02:28 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:21514 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfAOJC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:02:27 -0500
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x0F92AnB003965;
        Tue, 15 Jan 2019 18:02:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x0F92AnB003965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547542931;
        bh=vxlbXpdpk0a/odwzxea5qfzQRCnBVNhGbECA8De1nRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SDl92Qv4lbjWULet1QMzRphOHLhNgtTyCSfMFwulgVdmatuxresaisRmYcNDJIcw7
         s1sOFujykaMeGGdDp/NlN33GXreVmybw0qdQjJyuZ375St3G6AC1Uusn5oe3s51eVO
         fS7Aqt3KcUx009huXZ/Uxo+G9r44uspqQtSYXajXKFERITDd96MP1l9pEofIrP/suv
         Frg5fUbysI/1TZR5yh0+AzohNz8rC/U6Aqruyz5kLy7Lby6zYOnxLAgitpaSkYosEL
         IMNVZv82OaIP5GRl/6RM8mQQNc4speEXmCmZPXpV1t2Lo1qAfIaGx3iy4Jv8D8/N31
         VbDI1EYfobr1A==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id t8so677273uap.0;
        Tue, 15 Jan 2019 01:02:11 -0800 (PST)
X-Gm-Message-State: AJcUukcIPuVbD9i+lDbNUYWL7r4XUTT37iebXWnTMtfjObmxY4wIgZyq
        ZWBxdKIxuKnrd1mF9IK45SVjq6B6Wv5MqogyIps=
X-Google-Smtp-Source: ALg8bN6fdGDoYkUwR9CwA8Gr4TLXrwchn9tciI1c6cXdVn6iH7//dRGWmmRTLrTlFj2u+rlRThwN0E67BhCmjq22x18=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr1146549uad.55.1547542929988;
 Tue, 15 Jan 2019 01:02:09 -0800 (PST)
MIME-Version: 1.0
References: <1547436479-10491-1-git-send-email-yamada.masahiro@socionext.com> <1547536378.afs6amsrzj.astroid@bobo.none>
In-Reply-To: <1547536378.afs6amsrzj.astroid@bobo.none>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 15 Jan 2019 18:01:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREyw=qhRO-Cvg4O2fOnbV=zVJDE_mRZcVTkKG+B1gkRQ@mail.gmail.com>
Message-ID: <CAK7LNAREyw=qhRO-Cvg4O2fOnbV=zVJDE_mRZcVTkKG+B1gkRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: remove top-level built-in.a
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,


On Tue, Jan 15, 2019 at 5:07 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Masahiro Yamada's on January 14, 2019 1:27 pm:
> > The symbol table in the final archive is unneeded because it is passed
> > to the linker after the --whole-archive option. Every object file in
> > the archive is included in the link anyway.
> >
> > Pass thin archives from subdirectories directly to the linker, and
> > remove the final archiving step.
>
> This seems like a good improvement. As far as I remember, it was slower
> to do the final link without the index built. Maybe I was testing it
> in a revision before moving those files into --whole-archive? If there
> is no slowdown, then I have no objection.


Thanks for the review.


I measured the performance of scripts/link-vmlinux.sh with 'perf stat'.
(20 times for each)



Before this patch:

 Performance counter stats for 'make vmlinux' (20 runs):

       5.266796537 seconds time elapsed
          ( +-  0.12% )



After this patch:

 Performance counter stats for 'make vmlinux' (20 runs):

       4.945576395 seconds time elapsed




So, the performance is slightly better.

Maybe, does omitting the 'ar' save some time?


Anyway, this commit is good.


-- 
Best Regards
Masahiro Yamada
