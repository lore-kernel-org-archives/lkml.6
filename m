Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C86C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B3A21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B3A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeKUT3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:29:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38692 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKUT3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:29:13 -0500
Received: by mail-qk1-f193.google.com with SMTP id d19so4428693qkg.5;
        Wed, 21 Nov 2018 00:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDNJDsv5DFARE2AQajO9d1KNBipsynWMQ/LRfkr8aSI=;
        b=hRyud6LqG7yXuemGauePgTvpiwnraBbk8UrRfHAwr1zrZj+JV/blXwIyh6idI9pZuG
         3LxmxFiNcLP/NCgoopTb3Sr1+PIag32lBcuq0NnhveRZp1tJxKNGY41ymy0jji7JoNpD
         tVdkpAT8vshTsCeK//jyN1b2HhonTLkqtRURKqMRfQ7Z3C52/CHbFL1ht92eaIT2uCaA
         1WC3Z7RbDvkGaqYWJQzt9Z6GDaQgVQw1tcYMxdtrArJPwWFe57Ctv4hj1pdxDaMU82iw
         jZh8M1jSEJHkYOfD0qE2GeObjMj4AwIxOnM0VpPnEzKv4iOGwWe9jqsc/GH9PlwqEup+
         3OJw==
X-Gm-Message-State: AA+aEWbUSgPQ9x60nG8zici67Jj8gVwpK6JnJ5PStnbtLbDL7ZXG8b94
        x9EEVAlZfpqNJQCvW8dfzZapo7MvLbW31lRJqy0=
X-Google-Smtp-Source: AFSGD/XAKYrfWIKkTEGKKv1VngaUnO7FE/w3u8QgeA4Ml58X+CA8YH7G+LwXaipnCtdCFN8hoV39x8xU5aAMDL3S1vI=
X-Received: by 2002:a37:324a:: with SMTP id y71mr4732486qky.291.1542790534468;
 Wed, 21 Nov 2018 00:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org> <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 21 Nov 2018 09:55:18 +0100
Message-ID: <CAK8P3a0OqD=mxJmc2hPTp2s1-i1MPZWsjDF37hjSDKrFpzGxWg@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] arm: dts: Add devicetree for OrangePi 2G IoT board
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, zhao_steven@263.net,
        overseas.sales@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 4:38 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +       };
>
+
> +&uart2 {
> +       status = "okay";
> +       clocks = <&uart2_clk>;
> +};

This is clearly mismatched here: you mark only one uart as 'enabled, but
list three of them as aliases. Having 'serial0' point to a disabled uart
may easily break applications that expect the first one to be the
console.

Best make that

       serial0 = &uart2;

and drop the other ones if only one of them is exposed on the
board. If all three are usable, you should enable them all here,
and make sure that the numbering of the aliases matches the
labels on the board or its documentation.

        Arnd
