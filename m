Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6CDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5042146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FI0Pv/eX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfAKJhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:37:13 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37265 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfAKJhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:37:13 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so10356297lfj.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOlaGQV0JBDL7qF7LuPfPIwKlwRWVL8OVWL2jG4nkFY=;
        b=FI0Pv/eXlz3E4G4JoRXF9W0nAXnHP4L++1CCQChmTJhkbfeCA420Tssj7cli2AKOsA
         9vsexmXB4qNrtXvAVKe7+L0LnTuAndGvw4miRXz4TVsd49T7sf3mKLA0gLBvxx8qApFB
         hAHFNZGTfETpUvk9imsxl1QirpXvE9tKa/mwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOlaGQV0JBDL7qF7LuPfPIwKlwRWVL8OVWL2jG4nkFY=;
        b=t146hBwph1sup/R+pPisJIzPcusx4C/hVkqgR/B2K4//t2A5+ccDIcjRkERf33xf8K
         XpF47N9XncAVpW3r4ftx5hzS70ynQjRWiNHEEAXM75wTUnd5h44uGxWvGqU5fuABhQdZ
         8wxJIUlJEWykO92a701soRaRrkTur2sYOsaqTRQy5+13FJ4W6fgIMe64/3eRRSSogqpQ
         cZhOk68b8eAG39GcbknfK9p9bNLn548h6/8ZE2ulVpZ1SvpHDG151HyaUrgSBj2ARWXs
         di8Fodor+9Fze3R8Hbu6eGmxd2I6tBB3J74lcbiZhDezR7JZnXJeAwFJ97qWUBJ8CmEE
         QSJw==
X-Gm-Message-State: AJcUuke0Lxjftpa/FP9/+wy2aeRYltihdtV1crG5MbeVoqf7nooYKp0K
        IrCYBQU0rOK7Yv/rFIbb3CckPZE0jrtAkGIZGn7Ong==
X-Google-Smtp-Source: ALg8bN5aRuZ4QhsI0xgKGM9WL7zatk5XRiC+0/gKThyuFT4+HhxRwmWYTcbKOcaCPVgtoJqZdb5M05JIrLYr4gwmYHg=
X-Received: by 2002:a19:c801:: with SMTP id y1mr7300597lff.53.1547199430999;
 Fri, 11 Jan 2019 01:37:10 -0800 (PST)
MIME-Version: 1.0
References: <1546419614-31207-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1546419614-31207-1-git-send-email-chuanjia.liu@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 10:36:59 +0100
Message-ID: <CACRpkda_-C2aqGWqAbGJK9RRUF9zn=nqJq71tSP-j6pyjgb2rg@mail.gmail.com>
Subject: Re: [PATCH v4] pinctrl: mediatek: add EINT support to virtual GPIOs
To:     chuanjia.liu@mediatek.com, Sean Wang <sean.wang@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        youlin.pei@mediatek.com, huang eddie <eddie.huang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        hailong.fan@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 10:00 AM <chuanjia.liu@mediatek.com> wrote:

> From: "chuanjia.liu" <Chuanjia.Liu@mediatek.com>
>
> Virtual gpio only used inside SOC and not being exported to outside SOC.
> Some modules use virtual gpio as eint and doesn't need SMT.
> So this patch add EINT support to virtual GPIOs.
>
> Signed-off-by: chuanjia.liu <Chuanjia.Liu@mediatek.com>
> ---
> change note:
> v4: modify description and comments

Just waiting for an ACK from Sean before I apply this.

Yours,
Linus Walleij
