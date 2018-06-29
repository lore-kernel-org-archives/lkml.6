Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730C5C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2740E27ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PhOg97PR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2740E27ECF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755417AbeF2MTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:19:50 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34608 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755318AbeF2MTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:19:47 -0400
Received: by mail-io0-f194.google.com with SMTP id e15-v6so8283861iog.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UgOaALOJ9DqY2Q5vSGR0Vlu1QXzJ0yCa8ve2G93ZTwI=;
        b=PhOg97PR8PlkkNLU2kwPHoPKbU5shtGMnKeswqvfYV5RXcBfICncNjDqNJRTBOkaGJ
         U/XpykN/wp4ZGPXcBTjpr3lz3cnkXCluUMBrn+vOOwg6bKEzKDVztsm6l8UGVIqZo4Ov
         1wzlETIfU4L3z9HBA1mdGNu76MvgVhnbF1jzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgOaALOJ9DqY2Q5vSGR0Vlu1QXzJ0yCa8ve2G93ZTwI=;
        b=oLowG6+YnE9yhVA6XXe7iVeDBN2/SEqwywHE3XbJ5XVkkr3ZXGPxrp6vj6cA5B/drk
         n3PWTBeWdkLTbnRij2X4yq+lva7hZoIQBUKy2fP1Wgu7/ShHW8bqX9nvNYSXjC+Mv0VO
         I8WEsL09Mkrv2uHhFyhiDOPrBUmTSl0FcBjuJRerOQBQ3YOyHRz/0UZjIB81pcXgwVKL
         eX+AMYm4Fy/DkrNzaCzSI48LgnzMov48N6/2c/kQST+EtnaT4zrXkT86Y2UcTogDN3rc
         UUdXhNL8n/kqEnC+imUPya909vLZ4r7U4UMTfo1uFQaJEAe4WLHtsSihSa1ZtLZhWXbF
         H2xw==
X-Gm-Message-State: APt69E3EnPzsg45itZvAnHG7uq1xYZGq5KdJjnkc/7O310QTA+Npn6Ju
        Z9BbYV7x1Pm8sEIfrSgC2AkAAA1rP3aGkQ32KNYsIA==
X-Google-Smtp-Source: AAOMgpeW2ML+zpnolK48O/nvZsm1p7FX5SHbIzn4TQng20YrE2RdHWD5GFWBh5drUE+UEnnU3CSMAm6xkdKABWDN9SY=
X-Received: by 2002:a6b:4a15:: with SMTP id w21-v6mr11068827iob.277.1530274787308;
 Fri, 29 Jun 2018 05:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
 <3b1fa378e0a83a5f39497fe8efaf4c992507ed5d.1529639050.git.sean.wang@mediatek.com>
In-Reply-To: <3b1fa378e0a83a5f39497fe8efaf4c992507ed5d.1529639050.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 14:19:36 +0200
Message-ID: <CACRpkdaM2ZK-rF1_DKyZLnmbxCp0i-Myvke6HSVeGymayhJ4qg@mail.gmail.com>
Subject: Re: [PATCH 3/7] pinctrl: mt7622: fix that pinctrl_claim_hogs cannot work
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 5:49 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> To allow claiming hogs by pinctrl, we cannot enable pinctrl until all
> groups and functions are being added done. Also, it's necessary that
> the corresponding gpiochip is being added when the pinctrl device is
> enabled.
>
> Cc: stable@vger.kernel.org
> Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied for fixes.

Yours,
Linus Walleij
