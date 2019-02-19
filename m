Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A9DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93202147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EMCiJmt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfBSXbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:31:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34205 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbfBSXbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:31:08 -0500
Received: by mail-lj1-f196.google.com with SMTP id l5so15734588lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kIE35RsfAdfmPvEPcsGzl5k3eOYcySsNWpC7InGPXK8=;
        b=EMCiJmt/ma++GI5luHEWAweINLW5BeG+23iPS+q4Rf/Xop3Rat0n9vgaRuiLL2XzGR
         jMTnTlMySwyLHogYwZHrJZ7qaa8+iEHNb8NfquvcSpIsUjZ0Jxab4ktsfq4KLQ8InTh6
         ZB45N2QX4b1PifPwyCPbtWzppk6c/fEdB7yn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIE35RsfAdfmPvEPcsGzl5k3eOYcySsNWpC7InGPXK8=;
        b=ShTrjESwj4drdb3InEfJuO+2oMwRxpV1WwHK0Ab0tBIuuGSbwphqzMpTvGz5Bo7wIg
         2IuKWYqGr5MbOsKwes0QkFHLhHl+lZr1jzXDkEPq7BhKP0LdmKBobCtNdlHPyLUaDLrF
         TuQdOhKi2tBUEcVP6jfWGq10ehlNCNHoZ0tuhbOJQDphnTP8l4V7rppzv5WBSPpT0bRo
         9bSYc5dSeMSPqT8bibDsZQRI4Dvh/fptkJ9z6ZIsYOOHOBARLzloGNb2GGtHgpX9Jefv
         zMT9QAHgNyUxEhsdhcD7Na9lHMK2chYXXsFjyNyed2q1bvhfDl9ePxhEgZ4Ud/2HTdB6
         mIBA==
X-Gm-Message-State: AHQUAub5BbWoVEQAleVnng9SpDZh+xHQUugekXgK5+28uUujJ7ERO0zi
        lZimw6mA17W+/ygk7gLVX+xT+vLeEi0=
X-Google-Smtp-Source: AHgI3IaChhgfpp6KcNFUpTw2J9IfPqkFMNZolc7ywU/1TAdWrSXUsxevTFkLrwH/mOLt3h+itOujBA==
X-Received: by 2002:a2e:9cda:: with SMTP id g26mr17416423ljj.48.1550619065766;
        Tue, 19 Feb 2019 15:31:05 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id q123-v6sm4676716ljb.60.2019.02.19.15.31.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 15:31:05 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id l5so15734550lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:31:04 -0800 (PST)
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr19628484ljc.97.1550619064118;
 Tue, 19 Feb 2019 15:31:04 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com> <1550394300-17420-10-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-10-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 19 Feb 2019 15:30:27 -0800
X-Gmail-Original-Message-ID: <CAE=gft5UxHBwQ_fm+MD-x-yX8fUd5miFzzMnc8nmet+8JvqXKA@mail.gmail.com>
Message-ID: <CAE=gft5UxHBwQ_fm+MD-x-yX8fUd5miFzzMnc8nmet+8JvqXKA@mail.gmail.com>
Subject: Re: [PATCH v6 09/22] iommu/mediatek: Refine protect memory definition
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

On Sun, Feb 17, 2019 at 1:08 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The protect memory setting is a little different in the different SoCs.
> In the register REG_MMU_CTRL_REG(0x110), the TF_PROT(translation fault
> protect) shift bit is normally 4 while it shift 5 bits only in the
> mt8173. This patch delete the complex MACRO and use a common if-else
> instead.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
