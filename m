Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60D7C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FBD2083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrwbVlod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FBD2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeIARLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:11:05 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42369 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeIARLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:11:05 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so17465778qto.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=soLIkjCimvaLklnISTOpLPeVHQRO/fuxRRL77spNXxk=;
        b=LrwbVlod2OVeKoac+m5ia1ofDj58kFd7KXvsBEhF7+9TmBfUroFZ6KaA9lJLVkHIq9
         tRDLgIDWuT5tVYWoixVWun7fURWU7vK/NZQgKPbM0c3ngHSHffQR6AOc2D1wRkhpOj2Q
         bIRorv9GZ5cpsDy3FS0c97d+uMEKV1eG8+UPNhClBuywTsXD7dXeiyq24Qrs9/Gcr174
         kucpIwmmulResZeq/bQAM3xHJREYqf0txGXGxiutCgpuXP8HFDOwmyUFwP5pKYwBnNOB
         5vYWd8C6PZoy6LcCdk+cQiLAYGeZjYXP7K2Vkz8WWMJ4sDgXiQ07EZHBqCg2tz3a+8BO
         ce1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=soLIkjCimvaLklnISTOpLPeVHQRO/fuxRRL77spNXxk=;
        b=B4MlE06diTp/QH/G4OqpYz8KPtB+mPdQezyc9Zu3h8iwmK0UPuMnZGVo85SJ6pKEtl
         jcYPibDu2dfrZ9yTPQ4Ed37nVO7mz4YcLr41AkUSoug6WeTgVR8VOooELaskZtG9twnj
         WuxklPLsU8EncN6fVVeUGX6RtDq+rTIlZWj8cpe3XAJ5ETQ9iRnGzLMK/NEysYB83pRy
         bGfSpN1GDV9mGcHqxEEmd+dGsJhK3J8lcxGzxj1Svme2V8QCyqRQyTaLVHAdMOD47lf6
         CgUl1wO1PVqIyPuU618blZHMZdz+aYUjX8crh/6usBjoikFVsDbu0863yS+nvqwZ4STs
         3+1w==
X-Gm-Message-State: APzg51CyAIqWsXr3KqxMCn4n8JmCOrk3w4PvMFxzNlCR0R9Ys5e62z34
        HfqhrKzkE7C4gNIvE5U73TpiIuayAhxHe3yCjCLadMC0
X-Google-Smtp-Source: ANB0VdZoFJIIfbV4SyRw2LtrPET7D5TJpXUUeqi/VcdzXehEGawvsjAWL65buzWjA10y3mGvK0/QyPbhXLntLiwVKN4=
X-Received: by 2002:aed:3fd3:: with SMTP id w19-v6mr19688527qth.226.1535806745404;
 Sat, 01 Sep 2018 05:59:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2291:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 05:58:44 -0700 (PDT)
In-Reply-To: <20180901095639.ms6kkzywazkvs376@ltop.local>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com> <20180901095639.ms6kkzywazkvs376@ltop.local>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 1 Sep 2018 14:58:44 +0200
Message-ID: <CANiq72nrWMtCTNhMUCRjOPY2u0x78w8Hig2GcKf6WPyo5xkZeA@mail.gmail.com>
Subject: Re: [PATCH 7/7] Compiler Attributes: use feature checks instead of
 version checks
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On Sat, Sep 1, 2018 at 11:56 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> For sparse (which doesn't support __has_attribute() yet and defines
> __GNUC_MINOR__ depending on the compiler used to build it) it won't
> be totally correct since the concerned attributes here will be
> incorrectly considered as not supported. But, since these attributes
> have no semantic effects for sparse, it won't matter.
>
> So, for sparse:
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Thanks for checking (and for the sparse patches too!). I will note
this in the commit message for v3.

Cheers,
Miguel
