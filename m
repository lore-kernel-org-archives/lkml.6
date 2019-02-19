Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384D9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE94A2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VJGEVgQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfBSXh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:37:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34563 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfBSXh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:37:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id l5so15744455lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AJ7ED9jH39fuBc3f73jvNFeV5iY3KwuUSdsrf8MwwXk=;
        b=VJGEVgQj7V5QTQsVkhPvLHTwnozl56CbHYs2KKTw77qb03WH+izpub1pucQZI/pnMS
         Ln5Loflermovk58DJCIBryy/cBbXj9q+PHI6cg/ecAqS/DE2ZsaFY1+dYJcxEorcd7Gb
         aYVDR/p3ypPSxlv+pxCAIdFA9kcT4vxtrvuAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJ7ED9jH39fuBc3f73jvNFeV5iY3KwuUSdsrf8MwwXk=;
        b=h5fxVb859VBexsyHeocFd2XYI7OaIKnQL9wM6u98WkCwT9o1Sia3F87shDkaiiVkSV
         ZUldwDUGj7LujDty342xKR3aj6oMdy/qvad48eBN1HFNE478ASuNFo8lj84zg0Q/i0+s
         qsDs7BvRYV4cXZRReyTlz2F/OkOilQS/VBjHt5218iMZScZ89sznU0Jivu981GTYhaFX
         iwNu+jjhEGY0gppnxTffjIpDRMjo39blF34Zj5qt2X3FpkABqnZJYhF2QZ3FHGiYQXEQ
         oQgzLg5smFP1DY9IXWD+WQhDMFRr4ozFHMnKqRLCKX6xoLVCrkETJwbE7my5LeTyXaht
         6yRw==
X-Gm-Message-State: AHQUAua3++Kvy22WnCU8fgsfAe6kV7l5lkDi31SM2sbQLzwZ14SqbQ/e
        ocv7huhUD4iFxil2Sly7iMZ1M9yPb9g=
X-Google-Smtp-Source: AHgI3IYSXYeF3YzoQKNWF6FgtNEy6f87Sc1OUH4NdH9MGYQsPNSQqiNapMAfM8iEy5X+TOUpBGKsDw==
X-Received: by 2002:a2e:8803:: with SMTP id x3mr18063288ljh.27.1550619445684;
        Tue, 19 Feb 2019 15:37:25 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id a21sm4972272lfk.61.2019.02.19.15.37.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 15:37:25 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id l5so15744433lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:37:25 -0800 (PST)
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr19630490ljc.97.1550619131688;
 Tue, 19 Feb 2019 15:32:11 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com> <1550394300-17420-17-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-17-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 19 Feb 2019 15:31:35 -0800
X-Gmail-Original-Message-ID: <CAE=gft4A=MEYUwwgj4RCT=8Vz_qxbmPo8uG3Mf-HJwC0Zn0-9g@mail.gmail.com>
Message-ID: <CAE=gft4A=MEYUwwgj4RCT=8Vz_qxbmPo8uG3Mf-HJwC0Zn0-9g@mail.gmail.com>
Subject: Re: [PATCH v6 16/22] memory: mtk-smi: Add bus_sel for mt8183
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
> There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
> mmu0 or mmu1 to balance the bandwidth via the smi-common register
> SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).
>
> In mt8183, For better performance, we switch larb1/2/5/7 to enter
> mmu1 while the others still keep enter mmu0.
>
> In mt8173 and mt2712, we don't get the performance issue,
> Keep its default value(0x0), that means all the larbs enter mmu0.
>
> Note: smi gen1(mt2701/mt7623) don't have this bus_sel.
>
> And, the base of smi-common is completely different with smi_ao_base
> of gen1, thus I add new variable for that.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
