Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED289C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFE820659
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kWHjYB/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFE820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407599AbeKWI04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:26:56 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36274 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404988AbeKWI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:26:56 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so8479585oix.3;
        Thu, 22 Nov 2018 13:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EaDAETeXiO8irLAfRJkB2iKw1FoNmj5oMWtW34N04C4=;
        b=kWHjYB/OURfpUdcbdWuykvDwhVC4wIH/pgB1JCixpupASFIloZiitDc4PqvK8J86I0
         fbjGLAlfdDQ6xViVlXJziRN74N/+MeyFw9QVdnGkzZzrL0kA88IYOluZqiD+FboM4qUK
         LQoapwMfoEl763N2IyxhYv4460yDm0kQaExgg4O/ZYWWY5LaZj/CIeb9by40z/HAmCZg
         Xc/nD/qApTlLvlEQ1piuPDxXPla5n5Idun9ldGPJbbuOCHVUf5cEK+KnEJERY+MZ3DEc
         eGAplsrKc8Q+AR2bfA9EDkXNbtzEnleTI4aQJ6WNxoR+3umHx3t39NNWqOf1zIiJeZRO
         hGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaDAETeXiO8irLAfRJkB2iKw1FoNmj5oMWtW34N04C4=;
        b=bZn7tTJ1FfO1bEKsEqwjOMqoYKNc+RU3ei0CfZUrHxXUNmf/uGMMcQfNBeDLN1LFtX
         Vv/M7YXGRymOi78yJ5cGUp0OOKWcoGLuxMNcW05D1EtJAT/w4UErtYsaP4bzyix/d60z
         d9OoNwycgeL3zkMIQOIxQFn0T4Ll99q4U8rLzdWSRAZ5/3KdnZ+Ys8F4bkRp4akxmHNE
         oqAV1KiSfEhqYfsBKdFdkzcw6Se9ut0p81PCKHWCYBqjPI+UUIzXOJzp41bTDqO7MkUS
         pIM0xSIkUZJJXFGgddv2GiUFVzZ6UiHbtE0vuZdhvKiYd54OmgkrkgIvqgZJUqc1/dEm
         U2EA==
X-Gm-Message-State: AGRZ1gL1fG8lx7+y0NkSjO6XE+TjTll2KhaFZA4raGaFFl3ZQMntw8yC
        fWhOO+nnSpziAsqoOcUjrHRgFwkysJfHDis1NWM=
X-Google-Smtp-Source: AJdET5eeNus0llbKpRYJiu/D9bvwBg+rU68IisoB9tf2TrSkNn1/UPitTUtLokLFitu3hpxK3HDN2LTSMp2SSVC/h2g=
X-Received: by 2002:aca:f0f:: with SMTP id 15mr7471660oip.47.1542923140285;
 Thu, 22 Nov 2018 13:45:40 -0800 (PST)
MIME-Version: 1.0
References: <1542879319-2196-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1542879319-2196-1-git-send-email-hofrat@osadl.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 22 Nov 2018 22:45:29 +0100
Message-ID: <CAFBinCBEU336qqWnCvCVDuJ8ffOaXK5-jnUM0fuabdnmq8ZvWQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdio: check devm_kasprintf for failure
To:     hofrat@osadl.org
Cc:     ulf.hansson@linaro.org, khilman@baylibre.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        carlo@caione.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:41 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> devm_kasprintf() may return NULL on failure of internal allocation thus
> the assignments to  init.name  are not safe if not checked. On error
> meson_mx_mmc_register_clks() returns negative values so -ENOMEM in the
> (unlikely) failure case of devm_kasprintf() should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for the patch!
I tested the non-error case on my Odroid-C1 and it still works fine.


Regards
Martin
