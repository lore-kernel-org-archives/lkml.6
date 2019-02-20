Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F98DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306562147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zu6ma0Pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbfBTAqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:46:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42792 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbfBTAqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:46:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so16217657lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 16:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iP/6ETy+pOSIbPoAv6tz/DPX0DtkuhYiTbgrcxVYuJ0=;
        b=Zu6ma0Pk6QIhVjqrZaUecHrMbyM7lw73sjll5ob7NOLXw5nXQFdXsU8i9qQnbOsWru
         b19Dqc2Ze5G/a4/vm/s62BrFS/jzKSGhvaCUWTlZzl4WNcNFTrstq3AOzBbOZ+3j9Ait
         7wK/AN5QYIhxfn6l8crvv5SdbqxNHRMn1zxN2OWNm2OEb4VYYjO7jqf5o8LoJu9RL1Cz
         +B1qrQ3JkQC8nJT3PjRmkTXgUG44iQs/pE79hdI70s3E2dkXxznAiDAl0UaEqBiYDPr5
         dXJgjD1vdgyruvKH60efmXV7US/KtCnIFyPfiKYM0JuBzcqNvsUrFBDmMZ5NXe3RKuQo
         3ZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iP/6ETy+pOSIbPoAv6tz/DPX0DtkuhYiTbgrcxVYuJ0=;
        b=n28VT9R6DTVpcXV4xTvD86SXK/xlPrJ3UQZxH2aoTsRxV2EQiKexquNWkY0w97okio
         Wb4OA1q1U13oN7PnXKgsuz5fKUc8G4AIFLMdjg9QcLfhzuzhhXJx52pqBW6B+47TMmS8
         MxajJbWjTegTi3kgG7TFpAvB7T22sdIm8+VWRyQk3FZnSnDH78pMWxzKtevHJbSsB+oz
         59ftDE6uIzLFoiXTMI6YlX9qprXLkff3P0PS88V+P0ZM/6n2fq66Kpuiu9U+xE7BhXyQ
         LcPTKoV/d3E/lvRagW4FK2wZIA6WH/V91kuCj5Lzn+1aPQFr02Myn+6X+iyHjLoYh5u2
         urlg==
X-Gm-Message-State: AHQUAub+ku74h2F0P9A8VtvovwdUa/GKYQQG7O2hzKHQGLoJD4L5Y8zZ
        cdznzzal+VXZngC3hO7j1lyW2Jn12wstwTZhkRrpCg==
X-Google-Smtp-Source: AHgI3IZFT+T74mL/CzSF/UWgZ47HA0U6j7PucCMD3cseHcUG8SrsibkiA8sgrHYk+BuB7Pvcq7KQoOUrSwRkDgGX9+s=
X-Received: by 2002:ac2:4191:: with SMTP id z17mr18248649lfh.117.1550623557990;
 Tue, 19 Feb 2019 16:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20190220113729.49f28f73@canb.auug.org.au> <CAADnVQK3qg2k67LRiOqDmFnELrFOD1dLkrNbAvbMyu6xGpjBLw@mail.gmail.com>
In-Reply-To: <CAADnVQK3qg2k67LRiOqDmFnELrFOD1dLkrNbAvbMyu6xGpjBLw@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 19 Feb 2019 16:45:46 -0800
Message-ID: <CAKH8qBuoYKPMhHn6Xzo=nEBevBt93c4+9cAVW7BZZwpNj46SCA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the net-next tree with the bpf tree
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 4:41 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 19, 2019 at 4:37 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > Today's linux-next merge of the net-next tree got a conflict in:
> >
> >   tools/testing/selftests/bpf/test_progs.c
> >
> > between commit:
> >
> >   f6be4d16039b ("selftests/bpf: make sure signal interrupts BPF_PROG_TEST_RUN")
>
> Ouch. Thanks for the heads up.
>
> Daniel,
> should we drop this one from bpf tree ?
> I don't think it's strictly necessary.
Yeah, those can go via the bpf-next three as well, not very critical.

OTOH, I don't understand why is there a conflict? bpf and bpf-next
adding tests in the same place/file? Those can be trivially resolved
when bpf and bpf-next are merged in the next window.
>
> > from the bpf tree and commits:
> >
> >   bf0f0fd93945 ("selftests/bpf: add simple BPF_PROG_TEST_RUN examples for flow dissector")
> >   ab963beb9f5d ("selftests/bpf: add bpf_spin_lock C test")
> >   ba72a7b4badb ("selftests/bpf: test for BPF_F_LOCK")
> >
