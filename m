Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABB6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A971C20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A971C20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388157AbeKFHeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:34:17 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43281 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387813AbeKFHeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:34:17 -0500
Received: by mail-vs1-f68.google.com with SMTP id k14so6113471vsm.10;
        Mon, 05 Nov 2018 14:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gh3AuZIfe0zXP71uemtOcyqyiQLDcUXZMs2NYEEDjIM=;
        b=uV1BdT7rx/LW+4tIrGuWhBuEG9rusThwLpX6xlJ4LMCBxzgJ6MpGu/cnF4Pcs0KmTr
         ZzI+kGo5OnxCkfsYFqQn+K3N8yRul8SlzDA9bmozY4NYhy2GGIG5Lf7jelONPMCgZTja
         wCOhur6FaNdBbkUHWNEDf9LxW5JbqlDTasS0vlG5haPArOK1jeFG/FQAk9hGzQjKIwDG
         +ui8HEgTb3GTOta1St1pBvPXVXqtDm/ydr4NH3pLcPjt0/teSvQAQ6kQ2jsQ8Q7JNnar
         6t3Tokw/p1LBpSLghU6r7DlezX3N7Y92DpGD2jfo0A5MK8lqgyXshjmXEsBlsBl9tMYQ
         ituQ==
X-Gm-Message-State: AGRZ1gICFpKOPRhm319APxcIgg/5I67XNLEnr/FXcs8Dm5cXnKB/XL8k
        1tyYjJb1YGbI+KrMtWbuerBr9cX1l8V0BInjR3krltB5
X-Google-Smtp-Source: AJdET5f+xAXErfXdCjdJzGwNDibs9jRKoNN7jq+MjcXmj6ln4GNZzALe1+vMHmvZkIItOu0bQ48LR4YxaXnuOKOEU+E=
X-Received: by 2002:a67:c202:: with SMTP id i2mr9242706vsj.11.1541455944606;
 Mon, 05 Nov 2018 14:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20181105220559.27458-1-geert@linux-m68k.org>
In-Reply-To: <20181105220559.27458-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 5 Nov 2018 23:12:12 +0100
Message-ID: <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.20-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 11:07 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.20-rc1[1] compared to v4.19[2].
>
> Summarized:
>   - build errors: +3/-0
>   - build warnings: +449/-2712
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/651022382c7f8da46cb4872a545ee1da6d097d2a/ (all 240 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d/ (all 240 configs)
>
>
> *** ERRORS ***
>
> 3 error regressions:
>   + /kisskb/src/arch/s390/kernel/nospec-branch.c: error: macro "memcpy" passed 6 arguments, but takes just 3:  => 130:61

s390-all{mod,yes}config

>   + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 8799:3

sh4-all{mod,yes}config

Looks like d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of
pci_iomap() on SH")
is not sufficient?

>   + {standard input}: Error: Unrecognized opcode: `slbfee.':  => 89, 37

powerpc-all{mod,yes}config

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
