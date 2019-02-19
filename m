Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7056C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AAD21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H579K5eZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfBSXkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:40:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45380 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729813AbfBSXkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:40:12 -0500
Received: by mail-lf1-f66.google.com with SMTP id h10so15929242lfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94SH4zc3GWblxSgsPBw9cZZKhheiEMLicrGfPJ6Mqjo=;
        b=H579K5eZ+cwh29VMDSywEbZ/LsPFLC1U9Cl8GVKk+TbufvQ+liENSxNT2OGpEhimeQ
         bElJQIXTEEnrJDdyMHvgj0CTe+Jdd1qCcKuWoWmp47tsbNB6df59kC5Xy4YjYwtgzUzv
         B2EJsxiS8IgETNTM1cutVe9lbgaXJBVVudeZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94SH4zc3GWblxSgsPBw9cZZKhheiEMLicrGfPJ6Mqjo=;
        b=awo6RFfadt75lSA0uYx8g/Z1IxcFx8JsaVZF7gWGzJLPeCbrYfLVnhmhyBRH/y7+83
         LZEf2jlmBDuoW/PDJP7EsRUDSoOIPU7fs0i9depMXqsmoMEQbyp284QboREVLPlRdUuh
         yPEEZFTLDnZMAgUHBwpjLt1WZhZRQymLfJrWQAz9oWZBirGW/dltJYhAtuw1hllh5Ljt
         KvAGlnU+PCUuzJR/z4QVGCcjvaif1UULAErOJc3j13NeKOKfst+6m3sNvdGpAjIctrnU
         ZkXW0mJXz7ikBCScYoV0lgFwR9GDD44pVVCrQx7pSxf0mNkcN7ZJ1cs50HTEZgKAwpId
         NaZQ==
X-Gm-Message-State: AHQUAuZE1Qij7iKkkJlMV9/CiNg4XdERY+XsYQ44b8h+XeAeXpjwQUln
        SyXwUorV/2Clmvg7hT1J+9pyPIKB2dw=
X-Google-Smtp-Source: AHgI3IapTJIWQi6tezSoz0mjHXDA5nSdywI1Lj8mjTL79Yr+RZZwRfmOnjysq6Hji8XTB2ZiV4LPmw==
X-Received: by 2002:ac2:43ad:: with SMTP id t13mr11128459lfl.93.1550619610627;
        Tue, 19 Feb 2019 15:40:10 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id k15sm4486019ljc.39.2019.02.19.15.40.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 15:40:10 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id s5-v6so19083642ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:40:10 -0800 (PST)
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr18507676ljb.126.1550619182560;
 Tue, 19 Feb 2019 15:33:02 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com> <1550394300-17420-21-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-21-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 19 Feb 2019 15:32:26 -0800
X-Gmail-Original-Message-ID: <CAE=gft4Y+YiAdOHEbqO-d9JAs3AqK76AQ6_3AJ9Qqn_82HYtrA@mail.gmail.com>
Message-ID: <CAE=gft4Y+YiAdOHEbqO-d9JAs3AqK76AQ6_3AJ9Qqn_82HYtrA@mail.gmail.com>
Subject: Re: [PATCH v6 20/22] iommu/mediatek: Rename enable_4GB to dram_is_4gb
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, yingjoe.chen@mediatek.com,
        youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 1:09 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> This patch only rename the variable name from enable_4GB to
> dram_is_4gb for readable.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Nice, this is clearer.

Reviewed-by: Evan Green <evgreen@chromium.org>
