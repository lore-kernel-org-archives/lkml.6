Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA55C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2B22081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2B22081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbeKFRi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:38:58 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33164 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbeKFRi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:38:58 -0500
Received: by mail-vs1-f68.google.com with SMTP id p74so6785668vsc.0;
        Tue, 06 Nov 2018 00:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNQSiJXLZd6h0tWyqV1a2m9JXsYXCZTC0nMPmG8ESxo=;
        b=WZo3EtXPe9HbkN56y+VIt41K9MSmSgo3scGqhPP0DhmwiETHnl2k5WdgwLFTuUHyO/
         lyHYkWc2gYJDTZi1HJRRxSeSoDQrZWmuK5V7Mm9cQ9RC2I4SGwjIhYOJCeqatzAy+L8F
         /OrqTQZOtE2Cp9w40x/4l78UqCBE8i6ZnSHgqoOUP+kLKKm2EDXKCbbWRzJ4HuB5H3rk
         gqswnDF13plCCU0WMeU/I558IpRRifHD9f6uBojCuNmuCsf0JLUYbB6GLnZmrK8OPMUY
         Sv+VXCKC9bLgsp6uhF2ZYT0GeHtMedZpFUOvr0hXN+PRKw0E/QVmq635a8FxOueNwf7b
         MZGg==
X-Gm-Message-State: AGRZ1gIeEwrp1/fwuWAXjoL/lQxSUvUUfG86Y362lyMqhIzZyiARP721
        /hgIVqQ8q4qUxCRmuSxdR4hHHjYNRPwqRNlbdOi+Tlft
X-Google-Smtp-Source: AJdET5e54bFX09hlhWgzHu0wfUjwZ6nBB6InLw4avQVR+KbcCeOWauOgwpe0KM5rZ1BpzvUfv0Wb/ZhEkWKn2nAD2V0=
X-Received: by 2002:a67:f43:: with SMTP id 64mr1818788vsp.166.1541492096392;
 Tue, 06 Nov 2018 00:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20181105221117.31828-1-willy@infradead.org>
In-Reply-To: <20181105221117.31828-1-willy@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Nov 2018 09:14:44 +0100
Message-ID: <CAMuHMdU90im=GH+TrboxjH0K-cqfYmeDXromvC=ag5MjcE5-bg@mail.gmail.com>
Subject: Re: [PATCH] fls: Change parameter to unsigned int
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 11:11 PM Matthew Wilcox <willy@infradead.org> wrote:
> When testing in userspace, UBSAN pointed out that shifting into the sign
> bit is undefined behaviour.  It doesn't really make sense to ask for the
> highest set bit of a negative value, so just turn the argument type into
> an unsigned int.
>
> Some architectures (eg ppc) already had it declared as an unsigned int,
> so I don't expect too many problems.
>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
