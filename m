Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D7BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DA22147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qt9RhMqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfBSXhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:37:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46801 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfBSXhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:37:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id v16so19106763ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Avlfot9LMftj+Z5hvyEovLVV6ww6QQJZ+gLb7fH0KpA=;
        b=Qt9RhMqo4o6locL1K2fzZy2LXcthbZYosRedyplsjLg+cgzKdPJyIiLN73x1f3V9f8
         n4qybe+oRccViti//ykwCSY/JNY+fFC1Sym31lDRuXGLgdH0nqTDhW+qao41VuY0rdZN
         niM6C6fqtTwXlD3bfrROu1YXKjdQz8jXqAvfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Avlfot9LMftj+Z5hvyEovLVV6ww6QQJZ+gLb7fH0KpA=;
        b=KtTqoedByWmxoyW0eLlVAb2FcR6VUGAcgqiJ366KqCCbVzodrG3rRObx+l8CFfTbot
         uMgYu9L/OfeJcdtzsHI6Qy8W9cX8uN9IcN3F6lKubwxGT6UIUh7PR2L/8ZN0e9UZjTXH
         hXIGc7yXIBfvL+8PnJkrk1xjNB0ixxxCwlHeCS2MOne8brCNwEVwTEJcFCk17t+fG4lu
         Gq+b3oWbLbYPJ9T3Mob3fXmhPaiqi/AQjaWFRfwFbY+r525xd0a+lwHTEhwqu21rK27+
         yt/8Yvo62jFkb6NzRM4nwyeSiicRlmUW8F6V6+bgCoOQGis/3pHytLT61QU19WNH/jPU
         alUQ==
X-Gm-Message-State: AHQUAuYtEtYJChc9TGXIJZR7egPiLF1ZMNYI3mEPI3ELWybPn1Kq1wFg
        b2PlYruULi+j27yW/Ws3FWTL7bl7qB8=
X-Google-Smtp-Source: AHgI3Ia2J4rYXgUNnQoeOrHz5rcQ8C0v9MTtYb7gb/GMLcnRumuveL/HoED3QlGfgjxuj1+8tBSSTg==
X-Received: by 2002:a2e:96c9:: with SMTP id d9mr17843223ljj.133.1550619471999;
        Tue, 19 Feb 2019 15:37:51 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id b14sm597131lji.25.2019.02.19.15.37.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 15:37:51 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id g12so6542261lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:37:51 -0800 (PST)
X-Received: by 2002:a19:ec0c:: with SMTP id b12mr19485118lfa.27.1550619118494;
 Tue, 19 Feb 2019 15:31:58 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com> <1550394300-17420-14-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-14-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 19 Feb 2019 15:31:22 -0800
X-Gmail-Original-Message-ID: <CAE=gft4_PwC03FkzHysQiX-+aGEyOxDUxpHitwc26+_4qRoK3w@mail.gmail.com>
Message-ID: <CAE=gft4_PwC03FkzHysQiX-+aGEyOxDUxpHitwc26+_4qRoK3w@mail.gmail.com>
Subject: Re: [PATCH v6 13/22] iommu/mediatek: Add mt8183 IOMMU support
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

On Sun, Feb 17, 2019 at 1:08 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> the ARM Short-descriptor like mt8173, and most of the HW registers
> are the same.
>
> Here list main differences between mt8183 and mt8173/mt2712:
> 1) mt8183 has only one M4U HW like mt8173 while mt2712 has two.
> 2) mt8183 don't have the "bclk" clock, it use the EMI clock instead.
> 3) mt8183 can support the dram over 4GB, but it doesn't call this "4GB
> mode".
> 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> the bit[33:32] in the physical address of the pgtable base, But the
> standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> we add a mask.
> 5) mt8183 HW has a GALS modules, SMI should enable "has_gals" support.
> 6) mt8183 need reset_axi like mt8173.
> 7) the larb-id in smi-common is remapped. M4U should add its larbid_remap.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
