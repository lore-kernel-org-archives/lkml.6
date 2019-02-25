Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249A8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0DF2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GF6Ex+WP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfBZA01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:26:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32800 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfBZA00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:26:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id z7so8961750lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tZwR/zt5ZZMcpwi9xVzbwgZJ4rn4m7mYsGQrzVWldc=;
        b=GF6Ex+WPJgKPYaYMyiIbId6RIukmmSazsTWtV9xn9LdGcTAJYMpyGGB9FFXsFydzv2
         LkaUPFAXn/15yW0zr5q1QGGvuChK26PFnALGnpGwE9KrHm3rsA8CP6x8Xyii+g8Yn+L1
         Ke7i+KyQTxyMDH7waWKg44lZOM1ffsHMVAzRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tZwR/zt5ZZMcpwi9xVzbwgZJ4rn4m7mYsGQrzVWldc=;
        b=gh+pn9RXw6T5CcVi6R5/aw+BSwqYYfq8KyRygGdQzr3hcTSyqjSsn6v1AAT+Rl75Tq
         O+cwlMvjYI9tuvwQ6jEwLs3V8+/SQXS9Rxk9V3/UyZTW3ZZCu0JFf/rd+Druom2H2gGp
         9wdvngunjrrfIfBtn2vSoQXiDOEkSaoAkk5+uCxFPcH0bDZin1mp9UXshWx9xcm+MSNx
         Xgs41mNd5BQFdRhWx9zDahn1YwuxSscTJU6n3UMYPVrjEglMg09eZ1TLDBB7HLB2DHjL
         +o96m781yIoALDp1xfGmJHPOmI60/MaxjKThmHpy1wewYZkGrxmMejm4NxOdj8nkA0Gt
         mI3Q==
X-Gm-Message-State: AHQUAuaplqaexa6+5CibEpU2+UMW+ta1aJEewBjrqwD/U2ME41k/ANQt
        oMRjHynF7mJ5ntOXxmEBsbeePcWz5Pw=
X-Google-Smtp-Source: AHgI3IZPZM+OaNu7PXWylNiCBd659GEymmMXcpo3Xr+K2N0UkgVNJBpYmCYZF3sNVHRoOGrfqMPW7A==
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr12108536ljg.146.1551140785071;
        Mon, 25 Feb 2019 16:26:25 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id x64sm1839146lff.3.2019.02.25.16.26.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:26:24 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id u21so8336561lfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:26:24 -0800 (PST)
X-Received: by 2002:a19:ed0a:: with SMTP id y10mr11846459lfy.154.1551139034938;
 Mon, 25 Feb 2019 15:57:14 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-13-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-13-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 25 Feb 2019 15:56:38 -0800
X-Gmail-Original-Message-ID: <CAE=gft5KJf=mx1zmzVPxGw7roL6N9Z4QvDSyTekOCeBzaTDQVg@mail.gmail.com>
Message-ID: <CAE=gft5KJf=mx1zmzVPxGw7roL6N9Z4QvDSyTekOCeBzaTDQVg@mail.gmail.com>
Subject: Re: [PATCH 12/13] arm: dts: mediatek: Get rid of mediatek,larb for MM nodes
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
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 8:53 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> After adding device_link between the IOMMU consumer and smi,
> the mediatek,larb is unnecessary now.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
