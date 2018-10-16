Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F967C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1CB20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8W1axTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1CB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeJPPUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:20:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35283 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeJPPUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:20:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id v68-v6so13506169qka.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 00:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xngWekDgdWVLYtgMwZB4bPZP4dRKVsxuWF5aDY6u6AQ=;
        b=Z8W1axTGUIif58g7arM6h7JupiF3FaI55RpZzzSvLugTHPHLUwzvTu0Zpkz6K1Dyg0
         F2U+hN07yHX6F+1QiK1mytEB24Mi4rVKuO2tVL0JaKmNwNC0yPb+/eWAstQocf1izl9x
         vmZQv52+efbQXaCyZJ8nja/R2gN/zSrcgy64A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xngWekDgdWVLYtgMwZB4bPZP4dRKVsxuWF5aDY6u6AQ=;
        b=b6XzqdH3UsHg2wFAECFyLNnnh/gdbKvORQ3ePUCkiHoEdUhJpPJ05n9qdLfyvGrPuN
         UATZL9IynbL9bBVS0PkQWa2OyNqgYqHjaQVCNHa8GO67yfa8JbJS+4UXVi3PI9rEfD1b
         QA7hGqfCob/IjEYOfBDrITtIVTwshqie1GEo/nIn2W4qMjLm6x8Zcwlla+jbde0mKmwb
         Ujni50f104zxxMyuAcVi9lVg4uRlxZ14t6WkjAMSWwGvpKWBbwWvf/eGM3PkFK3r1MCF
         kLnuYEGuWdIEUNL1mVXowSk0xKdKPBJo5sHlYpXwsVg5Ll1env8dMi4LsQoKzQN79HxJ
         HN+A==
X-Gm-Message-State: ABuFfoh5pHm7myyKK9rJ3NdVpJWx7MikUAesr2s2mRg6YiaNlFpY/uld
        1GCCLmMzKPsdoH14WaU6pHauZDrejqXTpYSm4qBCdA==
X-Google-Smtp-Source: ACcGV63lGCwb6K9vE0hFujI/4Kt7K/LARB6dhZp90lzRf8hA4xcqP8e0iVb3aHHiNptWxV5nJvb0cRpt5SsaC4kkW/8=
X-Received: by 2002:a37:1f53:: with SMTP id f80-v6mr18527190qkf.109.1539675056216;
 Tue, 16 Oct 2018 00:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181008163216.97436-1-swboyd@chromium.org> <20181008163216.97436-5-swboyd@chromium.org>
In-Reply-To: <20181008163216.97436-5-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Oct 2018 09:30:44 +0200
Message-ID: <CACRpkdZ+wSEnT3u-0MeGaQhmivLDZJxUnEULFwT_trks8vYFBw@mail.gmail.com>
Subject: Re: [PATCH 4/4] gpio: Clarify kerneldoc on gpiochip_set_chained_irqchip()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        evgreen@chromium.org, Thierry Reding <treding@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 6:32 PM Stephen Boyd <swboyd@chromium.org> wrote:

> This doesn't support nested anymore, so drivers shouldn't call it with
> the handler set to NULL.
>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Patch applied.

Yours,
Linus Walleij
