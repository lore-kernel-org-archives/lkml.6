Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F511C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E480B2082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWTIImhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E480B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeLDOqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:46:51 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:44541 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeLDOqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:46:51 -0500
Received: by mail-lf1-f51.google.com with SMTP id z13so12116020lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 06:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEIAyhd3q32hXoX6vKAQHHuji5XKnBWqt8xzcwrmFJk=;
        b=fWTIImhww5xyT3JFLaAXctekBWL/Rfpsj6bFtSCYIy0DLEt8nZ2LbLudgZhKkFGflF
         WBjHPF2iL/WKQO6Sk9b2fNzeGA9GNUnpEWoqaTWwpzDyEqOw3oe4bq9zMkP0YhjHpkd8
         haeQlReeYCnzTS5k5n6QxWYwqhtRh7d0K/6gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEIAyhd3q32hXoX6vKAQHHuji5XKnBWqt8xzcwrmFJk=;
        b=T0kdR5unyf18MgK438RwfrAEuALX9ztr9HQAyGWwhBfSmeBGGJ2c6eW/PEOJfqbSo+
         mhsZAcmVRp2/AsC2Q6Ay+kWyRxgoHQo5Z/7Nan+uUVhRbE4wFn75WqdGxMsYKHACLK2V
         3v0MM7b/AXigCw5KwRodfQIiZ5mYxf43kARjee9l4IqihrLZP/gx2dgd9x4qI/F8y9Ui
         4ctiulYqmKRcMeAb493kbYywZzdGnt7A6i4G0Q0r3IWj1ENQrAE4P6jfOhzk+tq4i9tp
         /5CN7IY3NLuv28rH/+tXDrFIn77obvumvHk9ZLiqYcZnpMAn8j3//0JRY141hg55VPhn
         Wv8g==
X-Gm-Message-State: AA+aEWZvUPF2DU2bqVUBHfjxwlWxiuDwmNKSaHSzosmZebuQuRfFPCZr
        +7uhy2ttkbeLEaMeXsgeyibRf5bRinYvdkPutRC2Ag==
X-Google-Smtp-Source: AFSGD/U+B4u9u0K8iYu5AAYyd2YLWrpekx7Q1deCHJyzNe5vxiK2OQjVRUOZ933hKqK6s//q4UwttxFX8N05zfQ234g=
X-Received: by 2002:a19:d58e:: with SMTP id m136mr12791626lfg.70.1543934807251;
 Tue, 04 Dec 2018 06:46:47 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsvJkW5_hruVYzLX3g9_5scj9nnL240rOMQ+DSz70dqqQ@mail.gmail.com>
 <20181204125233.GA1519@arm.com>
In-Reply-To: <20181204125233.GA1519@arm.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Dec 2018 20:16:33 +0530
Message-ID: <CA+G9fYt020CHvoH32KgdjKordVtG+VmriKEFqa1HTzWJTYf-nQ@mail.gmail.com>
Subject: Re: Linux-next: Build failed
To:     Will Deacon <will.deacon@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, 4 Dec 2018 at 18:22, Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Naresh,
>
> On Tue, Dec 04, 2018 at 05:56:09PM +0530, Naresh Kamboju wrote:
> > FYI,
> >
> > The Linux -next build failed due to below warnings/errors.
> >
> > include/asm-generic/bitops/atomic.h: In function 'set_bit':
> > include/asm-generic/bitops/atomic.h:17:2: error: implicit declaration
> > of function 'atomic_long_or'; did you mean '__atomic_load_n'?
> > [-Werror=implicit-function-declaration]
> >   atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
> >   ^~~~~~~~~~~~~~
> >   __atomic_load_n
>
> Ha, I like that the compiler is trying to get us to use its __atomic
> builtins here :)
>
> Anyway, you're seeing this because of this previous error in Mark's script:
>
> .../scripts/atomic/atomic-tbl.sh: line 183: fold: command not found
>
> even though fold is part of coreutils :/
>
> Do you have grep? Maybe the diff below helps.

Yes. grep is present.
Thanks for the quick patch.

- Naresh

>
> Will
>
> --->8
>
> diff --git a/scripts/atomic/atomic-tbl.sh b/scripts/atomic/atomic-tbl.sh
> index 9d6be538a987..81d5c32039dd 100755
> --- a/scripts/atomic/atomic-tbl.sh
> +++ b/scripts/atomic/atomic-tbl.sh
> @@ -180,7 +180,7 @@ gen_proto_variants()
>  #gen_proto(meta, ...)
>  gen_proto() {
>         local meta="$1"; shift
> -       for m in $(echo "${meta}" | fold -w1); do
> +       for m in $(echo "${meta}" | grep -o .); do
>                 gen_proto_variants "${m}" "$@"
>         done
>  }
>
