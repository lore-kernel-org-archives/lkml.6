Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E16FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B507218E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRzJhHBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfBFVs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:48:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46177 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfBFVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:48:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so7454456ljh.13;
        Wed, 06 Feb 2019 13:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1wf5btUvPkJrFIrbawV5w09b+M4Qpj+H9XJCUlTVSPs=;
        b=WRzJhHBG//pfbMoE5VlhOXc1DuuiAfTDZYuHTcQOs0vDcHaeGtQu6/4hRWyNrhiy/2
         0iE2IZhI5mkjY8E1fCB6c5Ji1BOQV1Qs1/60OdXTX/HsQ0Jf6idMvPlJujrg7E5p1bfj
         NkxPHRHh9/Tha/AGJfZB7OI2ah0w2UI4aD3SAdBgBtdIRwruqBb46H1sQ0beRgZ3KD6j
         PlkDi+grJ7H0BRNKit3ksCCOAoTkhlrPPxqTYRnpckzvqqzOFUrNpc+eRr4aqc60XYQ4
         YpHhoOvtV4LSSe7NDiclXoCYxgacI+2/P1EBSq7Mn2mKgAO+khDgsVQnpBJLqwVEMQ7u
         eHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wf5btUvPkJrFIrbawV5w09b+M4Qpj+H9XJCUlTVSPs=;
        b=A0G9NP/Yva318B0SCNJ4JLgvsL8Af5e7fxXCqM+LTd1Xq6obyA/MmAcrCXYdqqoTUE
         NRrUBs3NC4fUApqVySUGfPcBkyeDR27YKTrI6fwsGYqF9nXSeXzET0JjpXRPsi919a1E
         uxAmqZjZhQ+OHaiVkAIrHLvMjJLByiah7dxTjI7bIjPVq9BBuLhH8wkH+L3+ECUojQsp
         aR+40rm4Rt7FQJhZhPZq84bgWiGYYo1WZOQ+2zf/2i1Xcmk2of9XO1OFs0ovKHRbYeMb
         PeXTuJIS3jEWdjjW01fxn6Bk5DuJ4C/0zvlh6GCdNt7FC+dKPycSqTeK8fTCnYAQoxl0
         aD4w==
X-Gm-Message-State: AHQUAubdt+dUsM3+HxAasm6AYBO/wrgYfoZbmHjPRRZpf1q4wOdjdTOg
        ipt/SPV6HpJAqnsNAxmo3SKc+LsU3lChjy/m2a8bwynAh4k=
X-Google-Smtp-Source: AHgI3IbRYm1Sai+f6yeTCP/Rz3VMFihuRIFWwLG5IjBOPic+pBPwEnM0uKBLeEtkV/dahdSvR5bFegCPnZ8dGp4P99k=
X-Received: by 2002:a2e:890b:: with SMTP id d11-v6mr8403848lji.113.1549489704760;
 Wed, 06 Feb 2019 13:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20190207083057.05b40e61@canb.auug.org.au>
In-Reply-To: <20190207083057.05b40e61@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Feb 2019 22:48:13 +0100
Message-ID: <CANiq72k9VSdZzGcRhZn5JYJ8N6_JPStjQKcr4rac=DNrVfDYtw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the compiler-attributes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Feb 6, 2019 at 10:31 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Miguel,
>
> After merging the compiler-attributes tree, today's linux-next build
> (arm multi_v7_defconfig) failed like this:
>
> In file included from arch/arm/crypto/aes-neonbs-glue.c:17:
> include/linux/module.h:138:7: error: section of alias 'cleanup_module' must match section of its target
>   void cleanup_module(void) __exit __attribute__((alias(#exitfn)));
>        ^~~~~~~~~~~~~~
> arch/arm/crypto/aes-neonbs-glue.c:433:1: note: in expansion of macro 'module_exit'
>  module_exit(aes_exit);
>  ^~~~~~~~~~~
>
> Caused by commit
>
>   b31ca3fcca36 ("include/linux/module.h: mark init/cleanup_module aliases as __init/exit")
>
> I have used the compiler-attributes tree from next-20190206 for today.

Yeah, sorry about that! I saw it an hour ago from the build bot and
already took out the branch from -next.

I tested the change on a subset of modules before pushing, but it
turns out there are some modules that do not mark their functions with
__init/__exit and that, in turns, makes GCC complain.

I sent a message about it a few minutes ago:
https://lore.kernel.org/lkml/CANiq72=gS7=G6WbZ4jqybMBh44FeF7UeVEfeb1hN8uMAMt_2bw@mail.gmail.com/

Cheers,
Miguel
