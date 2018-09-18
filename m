Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D532146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBpqO+Nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D532146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbeISBbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:31:07 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52869 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbeISBbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:31:06 -0400
Received: by mail-it0-f68.google.com with SMTP id h3-v6so5083756ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MmDLZJU+og8oY+kReLl5bOixoOX55wnLybK/AmCVRMA=;
        b=eBpqO+NmdPCOgvcs3qs1491nfWepbfHVNGWGNVlOguQkbVpux09S/6UggDsVTuPZWf
         ohiopDs1CUx0UkSmct8EMU8ixPZMyo6J5jcu8Jo2WDJLzax9y7SWSMN6KZ3d60qTAtdc
         ZJi8hfbDgao+xOJXQsVp1Jiz4UJze7Qj4Azao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MmDLZJU+og8oY+kReLl5bOixoOX55wnLybK/AmCVRMA=;
        b=Xv10WsWzvjjKnNPKyhcLsE6Q/LUQHiVaSGL1X+c1tcH4fsmVD5+mvDv/FbzuFHsU+U
         4npW95TkgE9eUhQd/hd+U48nTvvKthjZZTJn2KmbuF9DgQObBNywdHDFWrxGC7IYEPIP
         TxqIwu7101/BNNjiKILmVHyzF9j2hp7oTruaFPpaFN0J1VeRsjho97sAsXB81rxymg/w
         7m6rgSiqEArBq6nxpj2kvSNN7j6UCcoayf3KYKsT1hylJZW38DcmtxulG/BTiAQ7Brfp
         xLrXym/48OYmvw0iCdi0s5owH4JVxe40SZDD+ToJeSJ5sinynOyn9bl6+jJXE3hPAE8N
         FzuQ==
X-Gm-Message-State: APzg51A8Uc2XpRfZwoyubU7GavoFpxHsfXafp9VtWsdneBNVIryGsZus
        7EgOoCZZRS9e7ODg56bnBB1OFhwpyRlYg7TbjQAhbg==
X-Google-Smtp-Source: ANB0VdYpenMvi0EgJ4LJs3RKW4QZUiaFcF4cbNIwA47UPuJM3gd44v/7VG425iGw7bSb2O7CR8qmyh4uP9y4f376ohw=
X-Received: by 2002:a24:7605:: with SMTP id z5-v6mr6782129itb.62.1537300618362;
 Tue, 18 Sep 2018 12:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <8c4a741e7ed695d85844a1a550b956d767661b44.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <8c4a741e7ed695d85844a1a550b956d767661b44.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:56:45 -0700
Message-ID: <CACRpkdZbXDv2um0jbGWu8OY38sdJg_1ApqDQcj1GXJ5P_E-tuQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/22] pinctrl: mediatek: add multiple register bases
 support to pinctrl-mtk-common-v2.c
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Certain SoC own multiple register base for accessing each pin groups,
> it's easy to be done with extend struct mtk_pin_field_calc to support
> the kind of SoC such as MT8183.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
