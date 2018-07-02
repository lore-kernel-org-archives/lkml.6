Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA012C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9046621A8C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ddc63JYh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KACbGWd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9046621A8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeGBUMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:12:06 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:37677 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeGBUME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:12:04 -0400
Received: by mail-vk0-f67.google.com with SMTP id h22-v6so9843816vke.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bZWFZGJ8XiC/o9UlE9QWM/JHwknBqDwxJnZfW00jNmk=;
        b=ddc63JYhiOrKiVxfF4TlYO/TDS3SuQ0JWQG1qLjM5zP7cFBdqT98fCKXwuS80pxiyl
         Ot7woTqUYSmMj5U/Q3D5HQqzNKa/sYTVrmrqCeoYC77TL2YIGL8zmir4g5LpomaRm8aP
         8P7Meu/a3B+8EHeXqDa8bjnr4RAevIERx+G5JK/7NYvy3Iqgm+hbDpq5/yD57+ytAeVo
         M/v6JTv1ZpnOlAjjaBJ1pcsOE6Ct3T1Df/UBkFCa6GarXKbjH8rnWia2ivOeW0Z7n44+
         2XwGQ9oV85Hm0ITYJOqWX16YvC1Cdogy+fuEOeS+RoSuIdpgK9GTsWqi26KDjdVvn4sp
         FfLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bZWFZGJ8XiC/o9UlE9QWM/JHwknBqDwxJnZfW00jNmk=;
        b=KACbGWd031GukTLu26Xzs3eik0wfnulqRrmJ4eC01eH4voP1S7S+X/Wga3YAQXvaRE
         ve7zBnB/Cn7VsSrZR73o86IX62S/KDyjGXMlXEvzgJx3qy3UkfULH6lz4et40M5uckgR
         HYVYYn0cnt8BkV3Xa7jRT9ADufr9H9h63CCro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bZWFZGJ8XiC/o9UlE9QWM/JHwknBqDwxJnZfW00jNmk=;
        b=aRWKubMfAvKjrhH/iA3He6E2cufZZta63vXfQkFFP064rwaLdGSuZF0KLE3IfBaZrh
         rCi8urkZ717TfINLrODwDyosyRG09hy4NAgiN9iepKNH7WQQFLjAl2E7jCOLYY2vILdE
         TVKKndKmHY7y7tZB3RzqtQbFTAMu+eeknqERGfbED2N4cfee+yf+Fz+jUQJ+LGyk0eG9
         kXwMxj4MsKscdS4X8n/0pGAwuQOArhcwfWqQIks1NMcTPkuiYIAqC2bkg+k3y0o1GLL8
         KPbl9B05TaXIu2KQCSw6rLstLSrXH+ZumkjHoF0krbBGNQXPwT3+LlaozDz7n3ewL3ms
         eJRQ==
X-Gm-Message-State: APt69E1yaVQrE78rliHR5vT8iVhnYqltMAvUtyAmz1nmMt3KNqGR6fRv
        O5tiAh4qAKb7r9SoKybtdI8OA3QRumQEuo3Pk4IESw==
X-Google-Smtp-Source: AAOMgpfYj3BTO7vQRg4H1tpcVd5Fii6xeb7qbyCFPu3macpPb/MHd9OM1oXzWianambd3P/yJtdVU4TnxxDuTZRzlfs=
X-Received: by 2002:a1f:c007:: with SMTP id q7-v6mr16644728vkf.144.1530562322565;
 Mon, 02 Jul 2018 13:12:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 13:12:01 -0700 (PDT)
In-Reply-To: <20180702181005.18247-1-mka@chromium.org>
References: <20180702181005.18247-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Jul 2018 13:12:01 -0700
X-Google-Sender-Auth: opkIkq5TTLvJ6mkuk4NIP0P8KDQ
Message-ID: <CAD=FV=VSnKWqeRj-Kr9tkzeuqxm86Ex6E0uT6Qka=EqjurizNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 2, 2018 at 11:10 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> This adds the spmi-temp-alarm node to pm8998 based on the examples in the
> bindings.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - none
>
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 92bed1e7d4bb..2f4989e7ef68 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -11,6 +11,13 @@
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> +               pm8998_temp: qcom,temp-alarm@2400 {

Remove "qcom," from the node name (AKA please change to
"temp-alarm@2400").  Someone internal in Qualcomm seems to have
started this trend so you see it on all downstream kernels, but
upstream device tree isn't supposed to have it.


> +                       compatible = "qcom,spmi-temp-alarm";
> +                       reg = <0x2400 0x100>;

Why are there two numbers for the "reg"?  Should just be 0x2400.


-Doug
