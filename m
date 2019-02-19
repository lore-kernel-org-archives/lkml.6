Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB53AC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8079921848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bBK16VA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfBSHpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:45:22 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40095 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSHpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:45:22 -0500
Received: by mail-qt1-f194.google.com with SMTP id j36so22092121qta.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 23:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=83zkhls34LKhR/sV0XpJZp242lbQBv8At8MLdvC6g/w=;
        b=bBK16VA8uXAkhSMPxH9SnCW8evQPg5MYe40Ma66W5zMfPKJECSf+RxLQZ/f87io6Sz
         dS8GW5IydsnSvEQwLsBGkYYx9z1t4gpxeBV35ypI2oW5jqJzXOpxLCXp9mOawGeOsfQZ
         /rVEvd4TJm+dKieHi4PtW8G0TMnFOXZtQAG0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83zkhls34LKhR/sV0XpJZp242lbQBv8At8MLdvC6g/w=;
        b=sl0Gl7CYNXqOWHflCL0QGnq8pAVNVY6El+LEuZmb/1Ysk/0+fzRzp43FdYYAsODJRS
         QW4Zg2RF3Iyt6zW+C7bYx4k/9rqz4P5J0RIlwiVQuJ/W2yj5VJ+NxvrgYpEtkjuGSqjy
         5eeEG2eyVbF4/ReWII/SrnZj5a2yQGsxsPgOg2XYuctMDNrYpFAEqaDNoPE3L4hgFbBH
         Kmq46F1+AO8I/r2wPl4I2sEJAERm3m0P8EFslTvuJFgKWlNhwNq1PD4ZSpIOAbXM2+AZ
         YLOYoajJAZwZKdMHMk+Rf2nyWGvFN/mqqUkqe93801tN60N4NpfCyLcYcVk/0JKTMfCy
         pJvw==
X-Gm-Message-State: AHQUAubkT/QW37ZIPQ6GnuFKlXKTcFvEziWuoYStkE3WsFmAd23+xlm8
        SxMUzXWAEhc+8EMG0c9i2OIyS0BPhAFXsWcaEtjdJw==
X-Google-Smtp-Source: AHgI3IbhUkIE8jXOrnZJ8mXE8sF1ZTqJVqX5B6Vuv+mWKrJAj3MptxcPJYSJ4N/ttW2X/E3N+TX+X3ySdEKiRdbIIxQ=
X-Received: by 2002:aed:253a:: with SMTP id v55mr22027441qtc.339.1550562321007;
 Mon, 18 Feb 2019 23:45:21 -0800 (PST)
MIME-Version: 1.0
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com> <1550210558-30516-6-git-send-email-erin.lo@mediatek.com>
In-Reply-To: <1550210558-30516-6-git-send-email-erin.lo@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 19 Feb 2019 15:45:10 +0800
Message-ID: <CANMq1KDzYSJSKXZJd=xuwP+uFrDY-jGO1Yt2koH7uD5hpJmjJw@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] arm64: dts: mt8183: add pintcrl file
To:     Erin Lo <erin.lo@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cheng Mars <mars.cheng@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-clk@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 2:07 PM Erin Lo <erin.lo@mediatek.com> wrote:
> Subject: [PATCH v7 5/6] arm64: dts: mt8183: add pintcrl file

minor spelling mistake in the commit title: pinctrl

>
> This patch adds pinctrl file for mt8183.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
