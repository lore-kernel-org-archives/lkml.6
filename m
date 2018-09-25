Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F176C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A0E2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVsKI7sv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A0E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeIYTOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:14:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35500 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeIYTOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:14:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so11225504pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 06:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q6saL1YvF4GwIsHN4Hh+6nMHaJV3TiBF7vUy3veQNps=;
        b=kVsKI7svweVEbH291G2kFgZrUfE1m+XH2At7/6o57RRa6C4cOGPhILjuvShsBVxzJn
         SeHdw52VXKmzWmBL+Qj1tVUqpbSq44PgXbP+dlrDA/6S1SSPKqPxJRTDz8G5TbCmuAz8
         iY8Src46REftBtMf/GkYIu/jHBFfUFYhxvelQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q6saL1YvF4GwIsHN4Hh+6nMHaJV3TiBF7vUy3veQNps=;
        b=szHntjrb/zbOEpxHfiLzJo7X/zLGKCNzHLzcgaVOAOAubsGOrFo03VdLA4qa+z75Um
         P5jqyE7wTtIT5gkJyTnL8If3nF8VfdCG7Hgnm/XtOYwj3vg71ZqrAicQWIXAa5d9XG28
         858hdEvVcmLGLUW6+WgvgHoMBVQFFjqAQj8+kmUOpXHextEAbd1eBSQL4rX+HLyJ5+as
         1IzELfxNrUNAmw8KU9ZVRuYk7qzKLPG9QiYaXismjLSE40uSRx9bNpYc5sXhgHj1WHCi
         VCbrVPq+XGZMZuYX03/cCPkXIrWBvKOHLLwhEUSphpic5wfzBsSM/8AQqDsk1Eu4c7/i
         wjjg==
X-Gm-Message-State: ABuFfojKDXIatQk72/QmWx68u4GwsFnPHHfDvR4HieuxGN4m/Yrqxbs4
        Y50U6Ew7IiLCKN3HmbPxoSKi
X-Google-Smtp-Source: ACcGV60P4vEcS85TLWDwapynvSiT9N0oYXDnp3nxWjDWuejqEQr/xUsDqrRzoz+/eBDlDDjc5j6trA==
X-Received: by 2002:a62:5047:: with SMTP id e68-v6mr1044764pfb.157.1537880827004;
        Tue, 25 Sep 2018 06:07:07 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:902:6e37:d199:be26:17df:65f4])
        by smtp.gmail.com with ESMTPSA id 89-v6sm2748238pfk.134.2018.09.25.06.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 06:07:06 -0700 (PDT)
Date:   Tue, 25 Sep 2018 06:07:00 -0700
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Saber Rezvani <irsaber@gmail.com>
Subject: Re: [PATCH v2 00/22] Unify MediaTek pinctrl in preparation for
 MT8183 and MT6765
Message-ID: <20180925130700.GA4945@Mani-XPS-13-9360>
References: <cover.1536404280.git.sean.wang@mediatek.com>
 <CACRpkdZtVBjYGs5C7-HWEyX7f7pnCqvnRYBH=fFmLKhN4FGymA@mail.gmail.com>
 <1537325650.572.9.camel@mtkswgap22>
 <20180919043722.GA14181@Mani-XPS-13-9360>
 <1537503761.9654.17.camel@mtkswgap22>
 <9f0a8868-a06e-d378-1008-df758b898fbe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f0a8868-a06e-d378-1008-df758b898fbe@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:48:09PM +0200, Matthias Brugger wrote:
> 
> 
> On 21/09/2018 06:22, Sean Wang wrote:
> > On Tue, 2018-09-18 at 21:37 -0700, Manivannan Sadhasivam wrote:
> >> On Wed, Sep 19, 2018 at 10:54:10AM +0800, Sean Wang wrote:
> >>> On Tue, 2018-09-18 at 15:07 -0700, Linus Walleij wrote:
> >>>> On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:
> >>>>
> >>>>> v2 and changes since v1:
> >>>>
> >>>> I had trouble applying the last patches in the series so I applied
> >>>> all on an immutable branch (ib-mtk) then merged that into devel
> >>>> and added a patch on top to fix up some GPIO includes (just sent).
> >>>>
> >>>> Please check the result!
> >>>>
> >>>
> >>> Sure, I'll take a look and and test on the devel branch.
> >>>
> >>> On the top, I'll add a fix for the issue recently reported by kbuild
> >>> test robot about implicit declaration and a new MT6765 driver based
> >>> on the series.
> >>>
> >>
> >> Hi Sean,
> >>
> >> Do you have any plans to add support for MT6797?
> >>
> > 
> > I personally have no the plan to add support to MT6797 because I have no
> > the device, but as I knew some of people in mediatek have interest to
> > add them by volunteers and thus there is no clear schedule. Eventually,
> > if they're really done, they would be still based on vendor binding not
> > by generic binding.
> > 
> 
> CCing Saber as he is working on the pinctrl for this device. Actually he as some
> questions regarding the register layout.
> 
> Sean maybe you can bring him in contact with someone inside Mediatek who could
> help him :)
>

FYI. I started working on MT6797 pinctrl support but never got time to
finish it. You can find my initial work below. Eventhough it is based on
the Mediatek SDK it should be fine IMO.

It would be great if someone (Saber) can took and finish it. The hard
bit for me was lack of proper documentation :(

https://git.linaro.org/people/manivannan.sadhasivam/96b-common.git/log/?h=mt6797

Thanks,
Mani

> Regards.
> Matthias
