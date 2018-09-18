Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A452CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F40206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fIErjnaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F40206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbeISBZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:25:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40908 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbeISBZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:25:50 -0400
Received: by mail-io1-f66.google.com with SMTP id l14-v6so2586226iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rR8AxFCA/fRji3TJtxN9ixTqWCYFMmJIZaRYyP5U22Y=;
        b=fIErjnaK+TnrPkwfsaM8VeZdtCzSHFVoeoi0WBq3Kd85EQGppZMUJbs9pkM6LIKyzy
         HZUFy9pn05qVj5OI+F7SnjjHZaHzSCyKAYU4qWajtVGLNMHpwqRjRwN8myP2KZWdcAt9
         20s8zQwkEXIXjBvjzsrAKRGIq1p5bgHV+b6LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rR8AxFCA/fRji3TJtxN9ixTqWCYFMmJIZaRYyP5U22Y=;
        b=pb4qW00Grwmzay+MBrb8a8vpzerHgk0bslU100zAkVxwyfcwAgIhcJTYg4fiu0SQMR
         CVxLkSTX3LfW2dKY1cLoitGbhpCjI+cDMNu9gDPqEaFoe8xJbXe6icc7UUOisXQxqq7D
         Ul0qv9XNlgUSjheUCayZyN1hwPst80A7kP1z4cP1PgOZDtwqwvfPMb0PugE7pysbHVa9
         YVNeeX3eJl5M1nOn2qAwkxaqJySdfKrZe+WdOuh7LFXdDgwAX1NfwIZPzqWOBZA/jDjO
         tIaxJZD3NwAT4/YjdYp6nkRGPIpyMH623BtAYxosBfuiz+mMX7xTMCRgjtWd+LPKIZy6
         kpWA==
X-Gm-Message-State: APzg51DwS2VRQzRYu5jX4zcuLkT0zlWBq9bfjx6TGERjnk3Y6RzoWVpe
        kMX3zzXF7m/f+pntHm++YUabmFcqXQLNmdf0TxGdbw==
X-Google-Smtp-Source: ANB0VdZKgulDrkpLmPzXkdiOdpc1GcLBkHVhY4DNSwHTsTjaCzLIn2asTSswI00nW8hqEQb82CbX4g/W842KHa3pvzY=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr26031865iof.304.1537300303185;
 Tue, 18 Sep 2018 12:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <f698dee4dcac1b5acfde7133773f7dc1e8c40583.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <f698dee4dcac1b5acfde7133773f7dc1e8c40583.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:51:30 -0700
Message-ID: <CACRpkdZQ4qcm6SVtRzZPBREU6bKoLqhu4DZC34q8i9iOgSk7Ng@mail.gmail.com>
Subject: Re: [PATCH v2 11/22] pinctrl: mediatek: add pullen, pullsel register
 support to pinctrl-mtk-common-v2.c
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Certain SoCs have to program an extra PULLEN, PULLSEL register to configure
> bias related function so that we add it in the existing path.
>
> Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
