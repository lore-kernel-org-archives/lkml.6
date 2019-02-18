Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B282A21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfBRMJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:09:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41320 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbfBRMJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:09:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so18848703qtp.8;
        Mon, 18 Feb 2019 04:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rt8Onk5ZFIivNapcSYBDIp/BG20u3QyBL4v88MFsEog=;
        b=OzSkhE1VhgY2H2iSyfm/q7HXXNWST2iqSOdTVnVG/g0LCgPRRyGOI7MytWq63ssM+Q
         iNkPBLja0axHSOuVJ16guqLGGeskKYx8mdC2VOLXEJtUPpjKsM9p6QK7gz0O0Kr0kh06
         c0sdRtPeD9lHaaNUreSp9Y77H50I0b6vWqvAeNbyVvNDdF5/ECKh7IwzZMcft9YXyHNM
         QsfMPAHOyKTmv3YlYLDae2AyDSJ4V/Wg2eJ0Xixs+tIffq2RSpBs5HLlK0ljlDXUK1NA
         CuCBLPoIfMsGbB8t4n9PE4MMhOb32qBL6PweqUJziLTLndqON49Xxs4zoaJwl5/BP3++
         U/9g==
X-Gm-Message-State: AHQUAubrbchsJvExEP/urNcKpRb2rgkY3/00Vohfge2ZuR4dxz7S33Ew
        K/nPMPQaolma4+1caoJmYwhtBkh1Kt4WevCUmwXuJA==
X-Google-Smtp-Source: AHgI3IZ0H0QTGO2yfAXRK+DPKf1as5oE2i77Ox29VXi8tqA+s+QDSxx+jObbrp6qXqoWG80ldg63pd71KtD8FpcjdxI=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr17699767qtb.319.1550491784457;
 Mon, 18 Feb 2019 04:09:44 -0800 (PST)
MIME-Version: 1.0
References: <1549628920-32623-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1549628920-32623-1-git-send-email-sugaya.taichi@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Feb 2019 13:09:27 +0100
Message-ID: <CAK8P3a15mLEgVAh1+jQ+GqOcQa0zhrePWofo8iGkTs5_bd=TmQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] ARM: dts: milbeaut: Add device tree set for the
 Milbeaut M10V board
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 1:28 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
> +
> +       aliases {
> +               serial1 = &uart1;
> +       };

Maybe start with serial0 here? It seems unusual to start
counting at 1.

> +       chosen {
> +               bootargs = "init=/sbin/finit rootwait earlycon";

The /sbin/finit argument seems user space specific, so you probably don't
want this in the dts file but rather pass it from the boot loader.
Possible drop the bootargs entirely.

     Arnd
