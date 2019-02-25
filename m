Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713F8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D06220684
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jo7Vy+jY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfBYXyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:54:49 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46334 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfBYXyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:54:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id v16so9064917ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 15:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMX9Ml2XVdmdZ64dlD0uAky14OAHXuYnOUzBqziTxFA=;
        b=Jo7Vy+jYynanNQauVads0ABU/5uxCvgWwevdsLzsVa1bItuxNfpi7QM/Q5uTZdAhxH
         XrDcu0CHn6UvURaPN9KGwlsZpA5qIrZCltlmglj2UtrDRQIbAVDxng9EnMlIxcF43yZq
         CwihTX5a9aDU+LZ+AsWSoacY27ATMSDRW5WR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMX9Ml2XVdmdZ64dlD0uAky14OAHXuYnOUzBqziTxFA=;
        b=TH8onNYZ1jj1lvI2lmKLhp7v0FRxZ/fvws9GgGigyu9vEvxb8mMK9CPtG2brfGlNdA
         hIOe03zZNlxP9p4Y3aSZcaPSvZ6b4smfcTo9XOLmO6D6SxcdtdPQDe7oD5snDpOqDp+q
         n3KoSXzqxCt2Vus/02aoBmzyS+3NNJt4apuDWPthM4d7rmsbz24409us65/4iIS5sZ4a
         d/MdW/xt5QfLsy37n0Za/qleVQQ1YUnyedn4Qg/i1jeiI48AprIx2nM+Ni7xrbAGtNoS
         MdHQKfVLVdpSUM6emI3kMvjE6CDr9q+bTtwrIuEQiX8eJoXeR/V6htBuPRuXfr+5hoVt
         6ebA==
X-Gm-Message-State: AHQUAuaZfBjvpVvm7fGbqKn9I+rGw+PwYwLE3FaZ7CG3JqLXXADXyU8m
        aBbrYn3B4mfQJ1BsUTZNTdixby2qYWs=
X-Google-Smtp-Source: AHgI3IaqZxocV3no1QToQtCVZ0llT4RQC/6KBgLx4Pdnbi4kSka4gbkYBTYlj0e0yfrfaaK6qg20sg==
X-Received: by 2002:a2e:96c9:: with SMTP id d9mr11051774ljj.133.1551138886518;
        Mon, 25 Feb 2019 15:54:46 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u9sm2858074lfe.58.2019.02.25.15.54.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 15:54:45 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id z196so7564725lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 15:54:44 -0800 (PST)
X-Received: by 2002:a19:2d44:: with SMTP id t4mr11331025lft.90.1551138884649;
 Mon, 25 Feb 2019 15:54:44 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-2-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-2-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 25 Feb 2019 15:54:08 -0800
X-Gmail-Original-Message-ID: <CAE=gft41kvHVY=QJCK7y7AUwPd=HQGHUKoDUAAk42bvBZMExvQ@mail.gmail.com>
Message-ID: <CAE=gft41kvHVY=QJCK7y7AUwPd=HQGHUKoDUAAk42bvBZMExvQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] dt-binding: mediatek: Get rid of mediatek,larb for
 multimedia HW
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

On Mon, Dec 31, 2018 at 8:51 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> After adding device_link between the consumer with the smi-larbs,
> if the consumer call its owner pm_runtime_get(_sync), the
> pm_runtime_get(_sync) of smi-larb and smi-common will be called
> automatically. Thus, the consumer don't need the property.
>
> And IOMMU also know which larb this consumer connects with from
> iommu id in the "iommus=" property.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
