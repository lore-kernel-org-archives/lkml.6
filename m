Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAE5C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E428720652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9LAydVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E428720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeJWRni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:43:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34702 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJWRni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:43:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so11137272wmf.1;
        Tue, 23 Oct 2018 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UMAgX19jbo3EHVVn/bo1SiopC9dmGxljab2M3qjxMR4=;
        b=a9LAydVzV9FxrClb4o6/klrlZosRnnEnCB68LG7HL7QxE9LfTWSsN4aDNiPKeth6jA
         +3LIqva8lBtzJJixSG0CFah9hUeQoWk2dxhNrfmgAI4tqzVDVsA86gDmCutsXkF9z3lD
         PEnnLlMW5esmcpYYdbAKd+iXkL0MkVVb0cmhIEYZJymcD1SAlGttCIIosY2oao0HqtNm
         j7XQ1cxj0gpAPniIbn1LuTtBNAAo/KxG4oKM5GGLDmN8BmW8Xr3Zy8sau2NWAJDWnjp9
         HehQwI4kL44JbD/lmP4ESex0lIx1uC7BG/n4iDRmfJa1B6nOvaIMvpf0F1QxN1lZDRJb
         vAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UMAgX19jbo3EHVVn/bo1SiopC9dmGxljab2M3qjxMR4=;
        b=N8SnpEKv1Qq+FfkT75CjxaihVkYCwpHI0GfwN0mtd6AAyQTeRPGmg8wOtAJV0uiVWd
         VssdhOQeoYW+mz90HY4omLHgudwsivHp7bVz22BIvGvFxNPpvwMua3xoLnwHkcK8Ug2J
         hwKQb9EKayg85pBewc7wtRu9GMx9QCgpLmS6llft18LmR6DPkasC2jJiJovHEF0CcyYr
         cOVaA3eWAU31Zs9LbI2FarAwo/N4XL8T74qtQjj+rE1/tBAlgnPIhSLQtyyn1tp71eeu
         spG+PlkEK2vUGwZYHVpiihWxXBmwI9I1IxbE+IM5joeE75qBgFHkJBtqLGKZAWnJcprC
         ByGw==
X-Gm-Message-State: ABuFfogUANGU0fRJJtLppYWMVZTnIsDyWGXdYlZgkILBSgKUynZ69dST
        2jHsJEk6sqjsdTOBWSGeUeY=
X-Google-Smtp-Source: ACcGV60dWb4X8pDZhNebszCvFUhiI/+81koeCb1T9iL84Z9fWR3KqUWJxnFVNdc/4kkD24bQviV88Q==
X-Received: by 2002:a1c:dcc:: with SMTP id 195-v6mr19233727wmn.117.1540286463718;
        Tue, 23 Oct 2018 02:21:03 -0700 (PDT)
Received: from pi ([167.98.65.38])
        by smtp.gmail.com with ESMTPSA id 20-v6sm1391968wml.10.2018.10.23.02.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 02:21:02 -0700 (PDT)
X-Google-Original-Sender: <johan@kernel.org>
Received: from johan by pi with local (Exim 4.91)
        (envelope-from <johan@pi>)
        id 1gEsqt-0002WI-Uk; Tue, 23 Oct 2018 11:19:51 +0200
Date:   Tue, 23 Oct 2018 11:19:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Josh Wu <rainyfeeling@outlook.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 0/9] of: fix compatible-child-node lookups
Message-ID: <20181023091951.GC20058@localhost>
References: <20180827082153.22537-1-johan@kernel.org>
 <20180904130557.GT28861@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904130557.GT28861@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Sep 04, 2018 at 03:05:57PM +0200, Johan Hovold wrote:
> Hi all,
> 
> On Mon, Aug 27, 2018 at 10:21:44AM +0200, Johan Hovold wrote:
> > Several drivers currently use of_find_compatible_node() to lookup child
> > nodes while failing to notice that the of_find_ functions search the
> > entire tree depth-first (from a given start node) and therefore can
> > match unrelated nodes.
> > 
> > The fact that these functions also drop a reference to the node they
> > start searching from (e.g. the parent node) is typically also
> > overlooked, something which can lead to use-after-free bugs (e.g. after
> > probe deferrals).
> > 
> > This series adds a new helper, similar to of_get_child_by_name(), 
> > that can be used to lookup compatible child nodes, and uses the new
> > helper to fix child-node lookups throughout the tree.
> > 
> > This is related to the fixes I posted about a year ago, which addressed
> > a similar anti-pattern when looking up child nodes by name. Since it
> > took me more than a year to get all those fixes into Linus' tree (one
> > fix is still pending), and as these fixes depend on the new helper, I'm
> > suggesting that these all go in through Rob's or Greg's trees.
> > 
> > Alternatively, the helper could go into to -rc2, and I'll be pinging
> > submaintainers for the coming year as well. ;)
> 
> Rob has gotten the helper into -rc2 now:
> 
>         36156f9241cb of: add helper to lookup compatible child node
> 
> so feel free to pick these fixes up directly for 4.19-rc or -next,
> whichever you prefer. I've been able to trigger crashes after probe
> deferrals due to the use-after-free, but this seems unlikely to be
> exploitable.
> 
> I think Rob will be picking up any patches that remain by the end of the
> release cycle for 4.20.

So far only Ulf has picked up the mmc patch below directly, so if you
could take the rest through your tree for -rc1 that would be great.

Thanks,
Johan
 
> > Johan Hovold (9):
> >   of: add helper to lookup compatible child node
> >   drm/mediatek: fix OF sibling-node lookup
> >   drm/msm: fix OF child-node lookup
> >   mmc: meson-mx-sdio: fix OF child-node lookup
> >   mtd: nand: atmel: fix OF child-node lookup
> >   net: bcmgenet: fix OF child-node lookup
> >   net: stmmac: dwmac-sun8i: fix OF child-node lookup
> >   NFC: nfcmrvl_uart: fix OF child-node lookup
> >   power: supply: twl4030-charger: fix OF sibling-node lookup
> > 
> >  drivers/gpu/drm/mediatek/mtk_hdmi.c           |  5 ++--
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  5 ++--
> >  drivers/mmc/host/meson-mx-sdio.c              |  8 ++++--
> >  drivers/mtd/nand/raw/atmel/nand-controller.c  | 11 +++++---
> >  drivers/net/ethernet/broadcom/genet/bcmmii.c  |  2 +-
> >  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 12 +++++++--
> >  drivers/nfc/nfcmrvl/uart.c                    |  5 ++--
> >  drivers/of/base.c                             | 25 +++++++++++++++++++
> >  drivers/power/supply/twl4030_charger.c        |  5 ++--
> >  include/linux/of.h                            |  8 ++++++
> >  10 files changed, 68 insertions(+), 18 deletions(-)
