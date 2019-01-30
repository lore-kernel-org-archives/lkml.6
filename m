Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F1CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4994820869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SsQZ4kix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbfA3Sfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:35:44 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37223 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733050AbfA3Sfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:35:44 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so411672lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgDn3w54X8Bk6az8BYFqZSk6Fe3enX65M4AMBH8XrNw=;
        b=SsQZ4kixnoSxfSuaoIuMgqaZLJDcbUnwWAd/PcuSMGF2HaTTXdVhB+7tRqWfXYnEoF
         ZtqSQ+s+i840ezBg8svi6ps5YDISOnFZn1JQsQCAtxGsDEGYrLnEIeCo2IzVtb+V4a3R
         HYxWErI31o6esVYwtfKwmzdSLvgR0Vn2UKWLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgDn3w54X8Bk6az8BYFqZSk6Fe3enX65M4AMBH8XrNw=;
        b=gvDanoRckJqVj9BCDveORTy0cNf/29/QVY4gi5IV91yQSR03vKo3UkLmrBUVKi+WnP
         dxwHfFBGWe/bhD1++n+m++WHCCwv8TMREpu7pfEF4ImaK4TR69nzymz4orNwWJT4UgvO
         Km+50do9jsofctdmURg+zGc0ngERa5Wm6bQoIMRIsJBo04X8KTArgOtjiomcNbRUT8Dy
         40Hk5mtNhg8dhSEW8WlRnE6PEBIuilQKE8orV3AySc9vmyp7A492hHuEoQaYqHG8kWli
         Q6nl6VzGWJaW7QSVkc8rOK6t/7Ya8WCFyyR0hYxyx6R1+wPUqupdoRhMSL87zWkQU+Nv
         DVNg==
X-Gm-Message-State: AJcUukf7B1+vCdJncolSzuWUjW9/qqwkV+7LTXO+JL1quHrOJkx2arhu
        tmLUHmnfMYknlsK4WZcXI9gifd6LMWY=
X-Google-Smtp-Source: ALg8bN7nQWIy6my0HE5GgBkeD2I0Tu+mTMNJj4VV59xJXl2Q37ePzveiY7W3G3oN1wgjle4OqPaMWA==
X-Received: by 2002:a19:7018:: with SMTP id h24mr24308833lfc.162.1548873342166;
        Wed, 30 Jan 2019 10:35:42 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id f8sm427241lfb.2.2019.01.30.10.35.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:35:42 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id a8so402985lfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:35:42 -0800 (PST)
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr23773604lfd.90.1548872984375;
 Wed, 30 Jan 2019 10:29:44 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-8-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-8-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:29:08 -0800
X-Gmail-Original-Message-ID: <CAE=gft7ZVjJH-9f=ryoiegkjt+=Tnig=DRhc0z_5j=O7v4dQxg@mail.gmail.com>
Message-ID: <CAE=gft7ZVjJH-9f=ryoiegkjt+=Tnig=DRhc0z_5j=O7v4dQxg@mail.gmail.com>
Subject: Re: [PATCH v5 07/20] iommu/mediatek: Add bclk can be supported optionally
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
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 7:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In some SoCs, M4U doesn't have its "bclk", it will use the EMI
> clock instead which has always been enabled when entering kernel.
>
> This also is a preparing patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
