Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10458C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB0020862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB0020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeKZW66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:58:58 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39258 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeKZW66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:58:58 -0500
Received: by mail-vs1-f67.google.com with SMTP id h78so11114417vsi.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 04:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r34LJpugkd++vSdHyPUdI9UYF0F/7VWBkSRG0kBSTb4=;
        b=YpCPlwA+K39pfsvtt2AafqFVMkCj88AWFDjgb7TIO2+geMQ8w6LhO2vYtosWoqb4QG
         Dxon+Rcw5BaD0CAb5JBcy3rnz0QH0zQ1DaFEHR8z/swE/AU2RsZTm2v5yXd+CvrZhdow
         EzH65A8l0VtzEEqLiFNE9uJmqQo6fHWECHFSUsOR/y/F9iJUWKkp5eYEsbuKukIGPCU7
         mGStugvdWDjsuCpUHEKb4uwdYgBSoVb+dkJRqAqvhZ3eyyqwn6cXtA0fdR38rCvR9LbT
         NS19oeo+46a/xzSycx5JDAQeeeRroWThKWFm/SWigCkeF1PJpSioUSEEitvnz/FhX/bW
         20OA==
X-Gm-Message-State: AGRZ1gI0Cm2sb9JxW+sWARQ9D9/9544h/2s1vgms4GkVp84rgygGU8M6
        HTTftme74Kj8M4RaRD+VrrRjIpXE0iZv/Xh/D4W1QWZY
X-Google-Smtp-Source: AJdET5dEd9gnQ8mJUL3gKs/AKjEm2b7cZodbmBEuLLg+B6RTzjw9wzYV6izn3va8uPJUH8mytobSo0ms+IgM4W1kOjQ=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr11464407vsm.152.1543233900188;
 Mon, 26 Nov 2018 04:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20181126115741.15054-1-geert@linux-m68k.org>
In-Reply-To: <20181126115741.15054-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Nov 2018 13:04:47 +0100
Message-ID: <CAMuHMdUz35kOi+yoiR2b=Kj6J2RD77QdOZx=pA5tiLuugncs5g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.20-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:59 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.20-rc4[1] to v4.20-rc3[3], the summaries are:
>   - build errors: +1/-0

  + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit
declaration of function 'pci_iounmap'
[-Werror=implicit-function-declaration]:  => 8417:3

sh4/sh-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/2e6e902d185027f8e3cb8b7305238f7e35d6a436/ (all 240 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9ff01193a20d391e8dbce4403dd5ef87c7eaaca6/ (all 240 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
