Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB387C2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A2720861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkjQ2OSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfAUNF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:05:27 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36460 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfAUNF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:05:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so15440825lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCJqUbqBC71TfujrMNS2sCTF0zuolPp3Xv4qML7FfwA=;
        b=MkjQ2OSMR9JIMCArqEHgeme43DIVmqkhaVH902qP14kh6E7axXnZMan1cR56iOxVzA
         DvD3op1xEbcktnpepfYHwBI24/qdh0sPtMznp5DYnSjg7XbtFvdzK7Ho1blDqSI8/+lH
         KFcWa4FjXq0jvUTB/O+/b1VxNwu398b2fJcGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCJqUbqBC71TfujrMNS2sCTF0zuolPp3Xv4qML7FfwA=;
        b=Eh55jNB1MXDgNorxJdUEz9211GAewjc6Slb6YOOk0DXdpx3HODjMNGYnAAP+gDrXvX
         MX06LOBjqoPh+6FndpId5pLn6aMtwYlobWSNjR/MrAhPKu45X0oMU246feeiPx2pvlaa
         KCL1GhxaH5hbVRnvQZB6Zle489Vgn9xu0GhQOtLfkM5V/HFg735Pvia9f5e/syX8Rx74
         s7yp7953hS/gVvX6E1J0nTa8NdwPQrVvxfNNmBhtR6Lkse+DCTPJ5teQN70L7ZtJSaLt
         EXqLE2iCMDzzD52qboZwwabW8Iaac/hS7ZioJcDJPNfxjIVWd51P1q7xjCoqcQVx4Ydu
         u5iw==
X-Gm-Message-State: AJcUukfDw09BrOfyJaGUT4INboIL2m+YyxhPkV5MlvnRh2eMzztmusq2
        zFvZu6XjCZB0lT44lGMIEBCXRf1H9LFYRMeBQijxfw==
X-Google-Smtp-Source: ALg8bN5oi+iSywW7leEYc0mh9wxNstJdW0ZaDWY5M83pJ01ZDAkSPA+H6dHAJNx9pfQMLg77JI1iCllNst921Ddm3NA=
X-Received: by 2002:a19:5154:: with SMTP id f81mr19074864lfb.96.1548075924853;
 Mon, 21 Jan 2019 05:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20190116093158.2850-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20190116093158.2850-1-thomas.petazzoni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 14:05:13 +0100
Message-ID: <CACRpkdaN=kjgP7wgcOTfxuu_BM_ggADhKtesf4qEhx3aNhS4_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: pca953x: reduce indentation level in pca953x_irq_setup()
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:32 AM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> The current design of pca953x_irq_setup() is:
>
>  if (all conditions to support IRQ are met) {
>    lots of code to support IRQs, which goes to a serious indentation
>    level.
>  }
>
>  return 0;
>
> It makes more sense to handle this like this:
>
>  if (!all conditions to support IRQ are met)
>    return 0;
>
>  handle IRQ support
>
> This commit does just this change, reducing by one tab the indentation
> level of the IRQ setup code. Thanks to this reduced indentation level,
> we are less restricted by the 80-column limit, and we can have more
> function arguments on the same line.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Patch applied.

Yours,
Linus Walleij
