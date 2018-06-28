Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5297C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6049926A4E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6049926A4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeF1ENQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:13:16 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37277 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeF1ENO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:13:14 -0400
Received: by mail-qt0-f196.google.com with SMTP id a18-v6so3621974qtj.4;
        Wed, 27 Jun 2018 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xYdLdL5NOhOanKBmDogwIFVhN3D1iPAwaIm1IGp6c8Q=;
        b=saZqRdGUqTMT0RmnLQ99R0iOlLLTQW5l4wvJnshIPfccm3bLpwB/JXNYk8Zi9+/Xes
         w48uSqb4WJ8EIldPlTKwcMk84eZFL0pUZxBKQVfw/9EQt7BORE9Fefril5gw/zSGisQR
         6MvL5rIeSJ1/944LXIjBM2b7eB7DIHuVO18lbffATWlBIuZBgFucSASxasqVI9a3/0T4
         tP5vzZbEft9gQdWw2TQkBU5rGSHEPLvJheT4E8ElnUEGonx7kC8TyOoSF4Ai9OMTSawL
         /io+IO1FwWGyRfh9+LQXdV4a+RG2u353saD6GjmhtNoT+90E1LFN0ImiIj1XEeAx2RMI
         93jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xYdLdL5NOhOanKBmDogwIFVhN3D1iPAwaIm1IGp6c8Q=;
        b=BlTAjUA9j+k5ghjUrJo3WsAxkep5bBSeeTBy1Ou7EOOo0PkXWkl9HaB09gbe8okISb
         lXY/zIhJcEAxzYS0bHRTcraqkNiV9zQOil0T/+zMPbyVadKMdfSeWs0+/341FOXb4nzq
         m7fBoRA2ZrXgw3VpKYIBC0xuGXeXFt+ouBbwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xYdLdL5NOhOanKBmDogwIFVhN3D1iPAwaIm1IGp6c8Q=;
        b=Dei3UT1ETRheo8YhzPTYhydAH7trDKLEJn+jz8Wnxwo8m5RwRWDzoSLA8qf1WFiA2T
         EE34op1JXSjNOVuEpXlaq5wMkVVZBW7hGNpipUnybxDK4va4Tqes/VLbSAAqmTc+Vujk
         vNLG+zCbUvnbUmFaQPf3B8erlisH6PgGOqeQZO7MQALHz8uQ+mdGoOSV62Qdgi18yyZH
         luJMmmxtg6P/e+zIZX3cuIS8y5RpAPmSfaL+FumjwjZN9U4mesdUzKw+LR7mq/WUriuX
         mTjR4Bc2TaptbNJJjTXgU9noTijYQmksPwlWN8CiYy+/pkuiBNgIYGXinh+cOcdJ0RB5
         xGNA==
X-Gm-Message-State: APt69E0dZpUTGDkg6gDx/HgshbWHZmLV165JJNC+KLUaw7n9Edsx+AWM
        e8niSgNG0LSUwkm48S5DR5xLRcD3NpJWcIs0Y/A=
X-Google-Smtp-Source: AAOMgpe6TN7pLH/U9qXyfHQSGjKCvy9/mCDiQNWEW6azyUrbXAtbwi+SNBIvD+2WHlsmoDef/VUkOZyfFCHTSgqiMhE=
X-Received: by 2002:aed:24f0:: with SMTP id u45-v6mr452399qtc.340.1530159193487;
 Wed, 27 Jun 2018 21:13:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 21:12:53
 -0700 (PDT)
In-Reply-To: <20180626232605.13420-14-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org> <20180626232605.13420-14-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Jun 2018 13:42:53 +0930
X-Google-Sender-Auth: djlhkPWpR4JqcdJAomm9pcMi_68
Message-ID: <CACPK8XcyncbmU3kMVPVZV49Hnt+avbzgUOL=KMP+Ed12axWqRQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] arm: dts: OpenPower Romulus system can use
 coprocessor for FSI
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 08:56, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I will take this through the ASPEED SoC tree once we've got acks on
the bindings.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> index 347938673c83..070b8f8f1d62 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> @@ -37,6 +37,11 @@
>                         compatible = "shared-dma-pool";
>                         reusable;
>                 };
> +
> +               coldfire_memory: codefire_memory@9ef00000 {
> +                       reg = <0x9ef00000 0x00100000>;
> +                       no-map;
> +               };
>         };
>
>         leds {
> @@ -56,10 +61,16 @@
>         };
>
>         fsi: gpio-fsi {
> -               compatible = "fsi-master-gpio", "fsi-master";
> +               compatible = "ibm,fsi-master-ast2500-cf", "fsi-master";
>                 #address-cells = <2>;
>                 #size-cells = <0>;
> -               no-gpio-delays;
> +
> +               memory-region = <&coldfire_memory>;
> +               sram = <&sram>;
> +               cvic = <&cvic>;
> +
> +               fw-name = "romulus";
> +               fw-platform-sig = <0x526d>;
>
>                 clock-gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
>                 data-gpios = <&gpio ASPEED_GPIO(AA, 2) GPIO_ACTIVE_HIGH>;
> --
> 2.17.1
>
