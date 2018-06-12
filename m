Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1E32BC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75DE2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="koadCMEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75DE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934748AbeFLWD5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:03:57 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:50891 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbeFLWDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:03:54 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5CM3XRD019304;
        Tue, 12 Jun 2018 17:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528841013;
        bh=VJwn7nFgXFDQKZGq3aSkBOQq49NLq+WJVyh4kfPoc1c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=koadCMEKuF0451H/CmudW10QpAaPxyTTJ/EoluP2X4NS9PxukAY54R7F7QTSEJe+c
         BLvAcRSmq7exlpZ57R9jheAeoIKpyiyKv71cTOadM5mOww7EuQ9J6Foe8j7hMFRZlq
         IigBDRKIlq1DCXmF3h9luWOIMtOCZdj5ldLD5WJc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5CM3XEE006657;
        Tue, 12 Jun 2018 17:03:33 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 12
 Jun 2018 17:03:33 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 12 Jun 2018 17:03:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5CM3XHo012959;
        Tue, 12 Jun 2018 17:03:33 -0500
Date:   Tue, 12 Jun 2018 17:03:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [RFC PATCH 3/6] serial: 8250_omap: Add support for AM654 UART
 controller
Message-ID: <20180612220333.4odussbccwmup26v@kahuna>
References: <20180605060125.9518-1-nm@ti.com>
 <20180605060125.9518-4-nm@ti.com>
 <20180612210640.GA20728@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180612210640.GA20728@rob-hp-laptop>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:06-20180612, Rob Herring wrote:
> > diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
> > index 4b0f05adb228..c35d5ece1156 100644
> > --- a/Documentation/devicetree/bindings/serial/omap_serial.txt
> > +++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
> > @@ -1,6 +1,7 @@
> >  OMAP UART controller
> >  
> >  Required properties:
> > +- compatible : should be "ti,am654-uart" for AM654 controllers
> 
> Not compatible with any existing TI 8250 UARTs?

Base is compatible, however there are differences in DMA operation and
few additional bits. omap4-uart is sufficient for a basic PIO mode of
operation given initialization a bootloader might do for base console.

I will split the bindings off into it's own patch to keep the confusion
to a minimum and allowing serial driver change to go in independently.

-- 
Regards,
Nishanth Menon
