Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8ADC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D192147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h4cMTBsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfBSXiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:38:17 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:38098 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbfBSXiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:38:16 -0500
Received: by mail-lj1-f175.google.com with SMTP id j19so18354190ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3HpskIZHOlSnWS6IdFryCO/r0xlCFW+NgKCY956cuE=;
        b=h4cMTBsCf3wBIE7mkGV6oYFDz0+/pP42StFGmSeLSMCqqHPwEZnuyA2CVuW+/bwsrp
         MpeaZnKFbrD9EYr9iQMGHEi3tpHLy73PXBiabsnZSjHqmEPZA2gDQgyuyq1iwvDjdv3E
         zavMKQdN2MiCp+yAMOkXeQdPXdQ8w1VfMWB48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3HpskIZHOlSnWS6IdFryCO/r0xlCFW+NgKCY956cuE=;
        b=KfhksSSdz81nab/n9V5UsAy/kcTgD0O0Kr8m65E9oeVvbjbugTnSk1cdF0L6y3Sk4t
         0Xy6g6a5XNNVOtBCfcGw6hnPO5gVbV5BBBwZ0B+n+PJBJo4bQUI32Zti19o4ih16wgKo
         x+lG5xNJ48Pj0nHWscA46n8xVJ0eRXGiv8yFqFdy9XT9UwAFPVT3dF36C8n7IU9UcEZr
         PgROvFA+FJzma9/9vItdzb3nc4aQywA74wctJ06yXhJrUsyC3tyOF5l1n8Fu4Mt/0Tnh
         yP+gVWz5yvxX52mLmWuga1d+mcY4ur/+1IYiDBZICEKCDe7Pnk8aZedUGLdTnrdYdUtZ
         QDJw==
X-Gm-Message-State: AHQUAubqAk4tQOCJK1zwJgv5FBsKn41ycG49LMTytszqhBKITkKfVkMU
        qrVbsxPl/uPd046T1NTddd7CxXZrNe0=
X-Google-Smtp-Source: AHgI3IbSiPbvwH8sKymeAFphY5IfG/gXQke36dxBQTUJmhiNk3A5N8HGak/b2M1nbRAnQ3Gz3yFv/w==
X-Received: by 2002:a2e:9a55:: with SMTP id k21mr7589589ljj.191.1550619494324;
        Tue, 19 Feb 2019 15:38:14 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 67-v6sm4714932ljc.26.2019.02.19.15.38.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 15:38:14 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id u21so16192650lfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:38:14 -0800 (PST)
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr13049011lfc.104.1550619018042;
 Tue, 19 Feb 2019 15:30:18 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com> <1550394300-17420-7-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-7-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 19 Feb 2019 15:29:41 -0800
X-Gmail-Original-Message-ID: <CAE=gft5vUoxNgYfGEQ_KVQ7OfJxXG3R_jv6nbiNdM86uVHJ4fQ@mail.gmail.com>
Message-ID: <CAE=gft5vUoxNgYfGEQ_KVQ7OfJxXG3R_jv6nbiNdM86uVHJ4fQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/22] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
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

On Sun, Feb 17, 2019 at 1:07 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek extend the arm v7s descriptor to support the dram over 4GB.
>
> In the mt2712 and mt8173, it's called "4GB mode", the physical address
> is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> bit32 is always enabled. thus, in the M4U, we always enable the bit9
> for all PTEs which means to enable bit32 of physical address.
>
> but in mt8183, M4U support the dram from 0x4000_0000 to 0x3_ffff_ffff
> which isn't remaped. We extend the PTEs: the bit9 represent bit32 of
> PA and the bit4 represent bit33 of PA. Meanwhile the iova still is
> 32bits.
>
> In order to unify code, in the "4GB mode", we add the bit32 for the
> physical address manually in our driver.
>
> Correspondingly, Adding bit32 and bit33 for the PA in the iova_to_phys
> has to been moved into v7s.
>
> Regarding whether the pagetable address could be over 4GB, the mt8183
> support it while the previous mt8173 don't. thus keep it as is.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
> Comparing the previous version, I add MTK_4GB quirk always since mtk_iommu
> has already controlled the PA itself. Helped from Evan.

Thanks for all the explanation on this one. I think I understand it
now, and it looks good to me.

Reviewed-by: Evan Green <evgreen@chromium.org>
