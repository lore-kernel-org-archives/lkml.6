Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88C0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6855E21763
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVGQFG5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6855E21763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbeHCPqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:46:53 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36344 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731146AbeHCPqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:46:53 -0400
Received: by mail-yb0-f194.google.com with SMTP id s1-v6so2667444ybk.3;
        Fri, 03 Aug 2018 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XtslmG8l/iRc2k5q6zwj22bwk0LttblIv+FDNA7Nb7o=;
        b=TVGQFG5tzU/NVheWhn+C0OerbBVC6RZ9psRnhuwLO5iKfPBxawFvOD+Unu/9nKDR1S
         W5garCyxXxs0G6VTlkTdAaHNA5Po5mSLBpQ/fjQzR8HcHYBhRzcTPPoIcfB3IdFrPI97
         RIudonpJDD4gsDrM7UN5TxDsA+1CViU0BDmwn8IR+yEjGMljYoZQsr0PbALWZvr7nGNC
         kKLT4RlZZt7GZ9uNB038jcm7eYGowHqvYlid+kSUmAFemgoLBImWAFLApjfdgtG8aBFL
         mJ7AUZ2FkJPuU46UkxsPcAaa8BfAkXJMuJPBrCIfEK7WYYBk+abRcUgkeaP8CfiTC6BJ
         V+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XtslmG8l/iRc2k5q6zwj22bwk0LttblIv+FDNA7Nb7o=;
        b=FEUx0LO9bp83WdOree9Kz4vqcNi/q7QK2Zmvm8luIhX5yj0A8pAjQeJGtdRxS5rZh5
         3+u8S+tDTxvjyW9IDQvp6rLk08KDQje4LFVpcimKY9os36GOT1OLs00G9ohfMaO99Zpb
         mcbW1JyhbOh3EhjfcJP5o0yXrYVlXGLhI0GTWaxC2CSGTlhdbRLeq7jwEO+yhZNu4JX0
         AyPMqwRvyxxDBOKMSlv2NBPNBV3Ect/bxOGOkX5MXh/Mzo9NacUuAKngceZmpb6k1avw
         okEKABC2S7iRBxc3NlD7f4C5TZvFOhgnGDqOB2tUrDB6WUaP7APJviOy7WPZYIdasDWn
         JBuA==
X-Gm-Message-State: AOUpUlHT9SGDF5yf+9T5sNx9lNSGwic7fZnvL64HlhU61jqrknr/43A1
        b7pMNs6DoUUQYjtNXohjI1Fp+ehI98ODOEhbOXk=
X-Google-Smtp-Source: AAOMgpcFYmTCzXGWSmKGjqMub3boPu7/rZYc0+IKXkwbcweXTLtR8TaTa09FUOHdpCCcoOpujxXLQf2dNWoPAV/j6SY=
X-Received: by 2002:a25:4c84:: with SMTP id z126-v6mr2063828yba.409.1533304226354;
 Fri, 03 Aug 2018 06:50:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bc1:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 06:50:25 -0700 (PDT)
In-Reply-To: <20180801185128.23440-4-maxi.jourdan@wanadoo.fr>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr> <20180801185128.23440-4-maxi.jourdan@wanadoo.fr>
From:   Yixun Lan <yixun.lan@gmail.com>
Date:   Fri, 3 Aug 2018 21:50:25 +0800
Message-ID: <CALecT5hgk+Wuh4-UWY29NNoEz-47Fx3pSjve8raCd3hRMzXE5w@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
To:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

great job! thanks for contributing the patches..

On Thu, Aug 2, 2018 at 2:51 AM, Maxime Jourdan <maxi.jourdan@wanadoo.fr> wrote:
> Wrap the canvas node in a syscon node.
>
> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index b8dc4dbb391b..d104b9e111fb 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -423,6 +423,23 @@
>                         };
>                 };
>
> +               dmcbus: bus@c8838000 {
> +                       compatible = "simple-bus";
> +                       reg = <0x0 0xc8838000 0x0 0x1000>;
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges = <0x0 0x0 0x0 0xc8838000 0x0 0x1000>;
> +
> +                       sysctrl_DMC: system-controller@0 {
> +                               compatible = "amlogic,meson-gx-dmc-sysctrl", "syscon", "simple-mfd";

we'd like to drop 'meson-' prefix, so better using "amlogic,gx-dmc-sysctrl",
please take a look at the discussion here [1]

[1] https://lkml.kernel.org/r/7hk1prmg4w.fsf@baylibre.com

> +                               reg = <0x0 0x0 0x0 0x1000>;
> +
> +                               canvas: canvas-provider@0 {
> +                                       compatible = "amlogic,meson-canvas";
ditto

> +                               };
> +                       };
> +               };
> +
>                 hiubus: bus@c883c000 {
>                         compatible = "simple-bus";
>                         reg = <0x0 0xc883c000 0x0 0x2000>;
> --
> 2.17.1
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
