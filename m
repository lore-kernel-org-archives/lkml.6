Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0103ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9880021476
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlmgDcpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9880021476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbeGQOt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbeGQOt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:49:28 -0400
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com [209.85.223.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3A22147A;
        Tue, 17 Jul 2018 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531836996;
        bh=aaQS83AgV6FyHWujCE4DARS7b+YY+/fu+Lg6v7ZJvDk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SlmgDcpf/9eSOXQSRgI5duaIgXwj7aunvyBPjpJsbkcNm9jxYqR8OgcDpG5/c7ZDS
         L+SURq/o3H1UUwxr1fP8pnZt7xwwh031H3UXTHq6E9CF6LLVBngbAy7/6bgGSn67JF
         NHV0klD+IIKcIMQs2XeKmvf5hsXZhbdnW9+8DfyU=
Received: by mail-io0-f170.google.com with SMTP id q4-v6so1114517iob.2;
        Tue, 17 Jul 2018 07:16:35 -0700 (PDT)
X-Gm-Message-State: AOUpUlHJl2TharRHJd9Y8OmvxmnojrA2M8Jqk6kpT+Zbii3gYiPEg/ki
        NWqRI3KzCIDRlrLcNyYikgtfUsZ0xIbjwsQIsQ==
X-Google-Smtp-Source: AA+uWPyWs/mlXvVQzk8ldIA4juAnncruvuXKwQchzv/PGPXFBpuhzjwscIdGaLZv361ZSGD+EZzY7SHRbFps6bI/Xnc=
X-Received: by 2002:a6b:6407:: with SMTP id t7-v6mr1662452iog.111.1531836995334;
 Tue, 17 Jul 2018 07:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <1530261541-23104-2-git-send-email-hayashi.kunihiko@socionext.com>
 <20180716205049.GA3663@rob-hp-laptop> <20180717195531.8587.4A936039@socionext.com>
In-Reply-To: <20180717195531.8587.4A936039@socionext.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 17 Jul 2018 08:16:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKjC3J16uk2GTQyTquMbvO5Aw6kr4BfdNLAfZHD3MuBgQ@mail.gmail.com>
Message-ID: <CAL_JsqKjC3J16uk2GTQyTquMbvO5Aw6kr4BfdNLAfZHD3MuBgQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: phy: add DT bindings for UniPhier USB3
 PHY driver
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 4:55 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Hi Rob,
> Thank you for your comments.
>
> On Mon, 16 Jul 2018 14:50:49 -0600 <robh@kernel.org> wrote:
>
> > On Fri, Jun 29, 2018 at 05:38:58PM +0900, Kunihiko Hayashi wrote:
> > > Add DT bindings for PHY interface built into USB3 controller
> > > implemented in UniPhier SoCs.
> > >
> > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > ---
> > >  .../devicetree/bindings/phy/uniphier-usb3-phy.txt  | 118 +++++++++++++++++++++

[...]

> > > +Optional properties:
> > > +- phy-supply: A phandle to the regulator for USB VBUS.
> >
> > The phy actually needs Vbus or you just want to control Vbus from the
> > phy driver?
>
> To enable each USB port correspond with phy, we must enable Vbus for each port.
> However, the host driver doesn't have the way to control regulators directly,
> then I think it is reasonable to control Vbus by using phy regulator.

DT should reflect the h/w. If Vbus rail is powering the phy then it
should be in the phy node. If you just happen to want to put Vbus
control in the phy driver, that's an OS problem and doesn't belong in
DT. In that case, Vbus should be described as part of a USB connector
node and any driver can walk the tree or graph and get Vbus regulator.

Rob
