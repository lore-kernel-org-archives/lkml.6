Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A52C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1766420875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdUAoQUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1766420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932968AbeFTToE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:44:04 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44189 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932184AbeFTToA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:44:00 -0400
Received: by mail-ot0-f194.google.com with SMTP id w13-v6so831022ote.11;
        Wed, 20 Jun 2018 12:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hPaFNaAU0f1Q8sJS7QvbcQiE/jem/9DSyL6aa8ys5/E=;
        b=WdUAoQUirNrJnocQq7MvB4pffin70di2JjYUDJuD4d9dVsZZZVLMQzN1qEubLrkXm/
         JP8YUGGg7k9ovyLOR0LF+h+Cbn24GzRDLo0DgzEIwK2v2pY0OlleVMzW6/LeLKE0yP7Q
         xYIlQHd6m0wVMmhllEyYEpMEIXQWeQYKz5tI6hS4gdiR2PgvFv/YIi+efOOkaIAI6AhZ
         5QvVj5P/ypWn2lznVO5V5PsUxcJ7I7I49VafEyoFXSwrCgWk8xmtTT+DfHNV0Mb5a4Dv
         omz/JUlEy7JYKiHBEoOyv13F8IyFLmXvXorXOQ6cjkVbAgW88wdP1YsI3iTlxNWQmZ5K
         j8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hPaFNaAU0f1Q8sJS7QvbcQiE/jem/9DSyL6aa8ys5/E=;
        b=DIx9BNQqDXocjb2t0qDJHZJS93rLBiGoUkkFkGHo18ruPAx97I54L7zpzs8ouklZ03
         ZzGRPkh2sviJC5aZBCuFGSXyr07rmf73ZCbKDyEJrsS4+dEIsbs28fbNXjSrAlMgwNaE
         RLFcClmNqq2GP4c8l2rg68p5U/neDy++lCDRkrlXw8U98UBCKqxF55dRqShFQqekGDh7
         9TnLcQv5jBDySUybSGmlIsRs/z+p4l/l2bSXZMXt4Iu5BGIh8KyeZFMP1cphcAd3Q4/H
         yXwJPNQi1ae1EyQuXyyEvI+b7JT0JKrmh7hAaD2r9Ak2jdzXHNxzokieDimPBNbp26dV
         fWqA==
X-Gm-Message-State: APt69E0ZbGVLKzvkZoC8qhdeue0oNABfuEmYhBLLQWOOKOGJLl+sSWdg
        PPTFFMGEudK+cO+dgJka83q2P539X0VVLgeEQlE=
X-Google-Smtp-Source: ADUXVKIetrnSkCpBo2OAStc0GCNtMSOSyIU4heZhgxD3q4OGY3dyHB7TmFSsFuPC+CY0l5JgVL8+GvzvTFlzlcFLzHk=
X-Received: by 2002:a9d:62d3:: with SMTP id z19-v6mr12690190otk.159.1529523839678;
 Wed, 20 Jun 2018 12:43:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 12:43:59
 -0700 (PDT)
In-Reply-To: <CAAeHK+zJgSAxiHHfzhrm7N7iey7CbW42WfWvUN+FnZMPP3FXrA@mail.gmail.com>
References: <cover.1529515183.git.andreyknvl@google.com> <f76d3070776e0038eda3cd76d471d1bfeae18480.1529515183.git.andreyknvl@google.com>
 <CAOMZO5BgPaMsmx_3AJvMTKCFjhusfH=kH26U_PQCSD5TcUDA+w@mail.gmail.com> <CAAeHK+zJgSAxiHHfzhrm7N7iey7CbW42WfWvUN+FnZMPP3FXrA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 20 Jun 2018 16:43:59 -0300
Message-ID: <CAOMZO5APF=cYOia8dn7dHa3h-Tm6sFMsJZwie--T6N-1-X-TYg@mail.gmail.com>
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
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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

On Wed, Jun 20, 2018 at 4:41 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

> I used mm/slub.c as a reference, which uses //. Bu I can change it to
> /* */ in the next version, no problem.

C source files should use //. C header files should use /* */

This is documented at Documentation/process/license-rules.rst
