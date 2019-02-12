Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6156C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFE821B1A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UFKFZ3TF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbfBLXPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:15:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39564 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfBLXPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:15:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so190792pgp.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 15:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7eBFs2jG1q/fDxjb93hzAefYGEF97+oyRaVopG3hxRY=;
        b=UFKFZ3TFQ7mdH7hnczOfaUV8LmEVo8xlYKqiKZp8zmPjxDkcuWjKW4RhQTgnBIvsSy
         9T6QYFWyX7s9nJQ7Y0T+3NBKwAkieNOtwHq+7L2k0KUhyAdueXA6dagHOwQ9zNAMzWcc
         id5pHoDOSRL5qNOwmfCpPmAvSftm57cY12IgR0gxnvjeUZxbVvdCP5VblEsRJdjRpB+F
         W2ery4H1vPNFEO6UFDqoy0NIzqpRtUmf97th1Qb+a7gVexa2jqKbhf/6+3ACNAN4qnBj
         /DAd2qQkaRy7MH4HmC1ELYUVN3rQE0r3JEqi0wWpSbaQw1dWdbyMZ2HN49wygVP4gVDo
         dMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7eBFs2jG1q/fDxjb93hzAefYGEF97+oyRaVopG3hxRY=;
        b=rCsYk7I4TuZYz9nMoXLTb2p7oiSPd5Un4mYto4k4Jqgn6B1KC+liBpaUnzzs1Uya3Q
         zYRSlB6DMjrvOWoTJAt1W2qIeIsrBEp+djYyoWM/e2Bz+RWFKR4pfk61rSsQ2JAugtdS
         2CI0havM77lDRlALZvAvp8x31Ya9WCj6fQKsYucHOPdQMSEHmNb/Mp9yVOfnGIa0ztBP
         7jJHTfgDyFoYYmuA2sGpy5pLT4S+7/Tf0lmy1y4YPxeD8aa4Ym4izfFQubkjyFLGmPa1
         nj1UxS6qZQ1djGsOBlzgLeBfl3dbJDpdg5wl2PGuLo1azJnX2ow1kKvg+P2oRwYAhDE+
         HE9g==
X-Gm-Message-State: AHQUAuZdsH7xijRdZXjuBnWINP6n5mgKnua4KCdT96yfPkcyZ/JDpf98
        2iMdf/Jwl2IKVGN8nqjVm/m5267Ub9k=
X-Google-Smtp-Source: AHgI3IZ2WHnMhSklrjvS477A6+KUcHXhLrQlWDibtfRCJ6Z4Jnig9/4tq07FZK5LHNeN06SkNYw8ug==
X-Received: by 2002:a63:df50:: with SMTP id h16mr5985213pgj.421.1550013334522;
        Tue, 12 Feb 2019 15:15:34 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 66sm2548101pfq.17.2019.02.12.15.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 15:15:33 -0800 (PST)
Date:   Tue, 12 Feb 2019 15:15:33 -0800 (PST)
X-Google-Original-Date: Tue, 12 Feb 2019 15:15:28 PST (-0800)
Subject:     Re: [PATCH v2 0/6] Fixmap support and MM cleanups
In-Reply-To: <20190119132650.9978-1-anup.patel@wdc.com>
CC:     aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-3acc6cf0-4c86-4929-a653-11e87d0c6b48@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2019 05:27:53 PST (-0800), Anup Patel wrote:
> This patchset does:
> 1. Moves MM related code from kernel/setup.c to mm/init.c
> 2. Implements compile-time fixed mappings
>
> Using fixed mappings available, we can now get earlyprints
> even without SBI calls. For example, we can use kernel
> parameter "earlycon=uart8250,mmio,0x10000000" to get early
> prints on QEMU virt machine without using SBI calls.
>
> The patchset is tested on QEMU virt machine. It is based on
> Linux-5.0-rc2 and can be found at riscv_fixmap_v2 branch of:
> https://github.com/avpatel/linux.git.
>
> Changes since v1:
>  - Use more characters per line in changelog of PATCH3
>  - Removed #ifndef __ASSEMBLY__ from PATCH5
>  - Use more characters per line in commets of PATCH5
>  - Added PATCH6 to implement keepinitrd kernel parameter
>
> Anup Patel (6):
>   RISC-V: Move free_initrd_mem() to kernel/setup.c
>   RISC-V: Setup init_mm before parse_early_param()
>   RISC-V: Move setup_bootmem() to mm/init.c
>   RISC-V: Move setup_vm() to mm/init.c
>   RISC-V: Implement compile-time fixed mappings
>   RISC-V: Implement keepinitrd kernel parameter
>
>  arch/riscv/Kconfig               |   3 +
>  arch/riscv/include/asm/fixmap.h  |  44 +++++++++++
>  arch/riscv/include/asm/pgtable.h |   1 +
>  arch/riscv/kernel/setup.c        | 114 ++++++----------------------
>  arch/riscv/mm/init.c             | 124 ++++++++++++++++++++++++++++++-
>  5 files changed, 189 insertions(+), 97 deletions(-)
>  create mode 100644 arch/riscv/include/asm/fixmap.h

I'm getting some git issue when trying to merge the third patch via email

    $ mhng-pipe-show_stdout 4 | git am -s
    Applying: RISC-V: Move setup_bootmem() to mm/init.c
    error: patch failed: arch/riscv/kernel/setup.c:163
    error: arch/riscv/kernel/setup.c: patch does not apply
    Patch failed at 0001 RISC-V: Move setup_bootmem() to mm/init.c
    Use 'git am --show-current-patch' to see the failed patch
    When you have resolved this problem, run "git am --continue".
    If you prefer to skip this patch, run "git am --skip" instead.
    To restore the original branch and stop patching, run "git am --abort".

can you send a PR with a signed tag?  I'll include this as part of the next 
merge window.

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
