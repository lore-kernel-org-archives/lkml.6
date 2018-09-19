Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6961DECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE5C214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yFS84Djd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE5C214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeISGhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbeISGhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:37:09 -0400
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com [209.85.216.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7369C214C2;
        Wed, 19 Sep 2018 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537318915;
        bh=O5uCOpRCh+bVcOML06VcxNzbgKAZCQA6YG+26zvhhWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yFS84Djdi9hPc//ouDWAHrSnHwbpe3yQRnbBaPlJqCUOWvFy5wYq7t5in2Rf7FuCX
         5nGUZRPd+CAa055cJvioagKxQgY9qiFwSrhJQAssV5DKrLX1yEEY6gCbNnf2pP4ljo
         aARUZsDbWTpXctSFvA6yxelFZElpZmxCTlx5Hvjs=
Received: by mail-qt0-f180.google.com with SMTP id r37-v6so3633178qtc.0;
        Tue, 18 Sep 2018 18:01:55 -0700 (PDT)
X-Gm-Message-State: APzg51DzeK/Ue4aV7QPYBh7alMEhuJlaatH6w2CqO0YhOIjcxX3E5nBk
        EiH7TJ7bLUxnpP4HLvan3FDrUwk/a7JUrwbBOw==
X-Google-Smtp-Source: ANB0Vdb9Jaw9sK2DnWfsq92V2hLOvBBBic5EohWBEo0m3/ZWf5C9COijRSmUKR/M+q/Rr6ctvsh5S7OHVtUJQ2CLe0c=
X-Received: by 2002:aed:2da7:: with SMTP id i36-v6mr23203081qtd.164.1537318914701;
 Tue, 18 Sep 2018 18:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
 <1536139607-16848-2-git-send-email-Anson.Huang@nxp.com> <5b9f3f5d.1c69fb81.bca6d.cdee@mx.google.com>
 <20180917180744.GB104770@dtor-ws>
In-Reply-To: <20180917180744.GB104770@dtor-ws>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Sep 2018 18:01:42 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKTm7Rc5a0Y4UMwpsTZm5amRRC8H6y0yWsOd4StmAWqJQ@mail.gmail.com>
Message-ID: <CAL_JsqKTm7Rc5a0Y4UMwpsTZm5amRRC8H6y0yWsOd4StmAWqJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: egalax-ts: add support for wakeup event action
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Franchi <marco.franchi@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 11:07 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sun, Sep 16, 2018 at 05:54:33PM -0500, Rob Herring wrote:
> > On Wed, Sep 05, 2018 at 05:26:47PM +0800, Anson Huang wrote:
> > > Add support for wakeup event action, this would allow the device
> > > to configure whether to be a wakeup source of system suspend.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
> > > index 92fb262..296a9cd 100644
> > > --- a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
> > > @@ -6,6 +6,7 @@ Required properties:
> > >  - interrupts: touch controller interrupt
> > >  - wakeup-gpios: the gpio pin to be used for waking up the controller
> > >    and also used as irq pin
> >
> > If the wakeup gpio is the same as the irq, then this should be removed
> > since wakeup-source replaces it.
>
> No, it does not: it is GPIO that we need to toggle to wake up the
> controller, not host, and we do not have generic API to map from IRQ to
> GPIO.

Ah, okay.

> This is also existing binding...

Right, I meant removed as in moved to deprecated. Sometimes we just
remove the documentation when deprecating.

Rob
