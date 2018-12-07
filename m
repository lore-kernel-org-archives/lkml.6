Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E46DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DF8208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AM8u0iWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DF8208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLGMZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:25:43 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34289 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLGMZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:25:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so2912126lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zS/CDdYP6ZehXVYpJeGlqaVcwGytLPNsiN+0j2/bwDc=;
        b=AM8u0iWSMxMWpQR/ZW6c8EMJAoRj0AP4RlQjB3tK8w2JZfU7hXDobOSSWTrbADwvjG
         2gDftt7HoLmU/V91RgY3P1BR53yx/W5LeJZBQprH14O71PCS4W3lqx+VoddPQYd6J2LP
         ycO0607DuJHghqXFQyO2cKoNGS8YclPMIseGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zS/CDdYP6ZehXVYpJeGlqaVcwGytLPNsiN+0j2/bwDc=;
        b=IDfnRYoZa5OFlrzf7+sJEbJdSJjxaBaQkSsgKmkvldR2PnJyPvqy9v4FJYG8ZgLhTH
         jybaWBai4xI33iabBFWW29G3ddxSMnT9xEaJe3lmmcZu0Oy4KNOcBSUYYfeCVgXzguz4
         T9TR5jn6qHmkFqNKwlj7j3grtHPISyGPNYuKXwzcXyhx0FEG//wVU2uhxH3vSXAk6duh
         jtTb2PQkmLdid0znTj/JDHsTukvLPAlgMtOR7VGHosfJLqB9Ht7AYT+AyfB2oGBXPSQB
         8Cdo7pdjkYMEZovq39pUeXtK0FSBxFMu1yFAUxZSAkvDS+SZdVnHdFENRdZnnnIhuCN/
         +CcQ==
X-Gm-Message-State: AA+aEWZxJc5aywl63f1TlGobLYnVl2WzcovhzbxkK8kjomLLccDvF8jH
        B+Ur87GYDy6+98lB20DDMaGS7Kft5dl/F4wO6h1EcA==
X-Google-Smtp-Source: AFSGD/XdUW9GrLB9pNrFpmAg5v1NXeAEoDg9+yxWWLM0StOHVpSMUCbGbhzTmak/ORy9JJ+nCbfqRshf9GjpBIr34bc=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr1129038lfd.149.1544185540505;
 Fri, 07 Dec 2018 04:25:40 -0800 (PST)
MIME-Version: 1.0
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com> <1543811009-15112-9-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1543811009-15112-9-git-send-email-paul.gortmaker@windriver.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 13:25:28 +0100
Message-ID: <CACRpkdbNaO_DgqN0bXcit4qFeWuf+y4Ba-EdjdaRPN3pUP0ceQ@mail.gmail.com>
Subject: Re: [PATCH 08/22] mfd: db8500-prcmu: drop unused MODULE_ tags from
 non-modular code
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:25 AM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> The Kconfig currently controlling compilation of this code is:
>
> drivers/mfd/Kconfig:config MFD_DB8500_PRCMU
> drivers/mfd/Kconfig:    bool "ST-Ericsson DB8500 Power Reset Control Management Unit"
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the couple traces of modular infrastructure use, so that
> when reading the driver there is no doubt it is builtin-only.
>
> We delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
>
> We replace module.h with init.h and export.h ; the latter since the
> file does export some symbols.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
