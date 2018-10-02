Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CC5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24830208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24830208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeJBOdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:33:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46519 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeJBOdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:33:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id d8-v6so930243qtk.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZWgLN4V4KNLZVZAP7/7sWQOLGosJxKJCZfhqRP9t88=;
        b=KstrZvJN+/IoLVMAir9UiSIMLxFhfyDfFBv4lciboxtKm8knaXPJIg2UMbjIo6whV0
         w1cq+jJm65+xhu7fbRSPOnHJeDRFQUuglxzeWmsd9k6tFU3FRgZqxpxPqaqV47tgHlQ8
         bnMTtN55W5ChfRN/5RKwo3tMQ29+kcI3YGnUuEVZlbnjcOR41jNsT4bQ4rhGOvPdZlh7
         skOBW/Fg8JZNuDD3Z2WzU6DDbhtNzYv7Utb7MtP1Hy4pfsTj1t9JS3GNGN6C+e+5hLgI
         5r4wSMbGACYORaI1NrH5wHTa3e07PgBI7uZhjhltCY+RKJKBPcp+v9AVn6bmDI+nsg9z
         LsgA==
X-Gm-Message-State: ABuFfoiroFbAyRGTHYsz50r+JcOMR7OX1slvz3q8Z5AqoE6UK42I2uvZ
        5IbbqYqxX8RVQ/xChDM5mnSuGwWGJFCuJdr3Ss/L15cc
X-Google-Smtp-Source: ACcGV61AHGaqQMgqzvCm2hT27rMtIblCDLIy2pfPU2pP7SahNRUvRQ2kdV8/XzAFsYsjg31bJRq1Q4K0xb+xt9ql4GY=
X-Received: by 2002:aed:2bc6:: with SMTP id e64-v6mr11657826qtd.132.1538466718973;
 Tue, 02 Oct 2018 00:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180930024904.14240-1-Jason@zx2c4.com> <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
 <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com>
In-Reply-To: <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Oct 2018 09:51:42 +0200
Message-ID: <CAK8P3a3TE8HW0wD9ETCDWMf7quDRx94-2iS6goYDQ18JQ6r=rw@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on CPU32v3
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 5:53 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Arnd,
>
> Apologies for the delay in getting back to you. I had some MTA issues
> and stupidly assumed ARM developers were taking the day off instead...
>
> On Tue, Oct 2, 2018 at 5:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > -arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3
> > +arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3m
>
> Unfortunately this doesn't really cut it in my case, as it's not only
> those multiplications:
> chacha20-arm.S:402: Error: selected processor does not support `bxeq
> lr' in ARM mode
>
> I think we're going to wind up playing whack-a-mole in silly ways. The
> fact of the matter is that the ARM assembly I'm adding to the tree is
> for ARMv4 and up, and not for ARMv3.

I don't see what issues remain. The 'reteq lr' that Ard mentioned
is definitely the correct way to return from assembly (you also need
that for plain armv4, as 'bx' was added in armv4t), and Russell
confirmed that using -march=armv3m is something we want
anyway for mach-rpc.

> I think there are three options to work around this issue:
>
> 1) Not build my assembly when CONFIG_CPU_32v3 via a Kconfig "depends".
> 2) Set asflags-$(CONFIG_CPU_32v3) inside my module locally to select
> -march=armv4.
> 3) This patch.
>
> My initial plan was (1). ArdB recommended I do (2) instead. I thought
> that was a bit too nuanced and submitted (3).

I suspect all three of the above fail to work for armv4.

         Arnd
