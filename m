Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60975ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1143C208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7+eSaVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1143C208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeGPKuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:50:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41526 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeGPKuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:50:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so24665566ljy.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=csA1vgGjv51f0Y+zmZvbR6JwTfJt3War3odYCSLxDDQ=;
        b=t7+eSaVSJNJsF2Ny1xWHgu7hV3eNIkOYBEt0rVjMDHZ1l5pzZlq1Jp1TKMh9UXJ/mM
         v6V9p6SezAPXKu3LXQjoNpn71jXmTRa3GgjHBrh99q0yaWufPvGSKhBoOO7xrDilBGgh
         IGHGp0MyMUSeHSDsj3S37diDniuB7J3B+T4FN0Wdnby81pHwO++LCwRgxhHe95qKccfb
         m8oz939PPSd9NvsQmcijFZ2gVy6MmjVjcrD9CUOtoI9zlQ6FMwneYVoEiIANFFhydN5b
         mLLzdSAXgG+TM8M3BHnfpee2CJ09rpqOBJ03pqSfPsqgjtD1eB93knDcaKFZwXNyUhPX
         eUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=csA1vgGjv51f0Y+zmZvbR6JwTfJt3War3odYCSLxDDQ=;
        b=la0TvAGo3HPRIDVoC5I/uUtOvWtrt149C0at19H2ogTs+EzvrYfaTkzxh1SQoyPnX/
         RMZM9e+7Ac62dUrCHUg5GLsbaLdQ5vRGRZl2NHRZV6kd5U7e78tCKbpOCXxx2bd5VSPp
         Y4Dc7VQp7VYkaJd1/mCvq57op+qKiZXrfJSm4eaNy1Ony9R24+wYVVayFDNS5dKUdNeB
         NHgJcsjzw3ojswLIkhefKQedLiKhmxGEXrX4vLbuTIH0e9KfoGQ81pfYwIWgkGbB2A9U
         /qXFXX3vFIga9IdjNGB0JTbYRp9uW806k9YjWw7Rbf8zAmjrUJb+TY8frI9boPVwCEtD
         TXJg==
X-Gm-Message-State: AOUpUlGXGGCzcmdQl2wh+Fmrnhrfbxp4WZ2hlyL7IoCEvhG7xiPUBnZV
        fP5gxj+HoQNO9qETVgeqgIu4I25A6QjrQTBvyIY=
X-Google-Smtp-Source: AAOMgpdEHFzLTqkXwIlyR+zq6ellomUEGzFxR5UP7ClF2GsyledBTYFRsPZmKyYVuHE8b+gzqctyLi5hP0AG4IP+Ysc=
X-Received: by 2002:a2e:7c12:: with SMTP id x18-v6mr5420809ljc.71.1531736636915;
 Mon, 16 Jul 2018 03:23:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:23:56
 -0700 (PDT)
In-Reply-To: <20180716035912.GA32261@beast>
References: <20180716035912.GA32261@beast>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Jul 2018 12:23:56 +0200
X-Google-Sender-Auth: t0SliyRPJ7uC-7kNhSluyja-tRI
Message-ID: <CAK8P3a10ONoVAt8+5TNaYzM2qaH=0THkx16tZCd7hpcx-TWvBQ@mail.gmail.com>
Subject: Re: [PATCH] dm crypt: Convert essiv from ahash to shash
To:     Kees Cook <keescook@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 5:59 AM, Kees Cook <keescook@chromium.org> wrote:
> In preparing to remove all stack VLA usage from the kernel[1], this
> removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
> the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
> to direct shash. The stack allocation will be made a fixed size in a
> later patch to the crypto subsystem.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

This looks very nice, it should also make the operation more efficient in the
process by removing one indirection layer.

     Arnd
