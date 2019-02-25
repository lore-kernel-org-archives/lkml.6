Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9680D2184E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M8xtLOf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfBZA1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:27:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38583 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbfBZA1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:27:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id j19so9153000ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THittGfJC8emYBhU0KhzGPQFIt3H4BeIZxF6YUUJJdg=;
        b=M8xtLOf819mKuTqGzIZh5FEWMHL4Oj6lRGxIbkhnnZ5YBEtr4X09H5aShqQUNddMw8
         TchEUDsdfvInERbS1NqqA/0tOxlfQrr+sYSeZGaP9wn9qF1Ey1szZRF1y/S0JfadFtET
         bpXsK99UhMnPzhk989HhJmVDvQPeHn7zWDbM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THittGfJC8emYBhU0KhzGPQFIt3H4BeIZxF6YUUJJdg=;
        b=k38n+C3Bv43tY1mUoefE2zpSbs9Wv8T4pMMd1AMOeWrzG3XlqlSVNp8HC3kWdofnUz
         NKK+/maaOGrJslfqhLaaqbmxWZkiSaIx59bnvH2ykijkG9ChQRlK2wsJyRPl/pk0vdfD
         Y3MZqRpWwZ1j9iw5dvQmXEyJxBErm/k414ymHL5L8piq7mtacnEkvGidby17+a5P2rRt
         mT/9ldgvlFgRyp2LZ5UHhy4XRszObShxbRkAbVzMtpgB4M7EfJcmneU33SU153Pxlex1
         RswHlFHJvJFCaLQR3WOGZTgZlRSN0FugdYxO8jtF9ZmaL6STbFEytrSL38Vem9jLD/8q
         Bwrw==
X-Gm-Message-State: AHQUAuYSsnGKZ5hUex3EVx+9W+OpUSFl8a/QY50VBemEXMlMXULNvYUy
        crTWuCGQlgU4f/eCPjdD4jkBkBaeV4o=
X-Google-Smtp-Source: AHgI3IYJs/AXeSQwrOdcO834YxNxDRHcAF8X1QloEZ+DBxL1FCif4OwJW+UoC/QrvzmX+8XhOu8Inw==
X-Received: by 2002:a2e:408:: with SMTP id 8mr11489547lje.15.1551140869042;
        Mon, 25 Feb 2019 16:27:49 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id x64sm1839629lff.3.2019.02.25.16.27.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:27:48 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id g2so8281735lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:27:48 -0800 (PST)
X-Received: by 2002:a19:294d:: with SMTP id p74mr7312760lfp.101.1551138989171;
 Mon, 25 Feb 2019 15:56:29 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-10-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-10-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 25 Feb 2019 15:55:51 -0800
X-Gmail-Original-Message-ID: <CAE=gft7NZtWOCcbNi9uDwru7abHn52R-NgYyU2cnBehf7rAhGA@mail.gmail.com>
Message-ID: <CAE=gft7NZtWOCcbNi9uDwru7abHn52R-NgYyU2cnBehf7rAhGA@mail.gmail.com>
Subject: Re: [PATCH 09/13] drm/mediatek: Get rid of mtk_smi_larb_get/put
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the drm device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
>
> CC: CK Hu <ck.hu@mediatek.com>
> CC: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Nice cleanup.

Reviewed-by: Evan Green <evgreen@chromium.org>
