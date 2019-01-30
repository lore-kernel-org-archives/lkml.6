Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D687CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74B920989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ps15UBi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbfA3TAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:00:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37841 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfA3TAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:00:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so542108ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iICV6iO5GGqy/9UyvLBZFlPh+9/PoKYpYWrjSxw2AAU=;
        b=Ps15UBi2+dGsGjwapfletBv+573yHf6DC+OJb8tE5CbQxaNE2HEFKvYtYKiZ49sauE
         qr3hdJPCfSK5vXOAYerx0ce6yfBZhbx5ydpwO5+nMk/tvHiBkQQHcvnbd4bHPcbwL28y
         V//kUweAepKdxRr1pyB9Zwnju1ExglqAg1+QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iICV6iO5GGqy/9UyvLBZFlPh+9/PoKYpYWrjSxw2AAU=;
        b=mUx5J8vvZf2/Ry7+bl8/36BE2GOfio2J92okQwqroX79RovavzZ/gMkY8HuwiAPEOu
         6IEblD0ML5pdeSJJUTZwea3hXJyz09o68x2chtorqoPEig042sbjpDDkp2jDjaRqkKH+
         bZo7xqc5xJIumPASO5yw7OESz+ph+UoG5PZEVzYUZe0lhM4NcEZ1ftDwuEz4bwQcy+Zh
         fAU8b35357WNIHwozE+OWobq8n/nE+Zh5qLG2n1A/mDy3yc9z4jzGjo1EnPOYk8i6Yqo
         1wP/IH9DODyInzsH+o87PUZwvbDO0BxXnaakNrTSGWvNLEXB0J+CifSkvJPvRTRNY7kv
         elmg==
X-Gm-Message-State: AJcUukd6Fp7Nu7b6Ed5bg4Tn3H22ykY8YvCQ6Ak/+XtsBqioVzYnhhQ6
        NyfIHCAmM2TC/LTwQ0F+tz99w5wnyKg=
X-Google-Smtp-Source: ALg8bN7tlmS+ir8sIP2HzgvEySH4E2tagMpu8KDbp1tsC+zwKkjyGp1+BE9V4UQQGBpPX5LYLxPSOw==
X-Received: by 2002:a2e:9c52:: with SMTP id t18-v6mr25019535ljj.149.1548874847649;
        Wed, 30 Jan 2019 11:00:47 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id s127sm436418lfe.8.2019.01.30.11.00.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:00:47 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id u89-v6so558987lje.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:00:47 -0800 (PST)
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr18171528ljg.64.1548873092541;
 Wed, 30 Jan 2019 10:31:32 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-13-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-13-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:30:55 -0800
X-Gmail-Original-Message-ID: <CAE=gft5BS=yDQV48V1a=n8U1YyAQuQ+vxg1bFy1HFJXmvXE_gw@mail.gmail.com>
Message-ID: <CAE=gft5BS=yDQV48V1a=n8U1YyAQuQ+vxg1bFy1HFJXmvXE_gw@mail.gmail.com>
Subject: Re: [PATCH v5 12/20] memory: mtk-smi: Add gals support
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

On Mon, Dec 31, 2018 at 7:58 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In some SoCs like mt8183, SMI add GALS(Global Async Local Sync) module
> which can help synchronize for the modules in different clock frequency.
> It can be seen as a "asynchronous fifo". This is a example diagram:
>
>             M4U
>              |
>          ----------
>          |        |
>      gals0-rx   gals1-rx
>          |        |
>          |        |
>      gals0-tx   gals1-tx
>          |        |
>         ------------
>          SMI Common
>         ------------
>              |
>   +-----+--------+-----+- ...
>   |     |        |     |
>   |  gals-rx  gals-rx  |
>   |     |        |     |
>   |     |        |     |
>   |  gals-tx  gals-tx  |
>   |     |        |     |
> larb1 larb2   larb3  larb4
>
> GALS only help transfer the command/data while it doesn't have the
> configuring register, thus it has the special "smi" clock and doesn't
> have the "apb" clock. From the diagram above, we add "gals0" and
> "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
>
> This patch adds gals clock supporting in the SMI. Note that some larbs
> may still don't have the "gals" clock like larb1 and larb4 above.
>
> This is also a preparing patch for mt8183 which has GALS.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

So really from a software perspective the gals are just a couple of
extra clocks that need to be turned on for certain larbs. Seems fine
to me.

Reviewed-by: Evan Green <evgreen@chromium.org>
