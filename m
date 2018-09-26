Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECE1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4143A204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWs64cLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4143A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeIZNvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:51:52 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36357 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIZNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:51:52 -0400
Received: by mail-it1-f194.google.com with SMTP id c85-v6so1610222itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfnpbaR3SDXR/aQqeff4V3LJaqdrHDZ2daaRjH7OrfE=;
        b=OWs64cLZi/AqDPQOpeW0Yltr4EMfbUNjhwYJvPghcdoGuWg6C0QhcjHCFSWti59KqT
         B3FaQaBbVyr0K8dgPdv9lrcKQ3QcmkeTv+YSYGlkq6hgG/j4XHj0mUSvq7QjORevzNfY
         s3kKtkMWcwrKcoiUf6eYe07l5m2r+z+LCH4zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfnpbaR3SDXR/aQqeff4V3LJaqdrHDZ2daaRjH7OrfE=;
        b=LIDhptsF38bT0z2+GhLq1g7smtN73RzmHQB0s4ua1pL/XLDjkgEjKVv3VUPOYGzxjb
         Hhw/lotH35yuxZ0tFnz8Scckfdgg0gwz+oHHRsj29tQMBa9GgY6uECpTnQ+lSbjJG83M
         maauBsvHUIdtMmNs5tGzLxmKCZp1uS4fIzpNd9I4B0C4+Xb5uHB3aZn2OKooBMU3q69b
         5waenGb6/h23kp8zPREtNyNXdzDSqfZrG9fDcn0V18NlFtPUIFIBWLLLo/qeB/gdtr/a
         E4TC19dMu9TUcOYcGSc1LhS7TRYiWNkGSYx+COnPhSwa6RI3vDKqchKJtkhHXV230r4y
         QViw==
X-Gm-Message-State: ABuFfohTOkDJze3hRQR4fwDjhzuDpkT6WbkXkWK2eoBJdgzBtRZ5BIn6
        mgPEhklUO9K3Wd2EvydQduTg0jmAyGTb8TFznCOuYA==
X-Google-Smtp-Source: ACcGV62EGh8yIxCrXm4iif2xcBN+6WXRRHs1ELazf6iDQYSB/NxvAo/1+Ym8fV0NtMU0Cy8Bsenj0CgVOaH3luGKwdc=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr4486100jab.87.1537947617008;
 Wed, 26 Sep 2018 00:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180924144902.607-1-alexandre.belloni@bootlin.com> <20180924144902.607-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20180924144902.607-3-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 09:40:05 +0200
Message-ID: <CACRpkdZ97txAe+Nm_AKTQsBEfcq8ShVZOwv_fcHBk4w4t2bgSg@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtc: ab8500: remove useless check
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 4:49 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> rtc_time_to_tm always rturns a valid tm, there is no need to validate it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
