Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E515AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33D02081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+fVd93c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfBDKDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:03:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36811 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfBDKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:03:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so11059786ljk.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 02:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzrWxQmO4UQ5Aqm7IR3I9DrPxmlHOZ3c/1JaT+pgdfc=;
        b=j+fVd93c8AEVBkxCU6cLFzmanFCL2DuRcbDpTwGpzeaE8UlvC25a9UqrY2H6iKrRFn
         HplyDKNkogA4POpAUya6SgpDn+VS6awCK6a+rw6zZZBEpej+v5Krt96ZSYCPC5ZfzLF0
         mP1En3B5B8ziIoECJYjaXe/xKLHZPa4m6q0E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzrWxQmO4UQ5Aqm7IR3I9DrPxmlHOZ3c/1JaT+pgdfc=;
        b=U/+l108ceQyBIG2nZC2rqgapGv6KLtz4+cE8aBBL2MOn4PYMgsGKJpEKNDI+B2Zrlm
         KHok+A4OdV3IEILfCDt94Dc47SOBZIJc8ASLJO0B1jNJ8mg8pb6rL5UWVqqMSyR67Nho
         fvOtxBA4MhQWCJ0mjJa2QBw7Yzuje0VdH4QcjkwnP2EsHOkno2sEOTtFZwv3+g7f9iGP
         LPj+V9eMkrjMF4oPp17upnNZ/K60Q61WfbIwGkd8g8kEOgZ25/DN+PfL8JC52YuLl/Cd
         SZtN5xOCHtKNn9JMc7zBYs8BcCKqFekdpcMY22JlydeBFwEpV9Jbc5pQ4ZcXoMnbthTN
         rbew==
X-Gm-Message-State: AJcUukedEjzMKqSw2oumEYL78ScQrSF2HdC2+u+920nzpvJChSIHwrs4
        YcvS+bUZUp+9OggMoXDmH65KUPbkQ5z4aBE7xD7rqw==
X-Google-Smtp-Source: ALg8bN737d8LObdfcmd4pqjHv+mj76WX5F8pLRDxH+XKpkZu1KCShwdHTAF5Nvm7IqMv+vXSeExDH/kPUmHi4PFqNQk=
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr39018995ljh.135.1549274627159;
 Mon, 04 Feb 2019 02:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20190204095853.12212-1-masneyb@onstation.org>
In-Reply-To: <20190204095853.12212-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Feb 2019 11:03:35 +0100
Message-ID: <CACRpkdaLx7BtkaYAD+d+hRNhnpu2ByeC1KqGA9yYjJjGdyMcDQ@mail.gmail.com>
Subject: Re: [PATCH v2 -next 1/2] genirq: export irq_chip_set_wake_parent symbol
To:     Brian Masney <masneyb@onstation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Kernel Build Reports Mailman List 
        <kernel-build-reports@lists.linaro.org>,
        linaro-kernel <linaro-kernel@lists.linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 10:58 AM Brian Masney <masneyb@onstation.org> wrote:

> Export the irq_chip_set_wake_parent symbol so that drivers with
> hierarchical IRQ chips can be built as a module.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reported-by: Mark Brown <broonie@kernel.org>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> This fixes a build failure in linux-next's spmi-gpio when using
> allmodconfig. See https://www.spinics.net/lists/linux-next/msg46362.html
> for Mark's message.
>
> Changes since v1:
> - Moved message about build failure out of the commit message and into
>   the notes field.

Patch applied to the GPIO tree. Thanks for the quick fixes!

Yours,
Linus Walleij
