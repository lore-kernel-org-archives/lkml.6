Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF989C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D43E2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W51aRyaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfBHMJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:09:39 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34611 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfBHMJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:09:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so2376814lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UjGhLZdw+3llrgShn2gk0axK2isy86NYsLzjGb+QHl8=;
        b=W51aRyaWJXsY8daB+85Cm+wFaF/KGQENDg4kvPiDPQ1d1looHVRwUk0sY6ZXYAZhYd
         xkN+jCnQgSjusKMZw5OFZw7oWELRFnNThs8aNZfPN9Yq4Y9n9cRhB3SdCZaQRtAN9xm4
         81470opGmXD9nL+bMbT/t7+vn4FDj5I7/koPGlWrfMRLAO49mt5JngKhSCsIyiy6pbIJ
         JTICWOGaOLbbnl3xPJJwXTLGRhs9ZZ3ABFrsjIbI+FtJp9tb3AYriWNcoMqlKqDF/6vz
         kAtohcLhgzOo+/1qfJ3EzicuugcjEqWnN2heCAN3iCpwORh+BCNFHoL3eNGjauk0D8wU
         WQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UjGhLZdw+3llrgShn2gk0axK2isy86NYsLzjGb+QHl8=;
        b=IML4IIGrnvQW+of7xdwLSLKdSoJtBZP1pFbHY/jYPUbthh0rUG8ciZ0maES2MkWaZL
         ih+RgI4plBgT2KsayNB5J1ro2ztIMvWctp16KCHTsEkxd+b7TkhiiUzQToTGGweMoATb
         3+5wBWOu/GXcqb/q4QPEuNIY0PufSl5QIgAKrHQ1Kos7DAzPMKz7BSh5GP3Man5V+PNr
         dryHFFpzqZbwcmcSdXKMIT/NMxZpQEKiRI+aHM1lPIWKS+XfFiIUXf3olyyPw0PdJQaD
         xiYpNFSeHJuPzcbw9EETJWJwrCdxd2TR0YoTVc4RorTVkwaDLy759mKB0W12lzLhLC3a
         M4mQ==
X-Gm-Message-State: AHQUAuYi8rZf2CfPiy3dB68XlZf+BBTb9mgyGz9KJo8z7H+5rMpeYuj4
        r+kUqGAunbCXTkBpjWs5Xl7Di48yNouSnKbAkU5ibQ==
X-Google-Smtp-Source: AHgI3Ia9JZug/MGXjfukTAB7nqds8RGEEHQKLWmsG6bV4r/p543FZY+fs/oG3kf1UfDWWb8pwHEBlCifjGyCWK+/HjE=
X-Received: by 2002:a19:c502:: with SMTP id w2mr12991667lfe.168.1549627776894;
 Fri, 08 Feb 2019 04:09:36 -0800 (PST)
MIME-Version: 1.0
References: <20190131173853.27706-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190131173853.27706-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 13:09:25 +0100
Message-ID: <CACRpkdbjqdByJCNWPaBnePTZdYjyKqrsKz_VoCj1sA8YcVLTLQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: qcs404: Drop unused UFS_RESET macro
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 6:39 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> The UFS_RESET macro serves no purpose on QCS404, remove it.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Patch applied.

Yours,
Linus Walleij
