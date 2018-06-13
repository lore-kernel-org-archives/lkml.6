Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2E9C5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F83208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DdBetgUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F83208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935417AbeFMRta (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:49:30 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34342 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934951AbeFMRt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:49:28 -0400
Received: by mail-io0-f196.google.com with SMTP id e15-v6so4372358iog.1;
        Wed, 13 Jun 2018 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aU1VeaWZoYJdHOijTiu+9TtBdicfvOtmGZ/Ed/O9fI8=;
        b=DdBetgUduE22YoqwAWhQxMZKlcPqX+iCEht9GGDxyZYRwoi2OUYsrcAtXWECi5OXwt
         dNABBwW1qPwnHzJVkjjhQ8RTlQDxn5lfmEIzmpOMomDlT54CZEnQ5iwUizI0AYxVgNKJ
         ZajXJlipGlPNcosQW3FW18GJoAbN9NsYbatKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aU1VeaWZoYJdHOijTiu+9TtBdicfvOtmGZ/Ed/O9fI8=;
        b=g/PpUlq6qcAMYS0Fy5SBdeK4dky9MpR/Z9LbWXybkqjPuYXzNvqs5vZpAcErV97xq9
         ZxyEPVpmHD5QR9H4e9VfRZC+y2zZCh0OzMYBPZTU4lrrrmx9jJFGMEJwTuZ/MQdxZkw1
         WjPWz8ZF8Fl0BcCSn7cUwL+R79hNUIBEtAOtpxNyBnGUeqPA+VT0BztuFGeZ9L0/yyNw
         1ZsLCa+09pYVNut6fSN6jp/Tl/PdXNskSvE3jxlC7qBLW/8rWfUoIIm3WzYxXeSjgxNB
         rR+Y8jqS+gzbBWmknx/KdMJPUoBp8ViaMMoe6TmYuEqtsR5QhorurVRKXn51iH9rBx0j
         MEAg==
X-Gm-Message-State: APt69E3qZeEdQUrf3fKIP63hPK1WhvXmuiLScF2q8HWNOFjMptzunQ1K
        022+MoiSrAs1yX1qFSYK2kcpg+vr82vz93Dqs3Q=
X-Google-Smtp-Source: ADUXVKKR2SvwpqvqvMMLSVyNWSnCUGX7JL/9ioMbSFRX75KMh8uqugFODVSXp/rLNu1GrA28SXJCHX5Mz5WA03xyTCY=
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr5893518iog.238.1528912167839;
 Wed, 13 Jun 2018 10:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARDLbEhbJGrKY6HGwfxL8ebAMBDa_2A+s2QkzQGEKyFHQ@mail.gmail.com>
 <CA+55aFyxY9f9_eGv3CvA0zwzo8K5WeNbNPDFuyhtCrzRyic85A@mail.gmail.com>
 <CA+55aFy2KEzTiF=0nG8_RFoPpycaqc=n-hf-mQSbKotMzYJG-w@mail.gmail.com> <CAK7LNASd7Mc8eU76L24ZC0OFdUf566adNGVvX9Ou987cT3CCWw@mail.gmail.com>
In-Reply-To: <CAK7LNASd7Mc8eU76L24ZC0OFdUf566adNGVvX9Ou987cT3CCWw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jun 2018 10:49:16 -0700
Message-ID: <CA+55aFz7KGMcvABxJfYs719ySyt2JouDX9t0SAV4Qu9yY9tfPA@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for 4.18 (2nd round)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 10:29 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I cannot come up with a name better than CC_STACKPROTECTOR_STRONG.

How about just calling it STACKPROTETOR_STRONG and leaving it at that?

Make the "CC_HAVE_xyz" model for compiler feature tests, but when
actually picking an actual option, it's not really about the compiler
any more, except in the sense that it depends on it.

I guess we could leave the CC_STACKPROTECTOR option as-is, just
because it apparently has a lot of small uses in actual code too, but
there is absolutely nothing that uses CONFIG_CC_STACKPROTECTOR_STRONG
outside of the actual compiler option choice (and config files)

                Linus
