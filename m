Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EC3C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 19:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C032082C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 19:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO9xKHns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C032082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeJ1E3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 00:29:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36959 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeJ1E3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 00:29:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so4304955wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 12:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hIUgqk80qYi7BCDY9mXYCIvlqNz5V9y+3GPF6/XyZbs=;
        b=hO9xKHnsTBmdzYOHRXnSt2la6KIdhsIa4axc/3AiSRQbCS0WM4gYUe6lVth/QPFY23
         HbgXwHGs5TBNxnqPm/QKiqFTNCyQGwOkOUO202zHcddbwXAf1CmlHzOya/7gwTmwY4o+
         tUwgfbfcYGhi0ylcqDfCQ585UTWf+GMGASCpF+9+QUdaz8gkbX9jzeSszTDlNLN/+J6N
         a/Qb49pwab2HvZ1gmTVLEytIflEM426U75FZINBMxTWJ13X4feiNIhoh+7twhhDQPTgm
         RrhwAeMZOviU7KGiKoDN9bJcqYeyEBjIHsLoS8r0XrIi4XEUfGMuVxv6W748ytndG+9B
         xztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hIUgqk80qYi7BCDY9mXYCIvlqNz5V9y+3GPF6/XyZbs=;
        b=A9twMfIVM29GPZ8tdSu91NrlJuMhSJdza1jl3SEKwrkjw4vmo5gXhwfvo7V7S1/a0Q
         TKmr2mlGuEnON2imSWOK8PyZPsd0wvB/oi624/hDWGh3rrl57fsMKMnjaI/2OSEBeC2C
         Q3mrorwvoQXCVMjnZ/fPuUPCQHktIfWU5aOsl/2z88U4oFrdgZdFUAyJqr4K60nE0h0/
         tR408DUumv1a43fAoFTTUIdNzmBdPiCfiPoHtcuxzVxkCCjSaeyqF3iDgH8sHC1ve8My
         OoMsYlYQj7vjMHysRnFYGZVmt7Ycx79cC/i47okYrn3T98onaBP2z/dyRe29VHAh0rLB
         0guw==
X-Gm-Message-State: AGRZ1gK/lo1Buz6YgRHdwqpqxn55mqTX/tWOi2LWUQMQzIC70Yb9AlE5
        NVP9PAcvauNtRS31ZEAS2w==
X-Google-Smtp-Source: AJdET5dzT+2NLKWhfVbbVkQkgQ8wx+d2u6rDT/lO+7SscYecmjlrCsAS/+0ChwJlo4E8h+VKAMh2Sg==
X-Received: by 2002:a1c:a88b:: with SMTP id r133-v6mr9153380wme.97.1540669649347;
        Sat, 27 Oct 2018 12:47:29 -0700 (PDT)
Received: from avx2 (nat5-minsk-pool-46-53-217-92.telecom.by. [46.53.217.92])
        by smtp.gmail.com with ESMTPSA id y19-v6sm20463012wra.60.2018.10.27.12.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 12:47:28 -0700 (PDT)
Date:   Sat, 27 Oct 2018 22:47:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: proc: move linux_proc_banner to where it is used
Message-ID: <20181027194725.GA30155@avx2>
References: <20181026212034.5491-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181026212034.5491-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:20:34PM +0200, Rasmus Villemoes wrote:
> +#include <generated/compile.h>

> +#define linux_proc_banner \
> +	"%s version %s" \
> +	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")" \
> +	" (" LINUX_COMPILER ") %s\n"

Include doesn't work if compiling from scratch:

	rm -rf ../obj
	mkdir ../obj
	make O=../obj defconfig
	make O=../obj fs/proc/version.o

  CC      fs/proc/version.o
fs/proc/version.c:2:10: fatal error: generated/compile.h: No such file or directory
