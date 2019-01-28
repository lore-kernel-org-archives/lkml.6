Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B6DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5452721738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbFy6eoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfA1TFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:05:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37663 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbfA1TFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:05:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so15252027ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLBtBGXi3hlTxbZLGrRdRNxgDb+OQSk2JyX0KtPuOm0=;
        b=fbFy6eooKBnPCjgoX3yEfus37O2C7wWdE7RkU3pSZF8JhIv6RWSANEdUvqIoX6DvjV
         Naua51jw5y0va2ez0qy6z1zhI/aeqLNqE83FrYBEsRzlsTbEt4qeGbJdN/VxTPLk7IfM
         9IJjyEK7MFHigbch5YF4Rv71dAV190/YbCYaXBQLTg4u8nOVMMRxILQX+yh2QOdzvwgs
         U/3OiRyRyFt6YWTpIyMn+xk9nEgpVkMjOrXdCIZwFoBITNm5QLwYayZF5sJam8G1RDF6
         0e74wbb27OQnulrXDdYV5nDu6lVFVh9xaomdulLqJl3lt6QyYx87pfRoi7Cw9qkGoChq
         om5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLBtBGXi3hlTxbZLGrRdRNxgDb+OQSk2JyX0KtPuOm0=;
        b=ZeQxi1OoULRl1isQxxXvTNsiJsj9/T/EeKHTgvsKKEB0o15roJpQt2jrX6n2CTdL7Q
         YbDXWaMwBZWB/hll9W+ED2zYHvmg1RYIy2ta6fFI4l/3P1zcCtkc/lMViDBgUnjciBhP
         BqM4TMpk4NsWTftaXAbkw4BcHdDZrzpauBfpdzSlcbgJIExwsV2C2xxNXz/lYGOUrjX3
         UpqgDmaM3t8tJdjdUs+SAKPH4MTHFhIEy5NtpdtpQicfCGUxNXYBiJ9JU55V8CNcTBgo
         SMU7NhoZ5UzXxGcdwQTssQgHmWz2CWZvAaDA2gSvBk743c6YmUc/weSHfpV07lL4ZoO9
         QVzw==
X-Gm-Message-State: AJcUukf9r7OEpnFNJiKDeJc2Hj3fjrxfutt1eJb/cnRz7u/c6/bv4YH+
        C+++5qWqBPnrNOg50qXkysYJtMuM/m5gBvN52/Y=
X-Google-Smtp-Source: ALg8bN5nuobWIeIPWqy+hB1cSR4Pu3LHtkKdP/LJevum907FwcbkIu/ncqDDOKeDHgeGGxamAg93g3QnVCoBjaitQtU=
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr19612443ljj.43.1548702314824;
 Mon, 28 Jan 2019 11:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20190128161136.GA2266@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20190128161136.GA2266@hp-pavilion-15-notebook-pc-brajeswar>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 29 Jan 2019 00:35:01 +0530
Message-ID: <CAFqt6zbv-tMbv8JQdzHf7jjZPg3oGUk1H9gdnkbAvueBbemeow@mail.gmail.com>
Subject: Re: [PATCH] powerpc/kernel/time: Remove duplicate header
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@c-s.fr,
        Arnd Bergmann <arnd@arndb.de>, anton@ozlabs.org,
        aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 9:41 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove linux/rtc.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/powerpc/kernel/time.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 3646affae963..bc0503ef9c9c 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -57,7 +57,6 @@
>  #include <linux/irq_work.h>
>  #include <linux/clk-provider.h>
>  #include <linux/suspend.h>
> -#include <linux/rtc.h>
>  #include <linux/sched/cputime.h>
>  #include <linux/processor.h>
>  #include <asm/trace.h>
> --
> 2.17.1
>
