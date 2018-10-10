Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E08C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE9A214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyhiloYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE9A214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeJKCXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbeJKCXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:23:08 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766DC2150C;
        Wed, 10 Oct 2018 18:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539197979;
        bh=NTNwFHW4NnHcGIdJs7M1XEYgEubdydYqRG942JgEUQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kyhiloYDXtw+/k7aY8KJeBlwxS4PIV9xurX4pN0FTfquuJDl+oLjUSxg2IpgJphk3
         WT5Pnt+YpCkw+mTn4Hrvyamrdl/Ee4qxEcIpx9SSeyDn50ToXTjyXFoRNZ3Ayyxf8C
         QtuZ9RoauGKLWzwJL1Tbd+WdA0TeraiHm8SIrTwA=
Received: by mail-qt1-f172.google.com with SMTP id o17-v6so6977588qtr.1;
        Wed, 10 Oct 2018 11:59:39 -0700 (PDT)
X-Gm-Message-State: ABuFfojz8oeFNUzM5wVOjzBxhSKxqPtTuob/oetPsL9Fgvf2KOQbk6ia
        QhziIOA+nc6STy7wEhlwNgZteelloEqj/UPyhw==
X-Google-Smtp-Source: ACcGV61LVm6+gbDvX380AsowmoxBOs1DMwji4+grw8r3kSOW3luirD/f0/AyFEU7uC5N9D4j22MSwrh3N1803cwwWm4=
X-Received: by 2002:a0c:d4e5:: with SMTP id y34mr14268306qvh.106.1539197978661;
 Wed, 10 Oct 2018 11:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
 <CABGGisx-iLr+CQ=JjmHEe5J_Qqpf0yrgOmSOHa74GnfwE_RKsA@mail.gmail.com> <93cd9c43-6fe3-c691-005b-e27cf101c7d6@i2se.com>
In-Reply-To: <93cd9c43-6fe3-c691-005b-e27cf101c7d6@i2se.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Oct 2018 13:59:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK_MDQvePhEGJsk5CRQuzkOo+s3QjF7hcNZp_dVsbc9zQ@mail.gmail.com>
Message-ID: <CAL_JsqK_MDQvePhEGJsk5CRQuzkOo+s3QjF7hcNZp_dVsbc9zQ@mail.gmail.com>
Subject: Re: [Question] directory for SoC-related DT binding
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 7:04 AM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi,
>
> Am 10.10.2018 um 13:19 schrieb Rob Herring:
> > On Wed, Oct 10, 2018 at 6:08 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >> Hi,
> >>
> >>
> >> I see a bunch of vendor (or SoC) names in
> >> Documentation/device/bindings/arm/
> >>
> >> ./Documentation/devicetree/bindings/arm/altera
> >> ./Documentation/devicetree/bindings/arm/amlogic
> > Yeah, it's kind of a mixture of board/soc bindings mostly with some
> > ARM architecture, ARM, Ltd. IP, and SoC system reg bindings.
> >
> > Eventually, I'd like to not split board bindings by arch and maybe we
> > should move all the system/misc reg bindings out.
> >
> > [,,,]
> >
> >> I also see some vendor names in
> >> Documentation/device/bindings/soc/
> >>
> >> ./Documentation/devicetree/bindings/soc/bcm
> >> ./Documentation/devicetree/bindings/soc/dove
> >> ./Documentation/devicetree/bindings/soc/fsl
> >> ./Documentation/devicetree/bindings/soc/mediatek
> >> ./Documentation/devicetree/bindings/soc/qcom
> >> ./Documentation/devicetree/bindings/soc/rockchip
> >> ./Documentation/devicetree/bindings/soc/ti
> >> ./Documentation/devicetree/bindings/soc/xilinx
> >> ./Documentation/devicetree/bindings/soc/zte
> > This I believe is mostly SoC system reg bindings though there's
> > probably a few other things.
> >
> >> Confusingly, I see bcm, mediatek, rockchip
> >> in both locations.
> >>
> >> Is there any rule to choose one than the other?
> > Top-level SoC/board bindings in arm/ and anything else elsewhere ideally.
>
> in case of Documentation/devicetree/bindings/soc/bcm the directory
> contains SoC / board bindings, cpu-enable and a firmware binding.
>
> Is there any action required?

If there's a better location based on class/function, then moving them
would be nice.

> Btw the Broadcom SoC / boards from this directory has been left out for
> the yaml conversion [1] was this intended?

Yes, I'm not planning to convert all bindings for everyone myself.

Rob
