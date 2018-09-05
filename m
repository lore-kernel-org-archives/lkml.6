Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A3DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2A320857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QnZY/kDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2A320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeIEVc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:32:28 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38168 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIEVc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:32:28 -0400
Received: by mail-io0-f193.google.com with SMTP id y3-v6so6548122ioc.5;
        Wed, 05 Sep 2018 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g13dGKG3e0acFZr/QaQsslKuY0c4Crqv1u5zuPVgiVM=;
        b=QnZY/kDX8Nvl5WTUsJGz36kp/lcSGR/y5dbRg7Woa7E4ax+E3VUfF+X1P/UFZOz44i
         E7zc8tZKKCttmMD6bMKN5y9tHEHwwxpCPt+Gt2PVFJBBQkXuDfYlIN9aCz6S9e03VdkP
         1PxXIIH+zeBb2F7Vy7M+sFx1F/MTuNNZuR9vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g13dGKG3e0acFZr/QaQsslKuY0c4Crqv1u5zuPVgiVM=;
        b=hpYWHppgfOXbsvdZNYSRoNekF+Q4u4UmWvbNl4m7AlcoALtGmG2VnA1G3RX96AQviU
         mcpbetQqPvIbWbPe+F7/35sCqrbteDO3bR9H3jWL3lqXsYaZx9ID9Nh0Fbg5nNSeQNVB
         W7OAjuVBT1nmVmsKoVLhwofslV2eJjWk6FZUZsAJTIvMa/bpgo1lpkC3YhddjzalFnDX
         prv9lKiJuci2e07maGzYlVtvY/NDYlIStEcGZ7yBD1CaVCtQKgxve8nCjJyg0GLJF/kZ
         Pa+dfJd9KRDanb4+1spzI258XQHItEc75jbl5aDh29JW2moWxSk9OSOo55Yk00jzTvNu
         nbmQ==
X-Gm-Message-State: APzg51AXri0UqRe+Y2rEINZ0Q2iJ/DB2xRpJZgGtcBdMGvKBFMu/Rpa7
        uqTQypORjphNt/X3j8JcYv018QYyyS2vp7XIptQ=
X-Google-Smtp-Source: ANB0VdYgq/xOaBZJezWSq+dmOMHRpQUk70f4CAYUu9zyqFCTItn7Lv0M/bAJnWkwpuWUGMGU3SeWfBOeMChMBE4AVLo=
X-Received: by 2002:a6b:7a49:: with SMTP id k9-v6mr27899143iop.238.1536166883711;
 Wed, 05 Sep 2018 10:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180903165719.499675257@linuxfoundation.org> <20180904162434.GA16396@roeck-us.net>
 <20180905090110.GC30538@kroah.com> <7d4d11ab-c769-44b4-0037-d1be7f45e2c8@roeck-us.net>
In-Reply-To: <7d4d11ab-c769-44b4-0037-d1be7f45e2c8@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Sep 2018 10:01:12 -0700
Message-ID: <CA+55aFzpnXYHNeog==-aWYO=V_67viGrMah1ZSdcDqcRO214-w@mail.gmail.com>
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 8:34 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 09/05/2018 02:01 AM, Greg Kroah-Hartman wrote:
> >> ---
> >> [ 9990.754641] watchdog: BUG: soft lockup - CPU#5 stuck for 22s! [kworker/5:1:155]
> >> [ 9990.762601] RIP: 0010:smp_call_function_many+0x208/0x270
> >> [ 9990.762601] Code: e8 0d d1 77 00 3b 05 cb f0 24 01 0f 83 86 fe ff ff 48 63 d0 49 8b 0c 24 48 03 0c d5 00 f7 11 a7 8b 51 18 83 e2 01 74 0a f3 90 <8b> 51 18 83 e2 01 75 f6 eb c7 0f b6 4d d0 4c 89 f2 4c 89 ee 44 89

It's stuck in this loop:

   loop:
        pause
        mov    0x18(%rcx),%edx
        and    $0x1,%edx
        jne    loop

which is csd_lock_wait().

Judging by the offset in smp_call_function_many(), it's the final one
(there's two: the other one is part of "csd_lock()"). But that's just
a guess.

Anyway, it means that we're waiting for another CPU to finish
processing an IPI - either a previous one we sent asynchronously (if
it's the earlier csd_lock() case) or the TLB IPI we just sent and
we're waiting for completion of.

> Not tested, but I see it in v4.17.19 and in v4.18.6-rc2. Turns out it is
> related to heavy load, not to suspend/resume. At this point I suspect that
> it may be an AMD/Ryzen specific problem - it looks like it disappears if I
> add "kernel.randomize_va_space = 0" to /etc/sysctl.conf. No idea if it is a
> CPU bug or some AMD specific code problem. I'll try to analyze it further.

Ouch. Some IPI sending/receiving problem would be very very painful to
debug if it's hw related.

              Linus
