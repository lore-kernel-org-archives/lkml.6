Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B57C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5470E21760
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5470E21760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeHULXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:23:37 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42901 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeHULXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:23:37 -0400
Received: by mail-ua1-f66.google.com with SMTP id w7-v6so11310224uan.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 01:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oaj5KtgRdd0elAO1DCn34q1I09Sv3ho+rVaBHt2IV8w=;
        b=MRAbbeVNfOzaLiF04LQJFiM9YQBxQB/EWxJNMkjJ+nIE5C4GQmgEL/b1jMHT7zMqWg
         S5fDvdJsp6R1HvdIxi92oXSR+J8XisCD+VRmK5sSaOt36aJSXtWPhk7maPfnMAKvMBon
         qHVQE+kPjC/xxEFu15QAiZCCnQeyjJYzW1sxb/LEoHjJORNYlEEsmxT1VgZSgPrnIqM3
         4lHDsgqLFLgdYp4anPIUB0QG2P0ehiscxlSbsfD9Wzm9idJ7CDRzpOfH8eNT8eyecwkI
         ifdd0K3oIJs9KZYJrkepvFbZsdNLsIl/03ixiHcNRl0WdG3cbQpA4coAK7ZMYMf7y+Cp
         RCwA==
X-Gm-Message-State: APzg51C+zJI8vA1QISbGRh+PMhmXYXTZiIWmhiBEIpHEdpILVY+vzaFT
        Cd+fI0w3ospEyqmNIJEdhqU+ef880xqLGMUXgvo1z39f
X-Google-Smtp-Source: ANB0VdZ8DTOEJ046EivouLSxIvUekjZIzZPSshF26x7+veGU8IkkOMZ77Lo9HD4wQpDxXTgYsYYt4l7zLUi8TDOBH/I=
X-Received: by 2002:ab0:51ac:: with SMTP id g41-v6mr805390uaa.155.1534838669605;
 Tue, 21 Aug 2018 01:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180821080143.13111-1-geert@linux-m68k.org>
In-Reply-To: <20180821080143.13111-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Aug 2018 10:04:16 +0200
Message-ID: <CAMuHMdU50tADHPZ66a_nOJbPE-10NHjkjbLnAGXtoVJm1u6_EQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.18
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 10:02 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.18[1] to v4.18-rc8[3], the summaries are:
>   - build errors: +2/-0

Holiday season?

  + error: "__sanitizer_cov_trace_cmpd"
[drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!:  => N/A
  + error: "__sanitizer_cov_trace_cmpf"
[drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!:  => N/A

x86_64-gcc8/x86-allmodconfig (patch available)

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/94710cac0ef4ee177a63b5227664b38c95bbf703/
(239 out of 244 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1ffaddd029c867d134a1dde39f540dcc8c52e274/
(233 out of 244 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
