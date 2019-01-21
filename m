Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590AEC2F420
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2921B20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548082537;
	bh=jDw5ROZDgCpNfHjGbyRcEW8lrmPIwlxOCU8ON5jZtvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g/0F28WM70X55Um/+XAHpObSV10rzuPFXjTrA+q8all8P0EqQyO8+U7nueDLElGwZ
	 mtS8ybbHXYbdUcAqlisikjeJYqijMrWRCwn7R5qUfoUfQaE7TmlDWfzNAx1nUWcA7A
	 EGnY8dUNzYXgvD4PZep/NXMSR1OAS59nv/9F3UFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfAUOzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:55:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbfAUOze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:55:34 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36EA220861;
        Mon, 21 Jan 2019 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548082533;
        bh=jDw5ROZDgCpNfHjGbyRcEW8lrmPIwlxOCU8ON5jZtvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3C3EZrbffoLz8SfEWy1K+1cYl8BCPiWrJ4SdLxxM9SeCEhhb3QeYuDC+K4ZqRXRI
         uugfiM6v/gNGcTcY8WMru81RXU7ZIuxlIp+0ydzcMyGyDibqIhCHEk2Sf/97pzPuzx
         1NA2eAnnMCEt8q9G9XPiNFE5t02w/BmTaVpH5vCM=
Date:   Mon, 21 Jan 2019 22:55:24 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 2/2] dt-bindings: interrupt-controller: Update csky
 mpintc
Message-ID: <20190121145524.GA5283@guoren-Inspiron-7460>
References: <1547830371-22122-1-git-send-email-guoren@kernel.org>
 <1547830371-22122-2-git-send-email-guoren@kernel.org>
 <CAL_JsqKjQK-qViMm55EiP5hXjfr04++5vBTAXCEa6yg9u1qCaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKjQK-qViMm55EiP5hXjfr04++5vBTAXCEa6yg9u1qCaQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 08:12:15AM -0600, Rob Herring wrote:
> On Fri, Jan 18, 2019 at 10:53 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > Add trigger type and priority setting for csky,mpintc.
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  .../bindings/interrupt-controller/csky,mpintc.txt  | 33 +++++++++++++++++++---
> >  1 file changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > index ab921f1..badbd38 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > @@ -6,11 +6,18 @@ C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
> >  SMP soc, and it also could be used in non-SMP system.
> >
> >  Interrupt number definition:
> > -
> >    0-15  : software irq, and we use 15 as our IPI_IRQ.
> >   16-31  : private  irq, and we use 16 as the co-processor timer.
> >   31-1024: common irq for soc ip.
> >
> > +Interrupt triger mode:
> > + IRQ_TYPE_LEVEL_HIGH (default)
> > + IRQ_TYPE_LEVEL_LOW
> > + IRQ_TYPE_EDGE_RISING
> > + IRQ_TYPE_EDGE_FALLING
> > +
> > +Interrupt priority range: 0-255
> > +
> >  =============================
> >  intc node bindings definition
> >  =============================
> > @@ -26,15 +33,33 @@ intc node bindings definition
> >         - #interrupt-cells
> >                 Usage: required
> >                 Value type: <u32>
> > -               Definition: must be <1>
> > +               Definition: could be <1> or <2> or <3>
> 
> For a given controller, '#interrupt-cells' shouldn't really be
> variable. If there are different capabilities, then you should have
> different compatible strings.
Ok, I'll Define it to <3>, see my next version of patch.

<irqnum trigger_type priority>

Best Regards
 Guo Ren
