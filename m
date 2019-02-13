Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A6EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8030221904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550074209;
	bh=1Ga0mlGbTkzTQOsOeEwy2Txp35a5K/9pjOTNmVoOdik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2NyfAbwrgK4xTw5QEDSK7+Hw2YKUpC3P7djK3XdlT/iBZ4akjlWIq36LzaoMXNK32
	 V8Conemuq8VxEpKPX5VpcICXoEwkPknXaZdgg9J82Cp5HygAxjXcDktI7WXSp35Pkf
	 OBxmrVqW3jDapPDXEMCWHmICKY/lzKYQzXEyaS6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404324AbfBMQKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfBMQKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:10:07 -0500
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90EB9222B6;
        Wed, 13 Feb 2019 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550074206;
        bh=1Ga0mlGbTkzTQOsOeEwy2Txp35a5K/9pjOTNmVoOdik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RZTsVZJxvrH/bhyKesfZoDwA2bSsvjfJ6bpsnQuA1hJ3gFKYZuM9M/+V/hORjgDvB
         U6vMuRtcANibSffBB/pz56v4+rEaQO5rpuFQmE2UFdQc4OH5j8Jk66HSavAebKj9/t
         jiTWYiLln42DmxNaDwU+uEpkc2vIQbFHmFIpXZ7A=
Received: by mail-yb1-f173.google.com with SMTP id s5so1119732ybp.6;
        Wed, 13 Feb 2019 08:10:06 -0800 (PST)
X-Gm-Message-State: AHQUAuZDjJFdCYWb97dfm5D5PFgYZ1wzun/kp/CBw0vsuz7bM3iCoeEz
        QJNQ1yNr79pFnn+PMmH3mGd+Uk/f/Z3AGZ59YA==
X-Google-Smtp-Source: AHgI3IanZ3XokatEDtDVHGOCDtEM6FP+/DzqrlPsFEYfk2wta6svpTb9pnJnBWfdKNHT9TnSg1jtif/aVEEJ78GLltY=
X-Received: by 2002:a25:6642:: with SMTP id z2mr1193642ybm.302.1550074205596;
 Wed, 13 Feb 2019 08:10:05 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-6-robh@kernel.org>
In-Reply-To: <20181205195050.4759-6-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Feb 2019 10:09:53 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+xpRPvj=UcSo+jQKX1pB=9B3SV9jB5ZVhaVsKvOqtoOg@mail.gmail.com>
Message-ID: <CAL_Jsq+xpRPvj=UcSo+jQKX1pB=9B3SV9jB5ZVhaVsKvOqtoOg@mail.gmail.com>
Subject: Re: [PATCH] devfreq: Use of_node_name_eq for node name comparisons
To:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 1:50 PM Rob Herring <robh@kernel.org> wrote:
>
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/devfreq/devfreq-event.c     | 2 +-
>  drivers/devfreq/event/exynos-ppmu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Can someone apply this please.

>
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
> index d67242d87744..87e93406d7cd 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -240,7 +240,7 @@ struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(struct device *dev,
>         }
>
>         list_for_each_entry(edev, &devfreq_event_list, node) {
> -               if (!strcmp(edev->desc->name, node->name))
> +               if (of_node_name_eq(node, edev->desc->name))
>                         goto out;
>         }
>         edev = NULL;
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index c61de0bdf053..c2ea94957501 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -529,7 +529,7 @@ static int of_get_devfreq_events(struct device_node *np,
>                         if (!ppmu_events[i].name)
>                                 continue;
>
> -                       if (!of_node_cmp(node->name, ppmu_events[i].name))
> +                       if (of_node_name_eq(node, ppmu_events[i].name))
>                                 break;
>                 }
>
> --
> 2.19.1
>
