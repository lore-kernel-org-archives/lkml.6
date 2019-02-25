Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA7AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F35A218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kc1+7CSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfBZACk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:02:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36411 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfBZACj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:02:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id v10so9125364lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4gY5KZY3j+v6lNL3mYxj3q2uSyGFjZbYwW3PkYe4vQ=;
        b=kc1+7CSQghDMEHxybMZNL+zxWbTGNFaeWcmZu7HPhDTWtIO7lYG9IdvAxq6ZoTXRzC
         vDnzAv0T/CofbIgC+9dAxgfyQWxZ1qqYK22vbAfZ7nUlrQW3DZDcxfN5kp44Hmn6Bcfu
         4+XoUuNtGRs/6Mi7l0mTBYa1fDagwO21XumVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4gY5KZY3j+v6lNL3mYxj3q2uSyGFjZbYwW3PkYe4vQ=;
        b=YGOMZksr8m5Zdhw9IWtA87LbBwiKBlkUFlW4tJ6FsyFd6U9/OD6VzJZrvG2BrvmBkU
         UG7IOoPhqbrgRLujp1rPtPKIlA8HxrzILjQr31NxmjfkvUsfV1TkErldu+uFsmFOosC6
         LupjpQnvltgOkAWP1ID5viQ9aJnMF92Qy7HYwlcO+ymFnv2JUOHAmuoKkVDHVFpD1Mru
         FNzhdvaQv9MI8bYHUHU/iQyNVFBQX4lOkQyagbSjfy6C5YQZIW4CUSURmYss2Z6zjCim
         HPTIR7ql4d4V8uSLA3eD8l6nwkkG0SkYGUU3WdTIL3x+uc6IIPtI8/8EPQ6xCc3DHg8x
         vu/g==
X-Gm-Message-State: AHQUAubUzZB2jfP3EMkvuEkAa49RdCUx7UifpEV81NzMqF13Gtrj5u90
        nveuDVf8kcaFgftv7OJb+wgaurVjkng=
X-Google-Smtp-Source: AHgI3IZEiRwt9Ec6iTYqV7HO1v+1faAOKZgOJLqVSB8lq/Es/x1Fpi85vVloXTTAGu3IruSU9kFuAA==
X-Received: by 2002:a2e:7314:: with SMTP id o20mr5734121ljc.111.1551139357849;
        Mon, 25 Feb 2019 16:02:37 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id v8sm2582189lji.51.2019.02.25.16.02.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:02:37 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id z25so9100972ljk.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:02:37 -0800 (PST)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr11645266ljj.30.1551138861092;
 Mon, 25 Feb 2019 15:54:21 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-3-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-3-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 25 Feb 2019 15:53:44 -0800
X-Gmail-Original-Message-ID: <CAE=gft7mWs1jc+KQQcPuuhcmxpFRnRBTt35+uC3F20N6R554bQ@mail.gmail.com>
Message-ID: <CAE=gft7mWs1jc+KQQcPuuhcmxpFRnRBTt35+uC3F20N6R554bQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] driver core: Remove the link if there is no driver
 with AUTO flag
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

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> DL_FLAG_AUTOREMOVE_CONSUMER/SUPPLIER means "Remove the link
> automatically on consumer/supplier driver unbind", that means we should
> remove whole the device_link when there is no this driver no matter what
> the ref_count of the link is.
>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> The ref_count of our device_link normally is over 1. When the consumer
> device driver is removed, whole the device_link should be removed.
> Thus, I add this patch.
> ---

I will admit to reading about device links for the first time while
reviewing this patch, but I don't really get this. Why use a kref at
all if we're just going to ignore its value? For instance, I see that
if you call device_link_add() with the same supplier and consumer, it
uses the kref to return the same link. That machinery is broken with
your change. Although I don't see any uses of it, you might also
expect a supplier or consumer could do a kref_get() on the link it got
back from device_link_add(), and have a reasonable expectation that
the link wouldn't be freed out from under it. This would also be
broken.

Can you explain why your device_links normally have a reference count
>1, and why those additional references can't be cleaned up in an
orderly fashion?

(To be honest, I don't really understand the case for the AUTOREMOVE
flags at all. Is there some case where the party that set up the link
can't tear it down? Or is this a way to devm_ify the link, where devm
itself doesn't work because the links themselves stall out that
mechanism?)
