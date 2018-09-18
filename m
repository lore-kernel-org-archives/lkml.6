Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCC7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E837E2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVEYA85b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E837E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbeISBSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:18:48 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51966 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeISBSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:18:47 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so5054814itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/H8qBgtT035gSAsyyDJ8PgFoseo6V4cXU/JwEevFZf4=;
        b=DVEYA85b9L6+S/OX4Q5rrdB5f3HzhB4QdQkS7De6doBdH/UPva5iGYUbktsftOo9bI
         QBSo9exava3k81kVYd6scSYJFiFWbxulm2+t1u0tJNPBHUeEXHplblJROu1B1Hkjn0XJ
         E1CTc6PHvx+YiV8t16tZINL2p9M/rKK18PNCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/H8qBgtT035gSAsyyDJ8PgFoseo6V4cXU/JwEevFZf4=;
        b=at+bdqoajzVmZHE3CUat8WULlMNlUbu4Q4uqS3ZRi8XieWy40/vGCpNIBc7q9yIviy
         QKHXsiCE/4LbJc4xX11KZ2yWtZnvFtBsSDtxMQ8s+UvUMGHeQF0sQ0/4n14iInvrnH9T
         c2YnJ1fNJEcJk+zAFtq04clSxeSTupJDyh9w6hZCEEtMesjnf2GVN0FGS6RfLkKwUY7r
         2IFX/InaU2zTnATLJvd+CfdMq420UNF8RrDaRHgKTe3RZQIId2lWkBPHfbjDMcZUb9a8
         eMWtSQZJXgPITENheAI+6rt8iRDmbFplKYcxPNqpg+7SO51h4w2yygfMFpCQ9Ju7Hph2
         oXjw==
X-Gm-Message-State: APzg51BpCHUlu2iJ/IXrX5QsJWHyRhaVKNNdHlX1vUwAgpF3a2PDEtx9
        L+HA7/U9x8g/587NGtu6Zn8JtNu1skmm/R8qDbzy7w==
X-Google-Smtp-Source: ANB0VdayDdPOmOvTxTMYFtEV5PlMe6yTKoJmQjw74X2slE5bmEI4JOOFYMbiIiv4RAnBhN26neDTGwryzB54SpqTfD0=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr29061650jab.87.1537299882235;
 Tue, 18 Sep 2018 12:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <8afc61bff2a4146731e5696f440c0eeaaf0ea341.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <8afc61bff2a4146731e5696f440c0eeaaf0ea341.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:44:29 -0700
Message-ID: <CACRpkdaLx_gxGMqumbRKVQA5asB0w+WA5nPgETiq6xQ=QzYJig@mail.gmail.com>
Subject: Re: [PATCH v2 04/22] pinctrl: mediatek: extend struct mtk_pin_desc to pinctrl-mtk-common-v2.c
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
> This patch introduces a data structure mtk_pin_desc, which is used to
> provide information per pin characteristic such as driving current,
> eint number and a driving index, that is used to lookup table describing
> the details about the groups of driving current by which the pin is able
> to adjust the driving strength so that the driver could get the
> appropriate driving group when calls .pin_config_get()/set().
>
> Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
