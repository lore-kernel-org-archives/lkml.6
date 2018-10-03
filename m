Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD29C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E21D2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E21D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeJCQlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:41:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42205 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeJCQlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:41:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id n2-v6so4728170edo.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 02:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cC8K2jOIoeXn1aH19tNO0E41M/B+EOXgwzwuQbyzFIY=;
        b=AIsTBr2cg4W2ijTwPlCi2mzkbiv53zOekGiz706cilSdLF2vNwI2NpDrQFAgAK19F9
         9ze1kVjL3cavv0yZB14Dg4bNphQRbfnk8hXvoWdK/D9+NF0aRah9QQ5OXeIK0JZy/5ca
         y8iMb3YUOaMnuEMotBcSlr2ZmvBJVhXBKdZrauEVi5/RKYZKD5DqVF6J+nmIMJ56Bd84
         4HRfoye/zvP+WneFFnwjuaEaDV4yxF+3+m4aw0kQx/MYUMxLbuLsJN3a5RjlMpJ9gDga
         CuTXotYqMKe409kVyzaW0HbGDW0aQzUnHQu59ubiqclZNXPnBSq46pLS89PA5T6CVCTv
         r9mw==
X-Gm-Message-State: ABuFfojs8t+zNawJa8Xe0iI4WoDFOSgh8Iv2BwUv5+0H8xJBtmvmjmTw
        WCMjCc+WVOZjVXLbjXK/ihO1mGAQMuo=
X-Google-Smtp-Source: ACcGV610y7DTQ47FY/+kj/OcawIuHDdWNBMduJXdKRA6jeDA6Q6xj2T16UUxVxWcpweuMKN2+kPsSw==
X-Received: by 2002:a17:906:a884:: with SMTP id ha4-v6mr1056346ejb.143.1538560414974;
        Wed, 03 Oct 2018 02:53:34 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id w22-v6sm206945eja.17.2018.10.03.02.53.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 02:53:34 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id z204-v6so4135196wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 02:53:33 -0700 (PDT)
X-Received: by 2002:a1c:8dd1:: with SMTP id p200-v6mr895441wmd.145.1538560413373;
 Wed, 03 Oct 2018 02:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180917122633.31401-1-katsuhiro@katsuster.net>
In-Reply-To: <20180917122633.31401-1-katsuhiro@katsuster.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 3 Oct 2018 17:53:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v64gTj7766o+6-BZkqKy=cDv9bqLcKHOzj-BiJOtjQMSyQ@mail.gmail.com>
Message-ID: <CAGb2v64gTj7766o+6-BZkqKy=cDv9bqLcKHOzj-BiJOtjQMSyQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: add spdif sound node for rock64
To:     katsuhiro@katsuster.net
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 17, 2018 at 8:28 PM Katsuhiro Suzuki
<katsuhiro@katsuster.net> wrote:
>
> This patch adds sound card node for rock64. Currently we can support
> S/PDIF only. It seems the lack of codec driver of rk3328 to enable
> analog audio out.
>
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> index 5852061e497b..9ee4f57557f3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> @@ -62,6 +62,23 @@
>                 regulator-min-microvolt = <5000000>;
>                 regulator-max-microvolt = <5000000>;
>         };
> +
> +       sound {
> +               compatible = "audio-graph-card";
> +               label = "rockchip,rk3328";

I understand that this patch has been merged. However, seeing this label
I wonder how this works when the analog codec and HDMI audio out are added,
and how userspace is supposed to select an output.

On the side, it seems that extra codecs, such as the rock64 add-on board,
are easier dealt with by adding a separate simple-audio-card node to couple
the codec and i2s nodes.

ChenYu
