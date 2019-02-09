Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5118CC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 13:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD6521773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 13:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7gwMPFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBINAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 08:00:53 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:37714 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBINAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 08:00:53 -0500
Received: by mail-wm1-f44.google.com with SMTP id x10so2807962wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 05:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9GAF514zp7u1ukVPMTmRTpOKo5aenr5g18trxp3tzpI=;
        b=m7gwMPFAF5VB9ZJ5EVWDYX1RFP9XI2e0OQaVNQsYaUhnGBkjIy5nZ+8JkXLf56+OAJ
         y6Em6ujzxx66e4Bzg0v6o2fO76SH07Qm7WTcsXv2ORZ1TSV5njJNTlP5rvVGzS82qoKW
         nY3ioruCVM2qyDAE7q1vJP4tfuIIT3rsmg/vQrrcQyLdOec/7tGrbuhK3kOI6qwkKFuZ
         OktrIGQ23QkeV2kgprT/3S0KETrVEdQw4TlSHVH5yUmEqy+z7J403g2JEtbiyWBlDjpu
         CLNr89YlagOzhSRmVKP1cHFBzsSaFRNuyTXDAS01t1DMNvMSQep7PygtKrwCI/Tte4+s
         2BKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9GAF514zp7u1ukVPMTmRTpOKo5aenr5g18trxp3tzpI=;
        b=CdS6uTz3B+wO3FWJWj1b/LX36/m4Tmxq6DQacWwRJGQEnQVz6simS45IlchdBAiIgr
         8L9H0jAAWf8yh6omzszASiTZjqjm8meDTMrBAgIG1q+YUVgaR4HsYPNWBi7PC03a5zSG
         UMzy+0K6jBTnxQY3SYXyagWyeP4rWpFMfsurEztKMSswlPsZI9JVXK6hQp+UkQOgee29
         0KGmrpUF2mbK47LGWH21D+nruUhuQO+YX566qTiv+ByC5ttejpUPg7MXJEbaS0ka1D1M
         1ZlfJlItCnAFfnd/JXgIhHDNqwdUDBFov9jhsyMLtNTxHGUVEjG5WqBCltoNibW8gclD
         XNFg==
X-Gm-Message-State: AHQUAubEUCBIHICWZRT+ZAdcGt+jSipPYVUeSbpNcdhEdGbHNnxbdS2j
        djthp8BcWutvKqCR4f843AdHIuM=
X-Google-Smtp-Source: AHgI3IaG+7RrSKcGu74OBFGJUpOPgsoS9jVJQCAzw99XEVOoL4xgYwYqn9V1epplYrqPHFnB3F4Q2Q==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr2753841wmc.87.1549717250613;
        Sat, 09 Feb 2019 05:00:50 -0800 (PST)
Received: from avx2 ([46.53.242.39])
        by smtp.gmail.com with ESMTPSA id u15sm11034196wrm.63.2019.02.09.05.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 05:00:49 -0800 (PST)
Date:   Sat, 9 Feb 2019 16:00:47 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     yamada.masahiro@socionext.com, ndesaulniers@google.com,
        luc.vanoostenryck@gmail.com, keescook@chromium.org,
        linux@rasmusvillemoes.dk
Subject: Re: [to-be-updated] build_bugh-add-wrapper-for-_static_assert.patch
 removed from -mm tree
Message-ID: <20190209130047.GA11849@avx2>
References: <20190208215824.zhXpv%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208215824.zhXpv%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 01:58:24PM -0800, akpm@linux-foundation.org wrote:
> --- a/include/linux/build_bug.h~build_bugh-add-wrapper-for-_static_assert
> +++ a/include/linux/build_bug.h

> +#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> +#define __static_assert(expr, msg, ...) _Static_assert(expr, "" msg "")

I suggest adding it to assert.h like userspace does:

	#include <assert.h>
