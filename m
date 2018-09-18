Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7C8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C72A2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ElqzVIT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C72A2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbeISBfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:35:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38673 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbeISBfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:35:55 -0400
Received: by mail-io1-f66.google.com with SMTP id y3-v6so2625794ioc.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZkncAa/Ndz50p4Otp8oHbYvEsprak64GC/dAwVv96A=;
        b=ElqzVIT5IgypaPTdbtVqc1js/vYL/Vch/eQqlGI40/M6NfrJkLzygzylNMRoCQLJPA
         tnGOr1LeSMPuEJJlcYrmvupmW5Qifw2G/Do+u3lQRWAjcX1d5acQLDwF0OE30zNs/xCr
         bQ0NfU0m+7PQa1gxAPDO1L9LdhhVvBxThyd7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZkncAa/Ndz50p4Otp8oHbYvEsprak64GC/dAwVv96A=;
        b=UQzaVa2Rtkg7OM97Jrxuo3AHBdB5b75n+YgEikPVeQ10HSSVKviwagRKrlB3tTFTvq
         kv/8L0xdkN+vwIlWor93BEvX65/rI34zn94EWdMznNSIN1AQbWhmVHTB0HSsvZkbmb19
         v9bR98qUx45JRit8HCOcsJyT7cFYjiJv0E5PYmlGrCOOQGvgZog/TZsu0kORlnk7kfYI
         n3KOfavtupzku1wbyWotXlqDSsb+e1eYsiEFwbA9wTP3IpXumu5BBkKp/XSdDOpN7GQM
         mY8g1pRLdLPMhVqFy7LaqKEC20MoAxr4da1UXz7BI8advXgPFYzvnkyC+rJ6Z5bQSSAj
         UhfQ==
X-Gm-Message-State: APzg51CGQ5FdYHhLgWjDSImSI1tJDoTEU0lNbxurtig4+9Rw4mFzSmMt
        bdoqn5w1To0tdPn9iKnpBc/JKimY5pursTCR0Is7Pnff
X-Google-Smtp-Source: ANB0VdY6M49TaoVS366EWdS2V8aPXJEf+kI4wLMO9Jptuca5KpwPTENLZzz0LBaRzTuDZk911RjPhex5XxExvEfGsUI=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr14534063ioa.277.1537300905756;
 Tue, 18 Sep 2018 13:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <3fecbf66bd90553297ff6bc56194807ddb6b92ca.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <3fecbf66bd90553297ff6bc56194807ddb6b92ca.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 13:01:32 -0700
Message-ID: <CACRpkdbcbxrQbt=ft6MeCRL6icEdE0J6oUJdZXqzmuC1TkRrbQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/22] pinctrl: mediatek: add MT8183 pinctrl driver
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
>
> Add MT8183 pinctrl driver based on  MediaTek pinctrl-paris core.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
