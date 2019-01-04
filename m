Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D7C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1724218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhfaw26h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfADRcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:32:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37332 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfADRcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:32:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so1907075wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 09:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMtwuIOEghKVjxfWhtNx5q1cXe98/sXY0O1Q4BdCfjM=;
        b=jhfaw26hniHl7QF+M9ttRhq/dj0Pec8jgLLVPJOCVQ+dJTTTQpVOce6SI7OEBhVHgv
         gOX4g+6no19mGqKSp+gNUiZBZBzsMUFgfwMahmQ+69BFa1dn8JRhPoBo6Hkcd7WblPog
         Cp4XSD6+2Epo1skU26s2rEZEJoKsTD9/dult8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMtwuIOEghKVjxfWhtNx5q1cXe98/sXY0O1Q4BdCfjM=;
        b=rX2kdtQFCULyfURLOKhGvx+U9SV3+3kNz3CH1ov3BVZum1IOs+pP/2azKNilFzsNT2
         xW1xfgq/p9BYLpl3RfQDho/xdagau86bqVV3jDVIpuSanuyYzUYzh+O9UaJTs34KSpxg
         8FPQ3LtuBeHKAU88zBr8YEjwKC1D3ZzMLhZMcMXGZ1ktH18864RN2i1hb+kssjyQMHeM
         K8FQGXDr7rYlmUtbSH+A4C1/AIL0XvMr7wt9xxv3URjfEwgmX49/Hl1YE3qY/oQcGDxj
         Y72ypN983nbn2GozR9t7OGQ84PTDtiRw1GxpoouanETntXyIla8vugBBIESLWwSMYY0l
         yOOg==
X-Gm-Message-State: AJcUukdzCFJrO47aZ+yAIquirNW1OPeR9kJlYcynSoVJOQd2Y9S21IGP
        hdwnwQMV8HtGfyc/cYrrZPF9tcI70XXv46gW/zWLhQ==
X-Google-Smtp-Source: ALg8bN5VdMxVkLZlC+G1VPl+I1Q0qtTfqzCtc/3GQm4avYLCybRF2ye6N1W/2bZAygqJ9xAMac206vjyifn0qA0EUAU=
X-Received: by 2002:a1c:a68f:: with SMTP id p137mr382766wme.64.1546623138927;
 Fri, 04 Jan 2019 09:32:18 -0800 (PST)
MIME-Version: 1.0
References: <1545978983-124360-1-git-send-email-hutenghui@huawei.com> <20190104172405.GR13372@vkoul-mobl.Dlink>
In-Reply-To: <20190104172405.GR13372@vkoul-mobl.Dlink>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 4 Jan 2019 09:32:06 -0800
Message-ID: <CALAqxLVrK+cBNsyt62Q6gb_SXc_04-LjO02hnhG24bJ6TAXapQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] k3dma: Upgrade k3dma drever to support hisi_asp_dma hardware
To:     Vinod Koul <vkoul@kernel.org>
Cc:     h00249924 <hutenghui@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        hanxiaolong3@hisilicon.com,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Hantanglei <hantanglei@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kongfei <kongfei@hisilicon.com>,
        ninggaoyu <ninggaoyu@hisilicon.com>,
        Liyuequan <liyuequan@hisilicon.com>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        "huangli (I)" <huangli295@hisilicon.com>,
        wangyoulin <wangyoulin1@hisilicon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Qianli (A)" <cash.qianli@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 9:25 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 28-12-18, 14:36, h00249924 wrote:
> > From: Youlin Wang <wwx575822@notesmail.huawei.com>
> >
> > There is an new "hisi-pcm-asp-dma-1.0" device added in
> > "arch/arm64/boot/dts/hisilicon/hi3660.dtsi".
> > So we have to add a matching id in the driver file:
> > "{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0", }"
> >
> > And also hisi-pcm-asp dma device needs no setting to the clock.
> > So we skip this by "if" sentence on id string matching:
> > "if (strcasecmp((of_id->compatible), (k3_pdma_dt_ids[0].compatible)) == 0)"
> >
> > After above this driver will support both k3 and hisi_asp dma hardware.
> >
> > Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> > Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/dma/k3dma.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> > index fdec2b6..10eecc2 100644
> > --- a/drivers/dma/k3dma.c
> > +++ b/drivers/dma/k3dma.c
> > @@ -792,6 +792,7 @@ static int k3_dma_transfer_resume(struct dma_chan *chan)
> >
> >  static const struct of_device_id k3_pdma_dt_ids[] = {
> >       { .compatible = "hisilicon,k3-dma-1.0", },
> > +     { .compatible = "hisilicon,hisi-pcm-asp-dma-1.0", },
>
> The binding doc patch should precede this..
>
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
> > @@ -835,10 +836,12 @@ static int k3_dma_probe(struct platform_device *op)
> >                               "dma-requests", &d->dma_requests);
> >       }
> >
> > -     d->clk = devm_clk_get(&op->dev, NULL);
> > -     if (IS_ERR(d->clk)) {
> > -             dev_err(&op->dev, "no dma clk\n");
> > -             return PTR_ERR(d->clk);
> > +     if (strcasecmp((of_id->compatible), (k3_pdma_dt_ids[0].compatible)) == 0) {
> > +             d->clk = devm_clk_get(&op->dev, NULL);
>
> who provides clk in this case? how does this scale if you have another
> compatible in future for newer version of controller?

Yea, I've pushed a few times in internal review to use match_data() here.

Tanglei Han: If its ok, I've spent some time integrating these changes
with some other pending k3dma changes. So I'll rework and integrate
some of the review feedback on this and resend it so we can get this
moving a little faster.

I'll leave the i2s feedback to you, so please continue reworking and
resubmitting those, but I'll handle upstreaming the k3dma changes
(keeping you on cc of course).

thanks
-john
