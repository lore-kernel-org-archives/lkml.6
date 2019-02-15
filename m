Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6CAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B68A222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrvH0y8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfBOT2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:28:35 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51135 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBOT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:28:34 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so26869064iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=16BwAubb/CEwkuqEMJJnIJO3EunA1ix3duMQL+2f3lU=;
        b=vrvH0y8CnGZA+tV0X6L3rT1mEM3hnJbKb74e73VtQceln+xtO+nEuVWFNz+6M8w94M
         43OKbKsezU7WxUM2TG7EK8vokj00UG6XsLIH21SwZHvyucRvnG9viI7P8Zlje97csZrn
         Qju78pIFbEWpVlGEMcQ9/naIo+qUBQr0ove2phUWYLLBm3o+4igUVEa9gLGfjPsNacJj
         VMCFlAhgwv/GM5jBDXON8ZL2dLjSbCd1DjlUkPXlxwSb9hBogIb9Ok6v/BwPNrnSlOaH
         1xXOj7DWrn8YXM8x3wKyl4PHWTbspDqHjj0uIanx0OxuTG+1DTLRW0lcv+sbwjlqY8D7
         9b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=16BwAubb/CEwkuqEMJJnIJO3EunA1ix3duMQL+2f3lU=;
        b=qbVU4NdwL6+RgHX7JpfPXP0kNwVOpMoHPVw/mqQpALrmIkR41JdMVYvHnr8Fg/l3sV
         Y8IBidmxO0e1vzfkf01yWQdkYlkO5ktTL2KkR/0sX6twEyuCbpybE5+wUZLJhH+Lsil3
         EaFjN0vpdjDqn2xYlPGE7pPVtcHNqJNKc3T0eFGlnWr1HPbg6Y2mqO0FgX2oslEOKj7P
         BJo44nAT58Ksyqlgu1iYrEEvQd0H3R9qby0LuOjqJDvgFApLZxd0xbP1fRp18ZE1DZOb
         qrtQhQR/tPHTgaj30NtgBFQqtrnwlHJ2FZwSDhVgYiYtzvzdAMI+21Kh/nfobig6oe3i
         NubA==
X-Gm-Message-State: AHQUAub+BuAX6i2+zBHoxFNL1HtfQPEQSQBO5e9kZZdhmdiJkDOL6+wz
        6a2Pp4Aae5apdg51OUiEsKvB0k6NmI+yj5ynKaesAA==
X-Google-Smtp-Source: AHgI3IYBKcAfW/QJVhSHH0YYCs8IpDhzCYCUusmu9NDi/3WEs647Eo9ViDhl+Z6uSw1Z6fyDCC5P4LsybC616Hrg4xs=
X-Received: by 2002:a24:c3c4:: with SMTP id s187mr6590904itg.158.1550258913880;
 Fri, 15 Feb 2019 11:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com> <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
 <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
In-Reply-To: <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 15 Feb 2019 20:28:23 +0100
Message-ID: <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sandeep Patil <sspatil@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 at 20:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > Provided that we stop sending Clang enablement patches to -stable:
>
> What does that mean?  We're trying to provide clang support back to
> 4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).

I understand that is what you are attempting, but that does not mean
it /belongs/ in -stable.

There are rules for stable, and people that track stable kernels (such
as the distros) should be able to rely on us to only backport bug
fixes, not linker script changes and other updates that fix issues
that did not exist when those kernels were released.

It is unclear to me how these clang changes benefit those users.
