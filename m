Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BECC282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294A12083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYOm5N7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfBEMlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:41:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39416 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfBEMlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:41:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so2752710ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 04:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PujTR3VNMLT5EVX/UqxbH2pEhEzBe1DF8UOx19PW8us=;
        b=XYOm5N7K+2gM6vgrKEvLrT+uS7LoA2euPbUNA9k2cE256s3MZjXdg1Ld1UjO+/+G+G
         lPIfJUQIUuOtcQ3XwImF3DgqtPhkiP14v8jZMSybH0JbI6no9y36Vgt/44hHdoxLwPh4
         B1dzeDKmR5QbFRXkdolp9O1bEJhyOPK9isk2VETBOoDRHThgyOYKL2bIhrGOArQGwQ8m
         gnUr300JQ6d6mre4/wPJAnGM810QiqKXoKWWMVb7fj7ypVH7hGR95RD7SNiubV3Cl2tH
         ty1alUY+g3MX3sQ7tth4ZA9boSzIXozzsxCy25Kliww8Tth1Ew8/2FIVPqgbC/9iECGI
         n3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PujTR3VNMLT5EVX/UqxbH2pEhEzBe1DF8UOx19PW8us=;
        b=czvK0Ic1NH9EOybus39afX5ePOMefh9xiTcapYSQ0G+/R2u0px1PZqKYu9/E+vpSum
         guIIeFRLgxjhpiAGAQ2c38z+ath1GgvU/C2gngw0HWTIoK2MWBLtYcQXHhGA2o2pOa7z
         0hCaI+IV5YEZONHL/EJ/Uj+jCDluTbdmpOialSmMPVOIQS7RJjFYNdJ2+U8H9qOsqLeC
         59D8A5SWG+usmxqVTDiz8TIlT5ccEJDzuI8pnG2qn0UIYTott9pBzzh2xyu/iYdBXw6S
         zZoANqx2BYl0koRdA8ParFfxQEcLo/etMtYS7Mrfg9DvEjJia1XpN3JK4NjxUSeGpAJx
         VJlg==
X-Gm-Message-State: AHQUAuYwdekKAyqtlsuAf64VNE8s3UM6Pzy/U+8wK6YxlJFXIZZn5Gup
        5OatIger+uCIUNCO7LyR9Jab9sSML01F3+N+NyOmXA==
X-Google-Smtp-Source: AHgI3IZ5PbuTNMeGMxbQSI9dcS7UkvwYFjc7/+WprXGB6n0865mBoKl2ukg6NtRertzthtF9PQNG5xYzIXGf9G+w7aw=
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr2744142ljt.107.1549370510090;
 Tue, 05 Feb 2019 04:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20190205094937.18645-1-brgl@bgdev.pl>
In-Reply-To: <20190205094937.18645-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Feb 2019 13:41:37 +0100
Message-ID: <CACRpkdb+fBGEv9xvvkC=YFMA5BeNNYCXKHFkRy=a_PS5QCCG6w@mail.gmail.com>
Subject: Re: [PATCH] ARM: davinci: da850-evm: use GPIO hogs instead of the
 legacy API
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 10:49 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> In order to drop the hard-coded GPIO base values from the davinci GPIO
> driver's platform data, we first need to get rid of all calls to the
> legacy GPIO functions. Convert the mdio configuration to hogging the
> relevant GPIO line in the da850-evm board file.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
