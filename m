Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D52C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CA720869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BaSN2tzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CA720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeJPPwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:52:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45903 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeJPPwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:52:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id e10-v6so24611907qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XebpuBAa/N4I5t+WvllZVz7C8W/X4EjhR10vqZfRn+A=;
        b=BaSN2tzfRKI/l7WHVCWs2Cfy+PUdpQJpebR7aDaJHKFKiBVqA0pN4HemsvzuPlRrS3
         wAsBVrtTPnnppdNjcUI0u14HxsPG7VwkWw11jhmmtj3gSFRqRIGeqRMnCX5Rlj7B05oc
         VIIV9FazeFjBLa5r69FFwiiIRzg2ZiQntziT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XebpuBAa/N4I5t+WvllZVz7C8W/X4EjhR10vqZfRn+A=;
        b=riIKuBwTrF9qgjVEoLN3cdnsklyXKBTwJlb8OAZ+IYmYS4LtDQlcOBwq0g1hGsflzi
         TK6H5enxh6BofWzqko6tq6vCw92xxMtxI1PA6BkIAvIqDVvJ8/nkGYrOAifUzKMC5NTB
         ro7DgbmQjDrakvMDgQVCwUKUCPSpfp4SmHxrbrJxxWVOFfqjhTG6INFzp3Qm/mXqvepf
         V+tCKwIy3VhRxWqZuK0LHM+6kqPU5lkGCiFQBlRhNhk4qvmnCAqM2/MmSz26rns2AKSq
         t5pb5F1yFIfLlw+rEi2UL64I9GPwgzSfnbyao4Zc+wGhffMW8NHswh8V3YkwAEDXim4v
         JtaQ==
X-Gm-Message-State: ABuFfojfixbDLr/M5T+LPPOBxihQ/aw84Q4M2ffbzDqG1CWkpVPHDvI4
        SfWHUz76I6FAVi3SfN7fh/36mCrnCMvi61biUd9++0Zv
X-Google-Smtp-Source: ACcGV62HbK3VyeFbb4UP6g0XL39kqd70WFcUi/GzaElTz/72KJ9f0EwApmN/WwWunLqXC6ixCtnxTK7+YLyARgnd3OU=
X-Received: by 2002:ac8:435b:: with SMTP id a27-v6mr19126291qtn.295.1539677001028;
 Tue, 16 Oct 2018 01:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <1539663093-15923-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1539663093-15923-1-git-send-email-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Oct 2018 10:03:09 +0200
Message-ID: <CACRpkda-0nM1BHRza91=4tG5cKA7qL4H8wC3Syn9g37OJ0dUHQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: uniphier: include <linux/bits.h> instead of <linux/bitops.h>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 6:12 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The reason of including <linux/bitops.h> here is just for BIT() and
> GENMASK macros.
>
> Since commit 8bd9cb51daac8 ("locking/atomics, asm-generic: Move some
> macros from <linux/bitops.h> to a new <linux/bits.h> file"),
> <linux/bits.h> is enough for such compile-time macros.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
