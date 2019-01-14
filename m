Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D991FC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B469520657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfANODE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:03:04 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43302 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfANODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:03:04 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so13644784vsc.10;
        Mon, 14 Jan 2019 06:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPXQ005dpgnhxanjjmigJASoqbeog16GFnmkdoG8qpw=;
        b=gXqQn64PGkDQicTiE7U5lWvtZPCa43V+pG6nDwNfyM6bu+vwRnEBBEHl2JvrEfxtIi
         r16Qim51vLVbCjLIZwFDJH0EzMVeC/R6vT4+ZtC2FDz+RtrcWh5LlQj7dfNraNYUkRLE
         KKGzxxykMbkP0K+YQhSIg9VDIrILRdrw19PaBxxeB88j2DqvSeWwmnJEh6848nZyrcKf
         CQ4R7UyMBTTpKiqoc1y9/RHsObLPnnEx3PNBujrWH9iXN2mmiI/0SjIFptX2Amm4g6Ce
         erwdh0nlrq42YNat4tPOUBSy8Aglt4OLDgLfPkl5u5V3wAHjP/rLY4CcPDN196BXdCh/
         zraw==
X-Gm-Message-State: AJcUukfa92CtsrIqcunJJ2M2hZvJxmh+yUDrUF83zmJgo472VB/GtbhA
        h3RcyFKvKtDu47ck+lqjl1frAUjo8/6bd7MHaxA=
X-Google-Smtp-Source: ALg8bN5wYMxOtX3lY+uzxTqd21QEfqP1458GnLRYAHGRLaMnhFDHkh8ZI6dVlRF3u0c0V7r+jYFPOiKxVX+duKm+d8A=
X-Received: by 2002:a67:f43:: with SMTP id 64mr10255483vsp.166.1547474582599;
 Mon, 14 Jan 2019 06:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20190114125903.24845-1-david@redhat.com> <20190114125903.24845-6-david@redhat.com>
In-Reply-To: <20190114125903.24845-6-david@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Jan 2019 15:02:50 +0100
Message-ID: <CAMuHMdWEChb4+tf0m_qN9Mc6Am5T0rZLqAn6QsQ8NdMOCRPySQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] m68k/mm: use __ClearPageReserved()
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 1:59 PM David Hildenbrand <david@redhat.com> wrote:
> The PG_reserved flag is cleared from memory that is part of the kernel
> image (and therefore marked as PG_reserved). Avoid using PG_reserved
> directly.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

BTW, it's a pity ctags doesn't know where __ClearPageReserved()
is defined.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
