Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B39BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4782175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJDyH/K9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBGXEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:04:01 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46358 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGXEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:04:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so2756472otm.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 15:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCv5/PGVNNWxs0HHsLz6/g8Xq2Ki+V4/UVfXStq6QTQ=;
        b=hJDyH/K9RtnTqhzjiYKO1iihOp8ZCRB4XYt2ZFijtvcO1PJ6NSKdbxbjStcqu0lU+C
         7Amr8/zEBKs03xXLMQ+2GIBKCQCqT/lptZx/E0hN8PURkqQbpVb6NS43u0OG5ra0y5W3
         nac7YdRtLG0GARFTHhkcv6NYiOf4SnQz5igyOadUhPmQUKO7k/T2aJ8VqfXUTnNN6/5I
         XjLPDyHkWYjI4/kShesbVqkaGXS1ZbTQbG2uOJ4EDxbBZv7NfGURLBFvs3+YSwvlDQYD
         txhfYSFkc9zOQ9JET8EXNW566W2IjDs9Fqpm66ChDtsqvJvqs41i7KCWaAiTxYbOMibU
         lg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCv5/PGVNNWxs0HHsLz6/g8Xq2Ki+V4/UVfXStq6QTQ=;
        b=OtzoqTAoF6YHiwX5hYUuqAbvaf5FN2Ia5B26JRfBODXPI7Jvxge+u2o++WWxYVWsC/
         kk+3IyfEDrqWEdKf0GzhFM1YZqbNMnseVO9C1QV8+bx2dHJEUTMlu+d3FHhZc36eQaaw
         AZ2ZvFDUVpTZZw33MBmiNi6V4Kz97R+S0h/zGuDh/hJ3Hn7gNk0lyuCxRTXQwSUKFLz5
         21ThoJqkKG+LrztvxDjF8Imh6IX2poxER8dBpZPS7sOP3Fn+rW8pMZkHGsvcgrsRJywm
         Z+jdK1LXGCsf9W93Z1otFpdcns2rZVHq42ATH0zR1LrPar8ej/GGTeJUwYHSVNoF5pZH
         PC0Q==
X-Gm-Message-State: AHQUAuYd2+GChBiAwhZVKB5jndoiblmxpj20edn4uJQ0aHMPRuEH/Hdw
        2e9V8C+IOFWeR7N1DorqU+zSUzR5XXtorKcds3+DYKVV1Nk=
X-Google-Smtp-Source: AHgI3IaAREbWknrsBfsKb7o6FpuXeHyLnoRE5xTFSSfTnK9cPkwr6zw/WPqP++sm+8YdQX7/k9zjqRhc2vBLXTKqDbI=
X-Received: by 2002:aca:1b18:: with SMTP id b24mr317645oib.152.1549580639857;
 Thu, 07 Feb 2019 15:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20190207225531.19219-1-alistair.francis@wdc.com>
In-Reply-To: <20190207225531.19219-1-alistair.francis@wdc.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Fri, 8 Feb 2019 00:03:48 +0100
Message-ID: <CAEn-LTrQtL3+MQSDKQmBBx4PJGox4r5yEyHxh35VVd_D4dg0Dg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Partially revert "Remove stat64 family from
 default syscall set"
To:     Alistair Francis <Alistair.Francis@wdc.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "alistair23@gmail.com" <alistair23@gmail.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 11:56 PM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
>
> To fix systemd/sysVinit crashes enable __ARCH_WANT_STAT64.
>
> systemd failed to start with this error for 32-bit RISC-V:
> [    2.833864] Run /sbin/init as init process
> /sbin/init: error while loading shared libraries: libsystemd-shared-239.so: cannot stat shared object: Error 38
> [    2.933593] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
> [    2.934120] CPU: 0 PID: 1 Comm: init Not tainted 5.0.0-rc4-yoctodev-standard #1
> [    2.934589] Call Trace:
> [    2.934919] [<c0048a30>] walk_stackframe+0x0/0xa0
> [    2.935243] [<c0048c14>] show_stack+0x28/0x32
> [    2.935518] [<c05fa418>] dump_stack+0x68/0x88
> [    2.935788] [<c004de48>] panic+0xf0/0x252
> [    2.936041] [<c0051780>] do_exit+0x7de/0x7fc
> [    2.936387] [<c00517f4>] do_group_exit+0x2a/0x82
> [    2.936674] [<c005185e>] __wake_up_parent+0x0/0x22
> [    2.936982] [<c00475fa>] ret_from_syscall+0x0/0xe
> [    2.937673] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00 ]---
>
> sysVinit had a similar problem as well. By enabling __ARCH_WANT_STAT64
> for 32-bit RISC-V the problem disapears and 32-bit RISC-V is able to
> boot.

Hi,

This is expected change for riscv32. More details here:
http://lists.infradead.org/pipermail/linux-riscv/2018-November/002062.html

david

>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> This was tested with this fork of glibc to enable 32-bit RISC-V support:
> https://github.com/riscv/riscv-glibc/tree/riscv-glibc-2.29
> commit: 04fdd476160a55792a75375ba2bf56c761f811c2
>
> I'm not sure if this is a glibc problem or a kernel problem, but this
> commit caused the breakage between the 4.19 and 4.20 kernel so I'm
> sending out a patch. Let me know your thoughts
>
> arch/riscv/include/uapi/asm/unistd.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
> index 1f3bd3ebbb0d..031b7d78e11c 100644
> --- a/arch/riscv/include/uapi/asm/unistd.h
> +++ b/arch/riscv/include/uapi/asm/unistd.h
> @@ -20,6 +20,9 @@
>  #endif /* __LP64__ */
>
>  #include <asm-generic/unistd.h>
> +#if __BITS_PER_LONG == 32
> +#define __ARCH_WANT_STAT64
> +#endif
>
>  /*
>   * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
