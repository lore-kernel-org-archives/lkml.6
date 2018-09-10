Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC16C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EA820870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgtYlM7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EA820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeIJUoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:44:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43861 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeIJUoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:44:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id m84-v6so18292925lje.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEbJEWlMHVxP+UhRF8B89+AHLSotHTA5G1nehBovDG0=;
        b=DgtYlM7Im5NNukyxs89CNMSeL16WKUDcr212uNpmPxqmwdwUZ0eDlqMl/y3hdz7OO/
         Nw/Wmv0VoUaYO8TYtU/+ZcWUdmG7BMX0t810v2Sv9xix2aGOM2NwL62NcaRO0np7w1DK
         PfbFhnSjtZLd+ZZ+I2tVe6oCWCGgfJc4E/H+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEbJEWlMHVxP+UhRF8B89+AHLSotHTA5G1nehBovDG0=;
        b=qqBViD/Osuux0tji6qoVv192D0YRugYUS3uTo19JtpzKq0F8Uh8VCstllkW2alpNWV
         tqJqv3oqGh3TxnOWKW/Ui1roXi/RQ+DQ75kaaVANfsf2sO2rXG1OcqRbdtV20OEZY6u1
         hMJrPwj4xz9BeiKJhwz7LN8HlY5OtHzctziEO3Jz+yYpI2lMEjnKfotOGCjaUpSGUlxJ
         /POKgop8Kha6qwVYPwK7WmvG2Fil6A6VWmuVwxsA2BVDDaYdkOOfCMNXY8YXu0CKGhrg
         Wp3DGnHjqzQi7F/Sh/zelXRzzqmbIkY38lnZaKF+Ru4UBHn3D93l+3xmVP9Efv4khkpn
         i0Lw==
X-Gm-Message-State: APzg51A4QMvMl3YouxBCyTko6/hdcqDk4dsIDYH1j5Yagntlg28znom0
        aPhbaxD3K/PtI26BUFWY9GoUFk/X9gX4tMv4bWsnqg==
X-Google-Smtp-Source: ANB0VdasTGkK93dgomE05TTkpWmjQqESt3Hi+f/iXBR6pR4PljEt0ILvIC5MPDo6l7EaE6+Fawf7dFAmvKe9349ickc=
X-Received: by 2002:a2e:240c:: with SMTP id k12-v6mr9961808ljk.135.1536594559002;
 Mon, 10 Sep 2018 08:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
 <20180730200232.GA31755@xps15> <CANLsYkzBfCydwDO-KyDub4X=GTy_dtv-478RyMReBEH6VybSAg@mail.gmail.com>
 <9e935bd9-1cd1-0fda-3d73-fe2487759a1c@arm.com>
In-Reply-To: <9e935bd9-1cd1-0fda-3d73-fe2487759a1c@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 10 Sep 2018 09:49:07 -0600
Message-ID: <CANLsYkwpFZcxaNdvcnag_-ywhWyE1yV6BT1sUx8-4i2dMdD8MA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] coresight: Update device tree bindings
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        coresight@lists.linaro.org, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Matt Sealey <matt.sealey@arm.com>,
        Charles Garcia-Tobin <charles.garcia-tobin@arm.com>,
        John Horley <john.horley@arm.com>, Al Grant <al.grant@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 at 09:35, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi Mathieu,
>
> On 31/07/18 16:06, Mathieu Poirier wrote:
> > [...]
> >
> >>>
> >>> Suzuki K Poulose (9):
> >>>   coresight: Document error handling in coresight_register
> >>>   coresight: platform: Refactor graph endpoint parsing
> >>>   coresight: platform: Fix refcounting for graph nodes
> >>>   coresight: platform: Fix leaking device reference
> >>>   coresight: Fix remote endpoint parsing
> >>>   coresight: Add helper to check if the endpoint is input
> >>>   coresight: platform: Cleanup coresight connection handling
> >>>   coresight: Cleanup coresight DT bindings
> >>>   dts: juno: Update coresight bindings
> >>>
> >>>  .../devicetree/bindings/arm/coresight.txt          |  95 +++++---
> >>>  arch/arm64/boot/dts/arm/juno-base.dtsi             | 161 ++++++------
> >>>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi          |  52 ++--
> >>>  arch/arm64/boot/dts/arm/juno.dts                   |  13 +-
> >>>  drivers/hwtracing/coresight/coresight.c            |  35 +--
> >>>  drivers/hwtracing/coresight/of_coresight.c         | 269 ++++++++++++++-------
> >>>  include/linux/coresight.h                          |   9 +-
> >>>  7 files changed, 359 insertions(+), 275 deletions(-)
> >>>
> >>
> >> Good day,
> >>
> >> I have applied patches 1 to 7.  I will wait for Rob's ACK before doing the same
> >> with 8 and 9.
> >
> > I just applied patch 8 and 9.
> >
> Sorry for the delay, but ARM SoC expects all the DTS changes to go via
> their tree. Please drop patch 9, I will route via ARM-SoC.

Done - it's all yours now.

Mathieu

>
> --
> Regards,
> Sudeep
