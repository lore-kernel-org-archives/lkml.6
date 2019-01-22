Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FD7C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E452085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfAVRMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:12:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:59755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729357AbfAVRMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:12:06 -0500
Received: from [91.14.89.174] ([91.14.89.174]) by web-mail.gmx.net
 (3c-app-gmx-bs21.server.lan [172.19.170.73]) (via HTTP); Tue, 22 Jan 2019
 18:11:53 +0100
MIME-Version: 1.0
Message-ID: <trinity-72bd264f-d4e0-444d-ac33-b708a0fc6503-1548177113835@3c-app-gmx-bs21>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Joerg Roedel" <joro@8bytes.org>
Cc:     "Matthias Brugger" <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: Aw: Re: [BUG] "access dev->iommu_fwspec" cause crash on BPI-R2
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Jan 2019 18:11:53 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20190122164916.r343pqa2dtopzrxo@8bytes.org>
References: <trinity-76e7f2ce-27ce-4f3b-809f-7da9a35e5210-1548173349245@3c-app-gmx-bs21>
 <20190122164916.r343pqa2dtopzrxo@8bytes.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:J8WEYEdymEMW3hMNqeHsxUdQvQOrZ1PrHBqxFaRB6xGSetdSgLugzWKIAXdedqaMGZ5dm
 nEwrP/76eI+NIviE3FBf6JZeK4HW2J0FjlrroTrVxXohBIzAC11L1q5kGTTzA1HE9eTs4HT5udxC
 H7+KKFLwnCKRQGEVsOuY/Y8aUdqYKJgBZaq1+MwG5vFdJrVQAswWHGOF/QZ7cg62JI/x9phvZM0J
 hgFqrBqtFJiY/T9xtDe+8tN9LUYHD8RXbNPcIt5FdiiKYl/0fdLXCsUwJ/f/jCjw6a62dSzo+fRp
 2g=
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y3hlLel7LSc=:7oXWQfPdYu5gvfgtMkCnIc
 AATP0fcV8p/QqBUIx77fj1IEA8Pw5j9IIXx4NHhauaOUJRUXVcKco0/jP0tSutoYsamUN9Unq
 8EVexWeejdQ468mr7g+xdSJHCnHaYB0Qbq/Qv4Pg+s02p9rwuA8b3rsUDzZhyd8rbA1cPGv/0
 kAPa78NNZJua7MJBZ7nJ6VBGEQomjlv3xGQBJ6tPLvyOllVV7DOktYiHd0HlbmbiB8WgmIrDK
 IbVvMA0ww1LPkPCFfrwFvOeN+dnqDNQII27IPYpSOlmTTcaMLvH0TMOUci1HqCQXeOTy11/6+
 SanZ6J0C2XLFOS0jrearCHvs5GYGkmZvh6iTOgM3aXmU5bIKga1dKNxZQ0hLcLqy6FyXf4sFD
 ZoYOWcRPTs9WMfhqyMUB0GvEQXGEh3APaJDaJQoHxPASGA7zL2J8ZiHwWrQVHHybqJgc6MY7J
 Ruqlw+O5nDeyTcGITR/yf5aG3ZOOwu5RZkzmyGMEoIrAi0ST3MbxjW6DkIazNnSj9joxi4WB9
 o/ZjdIre++ijjItMe3QCyZPoiXtSi+z/DgieMhLwQoxC1W0IH5otaS6+frQSysk76B0MyWJ69
 dRI3nR0mEWcjE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for quick reply, this seems to fix it

no crash, xserver works, like revert of the commit...pushed the fix to below github-repo

regards Frank


> Gesendet: Dienstag, 22. Januar 2019 um 17:49 Uhr
> Von: "Joerg Roedel" <joro@8bytes.org>
> An: "Frank Wunderlich" <frank-w@public-files.de>
> Cc: "Matthias Brugger" <matthias.bgg@gmail.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, "Ryder Lee" <ryder.lee@mediatek.com>
> Betreff: Re: [BUG] "access dev->iommu_fwspec" cause crash on BPI-R2
>
> Hi Frank,
> 
> thanks for the report!
> 
> On Tue, Jan 22, 2019 at 05:09:09PM +0100, Frank Wunderlich wrote:
> > Hi,
> > 
> > the following Patch breaks hdmi (at least) on Bananapi R2 (mt7623):
> > 
> > a9bf2eec5a6fc01a0a5250eaf0bf61dfd382a78a "iommu/mediatek: Use helper functions to access dev->iommu_fwspec"
> 
> Does the attached diff fix the issue for you?
> 
> Thanks,
> 
> 	Joerg
> 
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 6ede4286b835..f60bdb85c4c0 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -442,6 +442,10 @@ static int mtk_iommu_add_device(struct device *dev)
>  		iommu_spec.args_count = count;
>  
>  		mtk_iommu_create_mapping(dev, &iommu_spec);
> +
> +		/* dev->iommu_fwspec might have changed */
> +		fwspec = dev_iommu_fwspec_get(dev);
> +
>  		of_node_put(iommu_spec.np);
>  	}
>  
> 
