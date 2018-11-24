Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AFCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B17F2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIfjZDQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B17F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeKXTEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 14:04:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33316 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbeKXTEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 14:04:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so12410267ljd.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 00:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XuO3cCnBgi4a+nzaNlWwyIDAzoqgA7kwlXEq0ELHFjw=;
        b=vIfjZDQDdai+WqXgqcYHzifpLYjtArHIe/vWcae9RIciUvIbBCv/+r81qWQ/hsKJiD
         NEz80TQV1R/rRTPhhBYtb37tPS22ULzF7YADl4Lc8ASkVUjZ12wg6iXDXEpX5m8mlW78
         CLVunfK5q9IwhAJQ7Fz1eVeB6K17j8S2e8Oss2Auz+OfziFcNjdNznsovn1nmjidoUxp
         m14vDaR+tk/lTgRS6/8g+toKJFE5yEW6Y6CWUTKgdsqFdI4bnnb83hszuJuFkaZwBEt7
         wvTcSlinwDh5Lm237ycRiFSL0aCdUyFHiL6LAF1GGE5jYVyJO4H1dUzPqbs3vyRfYtKF
         PePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XuO3cCnBgi4a+nzaNlWwyIDAzoqgA7kwlXEq0ELHFjw=;
        b=ffRGKFzNMsix810KtegxYT8LYVGTHL+v8Yk21TQrHXEdaCw4R4BTRNRsgPHmI5h+uL
         kln9ihtF+XGYt+oYnv+kzw4GTIASkrKf9gPqWKssh3QyUmKQnpBj+ikqGlhj8YFA/u7k
         K2OjtImoCVfe/u1wKSEPt5B7TAxzXiM8V/kpKRWspTopNaU738jEINIbUv+fMlTr/zS/
         zIuwJFspcXXXWdW4WBlyqMIrFsGZWnVtpf39oTAHnYnGu/NGeKokITq+BmzJjSqaj1xP
         kX8NrD1WyQvWEFNLoOwR8Ne0DyLpnZ6iw+qW7YzqLvTzVKXTEWJfSbMPn9ioOLFffGt1
         5ifQ==
X-Gm-Message-State: AA+aEWaUMoBaRAMEih+db7xqcnw5zkrGckeU8lDeVjrWVzdK2OKqzEEl
        zTDbVnrTUQ9PR470g5EoUgnOCZWNnfTiZ+VX+HE=
X-Google-Smtp-Source: AFSGD/VJrdAbTL3S/ux+csH87KH67v9AjBGn3qtgZXOiI3kIu7cP/ruAW0fTqD1/ZMsh/CmT9zqcGSqnf7ZlvWixKto=
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr10373996ljg.150.1543047421031;
 Sat, 24 Nov 2018 00:17:01 -0800 (PST)
MIME-Version: 1.0
References: <1542856462-18836-1-git-send-email-yamada.masahiro@socionext.com> <1542856462-18836-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1542856462-18836-2-git-send-email-yamada.masahiro@socionext.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 24 Nov 2018 09:16:50 +0100
Message-ID: <CANiq72m24uArkvc-GYMa8j=C+fUfxCXm27nVsg1B-o0r3EDKEw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] build_bug.h: remove negative-array fallback for BUILD_BUG_ON()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, josh@joshtriplett.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 5:15 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The kernel can only be compiled with an optimization option (-O2, -Os,
> or the currently proposed -Og). Hence, __OPTIMIZE__ is always defined
> in the kernel source.
>
> The fallback for the -O0 case is just hypothetical and pointless.
> Moreover, commit 0bb95f80a38f ("Makefile: Globally enable VLA warning")
> enabled -Wvla warning. The use of variable length arrays is banned.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Didn't see v3/v4 (wasn't CC):

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
