Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457ABC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BB824709
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYrQgp10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BB824709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932424AbeGDBOj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 21:14:39 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:46952 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbeGDBOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 21:14:37 -0400
Received: by mail-yw0-f193.google.com with SMTP id e23-v6so854743ywe.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 18:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vv+yFnQADIUzWsLkt0mvN727IfZfZMBhU3jp8O47KaI=;
        b=TYrQgp10Cs/VzqSA39aq/BeE57AjNALWDp3HAmfTDikAUSD3Og1zLXpo92jnVZonBs
         olIU/uP4nSgaY4wGqZmNX9sD83WYZj0dtetsdiztsN1zY274RL5VYsc5EEJDLi/B8LXp
         BUCuKZRGjYOaMoesOj8qT1m7QBMKxjpyBK+X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vv+yFnQADIUzWsLkt0mvN727IfZfZMBhU3jp8O47KaI=;
        b=jpYXcUyk7YSxcNg/Kv3IXsex/ZkZ4/GduzvNVlB71NZCdVwQ8IWdXRBth+FBEhloVG
         60/nFEHAPuaQz8A53tUXwjF6bTO8bX+DjRPnf/vOJXck3389oLOKH2dC9ABA0aSbc4xP
         /GKAeZSi+ixK3QM/o9QW2vy4deNlr+Opzewmbgy6e3AFv+egJoJ7QiOXKyjyAUY+whxB
         XHWExdQHXmZa/gu5X0HAcdZa4BNsNkP3Y0hMIiRohIi4mjv+oJqJJ4jHJthkvwqo1owN
         SoYj84mIzUquARwJhscHJ8VSXZRwYqCCuvKMdEyiywv+v/JqLTDhv+iOQoDvfeTXPjZQ
         cA2A==
X-Gm-Message-State: APt69E1eNxAdbOdSxTHGrCEe+d8j+cGpJHB6BA6pc7sHb0TR2sFDdkEP
        o/sfaGf7HahYEWux3g4WLxZV/4wHHDeoujqCpk0lag==
X-Google-Smtp-Source: AAOMgpc6VvzT9cb55DLOw1Or9DU6KlychNKQ5rCT3+lVtcgDz/Cgl8ibGrEH7QEnlReVrPHF1xnlRtsBdQJzdqfLUGo=
X-Received: by 2002:a81:22c3:: with SMTP id i186-v6mr15617503ywi.309.1530666877267;
 Tue, 03 Jul 2018 18:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180622032416.20133-1-guodong.xu@linaro.org> <20180622032416.20133-2-guodong.xu@linaro.org>
 <20180703185442.GA18008@rob-hp-laptop>
In-Reply-To: <20180703185442.GA18008@rob-hp-laptop>
From:   Guodong Xu <guodong.xu@linaro.org>
Date:   Wed, 4 Jul 2018 09:14:26 +0800
Message-ID: <CAFGCpxyx1fqo0ZmthumQbHVJZTZ=mpX7HGg_V8oowmKRfb46VA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: k3dma: add optional property dma_min_chan
To:     Rob Herring <robh@kernel.org>
Cc:     vkoul@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        dan.j.williams@intel.com, liyu65@hisilicon.com,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        "xuhongtao (A)" <xuhongtao8@hisilicon.com>,
        zhongkaihua <zhongkaihua@huawei.com>,
        Xuezhiliang <xuezhiliang@hisilicon.com>,
        "xupeng (Q)" <xupeng7@huawei.com>, sunliang10@huawei.com,
        "Fengbaopeng (kevin, Kirin Solution Dept)" 
        <fengbaopeng@hisilicon.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 2:54 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jun 22, 2018 at 11:24:14AM +0800, Guodong Xu wrote:
> > From: Li Yu <liyu65@hisilicon.com>
> >
> > Add optional property dma_min_chan for k3dma.
> >
> > Signed-off-by: Li Yu <liyu65@hisilicon.com>
> > ---
> >  Documentation/devicetree/bindings/dma/k3dma.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/t b/Documentation/devicetree/bindings/dma/k3dma.txt
> > index 4945aeac4dc4..2fa1370c3173 100644
> > --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> > @@ -12,6 +12,11 @@ Required properties:
> >               have specific request line
> >  - clocks: clock required
> >
> > +Optional properties:
> > +- dma_min_chan: the minimum number of DMA channel which begin to use
> > +             the default value is 0, but in some platform is
> > +             configured 1, like hi3660 platform
>
> Can't this be implied by the compatible?
>

No. "hisilicon,k3-dma-1.0" can work with series of hisilicon kirin
SoC. And each has different reservation of channels for on-chip
coprocessors.

> If not, needs vendor prefix and don't use '_' in property names.
>

Sure, thanks. Will change that when design new property. As Vinod
suggested, it makes sense to change this to a mask.


-Guodong

> Rob
