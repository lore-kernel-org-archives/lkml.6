Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C691C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530AC20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/3Oq9WT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530AC20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754722AbeFTTPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:15:23 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40709 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754245AbeFTTPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:15:20 -0400
Received: by mail-oi0-f67.google.com with SMTP id f79-v6so621371oib.7;
        Wed, 20 Jun 2018 12:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=or7JVfRMbp9Ae8VFQMQJh1TDsOrY1QlGUNeCx4j0kEI=;
        b=S/3Oq9WTxEujbAC6K8bZwAOigCVWIS1UcN/KbFXbC0VonU+MOPzNgVtrbT7EYWqma+
         bAuQJFyxJ6lS8+FsIrnwa8khf8R1C0jyJU/lH6Zbe+N1oIq9bQ8aFxoOss7TKdfO+nbI
         clJ1DE6/Lst5GaiyNu4wXH+4di2sMMc6VfPVw1iOPBM5u/8d99DDaosGce8bGqkoAos1
         jgSdizDMAHKe/gENdUbpAZC1xKgLyaokZHpyVar1FBemqdMf89Ee5HihsQxWSIuDfby3
         T9m81i3V3bPu9f761VfeFKgtUpU+auv6maR5nHyMsPQcN0NAUbCeLexrs80W2VBvNR8U
         LK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=or7JVfRMbp9Ae8VFQMQJh1TDsOrY1QlGUNeCx4j0kEI=;
        b=g+T1sbx4C82s86CKFTK/OGRQvvXdwjDO+rY+794IomOZKGm2bidqWzmG4HIwTCl7yj
         ZfDLOXoejUd5Xnm8HgALlhKLQfGTk2Hl9ny3ckpSBCSohngGKtJOfaST95tyyofV9Ybz
         UIR1c1eGyk0VJeIqJmBmaSP0RzOn2DfoK0kYH72EXnJTtuA1QZmazAc0MCA0LVTHujXP
         ti9ZHr2lOWcJTqipPYRdGj0x7iLZojlYmYrYqaIHQRouvAiFHpoIKjlhY6Icop+Kajvo
         lWVx1VX6Sv6qiYuC8GL6Zcpfx7ezp/V7+J/LD9FBZUpEH90LhI1dcU+FkxNjmWgY0J0b
         X8Yg==
X-Gm-Message-State: APt69E2KD4CG6XMfCXrtRCiZnIV0HD0O0xjRtcEYA1xFkfghIOYWCAjq
        OgNrS1uihmhf20KegBXg83Vgmq5EyIr7+2CxHOY=
X-Google-Smtp-Source: ADUXVKIS3Cns5SAtNcFf6Vyyzkk5J21KiWfUYNY6t/ncDKw6PBtAhU2zi9Nz9k+W+hEDh/vMnFtnmHDi9S/TnUSu9as=
X-Received: by 2002:aca:400b:: with SMTP id n11-v6mr13308204oia.44.1529522118807;
 Wed, 20 Jun 2018 12:15:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 12:15:18
 -0700 (PDT)
In-Reply-To: <f76d3070776e0038eda3cd76d471d1bfeae18480.1529515183.git.andreyknvl@google.com>
References: <cover.1529515183.git.andreyknvl@google.com> <f76d3070776e0038eda3cd76d471d1bfeae18480.1529515183.git.andreyknvl@google.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 20 Jun 2018 16:15:18 -0300
Message-ID: <CAOMZO5BgPaMsmx_3AJvMTKCFjhusfH=kH26U_PQCSD5TcUDA+w@mail.gmail.com>
Subject: Re: [PATCH v3 17/17] kasan: add SPDX-License-Identifier mark to
 source files
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Mark Brand <markbrand@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 2:40 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 6f4f2ebf5f57..3feacd889e24 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0

The original notation is correct: /* */ style is used for header files.
