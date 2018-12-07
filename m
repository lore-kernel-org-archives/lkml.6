Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF7BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904EE20989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/XTNOIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904EE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLGMkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:40:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39014 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeLGMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:40:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so2918557lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wzt3ti5tXkWTxZxjywBygWxo7yIsI+D4X+mLAkTLH9w=;
        b=W/XTNOIQl+bsqceahhepp8wUSGiMw164P6me0NkHYN7yXciAgKTtFOOQsjZabRii4O
         urwPHj46z804GUL+/To7fLtU32x5LDTOmv79QJAueT053E22hNkVC1yuWETw+J7ZZxui
         TgaDFQFrxYeVDLDdKsKWvwJVYpEqx52VHVF1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wzt3ti5tXkWTxZxjywBygWxo7yIsI+D4X+mLAkTLH9w=;
        b=Wbx1r9b0WKs9VxJyL294124uEtJeBAmhvpjYarjzLDMfmut/44spxKsZZE09LcpIDP
         y9AaNW1syOA9vGV07C44BSoqDSOJM4m2QjQa1xyLwoBRdNRX6mTtrtkIVF+ZH08mAcFQ
         bzwafB7VwEOBph0lj6jOjm2X7n8vXjjO6S7B8G7e3ytyQ2RQ4DISEJhltL/TskjBaKQA
         t0p3UcpOWjs5jKbyvRbB8s8P/txNkIYLstux99jMZ8KD0hllVx567eP/hyvwsojVarhU
         z8vu1+jaZLIy30nmBTc9hX8mskLgvzzyIeXRuKCcQvYeJg5ewtGGh2SvsEg68b8hmtKb
         SWTg==
X-Gm-Message-State: AA+aEWaK0rXIw9Ub5Kl+h1W60ZkfbBV0EMk97BJ0qkWdZvg+VNtX25am
        Yfa/hQrSp0w2RKvtvtKp4e3ih5lM72txg5Go77v4SDMYVqs=
X-Google-Smtp-Source: AFSGD/WlWY2IyFk7hYAwfeM5/GRYheDnnV5W4vb8yprhxYigAMLXRGkjZ75GEb7eT/FN9sBpOzeet80WxnL6cbfRyts=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr1156549lfd.149.1544186400410;
 Fri, 07 Dec 2018 04:40:00 -0800 (PST)
MIME-Version: 1.0
References: <1544014419-5028-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544014419-5028-1-git-send-email-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 13:39:48 +0100
Message-ID: <CACRpkdZ=0meoCt6LojLj6LRx9n+W1NaJYCk7LVv-6Pxn1UpJoA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: convert to SPDX License Identifier
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 1:54 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> checkpatch.pl suggests to use SPDX license tag. I am happy to
> follow it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
