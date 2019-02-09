Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98F9C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 11:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3FC218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 11:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sloN88Sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfBILTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 06:19:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32837 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfBILTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 06:19:42 -0500
Received: by mail-lf1-f66.google.com with SMTP id q12so4478401lfm.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 03:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzhsAG0RQTwUbOAvsKDS2cY/SEjFWL07YCaH23xRSKc=;
        b=sloN88SaOy8sTCYfiW7wToATP/SlnemMhAABePevUM5KHJtHAyf/cC/42PEaMamiAP
         s4QjNwYp9fz83IC7a0dgYvjfUsA2UsYNtUhT1BGX0hJydS+S5SNSMdduc37IIH790+zc
         n4b6niUmnBbmi0SEM+TGUmLNeH1rE2pjQA7L0xmCVy8ztXxErdTNTJQTymgp4EQkmlEA
         KTHLT8SmAVjZ1Z7MDfzneJpmOKEGETyaPGWSbNMm4Pkbv8CN4ldx4jsVjJaKL5xvjJNx
         Y4KJa/EOpJmTRihvwgdjK9InM2s0myrYzu2JyeYh/mXWL3PbXn1d08IujFo9iUaMGiAF
         fidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzhsAG0RQTwUbOAvsKDS2cY/SEjFWL07YCaH23xRSKc=;
        b=p7GGmdD/rHubbyXTddoczcu5/Jcl3Z7knvH6xkl6/eJEyL02/m/ClkBcchYH2Z43lt
         haC78RtWAVVO9kHxRPwySocmtRsbfntVNqeBzTAnXnAjlhnHvU5W4Ytpjyl61hq1CosU
         5CTi5FW27Kmw3yX92m1TnMfV8bsuAH4BRLA79aUYGOi2crEWTy3TZjmSd52IVnOACqIM
         NA6peuVDjLskWhXVrHf5Gpes8JrtjJ54jYQ6lNltwbFyofC3ZiKf5Ri9UshopVO93jk6
         And6WVrWfZvEOmXPBuJ/2ryQh8UulEsSnGGFEOSNiyV27XDG0+oLalVYNSIAkDTAioa1
         z88w==
X-Gm-Message-State: AHQUAuaeWtvGBR6Bf9CBLCYX9O87eM9nPPyYxC2u7EdrGBIHqSsY4Yz1
        0cHO24KU0r7wlSMD7dGyO9z2stjHuaLdDWpG49o=
X-Google-Smtp-Source: AHgI3Ib6fvVECgZJ2vpvif1l0w9//act0PCIaKgp2aRtpExsLwd53jUCGe5WvjWJsW7azKtlke1WHIw0a7mcYGZfDY0=
X-Received: by 2002:a19:24d5:: with SMTP id k204mr4639295lfk.88.1549711179752;
 Sat, 09 Feb 2019 03:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com> <CAKv+Gu83rXGH5hVdHXM=65zQkc5FtG86xMccT7WByUFy9BmXkQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu83rXGH5hVdHXM=65zQkc5FtG86xMccT7WByUFy9BmXkQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 9 Feb 2019 12:19:28 +0100
Message-ID: <CANiq72nf2qyNxJ2Z9nypzqUC99-v5+WC_f3o98P-zoMqy+5sLw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Clean the new GCC 9 -Wmissing-attributes warnings
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <james.morris@microsoft.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Borislav Petkov <bp@suse.de>, Matt Mullins <mmullins@fb.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        WANG Chao <chao.wang@ucloud.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 11:44 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Sat, 9 Feb 2019 at 01:09, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > The upcoming GCC 9 release extends the -Wmissing-attributes warnings
> > (enabled by -Wall) to C and aliases: it warns when particular function
> > attributes are missing in the aliases but not in their target, e.g.:
> >
> >     void __cold f(void) {}
>
> Apologies if I missed any discussions on this topic, but I would argue
> that 'cold' is not an attribute that has to be applied to the function
> pointer as well as each of its targets, since it basically decides the
> placement in the binary, and it doesn't affect the nature of the code
> being referenced.

It also affects the optimizer in two different ways AFAIK:

  * For the function itself, it gets optimized for size instead of speed.
  * For callers, the paths that lead to the calls are treated as unlikely.

So GCC reports it because you would be (likely) missing the
optimizations you expected if you are using the alias instead of the
target.

In our case in patch 3, we do not want the optimization for callers,
which is why we don't mark the extern declaration as __cold (see the
commit message).

Cheers,
Miguel
