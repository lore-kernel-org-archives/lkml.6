Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98339C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D752081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmkpmZUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfBVKjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:39:08 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32855 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfBVKjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:39:08 -0500
Received: by mail-qt1-f194.google.com with SMTP id z39so1950872qtz.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 02:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Ycd7F6cSiLogdbx9zRwsP3cV/l35t97ZLFFQbqW0ZY=;
        b=QmkpmZUiBTbZ9js+DH1S5VXOUAULuAZLuoblV0v5GDDP8QKc/2qBF5QRoA0o/FFWAz
         3bL3NDQsR6+GvMRWf6Ie4uXz7E6nFW8STIGANrpojGfO9FMKmvc/m8QYfPkArk7o+/RO
         VV6PeDdL4GccW0ZhsrpKl1UARJCLKHkrZr4/79GXkEKLKfhBiiRIkqmhC/BYdA8jaPJT
         /x8seq3Z19RbpG2VQiMSJTaFzBvjBUa9g8emCTfnkLbhAD7VmBgCRT31WTgqiYNLSRzx
         LJwPCe4snAZD57HLfztU41cAiqw45/onngw+tJKzTBe4zr1VM2wLyKbxho96GCtqdnwc
         snIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Ycd7F6cSiLogdbx9zRwsP3cV/l35t97ZLFFQbqW0ZY=;
        b=pUntOUsPdDwnM/2fEljzTju24GxD2NBV63jOiW8kpY1dO1oFbycGAPg3VO0pZjWX7p
         RXLRSbg+Q30Bp3fTr5HrQKb9R5bz5ZUSRCg02qoSGP5RxMhHrdubPOj2E1SWLa+mkHW2
         WnEubouXTofL+2bxxW2eaXWZC4Gz6mvYwlb1UDiUJ5rBvuVSqoD5ul7qLNBOrL8V3I57
         WaSxTFhU/8mb7SJDW7Yh7lKoKk2qoV0Vcqphl5269RGHA7WHHei9zeFDovNGAnZtFzsu
         cF1UtP3yEh9Lotn+dCSilxb6vUbcoR9RKbj2gexrfHUttJkQFXrctNWKevuLR1pc2txb
         hYsQ==
X-Gm-Message-State: AHQUAuYPE/Gx6EeN+dG4YBRdeiEAPozIt1ZSiamYVnD07kDT6xbP+6eB
        JeCjSl9ARZq8FnkCTqwUkj5PukY6zgPNOG7oICBKOg==
X-Google-Smtp-Source: AHgI3IYPBeQReZrHfmtjIx01G+WbY+Szt8b2nB4hFiiHfak6YeCCIGdM8WMPfhyRAx41LlrRr8ETqmxczH1Ks6eGhQ4=
X-Received: by 2002:ac8:1bf7:: with SMTP id m52mr2568003qtk.200.1550831947420;
 Fri, 22 Feb 2019 02:39:07 -0800 (PST)
MIME-Version: 1.0
References: <1550819742-32155-1-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1550819742-32155-1-git-send-email-wen.yang99@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Feb 2019 11:38:53 +0100
Message-ID: <CACRpkdYwkNrLk-GuV7gaOKYFOeBd0=DLN1wsgrYxeXOHuwtz+A@mail.gmail.com>
Subject: Re: [PATCH 1/5] net: dsa: fix a leaked reference by adding a missing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, anirudh@xilinx.com,
        John Linn <John.Linn@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>, wang.yi59@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 8:15 AM Wen Yang <wen.yang99@zte.com.cn> wrote:

> The call to of_get_child_by_name returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./drivers/net/dsa/rtl8366rb.c:510:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
> ./drivers/net/dsa/rtl8366rb.c:518:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
> ./drivers/net/dsa/rtl8366rb.c:540:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
> ./drivers/net/dsa/rtl8366rb.c:548:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
> ./drivers/net/dsa/rtl8366rb.c:556:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
> ./drivers/net/dsa/rtl8366rb.c:561:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Vivien Didelot <vivien.didelot@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
