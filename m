Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EB7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8402086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rdj4uTyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfBTJ6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:58:43 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:45846 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfBTJ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:58:42 -0500
Received: by mail-lf1-f53.google.com with SMTP id h10so16876866lfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25wOCjJuLtCHKhw7aXSAdHD0XpH35Ob94NTaArnIrjI=;
        b=Rdj4uTyXoyV9Ez5+S4H7v9STzB2YDrEzRwrYds7JCCQUec68bvVRw/i4DD3m3aMVu4
         Bp26wgHc7v02vGktYDx4EEPauDJo17nE9ILVBZEc+6m93AoE8wQaA+tROuKnMpNiC3dI
         CkJig9qTsM+gruY+1L0fTnNdNOrEWJy7xLzMi9mTvHjVvIXDjfMN3Lenk0fIYCFhTDkV
         fq0ipuZoNhqmA9CR8gc5XmeMj8AW5THAoMA6xN2ERZvcv4EZ+9EHeB+iULbM+7pJ0qGg
         TcQZH/TytZm20icA7egl+fGWUWClSzRTJMWU12x9UM7ggcjcIkMs9mFT0tf+f7MMQm3z
         pKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25wOCjJuLtCHKhw7aXSAdHD0XpH35Ob94NTaArnIrjI=;
        b=P84VWwb0hpjILEQo2f+7MvC9vEtdBAwuF/cpk18Ov4Kab5PROO7POI1dNTXUn1j1GE
         Nre+i4Of1GPfrvti8gWz2lZVOpF9+B6j6sITYddilVUrq2UjGchpJ+AFYFC0I1PdBUCw
         0LO2nOy+pbdCvwygOFja4nM3WTv2nop6mpFhFbWg8cy5vNQIOn8y9gToVFNuOzOgqyvX
         9Mxr2Ro9Du2FC3Kmeq6l90c2wJUoEvgOV3t2rbXreBN5s/2OfOV6d/h8ZTYvFAUI1psB
         wygCIGA7IYh/acDF4SIRLNz2xGgp/IfwX6FgMOx2xgSjSQzWl8PhcmB7Pz0DLBmeaBgH
         o85w==
X-Gm-Message-State: AHQUAub/tb0aq9eZER6/aB7hGOboSy65RMikmRFzgJXbao01ZC3lsOq2
        FkuGqg/ELiCnfmdwirLsNJ5uLqSFAx0FbgBXEWueKQ==
X-Google-Smtp-Source: AHgI3IZUlcwYBF4m+Aj6SHSyY8f9t1MpBEzBqb0FGuMfH86C3J0MIhkbJZyxOnVd6XV1dYieuNKnvPkiXrp0meKiJNI=
X-Received: by 2002:a19:7b0e:: with SMTP id w14mr19597096lfc.8.1550656720529;
 Wed, 20 Feb 2019 01:58:40 -0800 (PST)
MIME-Version: 1.0
References: <1550091448-28578-1-git-send-email-info@metux.net>
 <1550181897-2596-1-git-send-email-info@metux.net> <CAHp75VfgzGQ7O-AjwQ1R=OZTiRwxRx_q9Yo1MOVjko7D-Wz14w@mail.gmail.com>
In-Reply-To: <CAHp75VfgzGQ7O-AjwQ1R=OZTiRwxRx_q9Yo1MOVjko7D-Wz14w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Feb 2019 10:58:29 +0100
Message-ID: <CACRpkdbSU1R0ZXyPfDrcnd0CYw+mjnPk4pVgbBnWZt-ibdfYaA@mail.gmail.com>
Subject: Re: APUv2/v3 board support V3
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 7:16 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 15, 2019 at 12:05 AM Enrico Weigelt, metux IT consult

> Linus, this one looks good enough, though some style minors can be addressed:
> - redundant parens (and actually I prefer to see x = readl(); x |=
> ...; writel(); in three lines)
> - useless blank lines
> - style of parameters where one per line (it's not needed in this drivers)
>
> In any case, FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

OK Enrico can you include Andy's Review tag when you respin, fix
the spinlock issue I pointed out and send out as v4 and I'll apply
it.

Yours,
Linus Walleij
