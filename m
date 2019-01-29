Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE16CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704302087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loh7/4Nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfA2WMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:12:54 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44823 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfA2WMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:12:53 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so24084457qte.11;
        Tue, 29 Jan 2019 14:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TIyDYxES46aXZPfDkeV56LwK2oUYfsXrhQM+OMffNVo=;
        b=loh7/4NwJxAME18F8qA/Ebz0a47EVxmOOEj5dEqkaNSn7cG9OYaBtIjnAjMGxna2s2
         i4dAHrFeB1y8VoHoS7yR1TQvc0Nrru43pEWJuQlqnNEgBjt0EH/OkgEFhWPNbTPl1dZM
         v/iDfMoAKOCOH/6zgDoZwXHhg6Z5d/8G3eVxY8LTLWaGP8rhUnFqZCmGD2z41PcuBXIj
         /9dnhg2KvteHuCHJHTlxrCvqhEFVo0kqXEG3L9WbLqYTy7tw4aFlj4dx83DuULY1H6az
         xHWaFHS8N/mATam+fh3XjVdwJ6G5EySKETF8TkXcahDG/dxkcXUNvs8iy0cSWAAzg/+V
         Ds/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIyDYxES46aXZPfDkeV56LwK2oUYfsXrhQM+OMffNVo=;
        b=M3wrLFIzfdDrUFzANceyhfAW5VimCi4Pd1TgbMzp1GYxQ40gGnp2kAtsK/uSnpuJ2p
         znTi02gV/x5mS4gAfewkAMTS71FJTSCDeW1ZC1nFDQqpqZSW9sEohmCicOODABbnxXKA
         Lvdoo9Er6m1SUTGZl/KwnLsFb4aK/cqWrTo22KEaSQjCdZ4793lQj6IOWv1FewyAHTRd
         N50dcUg/aw7TvaXtU2muviFiqubQ07H0kO6dg19OHMR+NHDz0BjX7Iz2m360WoBBhNj9
         duSLqv7V+LHD+TqH5jXpjelxe3DoBRxlUHF6Aq+D3fW0OZUEYQ3kyqObhs5V88/3MzAI
         7KNQ==
X-Gm-Message-State: AJcUukfN1OD/iMDplnUHryYxC6YCER/dNxQMdptsMkpnHzJlbfwmZycz
        AodhGchGbSOFAQwkr9tEp/CsMfhZA/MqwjNgxcXUR9Jf
X-Google-Smtp-Source: ALg8bN7NWxtJJsKnq3qSU6EFCeXKqyMyMbYhvIiYC4hVqF+pNzhz9znoeueAD9oFRhJKR0KTopfH8roOxNKDYhzVIKQ=
X-Received: by 2002:aed:2798:: with SMTP id a24mr27699322qtd.138.1548799972936;
 Tue, 29 Jan 2019 14:12:52 -0800 (PST)
MIME-Version: 1.0
References: <30924.1548734686@turing-police.cc.vt.edu>
In-Reply-To: <30924.1548734686@turing-police.cc.vt.edu>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 29 Jan 2019 14:12:41 -0800
Message-ID: <CAPhsuW6Jf3hThg5+BVFQC_iTS1m2psZS8pzmii+vzanfEcP_dA@mail.gmail.com>
Subject: Re: [PATCH] kernel/bpf/core.c - fix bitrotted kerneldoc.
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

On Mon, Jan 28, 2019 at 8:06 PM <valdis.kletnieks@vt.edu> wrote:
>
> Over the years, the function signature has changed, the kerneldoc block hasn't.
>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Acked-by: Song Liu <songliubraving@fb.com>

>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 2a81b8af3748..2728b6247091 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1216,8 +1216,9 @@ bool bpf_opcode_in_insntable(u8 code)
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>  /**
>   *     __bpf_prog_run - run eBPF program on a given context
> - *     @ctx: is the data we are operating on
> + *     @regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
>   *     @insn: is the array of eBPF instructions
> + *     @stack: is the eBPF storage stack
>   *
>   * Decode and execute eBPF instructions.
>   */
>
