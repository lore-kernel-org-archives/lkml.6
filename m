Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0565EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61C920693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXt62x9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61C920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934026AbeFLIkd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:40:33 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40977 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933363AbeFLIkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:40:23 -0400
Received: by mail-io0-f193.google.com with SMTP id t5-v6so27093366ioa.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 01:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7Qk6eG9NSA+esUpuqsnwNoC8/IZiapYuZOkg1RG2Jk8=;
        b=iXt62x9cToEJQFKWNGPuMCKyZKpbap1OcCI2FElC245QpOWDvt7A9FTZRvIm8kho2f
         Lz7XqH8d6zfJLjp9taDOGZ8PJHVV5L0wHiC2mO1NmT6mRbUWdGlsuztIvudJELOSVYoT
         xrwk6vt0vEh8gTumTmRuExBWYtesj5Fp/9Rg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7Qk6eG9NSA+esUpuqsnwNoC8/IZiapYuZOkg1RG2Jk8=;
        b=Lf/D0ySwgCgCSCRv8qGAQott9oSULsBJ0gEdGB7BZ2NqPlpRyE8R52gmI91xTBb5iI
         Gt2LQdEIPpK2PTbEmgJ5O90ozmzfXTNQJv/rQAeyOA31VwczHekLLzVRy6xmeU5ByqbO
         7RQg3ldMXrjXqmjWhq8/v25b8Cjn9+faBxdPtETtcMaJg5mrC2vszEwX+g16v0F8C1iB
         FqbzwW6oEkAiP1Y0hA8MK5xjbddCG7a5rS4gzszB7S3NIzT4wrhvJ3g0sdlKP0r6LWfQ
         DaPM8LIDMOLR5L+5KkTq2MKk2S7T9f3FtZb3jcE8rTHV3VCiKMcAgNL1Rr3jMu7nd7po
         TB5Q==
X-Gm-Message-State: APt69E2dU5vd3LUI7qCmR3dgm7JYA+B4PUIIcn7jh/zPpIoPXAGNkuSX
        7xPAMXTWMmp9Th4ODyiSircjj3JSd4ia1eYTxUXZIg==
X-Google-Smtp-Source: ADUXVKJXXoo0s3KzPgHvLysMWK9z7D06HWULYsK97IwFyfK8StS1TKrh+z4JwSNo/E3m5zv2Ndq4ceKbFOmUMQ6wEKM=
X-Received: by 2002:a6b:4a15:: with SMTP id w21-v6mr940805iob.277.1528792823245;
 Tue, 12 Jun 2018 01:40:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 01:40:22
 -0700 (PDT)
In-Reply-To: <20180604135814.101343-1-namit@vmware.com>
References: <20180604135814.101343-1-namit@vmware.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Jun 2018 10:40:22 +0200
Message-ID: <CACRpkdbqDKAkxjY1NsUpJ=UR0MVGivUdQz+BE-7MXXjZYa04bw@mail.gmail.com>
Subject: Re: [PATCH] gpio: Fix wrong rounding in gpio-menz127
To:     Nadav Amit <namit@vmware.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 3:58 PM, Nadav Amit <namit@vmware.com> wrote:

> men_z127_debounce() tries to round up and down, but uses functions which
> are only suitable when the divider is a power of two, which is not the
> case. Use the appropriate ones.
>
> Found by static check. Compile tested.
>
> Fixes: f436bc2726c64 ("gpio: add driver for MEN 16Z127 GPIO controller")
>
> Signed-off-by: Nadav Amit <namit@vmware.com>

Applied as a non-critical fix as I have not error reports.

Yours,
Linus Walleij
