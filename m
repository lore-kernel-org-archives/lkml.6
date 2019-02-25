Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E4BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B522184E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cHp5Y6XM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfBZAX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:23:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39315 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbfBZAXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:23:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id m11so8298389lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9fHDYu7/K0cxYsKBhkgbdvY8kvR2QORwgRSe5slh5k=;
        b=cHp5Y6XMmnVy/s/bjXsqT/7Q2JuFKTBrroRWUUnR9bfI7jozMY6TrEPaWzh7X1WuPh
         EKCkHnqlqQCGHRabdiKlXklvMa1rnGu7wSlz5sFySPzR6pdsZMGtwmQMEAyb1EgHlT0Q
         x2zZHPMEYO7N3Zzq/PN+95pCmAVMrK3otSyfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9fHDYu7/K0cxYsKBhkgbdvY8kvR2QORwgRSe5slh5k=;
        b=DPkvA6McG+q7jp/WVV3xB3HFftlz1FnDqZEzHl9k5A5+M521MkWhiEpsX7p2ntznmj
         h/lHHm9mPxbOAzMT/9zNv22yXVzyoE6VcM2N2KqXHZkUuDjA0lZJGcZVwDzgMnZIEyi1
         mEfVj1lNOEYwfD5BgMsuwgiNt/xhFpxLS44GaYJKbGLB8TEV4N2eH1YMnD766LTU9IBp
         eGe00Q3yXS1iKUYmmFwW5HHGVfcNUD/8UtBi28cpmHZbSFb9ppwb6USBJfgwGfn3A9vp
         r2ozg9/1rYNvEYIXnYCUbGhVbYIK1GU4uA+Vnnpc3hfQefUfgYR7wVFGPwP7KAi2Eeg1
         B0/Q==
X-Gm-Message-State: AHQUAuZnefoE9C3xHVBTy0WenA5gquOcnh7FeRyTW15/gch7eZhaDgid
        IIJ4vCgI6UQkc3NgL05Ew7NlJPTHZqs=
X-Google-Smtp-Source: AHgI3IaTAwMKKNas2GlrN3t/Dz9Mbl2D0eo6dgwRRhqaq1pCgAMWK80iVW9v1fZdCcBIO/vu6UWYwA==
X-Received: by 2002:a19:40c2:: with SMTP id n185mr4979533lfa.67.1551140603002;
        Mon, 25 Feb 2019 16:23:23 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v1sm544770lfg.13.2019.02.25.16.23.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:23:22 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id w6so9136936ljd.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:23:22 -0800 (PST)
X-Received: by 2002:a2e:9f0b:: with SMTP id u11mr12182408ljk.64.1551138970199;
 Mon, 25 Feb 2019 15:56:10 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-9-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-9-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 25 Feb 2019 15:55:34 -0800
X-Gmail-Original-Message-ID: <CAE=gft5rTt09Dis3Jq9vNqpqU4W-ehOxAmepYWJ6LXXnkvC8gg@mail.gmail.com>
Message-ID: <CAE=gft5rTt09Dis3Jq9vNqpqU4W-ehOxAmepYWJ6LXXnkvC8gg@mail.gmail.com>
Subject: Re: [PATCH 08/13] media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
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
        Tiffany Lin <tiffany.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the vcodec device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
>
> CC: Tiffany Lin <tiffany.lin@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
