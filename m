Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3743F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfBYJ0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:26:06 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42977 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfBYJ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:26:05 -0500
Received: by mail-ua1-f66.google.com with SMTP id d21so7674197uap.9;
        Mon, 25 Feb 2019 01:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niS14ojPf8D0CpyMtqT6BqvSFD2QpDUhVDkgdIU7ugY=;
        b=W8We8GsoBtQCurFambfvPYBS+MF4CVhNKH0izIknoIVVgupNdjIfZuGkK2QTec/nru
         lqzcXjzPcvdAHfurE43TtfCpApq8mdm/1rxijFRgwzdvdPkbYqI4C8p39ypc2Gw/96qy
         cRoj5XuMTB/S5U0dTTxafqAtN1zUaETOPAUhLiaFebaQ6M5rxIxo0Ibzm7PktURPbduF
         4o7FbyeDiVLIz7SxqfSn22KYXIw/rAT5EkzdLO6KLLWyIRomTolzySdMCpmiF+xi0Hz3
         jGMXyy9qMFk2t5CexVYMD0QE2FvzEy37zjHmvdH/r1I3n5H5EY5IfUDIus5eYiXz5VKU
         CczQ==
X-Gm-Message-State: AHQUAuYIr4up/ToBqCz+FGCQnJOwUay/KnfoajGZ3XHhaJmSl0jPxJ2H
        F0YNR5d+IbnjUxgUx4BB5LeEyDwKPDXH/mxrfRg=
X-Google-Smtp-Source: AHgI3IYupc+ykpR9fjC+vc6VimuH2AIC6+avofyINKhLdiz4A1DkTB8QBeJ98REnkt7wRP7CY7JFtnO5tGSn7ls3nXg=
X-Received: by 2002:ab0:6950:: with SMTP id c16mr2845841uas.0.1551086764140;
 Mon, 25 Feb 2019 01:26:04 -0800 (PST)
MIME-Version: 1.0
References: <20190222185026.10973-1-will.deacon@arm.com> <20190222185026.10973-9-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-9-will.deacon@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Feb 2019 10:25:52 +0100
Message-ID: <CAMuHMdXq5N1e+=dTPUu+AtSgh4QzuDzmhBowG_HFoVHwmndvkg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/20] m68k: io: Remove useless definition of mmiowb()
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, Feb 22, 2019 at 7:51 PM Will Deacon <will.deacon@arm.com> wrote:
> m68k includes asm-generic/io.h, which provides a dummy definition of
> mmiowb() if one isn't already provided by the architecture.
>
> Remove the useless definition.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Thanks!
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Do you want me to queue this in the m68k tree for v5.2, or would
you prefer to apply the whole series?
In case of the latter:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
