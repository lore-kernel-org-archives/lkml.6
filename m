Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2B0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B4421738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SWzMxd2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfBSXjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:39:39 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38390 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbfBSXjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:39:37 -0500
Received: by mail-lf1-f67.google.com with SMTP id n15so16155146lfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxFGa80PRFQNZ0iIIPGTuF/1GgUnWcFVVtlV5AVJGzY=;
        b=SWzMxd2s312nAdp04588KTgH4jh5miGItESLcy+KlwQ6BBIsp74P0x1nT4HFEqqasf
         8PyOPXfFCmnVz1F7xxwTFyoNLJZrv+rHme+9L+j+E2hFKyk5QRsuvKzXR8crLl1bH9tq
         y0hReo2aYyBvdeVzLwLwelVuWuDTjd46760jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxFGa80PRFQNZ0iIIPGTuF/1GgUnWcFVVtlV5AVJGzY=;
        b=jV8lRzuSPb6ZnlcOZdR5zYcK+hwnGaci40AP8TL2ZAmdtygEfTD79Zp+L4pvj3zGr3
         wNyKGSfD/SwNw3BErMWfH5sTy86QED8iFitZaCl4XXbsvqQM6c6ZNBAAtTfuH6YZPVhV
         j59zf3YVylNxv18lIac76C8wklG50aGz+PI7e46aF2TsgbvgraL6VvjYt/TjZTuOvrM8
         uThhbw80DkmNOB3tpA1SS4NNlvP4lRv/XgNFzJCBhaxUsvy2roImwR2UW75WMuV1IPvA
         C2OS0+UuPEi+vjzIkNllMAy1cc5RTxc2sfLXiY6bI6HsABrAWD9Ru0udoqIHTzdckEmN
         bVEQ==
X-Gm-Message-State: AHQUAuYqIJXNbmX2ROPwSHvzxVLS4WC7x1nuOBFisGAyODYDrGfpreJy
        X0wXBbw3Z5Ojpy7a+NbcZpQta5tinps=
X-Google-Smtp-Source: AHgI3IY0ge7oERlXwPMQ4gUPwlpHOB3RxzTTu4g1tkpZ6DZ+S8rzv+F2INK7rC/JsARHWG5BDV/gcg==
X-Received: by 2002:a19:e347:: with SMTP id c7mr9089403lfk.137.1550619575181;
        Tue, 19 Feb 2019 15:39:35 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id a3-v6sm4667172ljd.20.2019.02.19.15.39.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 15:39:35 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id f24-v6so19164845ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:39:35 -0800 (PST)
X-Received: by 2002:a2e:3a10:: with SMTP id h16-v6mr913549lja.184.1550619160820;
 Tue, 19 Feb 2019 15:32:40 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com> <1550394300-17420-18-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-18-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 19 Feb 2019 15:32:04 -0800
X-Gmail-Original-Message-ID: <CAE=gft5uXTZJms62_M7=14E7sSNepyLt9CL1KbfD163DsxHHFA@mail.gmail.com>
Message-ID: <CAE=gft5uXTZJms62_M7=14E7sSNepyLt9CL1KbfD163DsxHHFA@mail.gmail.com>
Subject: Re: [PATCH v6 17/22] memory: mtk-smi: Get rid of need_larbid
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
> The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> It's no need to parse it again in SMI driver. Only clean some codes.
> This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> and mt8183.
>
> After this patch, the "mediatek,larb-id" only be needed for mt2712
> which have 2 M4Us. In the other SoCs, we can get the larb-id from M4U
> in which the larbs in the "mediatek,larbs" always are ordered.
>
> Correspondingly, the larb_nr in the "struct mtk_smi_iommu" could also
> be deleted.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Thanks for the cleanup.

Reviewed-by: Evan Green <evgreen@chromium.org>
