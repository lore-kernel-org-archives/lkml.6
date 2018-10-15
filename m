Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50397C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DC22064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Seax8rZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DC22064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJOWEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:04:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33189 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeJOWEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:04:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id q40-v6so21612336qte.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXoE6HyH3otyGl62Cp1qwrpVWOMepFjzTme9Igi15u8=;
        b=Seax8rZJIehDZ1vXcahkfyj+vHMwckF2gbZKlUHthntJLv+94hS7NFEhJdN9L46vzj
         GFVjob+mLCM4lIa3bNhGeaz64Zl5oXl3967fIvdjL/spxZ3jh87hsfDjF8I8+AybQ4nh
         YltkoP0q9ApibzevbD+aZd3BNh/Uan4FErHgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXoE6HyH3otyGl62Cp1qwrpVWOMepFjzTme9Igi15u8=;
        b=LutJcbSaZVZwU6hl0QAfeAEk2CHM2WfsO0p8DuW/pkbbOuUOyeXmJD9LOOkwYLHlAV
         ViDgpVcVoVmukP4BhU9zRGwF2efFOrmD8/L5+7mYw9igOc5TT3k9CU5iAJfhv7daTUsj
         fKb1htJz+BxrjP/cCmW/3hFCCD2VbsiGvZqvvOXiTmqzLANPlVZfEw7fFfbUXUTa23t/
         i+HWUWdK/5PPZKw+YyccvL+i6wIaVfNII3tX8/lMkZu2JYJi78juFd0fGnToZr8JVo42
         hZ/pflS6S1bbpIaa2MGIU2bQQIZivVkJ2Z97JdO2smYNjFyNQraV2ASU+Huo2o4vn2EP
         pxlg==
X-Gm-Message-State: ABuFfojta0+CI53pQK5BQE/qFEMlYeQJGLwOKK83AT0YPnL0KRlS54Hs
        nTjzQ3cZr6bnfgseKe6QEw2ZXvY8Auc7EVfViy87Rw==
X-Google-Smtp-Source: ACcGV63+peyreU3aaTW/KQDJC0qqzD7joa5L3pIUEGBQhSyWHU3PdCU/by1FiY6FoLIWiZ4Hwf3MR7mlhY3Em0d7ZbI=
X-Received: by 2002:ac8:435b:: with SMTP id a27-v6mr16120456qtn.295.1539613123629;
 Mon, 15 Oct 2018 07:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org> <20181008191411.32555-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181008191411.32555-5-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 15 Oct 2018 16:18:00 +0200
Message-ID: <CACRpkdZAem09Qb_bUBk+QA5ngdjGTxqLxTtMMsSnO7rTME1Njw@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: mediatek: pinctrl-mtk-common-v2: Make eint_m u16
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 9:14 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> For SoC's which lacks EINT support, U16_MAX is assigned to both eint_m
> and eint_n through macro NO_EINT_SUPPORT. This will generate integer
> overflow warning because eint_m is declared as u8 type. Hence modify
> the eint_m type to u16.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied with Matthias' review tag, thanks!

Yours,
Linus Walleij
