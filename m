Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF01C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECBD2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dYoLjN9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbfBMLlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:41:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55965 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732035AbfBMLlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:41:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id r17so2070068wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 03:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37gNnip2pUO7WpshWw5fCnmuyn0lJdQR0BJGyefQAvc=;
        b=dYoLjN9TrUKPATAOQ2Er/MGKi76DiyZzIxu6I1xrWyopW/fXA6dW6F36PyuTCDGWDC
         q7V0kkGzY13yLOSEHpleaAeH0LVR96z10queTPnCzTnMcGeceiiX0ujvp8WgHewdBAfq
         H5wKGQk8IwmswEueq7gEwfrFW9iIzB0P/cN3QS02sZJ/nMILrGE6qrpXrKdaM4GNl+xA
         Vbu3lO2O3YIJnS/E/JZ/+YbDC27KmrF4SmCcg3eCh300Z4yEwzYt5NEytM9hfZ1jG9vS
         6dc3MQvPuy/QFZ6CfvotvARpETcVBH/3eOra/UF8Q3gnptSeK7WC19rCz5rbGNH7iv3I
         KYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37gNnip2pUO7WpshWw5fCnmuyn0lJdQR0BJGyefQAvc=;
        b=ou9BSQnj9HI3bPl5isBp94zZSbTqFeyn+3qU62di8S3pv/Ao6NhTLy1TrHJh7VJTOS
         tA+FuirgEui4X8DLgYHMHDpLPKxngJOPXMp2dQK9s2PFvFUyBE5cUCs9CLwA3DcFluKr
         +a9hrsO6jk2BtS6/NNrQsyaynVFoftNaufzbS/CqJztSZjGxiIzO0eVVu5drJrCAR+It
         rREZxlSPjkbuUlnU4Z9P1DsQ6EPKYppQ4XJH8dUiTa6fEtKzr9CU6hel0yFaWOeTqjVa
         MUQQDc5lDcOvK+cMqAr5dM7FWkYRr++ec0j+Fm1OHB6s0/SnUTHr9yHLN5ud1UMiD/wg
         E3vQ==
X-Gm-Message-State: AHQUAuYdYmuO7glB1zWPh8CRefvV4dKLO67MwPAvMr867L9n6g9vNHKS
        fqgfxxSVgkn7ln8NyHMcKmDeJdn8y/cYCSm6XrVqjA==
X-Google-Smtp-Source: AHgI3Ia3tlOX9B0Wc9itABeYo3VSlGbnUbRzEf1NckYvIhP1mEo5Xcjffa+PtDTuCksXTOIn8kFhY4+DSSlplDk5w2A=
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr11419wme.137.1550058060914;
 Wed, 13 Feb 2019 03:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20190213095835.17448-1-jbrunet@baylibre.com>
