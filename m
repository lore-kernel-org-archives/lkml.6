Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1159CC71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AFC2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULfMny1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AFC2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJOVsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:48:53 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41667 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeJOVsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:48:52 -0400
Received: by mail-ot1-f43.google.com with SMTP id c32so18981214otb.8;
        Mon, 15 Oct 2018 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DAuCb8LhCBrnxc5LNvtoylHSFjTFe5IA8gnh2qblrJ8=;
        b=ULfMny1RAwm6k1cTiKr6kwW6SjEBLjsEFFuFaxrN/gD0m7VSLKUuWeUk6NVFgwDBao
         ROf8mNWpb2iTQwKQe60ZGKbO9d/8e487BIlALMNZt5JOk3ZvKFMhyS/+vtYElJ2GzTy0
         /5KnLaItDAorVVN9BBgGMJi1cuFBvtjOJ1QQWcTkSJH6hOndAzvo7Ggl4/jzN6IPkEII
         ur5mHxJhhqrqQ8nRhffXn0MUcUBtOT1A84X6mnR+vf4Wk6wZe2ZT473MlZn3KochjWwQ
         5CsDeLtlFmr1g6gYjBGseSxsDwWXGUm1vtH/fJ67mLeV8X7G0M+U4R/+ENHcJdI1F6/K
         DkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DAuCb8LhCBrnxc5LNvtoylHSFjTFe5IA8gnh2qblrJ8=;
        b=OwIH4VX90PRmNwAy0+2euma8ZdXrzdM+a3BxZMpH9/3FBCUMh1goo9G5BskDVtmEyE
         hFTZXF5OT/oy9Ery/+QiUuUSbCAnEHaFYiv7WLIy1Jzvv0IwZNoegwHW7fb/nXKpUOhn
         d5/55k19dMXBaqpNoiLJMyOvYiJAE8qFrkUDFbORVoPOrAMccaOg/j3LeF25LdSQsktz
         5V3JoXhGgUXZiv8281GSmxSNljYsgeOSVkBUOTsj9uzgwwqcYB1U5IbBqYu3RWHgbH3S
         SZ8AsZFQ7EQonosOCYN+oFh3EzJi6Q1qzb14M759m346Vgnzmslwqyd3GMHNmiCM9TiM
         8OHg==
X-Gm-Message-State: ABuFfohFQFef1J7coIZrLdlYUzSyaej0A4jt0ga4nPw1eOf/wD9ygkD5
        0bKMvJVIlUleN4ASevT/gGnEjc73YbK3HeO6yK0=
X-Google-Smtp-Source: ACcGV61mThRn5/6agSnSxwC3Rld4ljdRqEt/xZZcOaUhm1bzCb//ewk1Cbn4J7txTmgXXeYMNZbwCZyXydUs5dzoWkg=
X-Received: by 2002:a9d:f9b:: with SMTP id d27mr12093709otd.225.1539612206768;
 Mon, 15 Oct 2018 07:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539609921.git.leonard.crestez@nxp.com> <9365e24504896e58294fd8786acb3c3d4a1a264d.1539609921.git.leonard.crestez@nxp.com>
In-Reply-To: <9365e24504896e58294fd8786acb3c3d4a1a264d.1539609921.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 15 Oct 2018 11:03:33 -0300
Message-ID: <CAOMZO5AMwGakygMT=O9CjN8jyL-FAox3-452C1vpGc9sPCXBHw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: imx6ull: Add dcp node
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta Neag <horia.geanta@nxp.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:28 AM Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
> index 796ed35d4ac9..be610339e933 100644
> --- a/arch/arm/boot/dts/imx6ull.dtsi
> +++ b/arch/arm/boot/dts/imx6ull.dtsi
> @@ -37,10 +37,20 @@
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         reg = <0x02200000 0x100000>;
>                         ranges;
>
> +                       dcp: dcp@2280000 {

Node names should be generic, so it would be better to use:

dcp: crypto@2280000 {
