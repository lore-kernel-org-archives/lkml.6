Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6422C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73618240B6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kldAhHNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73618240B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbeGFDRR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 23:17:17 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33370 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753852AbeGFDRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 23:17:15 -0400
Received: by mail-yw0-f193.google.com with SMTP id c135-v6so3709906ywa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 20:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mX+BIw9Fx922Jq3+E1cVggKFjzQfhWvVPNbjDy0L/uc=;
        b=kldAhHNqBvsNUn3ZtlllbFyyFbJNDysPNp3q9h/qYoKBRXHf/8I+O7h44MwMEPKTwa
         2wbpKGA0ALdq5TAx2NPifZplZrecadhU/qmQMla9APYI5UHikCCVTMOTTQh0M21E1gM9
         rt8SXGoNhEGn2MrtyGlliEnMAxDVb49/f1tNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mX+BIw9Fx922Jq3+E1cVggKFjzQfhWvVPNbjDy0L/uc=;
        b=o2b1+3Q6UKoIbtF9VMJzFAmscs6BZqGzlR+L1Ac5YQQUhGz4aMXtHwU5ImBfvblYao
         VKegmP475VVHnpT2MMukExVvEJOdOYE1xiUK0CeVN7Y1KcRVlkXqa7FF27IG4WAGUoBo
         FDtloF1ohdg1WeBkn9SjQiOSpahgdn2JLU60oqurWXFPpnwIClA/0Rbj8xRtk372IBum
         +hzNT501nSUsfg+q/mrKzfn3QHdiF4oQjNXmnfmW+1QBmfJGUU6+G33xzwR6xzA35nRS
         wfIBBBvkluG2tQxNz118xQiXzPZjDF05yQExLILHZVTxfXOX1/vT9IjPULfQ7DsEovJf
         0IAw==
X-Gm-Message-State: APt69E1DNgfUTi0qBIZqcJ1JOd36jdf5bckq15M5N8irUoTffpU3BpLR
        vFRWn1GUE8WBP+sKW2V2MWBl+12v87qXZlt/sdgLYQ==
X-Google-Smtp-Source: AAOMgpfsPQBgelvSUUdlbAOZg0GQyt4YfUX7pUl2NrkcxPLMB9tBgkH0nqmzLVAiHkNkhQSCsU4mWLvduRdd/Dz6PMM=
X-Received: by 2002:a0d:c601:: with SMTP id i1-v6mr4057634ywd.495.1530847034654;
 Thu, 05 Jul 2018 20:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180622032416.20133-1-guodong.xu@linaro.org> <20180622032416.20133-2-guodong.xu@linaro.org>
 <20180703185442.GA18008@rob-hp-laptop> <CAFGCpxyx1fqo0ZmthumQbHVJZTZ=mpX7HGg_V8oowmKRfb46VA@mail.gmail.com>
In-Reply-To: <CAFGCpxyx1fqo0ZmthumQbHVJZTZ=mpX7HGg_V8oowmKRfb46VA@mail.gmail.com>
From:   Guodong Xu <guodong.xu@linaro.org>
Date:   Fri, 6 Jul 2018 11:17:03 +0800
Message-ID: <CAFGCpxwEi-uG=K_KCRA2hmwmN=BEdU2jjTae1=jnugb04VEG7g@mail.gmail.com>
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

On Wed, Jul 4, 2018 at 9:14 AM Guodong Xu <guodong.xu@linaro.org> wrote:
>
> On Wed, Jul 4, 2018 at 2:54 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Jun 22, 2018 at 11:24:14AM +0800, Guodong Xu wrote:
> > > From: Li Yu <liyu65@hisilicon.com>
> > >
> > > Add optional property dma_min_chan for k3dma.
> > >
> > > Signed-off-by: Li Yu <liyu65@hisilicon.com>
> > > ---
> > >  Documentation/devicetree/bindings/dma/k3dma.txt | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/t b/Documentation/devicetree/bindings/dma/k3dma.txt
> > > index 4945aeac4dc4..2fa1370c3173 100644
> > > --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> > > +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> > > @@ -12,6 +12,11 @@ Required properties:
> > >               have specific request line
> > >  - clocks: clock required
> > >
> > > +Optional properties:
> > > +- dma_min_chan: the minimum number of DMA channel which begin to use
> > > +             the default value is 0, but in some platform is
> > > +             configured 1, like hi3660 platform
> >
> > Can't this be implied by the compatible?
> >
>
> No. "hisilicon,k3-dma-1.0" can work with series of hisilicon kirin
> SoC. And each has different reservation of channels for on-chip
> coprocessors.
>
> > If not, needs vendor prefix and don't use '_' in property names.
> >
>
> Sure, thanks. Will change that when design new property. As Vinod
> suggested, it makes sense to change this to a mask.
>

After checking with Kirin SoC design team, I prefer to stay with
minimum channel number instead of mask. So, I will change this
property to:

hisilicon,dma-min-chan

-Guodong



>
> -Guodong
>
> > Rob
