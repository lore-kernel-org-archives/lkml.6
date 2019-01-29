Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4662C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA11B2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seZcaraZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfA2HIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:08:07 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37355 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfA2HIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:08:06 -0500
Received: by mail-qt1-f196.google.com with SMTP id t33so21175454qtt.4;
        Mon, 28 Jan 2019 23:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HnPr78Z6Tsbuc0oWNtnDSNjoERejteU0nTTrHWFce8c=;
        b=seZcaraZA6eM78HPD70+7jYMj48mePTre8O/mQQ7RMGjTFFe4ayBXMZJ47Dz0igBeQ
         dwa1UnGx3SjrJeX+rWaklNa3EbgSl23+i+iTMCl6iZq3w7GRKI422tnhxlcArQMKfQpW
         re7S1wRJqmSa0hvwpbEOe2UdbsQEttmK8zlI++eQmhIblrPZBHEmH5TBaQtC5dDwGgQa
         5KV01uub5IMOkqfTu4JtqmydZfG0th34jQz63o0s8JU9vBxsCoYyTqf5FKVde4uAr4xr
         Fi0u/Kxnhbp78W/NAPVpGnUZdJ7+7KkIRhszYcIjywkcVOZURU83BpNyKnOhR79GeWV5
         NRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnPr78Z6Tsbuc0oWNtnDSNjoERejteU0nTTrHWFce8c=;
        b=MmfkTBMGhtv3iwnZX4S0LIlcd1dLeNPLxKJ8xexjiU4CPgi/m3CNvdICMUaGG5m+Ae
         5xjg/MT5ZWWIxlsYImqV2ucgjfGnTgWiOjXDrnF77kqMM4UBPraH4cmdFckfvkJREkdB
         +6q8cOmVqk9rGD+ALDVg/sHOvsCOsNc5jGnwPJizvoOf9aO+ySHJhkhVztyUrDVo/qsv
         dIFpNzGEonc5JS9kXhDjTxS0kh446XJTKltItUwk6GMEVqf1T4Dwqu5/H4+uxHweJu3R
         iyomGDb2RtE0qSVVTg6Ve9gm/vYSmNul2Um/8hDkzu2WW9iSxzh+FRYcbYpV0PWqr8cz
         Q3hQ==
X-Gm-Message-State: AJcUukcUzzb8blWPVc0KBhG1xmGnR5jUNOrvRvEkzJZeEo0gpJXza90c
        OkKaJL5wf6u3ArDgrL1/rh7Nfk2SgrdgwxaMMPA=
X-Google-Smtp-Source: ALg8bN6kBeq48hXDCBLjDZ6m8QvMZ1Tzofh77MfWXGAUchJUbGcrRFdlrPGMGdbpn7tj3F5u8wM02/5a158OiS6QVWA=
X-Received: by 2002:ac8:3312:: with SMTP id t18mr24740566qta.225.1548745685551;
 Mon, 28 Jan 2019 23:08:05 -0800 (PST)
MIME-Version: 1.0
References: <6349.1548741865@turing-police.cc.vt.edu>
In-Reply-To: <6349.1548741865@turing-police.cc.vt.edu>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 28 Jan 2019 23:07:54 -0800
Message-ID: <CAPhsuW6zCrQ5wn+PG4B3KWqEmMsVPEuJGy24GCUYdCH=t9VpKg@mail.gmail.com>
Subject: Re: [PATCH] include/linux/bpf.h - fix missing prototype warnings...
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:05 PM <valdis.kletnieks@vt.edu> wrote:
>
> Compiling with W=1 generates warnings:
>
>   CC      kernel/bpf/core.o
> kernel/bpf/core.c:721:12: warning: no previous prototype for ?bpf_jit_alloc_exec_limit? [-Wmissing-prototypes]
>   721 | u64 __weak bpf_jit_alloc_exec_limit(void)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~
> kernel/bpf/core.c:757:14: warning: no previous prototype for ?bpf_jit_alloc_exec? [-Wmissing-prototypes]
>   757 | void *__weak bpf_jit_alloc_exec(unsigned long size)
>       |              ^~~~~~~~~~~~~~~~~~
> kernel/bpf/core.c:762:13: warning: no previous prototype for ?bpf_jit_free_exec? [-Wmissing-prototypes]
>   762 | void __weak bpf_jit_free_exec(void *addr)
>       |             ^~~~~~~~~~~~~~~~~
>
> All three are weak functions that archs can override, although none do so
> currently.  Provide prototypes for when a new arch provides its own.
>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Acked-by: Song Liu <songliubraving@fb.com>

>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3851529062ec..99e55313123f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -472,6 +472,10 @@ _out:                                                      \
>  #define BPF_PROG_RUN_ARRAY_CHECK(array, ctx, func)     \
>         __BPF_PROG_RUN_ARRAY(array, ctx, func, true)
>
> +u64 __weak bpf_jit_alloc_exec_limit(void);
> +void *__weak bpf_jit_alloc_exec(unsigned long size);
> +void __weak bpf_jit_free_exec(void *addr);
> +
>  #ifdef CONFIG_BPF_SYSCALL
>  DECLARE_PER_CPU(int, bpf_prog_active);
>
>
