Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C1EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638A52245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="mbh1hNIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638A52245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbeKNOzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 09:55:50 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36829 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeKNOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 09:55:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id o125so23682403qkf.3;
        Tue, 13 Nov 2018 20:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2dB5Vh21L1zrYCsYUDJT1XDKS4DmUxt5WOtc2TT1VE=;
        b=mbh1hNIc8lvzyuqEJ0GemOJgzn8f4zYs3kqiPKm9smJnHD7kKNDcty6VGSdjR5LBVx
         7r0CMCXfaZ/lU3Z47VkNuevURJqzTaDNlUQPBKo3V0I/IwmYo2rl/N+qgZgbaXLOHWLd
         BTWA7+x61MA5kFka/fuuuRlVgiyRzei/rJDAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2dB5Vh21L1zrYCsYUDJT1XDKS4DmUxt5WOtc2TT1VE=;
        b=AJfZkgFZ8xLSlVLIZsCUcIJIlCgbgRrW4aK0ap3/GFyMiaF8TYsmLwUCiSEXWIaqvQ
         Se6Gj0JqSJq+PioTd7RvHITvxe3/RronVnIm6VLz6LOuc8HT7HNx3Vl/ievd4nh66miJ
         /Gtl5c9occjmqKG85+iY/gaSd1ox3tHf9eaYpxv3lJuKgtqhzkjzS+s9z51U+XeICceR
         p7Su029naseqQrjtxKZE5diBV6hqbBCc7okymsVC91nnI59WPU04lCLGK0ti9WyHu4eW
         XLJAI7SnvifBnOcr9gwH8rqGCc2NT0gEqnHzXgPF2u1uSBoUHmgtfkxgWN4xXofr5mc0
         Nmeg==
X-Gm-Message-State: AGRZ1gL2SQRnBrzVpm2ZvSC4E5dmFBXCuE9ADM4LYiAA2f9akFnYnlu2
        +f6T+T4IVGfq+qp58dhyP+Xhdu9WRCL4ieFuAuo=
X-Google-Smtp-Source: AJdET5eaCimi1HgZghom7n4Mp30JfR5EERHJ2opqIhqa0pa97TJYB1GOxPqw6kRz2vUTWRM7iRj2nUS3hkgvXi63xVM=
X-Received: by 2002:ac8:7308:: with SMTP id x8mr352468qto.284.1542171255664;
 Tue, 13 Nov 2018 20:54:15 -0800 (PST)
MIME-Version: 1.0
References: <20180612081413.323d85b8@canb.auug.org.au>
In-Reply-To: <20180612081413.323d85b8@canb.auug.org.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 14 Nov 2018 15:24:04 +1030
Message-ID: <CACPK8XeDHt46rUJWQ1n=4fRWioogs9K0Z8dkxUa=E2ShfQ1Vdg@mail.gmail.com>
Subject: Re: linux-next: build warnings from Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alan Modra <amodra@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

On Tue, 12 Jun 2018 at 07:44, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Building Linus' tree, today's linux-next build (powerpc ppc64_defconfig)
> produced these warning:
>
> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
>
> This may just be because I have started building using the native Debian
> gcc for the powerpc builds ...

Do you know why we started creating these?

If it's intentional, should we be putting including them in the same
way as .hash sections?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/vmlinux.lds.S#n282

  .hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }

Cheers,

Joel
