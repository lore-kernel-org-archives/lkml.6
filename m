Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44069C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDB820857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hg1P/5s4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfBHOCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:02:03 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37431 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfBHOCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:02:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id n23so2618573lfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8qOmj5x+Fz0Y5BPlWJzsaiY1RfVtCgfoVlvwLoWIyg=;
        b=Hg1P/5s4uQJb7wdp0Jm1x7og0G4yHtw7PRaWk8CjaBjroQ041PpEPfdYyMP4b/reG8
         s04CbBbsC2T2mzKyAWocVx6ZTF1a0yX78bkkbWr90zdQ9P9HQ+x9eELJ+8yLb2y/RIlc
         YSNgWPOmS88/WLb/yl4oNto8pL8qlzpAEpyk6HXYNGRMBbMPb4m3m39eGZS4slwrJvdy
         +ePY+CjWjLukG1eo8sMUeOhkilxLnWCRT7bPbziIlLsMiQiVkEy9S5l8wa/4DRmvgU19
         a6+nWA/xGHGVk+vhRLa2tvdCEmtpTb+71FrdaJvUUhDtoysQpk0lhVcZrYT51EapPgfV
         4gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8qOmj5x+Fz0Y5BPlWJzsaiY1RfVtCgfoVlvwLoWIyg=;
        b=p6Ojb2ishnHUNa3OQQZMldZ4dnrymRoRWLxVi7v4H1JP1FhUMLZ3+Vc39lU7NaEMSt
         1MHAbsEr0gxiNybCecm9A+eV9exkFcm8V+SoZwE1TJnn7HFho9WndslxsxuExUzJOroX
         Y8pbWLXCgvhY6Cxlj36XbwqUqSjDhkmKnAz2iaMacasS/iGKJaNKuLQ4Jl1MDMatZseq
         naFaiggQJXRf1Kd4dwiouO5NdWqTmjDKqlveovusr0kq7RqcAcnHxItbenpW2c+GXmLM
         BthlI2EjxU2nSC7Qp5AxgonRKTVXQGIewTxVivjucZhGBpiB5wAlOv/U4TLqS6/qDW3T
         hFgg==
X-Gm-Message-State: AHQUAuZAqwOVMXUP46Nc6gEgDASvZD3Q033M+BgjDNpKXg34hXMr7a/u
        5gozWoCwD+MekguTokm/0qjh+JX1lJQUHlYWgxPhLg==
X-Google-Smtp-Source: AHgI3IY2rXiYEtcc3sdUcCwXTJCI4mhPqq0pVp36xh18DDaXbIDB7bS5etMUhVYdrNEj+Wt/LrsG+AG03B1s5LRk3K0=
X-Received: by 2002:a19:c502:: with SMTP id w2mr13275794lfe.168.1549634521078;
 Fri, 08 Feb 2019 06:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20190207135536.6757-1-paul@crapouillou.net>
In-Reply-To: <20190207135536.6757-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 15:01:49 +0100
Message-ID: <CACRpkdaoyq_8Cu+=kyYaBuGtMTD9U+qWNkRtW2VVLSUuOULRVw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ingenic: Add LCD pins for the JZ4725B SoC
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 2:55 PM Paul Cercueil <paul@crapouillou.net> wrote:

> Add the pins and groups for the "lcd" pin function in the JZ4725B SoC.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Patch applied.

Yours,
Linus Walleij
