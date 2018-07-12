Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074DEC476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B835C2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bQSaexFq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EWfedUVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B835C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbeGLR3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:29:31 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46431 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732343AbeGLR3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:29:31 -0400
Received: by mail-ua0-f196.google.com with SMTP id r18-v6so18894514ual.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LsS+yh6UX5fQLn+Npe0FhoJuj8beO2ssH4Dh1rxFMzQ=;
        b=bQSaexFqqMRIY9AvddrDSfR7Xmg14PAh6dFEdJ0SVCi5AwgakjsSfjqtC3/qnduV7x
         bSlnYCtYAPIhwCECsHIcjMxmpgK2N+MFnGktGv8ng7E6Gzq0np66nJZvfunsK3cNESjo
         0zexG5drvBXLwOei81PMlSCSUvbRLBhZYLGQHzNk+A3qsQN7e13fktZbus4OJdLRFSNx
         dAmVhP53GDRbspha8rM8r8WA2tYoiub18zunlgi4yPOsbN+deSDUO+MoqQ9LRCeyT7Uh
         CoDO8S09BtRYVzOwrLPJGFyeAH9YoDayql2KwC5oJn1tM0BeeeIAIE+az6w6u8gWR1Ra
         0u6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LsS+yh6UX5fQLn+Npe0FhoJuj8beO2ssH4Dh1rxFMzQ=;
        b=EWfedUVkfqlaGj3h/JQjx4UC9krtOGUaTZ119MkFje+HwyF16ylKvUNPEwpIzU84Q0
         VXOw4BqWKoLRGG4zlwleuTiNM/cXZbx4htTRjQaI0b06uPDZ0vfNfI0YlBcf75R4bQ4G
         sgd/OciS645xUeR02RaksHcEwU2ciA+T7Txek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LsS+yh6UX5fQLn+Npe0FhoJuj8beO2ssH4Dh1rxFMzQ=;
        b=uXT32YUtXndEX5ZFJt44L071o1mJZrDYaPG+hbCXoWrC02rb8nf8DdnnQF1Zo29G31
         5BwZMDZwSKeQ+pSRtc7d84ZPukovWunwhbcIKo98SAj97wdtuWMAnGFoEJvXHfR9ZmBl
         3eGbLQg+Xw9DafvmCHfgNTsvmdNeYIXc3D6zt6FctTc+4UV+Qa2Ddc7VEs4nGPM37ylO
         deb2SaU4uKy4el1JdVyRGLYUMXldnvrr2FdaiZNKUTigxySGElwoPgQZ8cLFndRS8uMI
         dI6LHYSynAS5GmovrxrB2f9Pk0/7Z/DKi1ckVdUpxScyrtsyDij28NrQQp7tfX4Z3fKg
         nBLg==
X-Gm-Message-State: AOUpUlHjmtfHGqJpRzt+axtvqM+hSZmYYkB9OhmhZaokZ5Qr43tALSK6
        NCLY0tJJrzCYQvWq3BO3FqX9hKGcfq1H+BRNB7V5mE8na1Y=
X-Google-Smtp-Source: AAOMgpec9RUBbK9yuqJarD+H/F6RkDmeszqnbPAi8dcX765Eo9Ku1mqDNstTmTzFEnR32PccLjw/TYr25OLoyJVkQkI=
X-Received: by 2002:ab0:1163:: with SMTP id g35-v6mr1982282uac.135.1531415941134;
 Thu, 12 Jul 2018 10:19:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 10:19:00
 -0700 (PDT)
In-Reply-To: <3bd2c05db1bfe6fd3891abd87b0c767152346a1d.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org> <3bd2c05db1bfe6fd3891abd87b0c767152346a1d.1531384019.git.amit.kucheria@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Jul 2018 10:19:00 -0700
X-Google-Sender-Auth: kt2cn1n0ObZ-0J3a3D1tdMFls4g
Message-ID: <CAD=FV=WkF5VHEekxc0WTPbNvYikwgiZg684QQ7mLWmqSN12tgA@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 12, 2018 at 1:39 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> The TSENS block inside the 8996 is internally classified as version 2 of
> the IP. Several other SoC families use this block and can share this code.
>
> We rename get_temp() to reflect that it can be used across the v2 family.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom/Makefile                     |  2 +-
>  drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} | 25 ++++++++---------------
>  2 files changed, 9 insertions(+), 18 deletions(-)
>  rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (66%)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
