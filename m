Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA020C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D1521738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LswjmVyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfBSXbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:31:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39118 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbfBSXbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:31:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id g80so19132084ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIfJtFbcTx4wLP72OsVIvirz7fZiyTk5Gcu0qV9xxjI=;
        b=LswjmVygELud/ZPIitEuENf/mMAsZ7vP52842g20Jnx0pwOQIWP9NC6bYD3aXSBY+I
         h7szZC6TYQkSc2GrjYX43WyjkPML+0lZfKp2O1YLUGzVYwZeIZoWbI//5lBjxHhjuWK4
         dIk95/qSEZXx7OA4qWWorSzuWgV0VYXbLS7lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIfJtFbcTx4wLP72OsVIvirz7fZiyTk5Gcu0qV9xxjI=;
        b=Vv57ZGUGrMS6c9jzeK/uk0tJnRJzbDi09ofjTmTcdnIqXhDRigcL/HzVkU/eiX932U
         bQRvD/b3ThBtqCbWXeKL6XwiMwkvMl7EN2CpN1xgrEmP5suexFgARJwDkbY5g4eJn8Yq
         a932hLk/TgymbWNQ4mmg8irRsQ2+L+DUTa0sUryEm0krYMErrQIYi3HqncQx4a5kIpCM
         LmW5GdxmmMt41zXoyOV9XSxdFppJ36bP/uVt2GasyRvg91FVL42gNEoX6kmHwtHT9eQC
         F65ScMrOxAIr4Naj6jXXTogc64O1BTmboVHAGY2Z33rxZ8rfakFWV3DqmwpN9RmbuM1/
         KF4w==
X-Gm-Message-State: AHQUAuaGNSMABucH2LIgLQP2EKvF5jqQiOK3Ys5wsMAy+FoArBqK5y8F
        +DKk5R+J/1DBlugZf723G1WPp71yRoI=
X-Google-Smtp-Source: AHgI3IZ1dlqOetdHtZRocsEKvfNKv306CgA+FYCPShIXYUk2fgoS3Ys1EI/zJEZs+4KZIYc7iCCoOA==
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr18694839ljk.4.1550619099333;
        Tue, 19 Feb 2019 15:31:39 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id q15sm1710095lje.89.2019.02.19.15.31.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 15:31:38 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id z20so18105204ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:31:37 -0800 (PST)
X-Received: by 2002:a2e:2c11:: with SMTP id s17mr13935662ljs.147.1550619097330;
 Tue, 19 Feb 2019 15:31:37 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com> <1550394300-17420-12-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-12-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 19 Feb 2019 15:31:01 -0800
X-Gmail-Original-Message-ID: <CAE=gft4QKi5kfK9mXs8-OLcYyZzRYOd7DrvUx8CJZH9UJGq6hw@mail.gmail.com>
Message-ID: <CAE=gft4QKi5kfK9mXs8-OLcYyZzRYOd7DrvUx8CJZH9UJGq6hw@mail.gmail.com>
Subject: Re: [PATCH v6 11/22] iommu/mediatek: Move vld_pa_rng into plat_data
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
> Both mt8173 and mt8183 don't have this vld_pa_rng(valid physical address
> range) register while mt2712 have. Move it into the plat_data.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
