Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EFBC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFB020989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCl2w8wK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfA1RTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:19:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45642 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbfA1RS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:18:57 -0500
Received: by mail-qk1-f193.google.com with SMTP id y78so9806584qka.12;
        Mon, 28 Jan 2019 09:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZREMQe/Zxzwcr4L0rEx84MvD8WUiexrrbKJ1DrVsjNw=;
        b=JCl2w8wKODSnxWDejcxItNxb+tIU0k1Mp5ww6FKLX+xRK86/McUhoW0U2TvFAds+Gq
         NkisHzWHEN+qazqYr9Qnz0pUhzoOoe3YwO8BaEdVmMOFNBjVAWqPlkw1ejKbzXJmQyOx
         yXytRALS7o1XFxdxCAZfPqF7ZAyCCAk/H7EM/RYjDUdf223rxKdWAafZ/+jCG1DsR48I
         O8b+NU2QwWsZbas/4OqVyZcGOkbfr0QBFTGGHwQgXxPt1dr3XKSX0FFejFG0OqNCV7cH
         +7Ibn3wP7H8r4SZ0Q26Cs3G1tmui9q3RCt7mCKbCxRncnmAUEB/DG1q+oIdH+AIth+4z
         adDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZREMQe/Zxzwcr4L0rEx84MvD8WUiexrrbKJ1DrVsjNw=;
        b=SA4tD/afIl7Q1aZTCQxDfhWyBUzxEc8iJFcEiiW42QmIO10zrPu3PpeYvot152WO16
         LY9KRPi87DB7LMNQkDoO7jHUoFUg8oL88sobh2UNSoflvq//YcRmHyqwwryvM02NnPWJ
         7QaxExqvpo553IcHpAULJM53hWP61DGBAZSD2uCuNuw5N9QAG5px7E0wFheKL32v8zS+
         +6SaqgMjUKa7B0a4tmL18mQjaKuQwibEXCKeU1WptGiK5Yp+p14AmJ5vNU5JUP0lcR4v
         tjlp/BMAapsDZGkmIeQKZeFi425KnrqzSfDiHCMMXvbHmj1pf9Yy2uz4EiWYQerfAsHL
         rvQw==
X-Gm-Message-State: AJcUukc6uJW0OaAKTyIpxwBa0Aosjyfx4a5Xrd8nWrufsLqnJ/+Pc91v
        D13GuGLp/tJEmEbkZ0mQlW3tgYQHOTnQilHEI2g=
X-Google-Smtp-Source: ALg8bN61etkNKg68lL4h6bbIsRhlgFRluXy0DND2CDzFLIb6BV8zWJxb4ikHBTIXU+Jl9zVmR2QT3z8YqWtIZ/uskXk=
X-Received: by 2002:a37:cc4c:: with SMTP id r73mr19930545qki.120.1548695936320;
 Mon, 28 Jan 2019 09:18:56 -0800 (PST)
MIME-Version: 1.0
References: <31468.1548648675@turing-police.cc.vt.edu>
In-Reply-To: <31468.1548648675@turing-police.cc.vt.edu>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 28 Jan 2019 09:18:45 -0800
Message-ID: <CAPhsuW54z8ao4KOKG9ZjdXus6LTBH2qwAi8LgPFZ_qb_ObKsRg@mail.gmail.com>
Subject: Re: [PATCH] bpf/core.c - silence warning messages
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

On Sun, Jan 27, 2019 at 8:43 PM <valdis.kletnieks@vt.edu> wrote:
>
> Compiling kernel/bpf/core.c with W=1 causes a flood of warnings:
>
> kernel/bpf/core.c:1198:65: warning: initialized field overwritten [-Woverride-init]
>  1198 | #define BPF_INSN_3_TBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = true
>       |                                                                 ^~~~
> kernel/bpf/core.c:1087:2: note: in expansion of macro 'BPF_INSN_3_TBL'
>  1087 |  INSN_3(ALU, ADD,  X),   \
>       |  ^~~~~~
> kernel/bpf/core.c:1202:3: note: in expansion of macro 'BPF_INSN_MAP'
>  1202 |   BPF_INSN_MAP(BPF_INSN_2_TBL, BPF_INSN_3_TBL),
>       |   ^~~~~~~~~~~~
> kernel/bpf/core.c:1198:65: note: (near initialization for 'public_insntable[12]')
>  1198 | #define BPF_INSN_3_TBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = true
>       |                                                                 ^~~~
> kernel/bpf/core.c:1087:2: note: in expansion of macro 'BPF_INSN_3_TBL'
>  1087 |  INSN_3(ALU, ADD,  X),   \
>       |  ^~~~~~
> kernel/bpf/core.c:1202:3: note: in expansion of macro 'BPF_INSN_MAP'
>  1202 |   BPF_INSN_MAP(BPF_INSN_2_TBL, BPF_INSN_3_TBL),
>       |   ^~~~~~~~~~~~
>
> 98 copies of the above.
>
> The attached patch silences the warnings, because we *know* we're overwriting
> the default initializer. That leaves bpf/core.c with only 6 other warnings,
> which become more visible in comparison.

My concern is that this will also mute the warning for other parts of
bpf/core.c.

Maybe we should move bpf_opcode_in_insntable() to a separate file, and mute
warning for that file?

Daniel and Alexei, what do you think?

Thanks,
Song


>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
>
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 4c2fa3ac56f6..2606665f2cb5 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_CGROUP_BPF) += cgroup.o
>  ifeq ($(CONFIG_INET),y)
>  obj-$(CONFIG_BPF_SYSCALL) += reuseport_array.o
>  endif
> +CFLAGS_core.o          += $(call cc-disable-warning, override-init)
>
