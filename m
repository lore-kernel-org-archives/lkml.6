Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC20DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCFE2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnvOXkCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCFE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeJEWPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:15:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45248 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJEWPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:15:18 -0400
Received: by mail-io1-f66.google.com with SMTP id e12-v6so10918871iok.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 08:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=K2fR45txb+KGTYn8sBXSjm3wPg1ebjIW3jHzlvMEYbk=;
        b=YnvOXkCdJ1oJ+UhIdJGdzU3Ri0RkbyrwIJSzkOse46phpV6Ep6iwujnFO+mdgF0dB1
         KXlJ/6LiRql0L7x19ycqtf+Ef8Ixc+VDOWZ+LVDGdlQ7j/6VTmptn2vgwF/TUABJ1ISD
         yyKEy7g+GTWcM2J09NkvhPENi/JMn+c+HUuVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=K2fR45txb+KGTYn8sBXSjm3wPg1ebjIW3jHzlvMEYbk=;
        b=VQ+oB0EptN5keQgtcHNrZf2hDlTs1lJ8XQkM7azKUJqx1P8ZVKYsgM+u3PAtcsIP4i
         gC2gxVWTC00oUVugMvl6MchrD2WjPm4kJ2wotc6DIgoMnDY0pYfOCmJ9JaEVnzPntTV4
         ZNeU6UYem/DQAe2fSlcoNZJYH4wcjoTQ1Co8jAhTDliivZIICf5+Y9C0YPMxLOWHYfqZ
         lXDL+1M4hkgg3hzJgFvYK9VMlRgw72l3s/WmvoScKYvYHyPs9iOxKJ9P3NTdvbHk6lGG
         II9l782lrtfZSe0TmH3aS2GYHj9mbVxWhVNZtGcLoQ69fx2XOeceXLsM+8QS0f2HLAeI
         tHjQ==
X-Gm-Message-State: ABuFfoj3bdnALG2ML8GOXh15jH1/DJclRC9yWQ3DAiVpFIETSLQO+J5j
        kJI5F8sfoqP5xaXZTPw7IkukUgXBotB8+i4rFkEWPA==
X-Google-Smtp-Source: ACcGV62L4I0mPQSBMQD06bUFfC0YL9+loe3q6sdye9/64hGEOCyhMivcs9p8C2N17pJKBkDyMV34yfFft6hIETfduS0=
X-Received: by 2002:a6b:3787:: with SMTP id e129-v6mr8524150ioa.60.1538752569558;
 Fri, 05 Oct 2018 08:16:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 08:16:08 -0700 (PDT)
In-Reply-To: <20181005150538.17006.qmail@cr.yp.to>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-20-Jason@zx2c4.com>
 <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
 <CAHmME9rp0Fi5ObK5oi8FHj1_nK5hP4T2Bq7_dAmzq4OQ0mp0uw@mail.gmail.com> <20181005150538.17006.qmail@cr.yp.to>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 5 Oct 2018 17:16:08 +0200
Message-ID: <CAKv+Gu8SFbKXwO_fngymM6Rh6jU4=B14=V0NaCBOTOCoO3M-kA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 19/23] zinc: Curve25519 ARM implementation
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        peter@cryptojedi.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 October 2018 at 17:05, D. J. Bernstein <djb@cr.yp.to> wrote:
> For the in-order ARM Cortex-A8 (the target for this code), adjacent
> multiply-add instructions forward summands quickly. A simple in-order
> dot-product computation has no latency problems, while interleaving
> computations, as suggested in this thread, creates problems. Also, on
> this microarchitecture, occasional ARM instructions run in parallel with
> NEON, so trying to manually eliminate ARM instructions through global
> pointer tracking wouldn't gain speed; it would simply create unnecessary
> code-maintenance problems.
>
> See https://cr.yp.to/papers.html#neoncrypto for analysis of the
> performance of---and remaining bottlenecks in---this code. Further
> speedups should be possible on this microarchitecture, but, for anyone
> interested in this, I recommend focusing on building a cycle-accurate
> simulator (e.g., fixing inaccuracies in the Sobole simulator) first.
>
> Of course, there are other ARM microarchitectures, and there are many
> cases where different microarchitectures prefer different optimizations.
> The kernel already has boot-time benchmarks for different optimizations
> for raid6, and should do the same for crypto code, so that implementors
> can focus on each microarchitecture separately rather than living in the
> barbaric world of having to choose which CPUs to favor.
>

Thanks Dan for the insight.

We have already established in a separate discussion that Cortex-A7,
which is main optimization target for future development, does not
have the microarchitectural peculiarity that you are referring to that
ARM instructions are essentially free when interleaved with NEON code.

But I take your point re benchmarking (as I already indicated in my
reply to Jason): if we optimize towards speed, we should ideally reuse
the existing benchmarking infrastructure we have to select the fastest
implementation at runtime. For instance, it turns out that scalar
ChaCha20 is almost as fast as NEON (or even faster?) on A7, and using
NEON in the kernel has some issues of its own.
