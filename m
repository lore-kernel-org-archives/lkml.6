Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA9BC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A2F24C61
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWzKO5XN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A2F24C61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeFWQAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 12:00:21 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43301 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeFWQAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 12:00:19 -0400
Received: by mail-oi0-f66.google.com with SMTP id t133-v6so8776473oif.10;
        Sat, 23 Jun 2018 09:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GJz1ieC6kmNVEc+BrKXk6UivhbovnAvQaQgyk1NI/1Q=;
        b=MWzKO5XNCKqC/L+/vpsNNDJj+0W+V1vE2qXlo3wHBDbcfbZE/w9B3YjTIaVUQXhHVe
         0dCFHE9FZqRixWsLcjjvo6Oortt099D8Q9dbBURYD1/22tr/yDHKAhFn8fRVHilct81s
         azaFs9BG8g39Bj3Jd/JY/LHiiOzEJtJabICHG/4pn79PQ4OFZHJGlT7k34NQQCbOp6LE
         lz1IOWg2z8A5UcQ9cM4ZVAi91o82K0KMgz4S5DktfZYSfQbJ3F6qcg0seLA97U5OFzWE
         /Lrw+ngADlAzq1a/90gmj9L4Q+TOi0kdAQtPtZWYf4BrSe7XfkNaDLPZ69nN/ohtAR3H
         Af4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GJz1ieC6kmNVEc+BrKXk6UivhbovnAvQaQgyk1NI/1Q=;
        b=DEwxYAU7ICQc8McXibu0HjzyulCnGxrw+Q0y5qNU9HgbCkh8EcQ6tEMUlQomgKTYFC
         vKd8wPrFzsfhsOVL4NZGvJ5M1umvGXSdR3KbjvVfnow51zUiwCBjKBdqd4nPuuKhyuST
         j1mZOjctQ9oN3pC/NRwyKkTPIc17yFhCmFQAD/fMy5cu43gj3eJTiL2tQDC6lW0V3gxa
         rQATdpGUnab8LflhrQW7qUJS7TYmKNhKMQlD+lF11Rsx0w1X4NQSt+zXG1iGooXSM2R9
         XUJ8w2sXx5EMbsHTz/31ZL6cHBinwxwAsEQg94IgpV7n3dZn617HCdRX5HK+e43geayV
         b2fQ==
X-Gm-Message-State: APt69E1cCt33Zjf9K1MmfEiGdqwnrhHCZ5p+djzpTa6TD3UUFGM4I8y8
        HX0bQcmyzYUs5k0ZbdcddON3W0QJAl2nPCLZN4o=
X-Google-Smtp-Source: ADUXVKIhUqr8m35w30p75NDgUiaUa5OsDNzWdtic2EIzXr3b9nsy2jwYuhindOpLMgpBU62Vz/EZ5O+4em28IYqx0y4=
X-Received: by 2002:aca:3a45:: with SMTP id h66-v6mr3503098oia.336.1529769618347;
 Sat, 23 Jun 2018 09:00:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 09:00:17
 -0700 (PDT)
In-Reply-To: <20180622145225.17883-1-sebastian.reichel@collabora.co.uk>
References: <20180622145225.17883-1-sebastian.reichel@collabora.co.uk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 23 Jun 2018 13:00:17 -0300
Message-ID: <CAOMZO5Bdh9d6nrX80xpkmFdFydfmazSkU+bwzNGFQFGz8dPAPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: imx53: PPD: Add fixed-regulator information
To:     Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, Jun 22, 2018 at 11:52 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:

> -       usbphy2: usbphy2 {
> +       usbphy2: usbphy-2 {

This node rename seems to be an unrelated change.

>                 compatible = "usb-nop-xceiv";
> +               vcc-supply = <&reg_3v3>;
>                 reset-gpios = <&gpio4 4 GPIO_ACTIVE_LOW>;
>                 clock-names = "main_clk";
>                 clock-frequency = <24000000>;
> @@ -208,8 +230,9 @@
>                 assigned-clock-parents = <&clks IMX5_CLK_OSC>;
>         };
>
> -       usbphy3: usbphy3 {
> +       usbphy3: usbphy-3 {

Ditto.
