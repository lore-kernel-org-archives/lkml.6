Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184F0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADBB208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBINXLb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADBB208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbeGPKof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:44:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46396 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeGPKoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:44:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so18413319ljj.13;
        Mon, 16 Jul 2018 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=o/6Lyz0w/afGmRq5IKZ4vjVV/6xi1QhEFLL8L4wryF8=;
        b=iBINXLb0i6AxofkMxav10431K/Zs31GoefXyNJ2o7Wu8P5bfuEQ2udJpWtWNhAoRaN
         hTll7ofzS5T2ZpwHIgyHsZOIQwzxlqqHZY9QyD5GVTavY03PKTjsNGfdlCibbGlE45Ku
         Xd8kSB9VsWHKF9EWUx1AEFXMAeRVG5+zB6IMHMyVBrasLLVOk9Jhyx0nTGIZ4VbXsYwZ
         DYrCNSGN6rYSfmojunG/2SyXX36OKUSEBPxabZPdeG0cI13d7lEgR90xxWp4hI5urQlO
         8Y8w2lM+has6T5Sv2AFQEnHaIIdHV7tCLF+O3S+W4OGYBnYH+0SoGkWClkK3s6LFHU1V
         lZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=o/6Lyz0w/afGmRq5IKZ4vjVV/6xi1QhEFLL8L4wryF8=;
        b=sP6IgdhJLH3ogKQdsRPzNP6dCYjDNvurUSMPZhg052JRiMVCDU5RhO5SAVxiC+OHPO
         2Z9DKp3XF7EuUqgTaYX8Euc3qyFbj4Ig9jo9/iIXgYseQnd/RfLubPFCHeZfS20ytYUC
         ThCjbEsYsFmcLJVLQFWKJ3e6AoMXxlzk5psadzNWz0H6AKVQwUpmFScLxST1OC9f34MA
         /qez8dc0Dp5jeXSASDiZTv3Ekq1UWqFsTBUdhnHXudtM8CjepBp6I1jdMccqBsjtwWnC
         RyYnJaWbs4cN5AS5hUIfIYu2JREsbqyVkE4y2X3sBI0u8etNS2xMMhW+daP7neEKernw
         ypyA==
X-Gm-Message-State: AOUpUlG9M4NvSe8IzasizoHXmqrdg4XktMJYaaPzHDWEevvkn2gerp9Y
        NFS+RefneYlRw8KsOjpTut5pGm7YQBiuF/W67R4=
X-Google-Smtp-Source: AAOMgpeqQCktD0KNGnwlRJf/0zjkbhJE6jCcdej2aBUqJArvEX8baAsjXhDE0TmS0hqxH+sICy5+OaKAzVA7W1ZRnlM=
X-Received: by 2002:a2e:118f:: with SMTP id 15-v6mr9531636ljr.38.1531736270871;
 Mon, 16 Jul 2018 03:17:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:17:50
 -0700 (PDT)
In-Reply-To: <20180716034947.GA32022@beast>
References: <20180716034947.GA32022@beast>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Jul 2018 12:17:50 +0200
X-Google-Sender-Auth: SlERCLOWRH5bfBUqpQrYtabtcEg
Message-ID: <CAK8P3a3Owx8SMtenkOwXtqLCk_P8B18CNRkLfyL+GFUW9rYU1w@mail.gmail.com>
Subject: Re: [PATCH] rxrpc: Reuse SKCIPHER_REQUEST_ON_STACK buffer
To:     Kees Cook <keescook@chromium.org>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 5:49 AM, Kees Cook <keescook@chromium.org> wrote:
> The use of SKCIPHER_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
> (when less than 2048) once the VLA is no longer hidden from the check:
>
> net/rxrpc/rxkad.c:398:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> net/rxrpc/rxkad.c:242:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>
> This passes the initial SKCIPHER_REQUEST_ON_STACK allocation to the leaf
> functions for reuse. Two requests allocated on the stack are not needed
> when only one is used at a time.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

This looks like a very nice solution to the problem.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Since the large stack usage could already cause problems in older kernels,
should this be backported to stable kernels as well?

      Arnd
