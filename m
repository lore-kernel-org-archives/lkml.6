Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2E0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A9520869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2rKGnk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A9520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeJPPvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:51:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41251 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeJPPvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:51:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id l41-v6so24606799qtl.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 01:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nL+rl0AgL+S+0rJp5k2vnfDOBVCoZeAXF0pBRsUjNPc=;
        b=N2rKGnk9v+eQV1c2YYWEOuSOOU5OYBd689PJh9Lw9XP5rnHjTK7WBRYI+n2mXs8/yT
         0K6DOsckjNx/o6IyFA2ml7MueNu8aPYha+kVFI+qMrrUi+CbrtFL9vweEg1eUbMF7G4z
         Xbk+P62gGIWkKKTA1Z+9GEsg4NS5BDvXpLaFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nL+rl0AgL+S+0rJp5k2vnfDOBVCoZeAXF0pBRsUjNPc=;
        b=dReOP0EDpoghkg06gkvkymGVRymlj7di6NluvXJ8WIT4Kldqt438qbZk5AQGUhyhn7
         rcM4n69okQb68G2IaxqdCfgOpy/mOa2ToTZiRX+3I+y+s+ARHLXlNMyBMtNr9R/Gef1y
         tQ8Kn0qZZyx9k1xw9sooRSO6pIX+Xi5xzw2gF0ngXWtUgoZ671EP6LNkgYEys/dse5Oz
         L1TwFmwRBbr/mavFipCjWrG5hV7cLg5q6u1vI/tprvOJGuMR3haJD9FSHeeTAcO/oZtf
         kj8sYb7HQ+ygNj35zxvLCMk2Z0KUFouFEe66moJ6TUgJOKG68ft5F/C0mGH+2fs9TsrD
         atwQ==
X-Gm-Message-State: ABuFfogYHJOTZfrPoFimD3CzaQ7uf/HKbuJJPSW2rgwot1rFhgOgRt07
        +rOiscr3sryE1/nnNAaOK6Bh0ADgywyxvXznM3YlcA==
X-Google-Smtp-Source: ACcGV60ZYg+WrU3Rf3TZvWqYkOW3zowIyzPqt7gDdTFuWInm8z435AnQLmHZPfxwmQvuGbvC6gMzbfsn9cKayxutuxI=
X-Received: by 2002:ac8:440d:: with SMTP id j13-v6mr18837148qtn.257.1539676951443;
 Tue, 16 Oct 2018 01:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <1539662998-15467-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1539662998-15467-1-git-send-email-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Oct 2018 10:02:19 +0200
Message-ID: <CACRpkdZSDyTu3HJ-3MCgsRVizvuUsyLfPg08-Q5tZeZKTovNGA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: include <linux/bits.h> instead of <linux/bitops.h>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 6:10 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The reason of including <linux/bitops.h> here is just for BIT() macro.
>
> Since commit 8bd9cb51daac8 ("locking/atomics, asm-generic: Move some
> macros from <linux/bitops.h> to a new <linux/bits.h> file"),
> <linux/bits.h> is enough for such compile-time macros.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
