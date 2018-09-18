Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBA6C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3E12098A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3N7LGvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3E12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbeIRVkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:40:36 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41661 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbeIRVkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:40:36 -0400
Received: by mail-qt0-f196.google.com with SMTP id t39-v6so2182022qtc.8;
        Tue, 18 Sep 2018 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3oqXhLdQSRFGXH/IjF86ZThN1kTAlHC49oqoN88lyHo=;
        b=Z3N7LGvs/9K0sELpzLoDBf4rOipe5njAdzAXnu6pPgNPv5Ni4GK3ZGLb2DgPtp/DSv
         oNSEKpp350loqhmt9VlqVjb6cLdjnY/mFGVnMjv2UxjdLbt0JNDW2MskdoMq8ePpIOIr
         eX2nERAYquYDvecVEDgDs55PZP64oOUoLOkPCM/gnAl+tz0bS9a81ec1OLAF6H4hHhuu
         JsluozZ3morgp8Pz93GD+tt9ub46dz/1LMIfckPdnT3YnbuuBhzzBwQuMPTNKltzUGz3
         G/VlHlHYw52nkuHy6/W95V+jevLVpkuHHlnW4ciaqx5iZ1m9pWcc/Y1toCK14Ywcfdee
         gZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3oqXhLdQSRFGXH/IjF86ZThN1kTAlHC49oqoN88lyHo=;
        b=AQ2BqPHB7zU1UYsBPof+XUN4d/2BqJ600na2Ph4qxnqHR5I98kUWuFhoLAF+c6gVBP
         uO5WspAVC88CP92FB/7+czVqao8dVANwzm8xQkbKJo/sD9TqcOwParztAFPQEqXm9RNS
         cvhikbP1BybSdmAn9jedpUtoUQ72aHeM1djJPrgPlOCca0ZWdqKRKMOEbEwS6qYUbj0s
         OFhKXbIUHG9w2BVzHKvh68wqvi00CMlvupa47mbH1bwE6uVR7J+aalyMLGdjZyWXcqfT
         5L3K4A8HG7t75mNI3Lg029kdgI/xZpnLKnDD4WBPAuNsi2urBVoCx1Hhz1qVzLSka8b4
         qh9Q==
X-Gm-Message-State: APzg51BVz/8+hHsrN5RsiMZd0vHm7MTw5eXNxRlz60uOYmNUAnYdw/J1
        cOTOuP+RT65LSyadjucRu5gO3bpHVN6ae5t41YQ=
X-Google-Smtp-Source: ANB0VdYtBP5IaKsw77rvAJKxBkSnGkkgC7aW6ppSHqnJGUWpCexoOtIii/eFzNg3DzWiboEzfwzshAj2P+HtlEwIHSs=
X-Received: by 2002:ac8:34e1:: with SMTP id x30-v6mr21872835qtb.115.1537286842362;
 Tue, 18 Sep 2018 09:07:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 09:06:58
 -0700 (PDT)
In-Reply-To: <20180918073005.GA4067@kroah.com>
References: <20180913235941.31211-1-miguel.ojeda.sandonis@gmail.com>
 <20180913235941.31211-3-miguel.ojeda.sandonis@gmail.com> <40a059bad54389ff2a9ddc26b9d99a4b@agner.ch>
 <20180918073005.GA4067@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 18 Sep 2018 18:06:58 +0200
Message-ID: <CANiq72=JnMMp=jTvqi4iiTrOXxRMHs3kk8h_ukr0ughtntdEaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Compiler Attributes: naked can be shared
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Agner <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 9:30 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Sep 17, 2018 at 08:19:50PM -0700, Stefan Agner wrote:
>> On 13.09.2018 16:59, Miguel Ojeda wrote:
>> > The naked attribute is supported by at least gcc >=3D 4.6 (for ARM,
>> > which is the only current user), gcc >=3D 8 (for x86), clang >=3D 3.1
>> > and icc >=3D 13. See https://godbolt.org/z/350Dyc
>> >
>> > Therefore, move it out of compiler-gcc.h so that the definition
>> > is shared by all compilers.
>> >
>> > This also fixes Clang support for ARM32 --- 815f0ddb346c
>> > ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
>> >
>> > Cc: Stefan Agner <stefan@agner.ch>
>> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> > Cc: Eli Friedman <efriedma@codeaurora.org>
>> > Cc: Christopher Li <sparse@chrisli.org>
>> > Cc: Kees Cook <keescook@chromium.org>
>> > Cc: Ingo Molnar <mingo@kernel.org>
>> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > Cc: Joe Perches <joe@perches.com>
>> > Cc: Dominique Martinet <asmadeus@codewreck.org>
>> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> > Cc: linux-sparse@vger.kernel.org
>> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> > Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>> > Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>>
>> Reviewed-by: Stefan Agner <stefan@agner.ch>
>>
>> Ideally this two patches should go into v4.19. Not sure which path the p=
atch should take, MAINTAINERS is not quite clear about that. This fixes 815=
f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive=
") for ARM32, which has been merged directly by
>> Linus, afaict...
>
> Good point, can you resend these to me with all of the acks added so
> far?

Sure (I think only Stefan is the added ack, though).

Cheers,
Miguel
