Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129CBC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D2D208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XA89MQaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D2D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbeJASBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:01:43 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54548 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbeJASBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:01:43 -0400
Received: by mail-it1-f193.google.com with SMTP id l191-v6so5122891ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 04:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSHqyFyM9bJNA/HWHBaUjikxTiZCMSt5HgK56xM0zjM=;
        b=XA89MQaEypUVGC0i0Tq2l6E3p4+eb1A1gSHDQEZOSy8fi6lbgQwE0VIB/cPcQmeZ/0
         o/UpnRcKms0Ynm0npQ9v+u50NYG/xTDwVouUu68X4QXdIpWfCQRvVsb9C/96PhTpEt2C
         ppMfAee6Th2hwSJ2yEMcAEDZo2bR/ukMHe9JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSHqyFyM9bJNA/HWHBaUjikxTiZCMSt5HgK56xM0zjM=;
        b=q1mR8Um1t1AQlerDk+aie4Nx26CQ9xh1UHPi8GKM2KlYi1eoBhA70FmyOeDydVSmwA
         f/7JitIn67lo1w5AEO0by/tGOt1AifoL4d4B3mZRWgS2GpjVgbwHt8nurwL0m6ROn9rh
         HKZSML8W3fwy5WrC9w6+yHpAmrNqA+ILkQSKRQvPGXRZV1BA4Kl2Sr6w1MDTg2k06C6f
         b5jopbH6kDUTYhtxt1AyEyTGY1MCyiU0hQT6JQ6ftpFXUVSKws8CQL5igqkTjuRm9TCR
         4JvTgyBqkyCXGExbcrsUv5dT7aUOj70sMdDCTRU6kuKCSYAVI4I8d7xgdK/29nmKsP7J
         xyZQ==
X-Gm-Message-State: ABuFfoi4EEulbLznZpPQN1XoxXW8u38ESuW7iA8BFrV7FTOgMvRgtLZA
        Qv5uJ08mccY11Y0Clm9Uk1WE6n8b+lih93VO6zyJOQ==
X-Google-Smtp-Source: ACcGV61BZbOoDebwMA4YM2OCOjp1ynUP+F1wh9J5r4C+tNSuEBp6UWVIIcceB1DYrkDJcubxA/R9d171pwFJ86xGfaw=
X-Received: by 2002:a24:97c8:: with SMTP id k191-v6mr335489ite.130.1538393064480;
 Mon, 01 Oct 2018 04:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180927233844.18443-1-grygorii.strashko@ti.com>
In-Reply-To: <20180927233844.18443-1-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Oct 2018 13:24:11 +0200
Message-ID: <CACRpkdb=+PDA1dz=Ui0OmhwKzDvCGEBMa7aUyqfg-s84gki1SA@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: drop omap_gpio_list
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     ext Tony Lindgren <tony@atomide.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 1:38 AM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> omap_gpio_list is unused so drop it.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied with Tony's ACK.

Yours,
Linus Walleij
