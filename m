Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED2EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA046214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA046214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koikeco.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeJQMjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:39:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:47074 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeJQMjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:39:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id q12-v6so15673812qkl.13;
        Tue, 16 Oct 2018 21:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SvxdV+DeSaWc3WWNI2HFC0gb8fgI4Qrf3SATdZFzkSo=;
        b=RECmOfo3eCF5P3pOf7inPivdXRDU+B/CoiYAufPopICzl+QPzfsWCbisv5T5MYgY/t
         Nr9scTU5DA2YV+tzxKPL23HipJjf1qqYYJLPhlaeKa4eXtyWP8BwpL6lydlZWIg8INZd
         /epwLMZuhnc8svQquHwg8sYTlr41+6LJAyHPiIZlaTf1Txvouwh5d0BnrRBVDoHquDaC
         NtebqVSsucHW38DGiJEGJHadNU2YWbn4t2X7Ce7cXx3lPemNFlBvfR031ncQwUDo1AH9
         nxHkY+K+pdglBHaX55kiHDWvH3F0vqLAG7cr/AvWzUE1xv3wvGSpo6ZwfE4Uc6MLcDg5
         2TKg==
X-Gm-Message-State: ABuFfoigLWh27VdYwxFYBwdArKT/mDV/XWenI7sfaR9rySFnzFc1xJ2G
        CMX9YjHoh4Gvchp7ZQpo/uU=
X-Google-Smtp-Source: ACcGV609mCbqYI6EGn37FtApiWLu0mxmAFsYE+XqDbKXUkGHxuHuUY2/1XsJLYVQDctnEI3dXyBU1Q==
X-Received: by 2002:a37:ddcf:: with SMTP id u76-v6mr22401083qku.184.1539751560260;
        Tue, 16 Oct 2018 21:46:00 -0700 (PDT)
Received: from ?IPv6:2804:431:9718:6346:661:e081:23ef:66b? ([2804:431:9718:6346:661:e081:23ef:66b])
        by smtp.gmail.com with ESMTPSA id 128-v6sm8501361qko.7.2018.10.16.21.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 21:45:59 -0700 (PDT)
Subject: Re: [Lkcamp] [PATCH 0/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
To:     =?UTF-8?Q?Leonardo_Br=c3=a1s?= <leobras.c@gmail.com>,
        lkcamp@lists.libreplanetbr.org
Cc:     x86@kernel.org, linux-kbuild@vger.kernel.org,
        Matthew Wilcox <willy6545@gmail.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181017000722.GA20892@WindFlash>
From:   Helen Koike <helen@koikeco.de>
Message-ID: <00beb3a2-e68d-4f6c-d69a-8413acc214c4@koikeco.de>
Date:   Wed, 17 Oct 2018 01:45:54 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181017000722.GA20892@WindFlash>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo,

Thanks for the patches.

On 10/16/18 9:07 PM, Leonardo Brás wrote:
> This patchset add -Wshadow=local on KBUILD_HOSTCFLAGS and fixes 
> all code that show this warning.
> 
> The third patch was already submitted, but was not merged yet.
> I like to think it's part of this patchset, but if it was 
> already merged, please ignore it.

You can check if it was merged in the maintainers' tree, if it is not
there then it is not merged :)

imho, I would prefer if you submitted it as a v2 with an explanation of
what changed since v1 (e.g. new commits) or even stating that nothing
has changed and you just regrouped it.
Or better, you could also not re-submit it and just point out that this
series depends on a previous commit (with a link to it).

> 
> Leonardo Brás (4):
>   Adds -Wshadow=local on KBUILD_HOSTCFLAGS
>   Renames variable to fix shadow warning.
>   kbuild: Removes unnecessary shadowed local variable and optimize
>     testing.
>   Changes macro usage to avoid shadowing a variable.
> 
>  Makefile                     |  2 +-
>  arch/x86/entry/vdso/vdso2c.h |  4 ++--
>  scripts/asn1_compiler.c      |  7 +++----
>  scripts/mod/file2alias.c     | 14 ++++++++------
>  4 files changed, 14 insertions(+), 13 deletions(-)
> 

I hope this helps.

Regards,
Helen
