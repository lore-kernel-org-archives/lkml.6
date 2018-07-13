Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0068ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856ED208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bafw9Vln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856ED208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbeGMHwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:52:24 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40477 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeGMHwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:52:23 -0400
Received: by mail-it0-f66.google.com with SMTP id 188-v6so10269803ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09laPRvm1HZl+PrPuAsAEav8QzfLNVXijvBJBWVfc+s=;
        b=bafw9VlnKHGBa9WIWi+3doEWDBN7gkP9/J56LTtCDPIBbUH21UGeH+8/gW51F+Zmn1
         z5jgc0WahKg1uPdasBI84QxZD4BvCBw0pWcWK03NJDXyR5juHK/wB44Iq/ZpsSX05giI
         vF+PP5UMoH9R0N9I7mZIZCWpoTMIpRhXeMLmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09laPRvm1HZl+PrPuAsAEav8QzfLNVXijvBJBWVfc+s=;
        b=kYknVAyO3XK8VMp08+4epMTbKTJh5nhUeiF7/mnVs84ykxFL2L/hEZ9AwGmgtf86MV
         ++9Q4B9/t7+x7W7ib5Yw4AdYkxfCmXpGgDAd98NxRkGkEDQK1VJ+IumBQvzh0zkm4nZ4
         TxwbesKOFZ+sWfEwfX2Sqb/ceOocLzocl5tXyBD4XfwPLetr6qr13uYHwt1ECEo40q0T
         qBxv1oX3gkDamhWczPDVl9ogsmQ1ltDzVsV1T8qmNHnwHxyIHWLxAFKVcek8Ee0tpJZD
         +ALKLsBevtzTK8qRpAzoPmdeLzVLAeILLzfnsrScbpzraErjRwJ3ehCYbZLxadstt+St
         l7HQ==
X-Gm-Message-State: AOUpUlGNmj4SROUsy72VoGdajkh6x6PTeuPXGU3W+ce4EmNw4NIFFWhv
        f3Pwi3BZ4M5jpmv28G5IetdajDf2O0Xb6rbnMKLYUQ==
X-Google-Smtp-Source: AAOMgpfHfvi+AKZDbeYTPI1+uTLp5NSP/Lmsj80E3uiX46B9sOZIDyk91tf3mv2MrwXobrM+qfRUefw7qjmp/PH9uyY=
X-Received: by 2002:a02:9d03:: with SMTP id n3-v6mr4197164jak.113.1531467539440;
 Fri, 13 Jul 2018 00:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1531294612-29526-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
In-Reply-To: <1531294612-29526-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Jul 2018 09:38:47 +0200
Message-ID: <CACRpkdaGynwq_sApAgahAY7vQ_HaPqTRhzpWPDCu_PtMc2zoCg@mail.gmail.com>
Subject: Re: [LINUX PATCH v11 2/3] memory: pl353: Add driver for arm pl353
 static memory controller
To:     naga.sureshkumar.relli@xilinx.com
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>, ada@thorsis.co,
        honghui.zhang@mediatek.com,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nagasureshkumarrelli@gmail.com, michals@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 9:37 AM Naga Sureshkumar Relli
<naga.sureshkumar.relli@xilinx.com> wrote:

> Add driver for arm pl353 static memory controller. This controller is used in
> Xilinx Zynq SoC for interfacing the NAND and NOR/SRAM memory devices.
>
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v11:
>  - Added amba device registration and removed platform device, since it
>    is an ARM Primecell Peripheral and it should register as an amba device
>    as per Linus Walleji.

This looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
