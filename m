Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9C4C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFDB2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFDB2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeLNKHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:07:47 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37217 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:07:46 -0500
Received: by mail-vk1-f195.google.com with SMTP id 197so1148263vkf.4;
        Fri, 14 Dec 2018 02:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnQRPWfl/qdDg85AQcgvTE8sbROQCHCeXq+7jtuszNY=;
        b=o+CxdG8idy8E9SXpdYUzvKHnM6fIbTWPXVj+xxjQrEYqnUaSc/DbCDFGSkqaToKIJz
         lNsbgkN7ZulnObLOWYxX/BQOdjcyu9kqx3EIvWTlMLvvqKWPM2hpARIKio/RsT6/QYV8
         XlqMwF1H4KE5vAj1n9TpKkyEPW3k2qRKXXAkaA6e2esVtp11ShJUnP1WHms6CEIUeMDX
         kqTjvRaZcy5YBMBNu0Ke7V777uHPRCGstni406zmrodNFV6w4QwGuXH8bXV4CHZSAISv
         suJgjHgQVYwGZmy/laFkpeddxnPRp1SGmlteW/rtzjYcPh94GRmzs6TXZKGHfbAdYDlJ
         uQZA==
X-Gm-Message-State: AA+aEWbYHqL26WD4wkIankdBS81JT025MoN/IBewomfGUA266tFhb4OJ
        dzcXhUq9aQEhixYnigbbcjmUimS2wKt6ycHZ5Pk=
X-Google-Smtp-Source: AFSGD/Ws5GXppcdAYCBRl9RZuBstsGyfWpG9BJV+W8Y5Om88P1RZ2bWinDKJC36USJCJbhLhDG2BXuHYkuSRYh2tBXg=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr959120vkh.65.1544782065615;
 Fri, 14 Dec 2018 02:07:45 -0800 (PST)
MIME-Version: 1.0
References: <1544732342-6131-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732342-6131-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:07:34 +0100
Message-ID: <CAMuHMdUFbkowC9a-2wst_GufizEY2CtWjr2R0yerzS1d5EmB-w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: i2c: rcar: Add r8a774c0 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:19 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Document RZ/G2E (R8A774C0) I2C compatibility with the relevant driver

device

> dt-bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
