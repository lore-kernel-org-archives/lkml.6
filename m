Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F19ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F6020883
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ANpgjXFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F6020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbeGXSpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:45:41 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40370 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388414AbeGXSpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:45:41 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so4855728ita.5;
        Tue, 24 Jul 2018 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BCJUgo3VmES9ZNd5k7h52n+7vq5jYqixBeFxcSoDsKg=;
        b=ANpgjXFXSjp5DI5KYstwUie6UoG4YxBfJiljIGkvl45WL1+9dzbhaSXWokVBLfgTcq
         lWcDPcHkHbDFUfNRkgn17AjSQcWi53W/m20Dae49Aan1lbaIJ7mc+Y6Wn1RHyuzlr56l
         coEyBeKyLEmvu/jBEJdOZp0u5Kzc4l8Zh/FEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCJUgo3VmES9ZNd5k7h52n+7vq5jYqixBeFxcSoDsKg=;
        b=kyZXoF+pPV/9XF8EpsllM1SqMsvOHGr+VxjJEGq10HZX/cayU01vc6tyNXWwJk0A+v
         h2cLLHwxnkJa4b+hqU39oT84MlRj8dU8M1hhoWTPvTWdgEKqFYS7pCUIW2qYFt5PYGa/
         wSCO3WqtYQtG7dSEHPk0BpIgQytR8+XGBoZXS2v4iujianxQ09mUk/XT6hNvx6pCWsaR
         WjakvjMyN1DivGGYKFYzOqhMAOBbMCHbEkBCfoLPCkL0HYfzY0nySeyH92G7XIM4XZwL
         UN8WCdfiKjd8iAQXIf70VjmUmRzRncN8gzanLZNSNQSEeWtBI49gRgu8ASFV23AflqPK
         OKpw==
X-Gm-Message-State: AOUpUlH0ZJMRAov3rZQkas7sfZkaDTO5iySuK3RJrVbs9FRgOMzy2JlK
        I7gOMuwUwxAGIv0MhcmiinjxDP5K+o4OESH1f4EEeA==
X-Google-Smtp-Source: AAOMgpe+/NMA23h0cUMXV81h5HBXuxMRQAliccrtBSpARxBBq2REHprhUW9nGPSax/5486NLKPdiJV4jQoaXUbegfuI=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr3487603itb.16.1532453887401;
 Tue, 24 Jul 2018 10:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <1532381973-11856-1-git-send-email-linux@roeck-us.net> <20180724004110.37d0e5dc@coco.lan>
In-Reply-To: <20180724004110.37d0e5dc@coco.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jul 2018 10:37:56 -0700
Message-ID: <CA+55aFyV=5QNJXn+t_ZDCigGi+HjM6N94DRb_E50_xUsk+VTFA@mail.gmail.com>
Subject: Re: [PATCH] media: staging: omap4iss: Include asm/cacheflush.h after
 generic includes
To:     mchehab+samsung@kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Staging subsystem List <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 8:41 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> While I won't be against merging it, IMHO a better fix would be to
> add the includes asm/cacheflush.h needs inside it, e. g. something
> like adding:

No. The <asm/*> includes really should come after <linux/*>.

This is a media driver bug, plain and simple.

We should strive to avoid adding more header includes, it's one of the
major causes of kernel build slowdown.

             Linus
