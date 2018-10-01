Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760CDC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168982089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUeq2SZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168982089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeJBB2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:28:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44794 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbeJBB2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 21:28:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so7860686wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4GgCgbaK8pRrkLIoTBtGpDQqIfLyPxDHMgzQfCY+p0Q=;
        b=OUeq2SZgCmbqbMK8FCOhhJPaHmxrZQB7IMY6Fi3az2khyVJoO7eWyCJtES4nvlmE4D
         Uke4xqSpjOVuKQ+76CveeSUZhHMQiKQgZ5hW/iy9poUUWXXeZPEKsJjMtxnkUw8HAg8U
         XrmwL/vuCizCWpY38GRLfjkIyXf2HQ6WjMNuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4GgCgbaK8pRrkLIoTBtGpDQqIfLyPxDHMgzQfCY+p0Q=;
        b=fyC2eOC3R2NGCs2dk9IH+JQ9NVI1+2JdcLMYi/3u53+Jn2IAfAt5SeY29Yd+w9kgef
         8HiWB3z/bkdpP4Y86o0aUd2yQGNkZoR/I0hnR5BkWav98LuAN6aNYV5f91IrVV9uKTWJ
         NDgofoRFlG3sJj8HTEqumn3aOJWw57yq7jsHjVkIQI0NJnG5sF1s6zAm2C7yuI3EllO1
         36xEIERFsSAbeyBKpuSGNx4ylJ76HPuJQcyGxO5eXbuaQy/MtIK+jMLjZgUdqXLhKiNx
         T+iEgDAW7DaYSAF+e1YJRs7fhEvQyqaLFGp5FUtVfP+VQ3HcaQx03gRw4KH82HurRU1g
         vnEw==
X-Gm-Message-State: ABuFfoiIV3J4NH5JAc1eTZT7LiDdQiIvJ1ZamPe7U47F13+ArrfCq0RC
        +rhM4mGiSLQpjGhqEgjV1zglb0sEk0goQJDuSIIe4Q==
X-Google-Smtp-Source: ACcGV62m2BYUIMQE7zklod9GWHzkhn53BL9nfLHn37RWgaJ6mgyqNYwkQGNvgj1kDdgscuHImvY2uCi1HFs9AISiAwk=
X-Received: by 2002:adf:ba06:: with SMTP id o6-v6mr7518744wrg.249.1538419767927;
 Mon, 01 Oct 2018 11:49:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 11:49:27 -0700 (PDT)
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 1 Oct 2018 11:49:27 -0700
Message-ID: <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
Subject: Re: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        android-kernel@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 10:58 AM, Mark Salyzyn <salyzyn@android.com> wrote:
> Last sent 23 Nov 2016.
>
> The following 23 patches are rebased and resent, and represent a
> rewrite of the arm and arm64 vDSO into C, adding support for arch32
> (32-bit user space hosted 64-bit kernels) and into a common library
> that other (arm, or non-arm) architectures may utilize.

So I feel like this has gone around a few times w/o much comment from
the arm/arm64 maintainers. I'm not sure if there's a reason?

I worry part of the issue is the scope of this patch set is a little
unwieldy (covering two architectures + generic code) might leave
maintainers thinking/hoping someone else should review it.

It seems the patchset is already somewhat broken up into separate
sets, so I might recommend picking just one area and focus on
upstreaming that first. Maybe the in-arch cleanups for arm and then
arm64 and then maybe do the move to lib?

thanks
-john
