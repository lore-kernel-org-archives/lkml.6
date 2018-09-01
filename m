Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAB0C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 21:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C4220837
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 21:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHAInkLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C4220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeIBBhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 21:37:55 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37149 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeIBBhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 21:37:55 -0400
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so27647529oic.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VkLdXV5yAiboEuM7R0yTOXbnV/Crj6RJa1fIJHi1tsA=;
        b=iHAInkLUjkypxMIUaWar/n27LWhBUdLMYhTWUX3Ro4E03VPMxbLoHSNR2avYOhoPI3
         PqxafsAVReLgqEbEX7xfRzXx2crlGdngNPrmXplezsgzVy1bNa97WrrCHLx/loDj79Gu
         YBgrZX1cGiY5ExFbdpoWQftLiTS2LtFHtn0E7DE1Y2sh6pVpZi+aMdQXu3/cKyxgbZ4f
         0CCKQxuf3OIT/8+WlEIGXJNwUO51EYuDVInBf417MpoAFXSrSPZFgRVw6JWuldLmCmU4
         Lhj98Y5Z88reT3xWslIQHveCWN5P0p3peazd834rJc3xyXODykRwlzFE0SENqQYYaAYE
         ZhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VkLdXV5yAiboEuM7R0yTOXbnV/Crj6RJa1fIJHi1tsA=;
        b=YHqWTZtENwtUMtPxtzFjWt+25T20BOQ/T0vmL1ZdPcgYGV3jJYgdmjHJuUiWQAzgNf
         Ypbe1O6xRKqbCnK0W04VFgo7lE+WBUlaiktKKx5Hlit6+eTo7jDmCwWLTivET3l4OU5P
         QPobFaSJYbb6Aa4sxrkoE0I5L3zQql/cif3I5gH9GJAfRdnL+tQdMPeZdMe0/81ih9wG
         DvipEwMC/EpyQH4/SJRLqSvViFlzAm7Yem9tAwhDZSIJy2WwUNUWQig+hb3iSvUgPEEa
         R1Rym1FsDCQjdWL64QWhfdZr6q6yQGEmSO8K+JeBODs59s15SYXCRM5j87z2QIVDHlmD
         oSBA==
X-Gm-Message-State: APzg51C9a6/V4UPNNNy5fkqy6tXoDWJEFGFtkaYkvKM8m1djO9dNOorP
        h72DL0U74/qvRicKmBK2EpLWucfDrvzV5vWscyBsSA==
X-Google-Smtp-Source: ANB0VdYt0iZ9L+dg5Djq0IjqSyok4B9PdI8qSCdyfhI2mtgwA9E5kXr9ibGnvesbVNMd8E5GR1GnTh9Aa8NAwfkHu8A=
X-Received: by 2002:a54:4017:: with SMTP id x23-v6mr9942476oie.25.1535837079458;
 Sat, 01 Sep 2018 14:24:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:588b:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 14:24:38 -0700 (PDT)
In-Reply-To: <20180831150218.8307-3-jbrunet@baylibre.com>
References: <20180831150218.8307-1-jbrunet@baylibre.com> <20180831150218.8307-3-jbrunet@baylibre.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 1 Sep 2018 18:24:38 -0300
Message-ID: <CAOMZO5BOMOB6LaRs1fnmm-Ghu7pMkXW=sH_NOEWK3pqHAbUMCg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: meson-axg: s400: add dmic codec
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Fri, Aug 31, 2018 at 12:02 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> There are 7 digital mics on the MIC daughter board attached
> to the s400 board, so add the digital microphone codec to
> its DTS
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> index ff64c429d432..f3e16cbbc61e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> @@ -86,6 +86,15 @@
>                 sound-name-prefix = "DIT";
>         };
>
> +       dmics: audio-codec@3 {

You pass @3 without a corresponding reg = <3>, which causes dtc
warnings with W=1.
