Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1609C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D6A20873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgUuBaXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D6A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeG2Vro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:47:44 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34696 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeG2Vro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:47:44 -0400
Received: by mail-it0-f65.google.com with SMTP id d70-v6so7437057ith.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/x8kTd1UPAAZVNK/2C3EFiLl+aBh0wsP+bWRJWDMHo=;
        b=IgUuBaXtfCoh93udhQAneJAjvvEo03q5CCaM7YPB0PG6+MgHy/haMcpTLmyS7gc21q
         zu6UWWo7qdFvQbL93UfwkONkKi8/iPdrhWd8jJ9OgMlASbuGlGmswd3XhT8MsXYrmzoo
         aqBsCAL9Cvug9fvk+jg9R/bwPDdiF2f2ME28g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/x8kTd1UPAAZVNK/2C3EFiLl+aBh0wsP+bWRJWDMHo=;
        b=cALhzcBgoWS/NTdQ70WPvIHaiSNeUKbY72RsAUc+OGlcsm3e0KriYNVZd9g+oVi+mE
         6kN1E649gP0pygXFz/ZJwUERn4VyGJqKhj72qvDM+JHWP4ncvdN2EX+vLxqBX/RWAxL+
         IyCP5hBD+NjCHmzUZEUPhik9b4eszzpT3r5352IhaD8H7iJWCVqswZQb7GGnDZH84yAo
         U5EZqFxOSX0juY+pUJiuDMYZ0eN03BYQsg4AZHVR7UIJ4Ja992GEVayolFs5yRsheia5
         ZR9a0lbD2+/9M5WelakuY0sBPbXye3gM8tNDWPXvyTgWqXbwd4FMPuEMKv+q8SRdDf5E
         2WbA==
X-Gm-Message-State: AOUpUlFQr02+I6AbxTzk7l/h/s/u8cq7ZKAWwoaPggS1n245wM0CWAQ7
        rYsqGpp0SkpUp4vSxSXinQFoO6CuetgzVKsZ1Qa2mA==
X-Google-Smtp-Source: AAOMgpeOOGdJBq0T10OwP5cB51N64FHSbtop+0wDLMmWOqf2jIhUVXJF0pQF+LDEFjuFtP0EfElPJB8E/lQ0DJWiKP4=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr12498508iti.135.1532895363823;
 Sun, 29 Jul 2018 13:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <1531821387-29845-1-git-send-email-ludovic.Barre@st.com> <1531821387-29845-3-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1531821387-29845-3-git-send-email-ludovic.Barre@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:15:52 +0200
Message-ID: <CACRpkdbEnLh-SYK5vo5oUV9MnDQAiObcKdpqzTdPq2aj52VShQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: stm32: add syscfg mask parameter
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 11:56 AM Ludovic Barre <ludovic.Barre@st.com> wrote:

> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch adds mask parameter to define IRQ mux field.
> This field could vary depend of IRQ mux selection register.
> To avoid backward compatibility, the drivers set
> the legacy value by default.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Patch applied with Alexandre's ACK.

Yours,
Linus Walleij
