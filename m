Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABA5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3A6206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ukDxC+hS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbeLQJg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:36:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51787 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeLQJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:36:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so11623934wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8zZYYBpwYWn5hfJjNp5dCjaWNFjJl27s9MRtcqUbWw=;
        b=ukDxC+hScIdsBXLuSXzJ3JfvXOcaezdp/yDTHJpnEgX+qge6+JhxctNWpT40cT53Mk
         VdJT0EENh+hK8eWwtOvO5kiK5jUQ91AR8LiXtzsxM6nuyps404Dd0ncILrZNS9g4y3hJ
         KENf0dlKfpfU5KjIoli5IJPPRX6UL2wwYxopvKjcYmiCUD7OlAp/kk0fHOSuJ++vQ0M6
         /FUFDU8rGmyt08o9w1GGH/E9QoFdabrtLB/FYGFtVhAcIgSQa1+uBPiShUDHblpgWkFU
         2L1y4GQiRfmU/FH8QHKGByHGCxv+ZYElVGCKuesPi+wX49pUJ4z3NyHt5Lvc1cMjmSZU
         k+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8zZYYBpwYWn5hfJjNp5dCjaWNFjJl27s9MRtcqUbWw=;
        b=eBXO5cCyAGoAeLQKq9c8ar67kdVZp/iPRySX8YEMPYCWRoYB/x8187KouMk01jMmyQ
         sbRMzyPv6ukn3da6S9ID0ZK2/zhtAAlVgj+KjIg2nUu+jkW/pcyIhvf1Z+YBEQ3lRdwA
         zZGsO3ZuT8EsmzD4/SPampJMdaCKGeu7taP/UcmAyyt/iJc+02iq9s5mxZSaW0BfDTM5
         v5U7EddEmXebpgAQSiZPGQxNqu8p3xHxlVOd8695cyplq1sie4KvhJte9crzPdzcN1Sx
         kOrbTJbu6PpnUsev8jUAVktrmesnmMWNSaShdwhVhCqiPV5BaqDo5/nynTsOOTm05+Wv
         qXTg==
X-Gm-Message-State: AA+aEWYVoTcxbAIiHsne/1SHdxymX23hOt45JTsn1XY8k3NYoQtW5ZAO
        G2jnOJz1lseIiNSxYyCQvySRCjQSJ/Kg02rqGwFokw==
X-Google-Smtp-Source: AFSGD/WayTs7+4YAKeVwDhjje6SQgEioUZRT4ssOYRLVkzC556m+b7SpabPA+eTnIDTytXMHo7B8Q6MGy4aA950gwhc=
X-Received: by 2002:a1c:1801:: with SMTP id 1mr11634200wmy.153.1545039416992;
 Mon, 17 Dec 2018 01:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20181126060802.19314-1-anup@brainfault.org>
In-Reply-To: <20181126060802.19314-1-anup@brainfault.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 17 Dec 2018 15:06:45 +0530
Message-ID: <CAAhSdy1danjgviJ2WGGEANQXFkzZzXUdCj+04dZ4eLjcVOt14A@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Make BSS section as the last section in vmlinux.lds.S
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:42 AM Anup Patel <anup@brainfault.org> wrote:
>
> The objcopy only emits loadable sections when creating flat kernel
> Image. To have minimal possible size of flat kernel Image, we should
> have all non-loadable sections after loadable sections.
>
> Currently, execption table section (loadable section) is after BSS
> section (non-loadable section) in the RISC-V vmlinux.lds.S. This
> is not optimal for having minimal flat kernel Image size hence this
> patch makes BSS section as the last section in RISC-V vmlinux.lds.S.
>
> In addition, we make BSS section aligned to 16byte instead of PAGE
> aligned which further reduces flat kernel Image size by few KBs.
>
> The flat kernel Image size of Linux-4.20-rc4 using GCC 8.2.0 is
> 8819980 bytes with current RISC-V vmlinux.lds.S and it reduces to
> 7991740 bytes with this patch applied using GCC 8.2.0. In summary,
> this patch reduces Linux-4.20-rc4 flat kernel Image size by 809 KB.
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/kernel/vmlinux.lds.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index 65df1dfdc303..cc99eed44931 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -74,8 +74,6 @@ SECTIONS
>                 *(.sbss*)
>         }
>
> -       BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
> -
>         EXCEPTION_TABLE(0x10)
>         NOTES
>
> @@ -83,6 +81,8 @@ SECTIONS
>                 *(.rel.dyn*)
>         }
>
> +       BSS_SECTION(0x10, 0x10, 0x10)
> +
>         _end = .;
>
>         STABS_DEBUG
> --
> 2.17.1
>

Hi All,

Any comment on this patch?

Regards,
Anup
