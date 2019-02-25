Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E555CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01C2217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hith3tE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfBZAC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:02:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46770 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfBZAC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:02:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id g12so8236238lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Drmc1vVJjOc9vytsMe0X64Yz8M+v4yfqHSmOLxaAl6E=;
        b=hith3tE+pVyUT59KL4PjCV27zF09x4kcF6qylISpwq66D8Kc+aKNi0+zqvbEc4Bd9r
         xgRjkYIhrW+uhqBmDkcLU932ib1NLnFD/S5GvRE6lNJ5Yn038rMPznmpT4m0I+I+R+Fl
         Esy/BhEpFT41xB4o8WoUcgHzlYmGkz8s627/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Drmc1vVJjOc9vytsMe0X64Yz8M+v4yfqHSmOLxaAl6E=;
        b=ZOCxtl5F7uVvdxoj8MPYsG+EOEuZXsAD0GO5SesYwGaVBCHo4IsvKgaTPKSnmxBtUd
         fQlOO7GkhtIhAhZ9qa+fuvOntQxD3sK9gurl3xoGtj/WkL9nCtJCZpDCts2pgMKivjGQ
         bqdU7nDbzcr7GruHKL2np5iDEqkwRAed12Til2cs5ii3+vjqI8SeEFKn1CPKlxJ2A5ZH
         HFxN8psyfL30UmfiNGmCAQOpUfsU9yykAu7hUWUCsFpbqq7x/jCAIYJSVCd/t8YnA+4C
         XwrKqHqFajhl3HVB3ld8MW9uddxTxcF3zJJpfAK7aF+y0sT/Hr2OKWzifm4bwu+R8s4u
         K3Jg==
X-Gm-Message-State: AHQUAuby5rXA8YlCf3gi6D2Kz58ZJvsJhkqasDrCNNjUok9ZVH2Q+s1d
        +ddSpBDjWt/L9g/b65rmfDrb9yiRXyo=
X-Google-Smtp-Source: AHgI3Ia1L9PHk4UwZAc6c1s06pzdrvZ1X6dpxpvZI2BmZ0LUDGbBeabDQppTSxH6iV2x5mwWRbjl2g==
X-Received: by 2002:ac2:5603:: with SMTP id v3mr2209632lfd.145.1551139375800;
        Mon, 25 Feb 2019 16:02:55 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v15sm2745173lfe.69.2019.02.25.16.02.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:02:55 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id j19so9111687ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:02:55 -0800 (PST)
X-Received: by 2002:a2e:93cf:: with SMTP id p15mr6570115ljh.184.1551139006617;
 Mon, 25 Feb 2019 15:56:46 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-11-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-11-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 25 Feb 2019 15:56:10 -0800
X-Gmail-Original-Message-ID: <CAE=gft4_D=vtM_cbrQGKz8XwHUF_JR3A7uoJ93OsiLBmvW9L-Q@mail.gmail.com>
Message-ID: <CAE=gft4_D=vtM_cbrQGKz8XwHUF_JR3A7uoJ93OsiLBmvW9L-Q@mail.gmail.com>
Subject: Re: [PATCH 10/13] memory: mtk-smi: Get rid of mtk_smi_larb_get/put
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 8:53 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> After adding device_link between the iommu consumer and smi-larb,
> the pm_runtime_get(_sync) of smi-larb and smi-common will be called
> automatically. we can get rid of mtk_smi_larb_get/put.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

It's possible that there's so little left in mediatek/smi.h that it
could be deleted entirely and its last remaining bits absorbed into
other locations. But maybe it's nice to keep those last little bits
used by mtk-smi.c away from the iommu definitions. So it seems fine
as-is to me.

Reviewed-by: Evan Green <evgreen@chromium.org>
