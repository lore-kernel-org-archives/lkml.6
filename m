Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF084C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA90218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NwDKccBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389591AbeLUKkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:40:43 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43310 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732887AbeLUKkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:40:43 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so3555654lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRYfLbBRwTZyuWd3nX/tqmFJpmA8TQYCaabirz+F2Ok=;
        b=NwDKccBrW67G2Z6YLBqi9YNJzCw2exYd4p9qRcKgPEU9tGiPkSRrE4iJUjeaTsSeta
         25D+anfhD7ZfLLAG3Wf+PuiASYfb2RzJ/iJk/pdDxbKCnNsCK7bVnCeOKOnkYnrA6lfy
         onKXGGHbBViLx68JxE3mDUkcvX0FfW7SS4QY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRYfLbBRwTZyuWd3nX/tqmFJpmA8TQYCaabirz+F2Ok=;
        b=dm5R9XfB+iJXtYmjWNOLugAckYfl/T9ITDJa4z3woSTvc65YlktSx2zU0miPWoO+FO
         z4degBCKBac0U1+iSXh62PfgxTUOLvHNUG8OA3j9G9UKDSswudcWIgi0JFlVmL9doJas
         uYaIQV2BGsHxOO8OJ16HNuiX7qgz4WDEbaoTO9oZkrcc0O/nhsiq/JTsF7Csk9q8Vsh2
         xVDKhW0OUoZbEe7zNsDyxO7KIdHgn4xW0KMXTIzwvZgQiLMHLp/suijzuIxbizxu5+Us
         4ZxNyKiTMICXeTIGD6QK08dUllElmp2LQ/5VXgbYx0Im8d6T6lJP3DGM3dNjS9rPJKhb
         S+Bg==
X-Gm-Message-State: AA+aEWYLCOCEJQVJ6w1NnMRZCLJ3UBAXWYEHdqVh6MzvTEVptSO68inR
        tQx/3GStnqOdutQZ3gay3qIqjho2HubijtNgk8y7Kw==
X-Google-Smtp-Source: AFSGD/UwqLDOwSguxOQW300KwiovB3IMyfhDOJa7Pi6usM8oPqF3O/PR50A9dW+jt/wM8jEzdbje9eiLJOxJO/9CfDg=
X-Received: by 2002:a19:f813:: with SMTP id a19mr1051197lff.67.1545388841502;
 Fri, 21 Dec 2018 02:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20181218161042.16366-1-jank@cadence.com> <20181218161042.16366-2-jank@cadence.com>
In-Reply-To: <20181218161042.16366-2-jank@cadence.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 11:40:29 +0100
Message-ID: <CACRpkdYbTraTy_5qWagp26peuBzCP_K1u61C1OU2FufsoL2nXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: Add bindings for Cadence GPIO
To:     Jan Kotas <jank@cadence.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 5:11 PM Jan Kotas <jank@cadence.com> wrote:

> This patch adds a DT binding documentation for
> Cadence GPIO controller.
>
> Signed-off-by: Jan Kotas <jank@cadence.com>

Patch applied stripping interrupt-parent as requested by Rob
and applied his ACK from v2 (assume it's the same patch +/-).

Yours,
Linus Walleij