In-Reply-To: <20190213095835.17448-1-jbrunet@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Wed, 13 Feb 2019 12:40:50 +0100
Message-ID: <CAMO6nay=xXnxks==Zj_uPAE6o9_V=DsLkJOkkLRR1duPxg324Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: axg-audio: unexpose controller inputs
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:59 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Remove the bindings ID of the clock input of the controller. These
> clocks are purely internal to the controller, exposing them was a
> mistake. Actually, these should not even be in the provider and have
> IDs to begin with.
>
> Unexpose these IDs before:
>  * someone starts using them (even if there no valid reason to do so)
>  * the actual clocks are removed. The fact that they exist is just the
>    result of an ugly hack. This will be resolved in CCF when we can
>    reference DT directly in parent table.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/axg-audio.h              | 20 ++++++++++++++++++++
>  include/dt-bindings/clock/axg-audio-clkc.h | 20 --------------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/clk/meson/axg-audio.h b/drivers/clk/meson/axg-audio.h
> index 7191b39c9d65..644f0b0fddf2 100644
> --- a/drivers/clk/meson/axg-audio.h
> +++ b/drivers/clk/meson/axg-audio.h
> @@ -60,6 +60,26 @@
>  #define AUD_CLKID_MST5                 6
>  #define AUD_CLKID_MST6                 7
>  #define AUD_CLKID_MST7                 8
> +#define AUD_CLKID_SLV_SCLK0            9
> +#define AUD_CLKID_SLV_SCLK1            10
> +#define AUD_CLKID_SLV_SCLK2            11
> +#define AUD_CLKID_SLV_SCLK3            12
> +#define AUD_CLKID_SLV_SCLK4            13
> +#define AUD_CLKID_SLV_SCLK5            14
> +#define AUD_CLKID_SLV_SCLK6            15
> +#define AUD_CLKID_SLV_SCLK7            16
> +#define AUD_CLKID_SLV_SCLK8            17
> +#define AUD_CLKID_SLV_SCLK9            18
> +#define AUD_CLKID_SLV_LRCLK0           19
> +#define AUD_CLKID_SLV_LRCLK1           20
> +#define AUD_CLKID_SLV_LRCLK2           21
> +#define AUD_CLKID_SLV_LRCLK3           22
> +#define AUD_CLKID_SLV_LRCLK4           23
> +#define AUD_CLKID_SLV_LRCLK5           24
> +#define AUD_CLKID_SLV_LRCLK6           25
> +#define AUD_CLKID_SLV_LRCLK7           26
> +#define AUD_CLKID_SLV_LRCLK8           27
> +#define AUD_CLKID_SLV_LRCLK9           28
>  #define AUD_CLKID_MST_A_MCLK_SEL       59
>  #define AUD_CLKID_MST_B_MCLK_SEL       60
>  #define AUD_CLKID_MST_C_MCLK_SEL       61
> diff --git a/include/dt-bindings/clock/axg-audio-clkc.h b/include/dt-bindings/clock/axg-audio-clkc.h
> index fd9c362099d9..eafb0de8466b 100644
> --- a/include/dt-bindings/clock/axg-audio-clkc.h
> +++ b/include/dt-bindings/clock/axg-audio-clkc.h
> @@ -7,26 +7,6 @@
>  #ifndef __AXG_AUDIO_CLKC_BINDINGS_H
>  #define __AXG_AUDIO_CLKC_BINDINGS_H
>
> -#define AUD_CLKID_SLV_SCLK0            9
> -#define AUD_CLKID_SLV_SCLK1            10
> -#define AUD_CLKID_SLV_SCLK2            11
> -#define AUD_CLKID_SLV_SCLK3            12
> -#define AUD_CLKID_SLV_SCLK4            13
> -#define AUD_CLKID_SLV_SCLK5            14
> -#define AUD_CLKID_SLV_SCLK6            15
> -#define AUD_CLKID_SLV_SCLK7            16
> -#define AUD_CLKID_SLV_SCLK8            17
> -#define AUD_CLKID_SLV_SCLK9            18
> -#define AUD_CLKID_SLV_LRCLK0           19
> -#define AUD_CLKID_SLV_LRCLK1           20
> -#define AUD_CLKID_SLV_LRCLK2           21
> -#define AUD_CLKID_SLV_LRCLK3           22
> -#define AUD_CLKID_SLV_LRCLK4           23
> -#define AUD_CLKID_SLV_LRCLK5           24
> -#define AUD_CLKID_SLV_LRCLK6           25
> -#define AUD_CLKID_SLV_LRCLK7           26
> -#define AUD_CLKID_SLV_LRCLK8           27
> -#define AUD_CLKID_SLV_LRCLK9           28
>  #define AUD_CLKID_DDR_ARB              29
>  #define AUD_CLKID_PDM                  30
>  #define AUD_CLKID_TDMIN_A              31
> --
> 2.20.1
>

Acked-by: Maxime Jourdan <mjourdan@baylibre.com>
