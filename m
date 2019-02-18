Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B53C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313CE20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550504690;
	bh=NJceUXw9RX2kTSXkv++RoV2NmqE8FAard7RwUSiIvZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MmkDL3KpjZZe+ONb2x9sR0FndBzv++X6EvF12fREy3/R4dWfIFcHII5K6OuUBGHLP
	 gOz+HQaCZtCMbgL+7S39qIXFt1UhcFqC9yKw3gEmM+H+5zOjah59xootNDnQcVh3L7
	 DhJhq2FvC5SN0DmahB0tLKlRAVByj0rXBdNu44Lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbfBRPos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:44:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40007 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbfBRPos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:44:48 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so28964417oth.7;
        Mon, 18 Feb 2019 07:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ce+FsWm+x9HHNqzsqHfs3p93v9ypTpSv8t2GcyaBUcc=;
        b=UCtk5GuTpAmaxTu+8G05TdSwoa5PaikUYJ48Ry6/0Hb69Z0q086P3gqyLVOlKtNmZr
         KKqWkx+/sjhc1CJEHUft8d92EV7vgd7SX4qwFfft0K1+0Su1eqPOquoB3cIA97TTtxLH
         28htlhSA0pFZvH3PmjbWchQGi602Jn3ypivLmcj0KCqioHltixmKLqrIIDl2E+hze4+U
         s4lM40GUlbggeQECDt7V2GZsiO+rZd2UVyFbocTHPr1e760ICx/1sMz2/HXDpiz8w2gj
         Sz+3Hyu5schx6t8POselkrBbJbk186reiCkURh9c+S+OVXrkp735wQdOwWnd+rftc2fm
         nwgg==
X-Gm-Message-State: AHQUAuZGcrd2pZdP3CYJdDsblZBSVfQ1osPdmvP1+OJczq0Oi+u1kdY8
        dG/KR9sG8nLs87mm+u/ytw==
X-Google-Smtp-Source: AHgI3IbA23hDY/RUuikmiosxCu8vFGpm3R1B3EOQdo8tRoA1IkwStmu0eNjVD6fm8YhD+yYR4MTFzw==
X-Received: by 2002:a9d:6206:: with SMTP id g6mr14483608otj.338.1550504686822;
        Mon, 18 Feb 2019 07:44:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y37sm3695809ota.17.2019.02.18.07.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 07:44:46 -0800 (PST)
Date:   Mon, 18 Feb 2019 09:44:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, yingjoe.chen@mediatek.com,
        yong.wu@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v6 01/22] dt-bindings: mediatek: Add binding for mt8183
 IOMMU and SMI
Message-ID: <20190218154445.GA28558@bogus>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-2-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550394300-17420-2-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 17:04:39 +0800, Yong Wu wrote:
> This patch adds decriptions for mt8183 IOMMU and SMI.
> 
> mt8183 has only one M4U like mt8173 and is also MTK IOMMU gen2 which
> uses ARM Short-Descriptor translation table format.
> 
> The mt8183 M4U-SMI HW diagram is as below:
> 
>                           EMI
>                            |
>                           M4U
>                            |
>                        ----------
>                        |        |
>                    gals0-rx   gals1-rx
>                        |        |
>                        |        |
>                    gals0-tx   gals1-tx
>                        |        |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-----+-----+--------+-----+-----+-------+-------+
>   |     |     |        |     |     |       |       |
>   |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
>   |     |     |        |     |     |       |       |
>   |     |     |        |     |     |       |       |
>   |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
>   |     |     |        |     |     |       |       |
> larb0 larb1  IPU0    IPU1  larb4  larb5  larb6    CCU
> disp  vdec   img     cam    venc   img    cam
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> Compared with mt8173, we add a GALS(Global Async Local Sync) module
> between SMI-common and M4U, and additional GALS between larb2/3/5/6
> and SMI-common. GALS can help synchronize for the modules in different
> clock frequency, it can be seen as a "asynchronous fifo".
> 
> GALS can only help transfer the command/data while it doesn't have
> the configuring register, thus it has the special "smi" clock and it
> doesn't have the "apb" clock. From the diagram above, we add "gals0"
> and "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
> 
> >From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
> Control Unit) is connected with smi-common directly, we can take them
> as "larb2", "larb3" and "larb7", and their register spaces are
> different with the normal larb.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> Hi Rob,
> In this version, I changed the picture in the binding and list the
> detailed SoCs which has "bclk" and "gals". So I don't keep your R-b.
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  30 ++++-
>  .../memory-controllers/mediatek,smi-common.txt     |  12 +-
>  .../memory-controllers/mediatek,smi-larb.txt       |   4 +
>  include/dt-bindings/memory/mt8183-larb-port.h      | 130 +++++++++++++++++++++
>  4 files changed, 170 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
