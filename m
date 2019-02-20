Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED0AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88312086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfBTPYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:24:08 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38656 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfBTPYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:24:07 -0500
Received: by mail-qk1-f193.google.com with SMTP id p15so2199946qkl.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 07:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w22eK6a8Js4tltFcVW7TveKwFMK0XS79riyQIh4CZsA=;
        b=O4mcVFv6VMInEGQmJYswutY1fpDxHsUtaFPoLU8H9dGqdZLGc/sb27XJO+DB31Qmtc
         P+dB7y0tDfg/89ioRjr785y1nv1p9iz5fr5jK+MKLuSuIpRMqHgx+P57NKb/ZwpKOXcX
         sKcjtJNWSywSsIB2UIOglO25xalI2mCTxc5TJYhgAVAKXsj4UN8we3V4NhohSSqC162I
         7beA2z8vcsREVZfjzvrSaiUNJ4d1CZOkUZa3x1wUAdf5ijzYjpT2ma6Ms5CNqwoTfwnB
         wtx1VXYbABm85XaRvKBP80Z/3NXklp42hYX5+ICPIhMyg/zIiJRUanr89JRpuwYX4nIW
         FjMA==
X-Gm-Message-State: AHQUAuaC9kfBTyknz4k/SpL4FflexTlelXZcp6wynGj/klBzMdlEg77W
        cTkA+BaZboxAIrTLe4ygDSpkcbM3YV/NXILjGSjrzg==
X-Google-Smtp-Source: AHgI3IYQZvIC+hpNskJMqI20c55HO8h6NwNwjM66GMoOuHES1G8UzV4Vb5IyRewvowztzHU+WCrpqE9JLUJSVVLLIEU=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr24083891qkf.107.1550676246700;
 Wed, 20 Feb 2019 07:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20190219091520.28990-1-natechancellor@gmail.com> <CAFA6WYP+vinWcM_wkSxaKfmRhG9hSZQSCh7f4WoUBEMWe-htbQ@mail.gmail.com>
In-Reply-To: <CAFA6WYP+vinWcM_wkSxaKfmRhG9hSZQSCh7f4WoUBEMWe-htbQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Feb 2019 16:23:49 +0100
Message-ID: <CAK8P3a2C9Vi0UPA29ncjFH89g2MahWDDxvULam2Xj46h3Wh6zg@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Initialize some structs using memset instead
 of braces
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 10:50 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> On Tue, 19 Feb 2019 at 14:45, Nathan Chancellor <natechancellor@gmail.com> wrote:

> >
> > Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/370
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I independently noticed the same bug, so I went ahead and applied Nathan's
fix with your Reviewed-by tag into the arm/drivers tree.

      Arnd
