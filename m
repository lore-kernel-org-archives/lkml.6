Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93849C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A622146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vXWPOtVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A622146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeLAC20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:28:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbeLAC2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:28:25 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B17121473
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543591126;
        bh=QCW8ckCIFFEcd0zf2KZidZdQjbGAkx/mgX7p6oQzpSE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vXWPOtVw1cCWDc/iwmtqW3yxVxm4UIEk+NqpPh9I+r44Wi1Yq+CokBtErmrUhtjvy
         INqdBPsZ0mD+JD8NlqFeYZlcq5Mz9Hpohq9yEXhK5u56xbsd4nRiHb3EcSrHnGRKXS
         HmNCQloXTyDHHEngpusjTkQx1T0EeZDRDMqrwnsA=
Received: by mail-qt1-f182.google.com with SMTP id v11so6274842qtc.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 07:18:46 -0800 (PST)
X-Gm-Message-State: AA+aEWZnmhE0RYdEbMW6E0h7wTN6Sooz0yuB9nHgrZxAMMlilInSUVUI
        XrnsNeyKcVMFNJy41GfF0y7wq4MYlr5WaDtNKQ==
X-Google-Smtp-Source: AFSGD/UJeAX9yfrb/mzIcU++PZZzonDdREYayVLPHmHujQle0jOTWhI7iEiBYo20x4pfg0mcJ51BGgIUWazb+rqbm0U=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr5017205qtj.76.1543591125348;
 Fri, 30 Nov 2018 07:18:45 -0800 (PST)
MIME-Version: 1.0
References: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com> <20181102183246.r5xxwsic2mxwihsi@localhost>
In-Reply-To: <20181102183246.r5xxwsic2mxwihsi@localhost>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Nov 2018 09:18:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+HFPnzw4Fo3rLRMxber8_itGZ=LjnUeyvvDOt4_txm3g@mail.gmail.com>
Message-ID: <CAL_Jsq+HFPnzw4Fo3rLRMxber8_itGZ=LjnUeyvvDOt4_txm3g@mail.gmail.com>
Subject: Re: [GIT PULL] sprd dts for kernel v4.20-rc1
To:     Olof Johansson <olof@lixom.net>
Cc:     chunyan.zhang@unisoc.com, Lyra Zhang <zhang.lyra@gmail.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 1:50 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Thu, Oct 18, 2018 at 05:17:33PM +0800, Chunyan Zhang wrote:
> > Hi Arnd,
> >
> > For 4.20-rc1 there's one patch only for sprd devicetree, please pull from my git tree:
> >
> > https://github.com/lyrazhang/linux.git m-v4.19-rc1
> >
> > Please let me know if there's some problem.
> >
> > Thanks,
> > Chunyan
> >
> > ----------------------------------------------------------------
> >
> > Suzuki K Poulose (1):
> >   arm64: dts: sc9836/sc9860: Update coresight bindings for hardware
> >     ports
> >
> >  arch/arm64/boot/dts/sprd/sc9836.dtsi |  78 +++++++------
> >  arch/arm64/boot/dts/sprd/sc9860.dtsi | 215 ++++++++++++++++++-----------------
> >  2 files changed, 151 insertions(+), 142 deletions(-)
>
> Hi,
>
> This came in right before the merge window so it wasn't included since
> it's more of a cleanup. Please resend it after -rc1 is out and we'll be
> happy to queue it up for 4.21.

I'm enabling by default the DT warnings that this fixes, so please pull it in.

Rob
