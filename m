Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69889C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352AC206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEaRB7ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbeLUKRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:17:40 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46166 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731601AbeLUKRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:17:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so3503807lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afcFUfas/vk/331jAo4gIvH82Dv7vTpFi3FOQp4ZaiY=;
        b=jEaRB7akudOo2vLclr1yTKKSo5VmVVUYzdpzmWzFu6f2ICbEtDH6EFyTC9HlOnPPWz
         dwbTw04xAo3xS4cOd3RdkVvQn+XgkANwVbIjFiDRLkNaJ6fBe+AWZTwQrH+lU6Wl37au
         3r7lFUUJm6YZB4FVpTbw1sBIaGmBECiAVgpPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afcFUfas/vk/331jAo4gIvH82Dv7vTpFi3FOQp4ZaiY=;
        b=JYEH5q9zB3KGo2GuLUdZP32mhGVaPnIkwt2tcCLtEKBPwfI9xDIpnpp0dCA8J8Si3b
         5YVRfdq7maWEM8v+Pg9fECQATQW2smct/Q6xOH5IHGI7rXwxdk7GGtvz5Wmi4pSXgnSt
         F2bj5tjZZnAQXsMSVB+T/UwxosBWuen7FtzLgB4u6eoj8cmhP60cQW0OnkCvMtUx5Xla
         w6C2aOd6BjJAwa1sz7ydpwrx2dk47GsjbVV0vPqdjIsDPVa6WChinZ/NVrwoF16L4MSe
         UZNCB0FTwxUe/6pxHUwthxGAiN16/72FIw4uLu3Bqqy1q29BfMwGTet83rcODv1vj4AE
         TO0g==
X-Gm-Message-State: AA+aEWZhltAYpzrzLELTNYGFzveIjQ4Mqwr0unOeOVqK2khdmf3iQUo5
        aZb0rmkcGwIxSEvw5DI2nN3pyS8x6ngsixyMeTBSpg==
X-Google-Smtp-Source: AFSGD/UFAke1qiEd6nqMpvJhR8QRd0yMrmIFciv+sIQIbp2HMFueCNxRyilTdjrot/RIZguc+SIiWttZKyENiZSTHYU=
X-Received: by 2002:a19:5154:: with SMTP id f81mr1108543lfb.96.1545387457776;
 Fri, 21 Dec 2018 02:17:37 -0800 (PST)
MIME-Version: 1.0
References: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
In-Reply-To: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 11:17:25 +0100
Message-ID: <CACRpkdZMgnj2S8xPPFm3PnDGrqTerOwWcS-+Uruy1uLH24HRLg@mail.gmail.com>
Subject: Re: [PATCH v1] pinctrl: mediatek: improve Kconfig dependencies
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 3:28 AM Ryder Lee <ryder.lee@mediatek.com> wrote:

> Remove prompts to make all pinctrl cores to non-visible symbols and
> make sure the target SoCs would be coupled with the corresponding
> cores.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Patch applied with ACK and Tested-by.

Yours,
Linus Walleij
