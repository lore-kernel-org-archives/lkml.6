Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E91BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6770420851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="grjU3UJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6770420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbeKTAae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:30:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38057 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbeKTAad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:30:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so13437737lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 06:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rasn0S8VGh4K78J8uRK50vRRl3n7OEbD28CMvS8nUh8=;
        b=grjU3UJyYlJ33RVpe/aVtkTRiaAuwHIcQjnDtoQPx5903GaeQ2tSmMAZ9rhOscPL3u
         5Kip4T+jN+XJXltFwdU0beGL8nGh5F/bdBurK8wg2UH89TjGX/oa/IFW53y6yT5ScJC1
         VAdn9j/OiQXpY548gZaksy7lFVdO4ou/reIig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rasn0S8VGh4K78J8uRK50vRRl3n7OEbD28CMvS8nUh8=;
        b=swSbHJOWKXywBogwSadhfZTtT7+33fNsIoBmXQTeM1NrI6r8cpuMhHJT5RfwFL594s
         lRFytHSGZv4RW3uPzBEBjQt/XxsNgtCZMxUON85YOMXayiLJOQSngZqe13dvr8VuElcJ
         V9L2sU0zV8V3cW/hpbmIdXvZvGYKwSp84jAeD7/7TmTSxZAh2pqlOyAIm8yKdqkg/4Zm
         qxXqjxF1A+m0s1lSqPN8xdTJb+G+d/wtfdU8y8rXW34Vf0+Kj7BVN7c2zuhpbZDVn6o7
         z4jOQgMvW5CINpj9rLYZCZ1fCEcQBTXiXMX/SqJf+oIlgv3KvqPgqpa++BiXPSuip9ee
         z2FA==
X-Gm-Message-State: AA+aEWaPvzXb27M2b9m+90E9tQ0v+cBD/phwWMmKuKA1cbKhdBNifV3j
        UGDbI2EaWpnqIuGZXl6pjUuepmgT41QoiRrhP87e9g==
X-Google-Smtp-Source: AFSGD/XDA5ulc4maakKntosr8qGBfgIsSgEUS1MDnvzpvG4AK8WW7vGPSI9uUd/1099JIEq+bxzFKu+PTs3+lfmBax4=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr7057737ljk.4.1542636408423;
 Mon, 19 Nov 2018 06:06:48 -0800 (PST)
MIME-Version: 1.0
References: <5d63d26156d2972b7e9f55c9743b66d7c6dac2ec.1541986223.git.ryder.lee@mediatek.com>
In-Reply-To: <5d63d26156d2972b7e9f55c9743b66d7c6dac2ec.1541986223.git.ryder.lee@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 15:06:36 +0100
Message-ID: <CACRpkdZQwqnJNTBojwrZ9=bRYonrk21rbbOgzR7sTiCEsHS+WQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] pinctrl: mediatek: add pinctrl support for MT7629 SoC
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     sean.wang@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        weijie.gao@mediatek.com, cheng-hao.luo@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 2:45 AM Ryder Lee <ryder.lee@mediatek.com> wrote:

> This adds MT7629 pinctrl driver based on MediaTek pinctrl-moore core.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Patch applied with Sean's ACK.

Yours,
Linus Walleij
