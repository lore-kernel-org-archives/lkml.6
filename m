Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD333C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D4F21738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="B2yUFAJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfBTDoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:44:00 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:25805 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbfBTDn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:43:59 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x1K3hmen016142;
        Wed, 20 Feb 2019 12:43:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1K3hmen016142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550634229;
        bh=uNLuUaUNs+8lnMz4Xan9HCcP9v/sdwVesMIjfxIBp2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B2yUFAJ9MaQMJQ5gN39+oQPSDtMDGuVTe0houjbiaLrlNv073AkFeFewA6RHBySJw
         mLjd8TeBjXn3V6ixWYthnhBgJfXekX/yGo0U6rfvGcGvnyTBh7tDvrJTrlTRFJh26P
         wi3CdYcmrLRXYUu4qRBOGXVDPJ+Y5KmKzLy2fgQJwzMSm1kOuLExinu4Trv+6UhK9y
         H78dLwo24sEtCKNVfi3WfJCJyF4YbbNQs3adp60y2uctyzeELSHU8yTRFjF2N4E7SL
         VmMnTu6wnwUj84mrq3HPLKJOhvmEhmK+muSoPVVehOvU7yBCY4YcjJjSa1plEswHmr
         nTXO1R5b9eaBA==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id e81so9992567vsd.2;
        Tue, 19 Feb 2019 19:43:48 -0800 (PST)
X-Gm-Message-State: AHQUAuZR9Ex22/1d3kHE9eGkh8ndb/BBEleLJucpcouVedmGZkjnyMhr
        AzK4BnhnypmfIc7f+Zcxd/YppGHF89/SNlIdVFI=
X-Google-Smtp-Source: AHgI3IZuDefOlX5Gg2an8yXJ0xli+H8WJLwOJ5Eq2OEOHmk/5I+D/LJfvgsyNC9vISWFsFodYOnVnFetbT4vrNTWv98=
X-Received: by 2002:a67:f107:: with SMTP id n7mr109451vsk.54.1550634227665;
 Tue, 19 Feb 2019 19:43:47 -0800 (PST)
MIME-Version: 1.0
References: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 20 Feb 2019 12:43:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNASpwS_1-4dOiYzOu-miVXbt1qFsxJOHc33FRqRxWW4XHw@mail.gmail.com>
Message-ID: <CAK7LNASpwS_1-4dOiYzOu-miVXbt1qFsxJOHc33FRqRxWW4XHw@mail.gmail.com>
Subject: Re: [PATCH 1/8] kbuild: pkg: use -f $(srctree)/Makefile to recurse to
 top Makefile
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 7:41 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> '$(MAKE) KBUILD_SRC=' changes the working directory back and forth
> between objtree and srctree.
>
> It is better to recurse to the top-level Makefile directly.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Patch 1/8 - 4/8 applied to linux-kbuild.

I will send v2 for the rest
because I noticed some issues.


-- 
Best Regards
Masahiro Yamada
