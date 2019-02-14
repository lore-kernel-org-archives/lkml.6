Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5212229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394492AbfBNIN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:13:27 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43474 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388915AbfBNIN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:13:27 -0500
Received: by mail-ua1-f65.google.com with SMTP id z11so1723434uaa.10;
        Thu, 14 Feb 2019 00:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDHSHKTHIgYnWNuqdjR3jG49iOOy8VGtWQxLsAaEpHQ=;
        b=LlVczVozth4MOvxVtkyYkUXlmKaOK3uDOBttXwoyBfKUyhp0vdR9rS+d5ddQv+oOii
         1lNzTSV0SS4xv83gTrANUBabKB2LaumFtcypWE9X+TIe9td00zyw4F5G/bN51J5IQnlR
         AKD7msP/r7LSNiOtPmQEw+mSyAnuJN3jb9RIzJBtihqYjSLhckk6nFmYs1ShMTvpXzGg
         HCk4baLsVl/ZanZRzYUuELaX2daUJW0ffVoSuz5msAP9TxifAap0FyHizQLPfO1iKLxj
         tXIEE6g49RTzKrIyogwV0zieS+NUK/Hb+cHNK6RRWDqVLfGVI5mpEGCJDetzmTq885EI
         JtLQ==
X-Gm-Message-State: AHQUAuY8YVRkAmGJ27Cy/XtOBh8dtOlRcfW4OVcSs1mxh6kZ0tky3EAM
        agC1LTw6CArQFwkMlxN5wIr4ZFs4sxOS+ciNST8=
X-Google-Smtp-Source: AHgI3IaE7cLxRKK27MHaxfzygEbpt/ImKUPXYqD0AR24BwNoDeuAjGZAMxX2/11NraL7sUOPNQIVEL+mp2wcl+dGTyg=
X-Received: by 2002:a9f:2726:: with SMTP id a35mr1290069uaa.75.1550132006060;
 Thu, 14 Feb 2019 00:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-11-hch@lst.de>
In-Reply-To: <20190213174005.28785-11-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Feb 2019 09:13:13 +0100
Message-ID: <CAMuHMdXPF4ohqzEnT_rnwKWi6r13cDMTtEinh-TpZ6YpSaQ=WA@mail.gmail.com>
Subject: Re: [PATCH 10/11] lib: consolidate the GENERIC_HWEIGHT symbol
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 3:11 AM Christoph Hellwig <hch@lst.de> wrote:
> Introduce a new ARCH_HAS_HWEIGHT symbol for alpha and ia64, and just
> default to the generic version otherwise.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/Kconfig       | 4 ----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
