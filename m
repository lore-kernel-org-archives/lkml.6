Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C12C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA0C20685
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK57YPDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA0C20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbeKTFcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:32:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeKTFcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:32:52 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C1E20685;
        Mon, 19 Nov 2018 19:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542654474;
        bh=BMJ8w+e8FL1v4qv3GydD1BOlAEyzwneOVVVQ1GHM4sM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XK57YPDDmDk8qjY6bef9UiFYQP0Oj+S+ELhlNW2B90mundOty/ORPGkgysw4rg4+B
         l48kDqs/lIDPTWsVHbcuLmQdi3Lau8f3FLX/lvDlxXmgU5Vyq0G3MOPeyziXkrbPJb
         domSafam96dX5LqfiDWsDAxQvMeQ9gbMRylL1TIY=
Received: by mail-qk1-f178.google.com with SMTP id m5so50470973qka.9;
        Mon, 19 Nov 2018 11:07:54 -0800 (PST)
X-Gm-Message-State: AGRZ1gKObabmoK4xl0Ka2r7RSaP1UV1oRsXqBWb5Da3bW0Oehi4XhH//
        sUSrRKtVtQCtfWm8qjgWBHc9fnc+uLJzItMVNg==
X-Google-Smtp-Source: AJdET5fo13pD6/5s/ev+dffNr1t+8ONtvNcokumD9bTFr1N5V3jvDREIYctwpa0PcPRnun/ZiqOeeYRlNwSMfyr+w78=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr22956364qvb.218.1542654473919;
 Mon, 19 Nov 2018 11:07:53 -0800 (PST)
MIME-Version: 1.0
References: <20181116220540.17222-1-robh@kernel.org> <20181116220540.17222-4-robh@kernel.org>
 <CAGp9LzpgZsj79Tf5Hee45Wt6ag+WHV0SMWd6qvvtj4G3pzAZKQ@mail.gmail.com>
In-Reply-To: <CAGp9LzpgZsj79Tf5Hee45Wt6ag+WHV0SMWd6qvvtj4G3pzAZKQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Nov 2018 13:07:41 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+r6JrKKcHnmBSncdEaw=7Jhobv_w8PJrH=sbY2qtxOTQ@mail.gmail.com>
Message-ID: <CAL_Jsq+r6JrKKcHnmBSncdEaw=7Jhobv_w8PJrH=sbY2qtxOTQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Convert to using %pOFn instead of device_node.name
To:     Sean Wang <sean.wang@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 5:46 PM Sean Wang <sean.wang@kernel.org> wrote:
>
> On Fri, Nov 16, 2018 at 2:06 PM Rob Herring <robh@kernel.org> wrote:
> >
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Sean Wang <sean.wang@kernel.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: linux-mediatek@lists.infradead.org
> > Cc: linux-gpio@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Acked-by: Sean Wang <sean.wang@kernel.org>

BTW, messages to you bounce:

<sean.wang@mediatek.com> (expanded from <sean.wang@kernel.org>): host
    mailgw01.mediatek.com[216.200.240.184] said: 550 Relaying mail to
    sean.wang@mediatek.com is not allowed (in reply to RCPT TO command)

Perhaps you need your kernel.org account to route somewhere else.

Rob
