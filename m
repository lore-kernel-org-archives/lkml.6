Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C33ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2D620869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2D620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemonage.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeJSRRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:17:40 -0400
Received: from smtp3-1.goneo.de ([85.220.129.38]:53562 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeJSRRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:17:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 879E123F016;
        Fri, 19 Oct 2018 11:12:24 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id giTZjLlhmmzq; Fri, 19 Oct 2018 11:12:23 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 8603323F121;
        Fri, 19 Oct 2018 11:12:22 +0200 (CEST)
Date:   Fri, 19 Oct 2018 11:12:21 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Lei YU <mine260309@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] nfc: pn532_uart: Add NXP PN532 to devicetree docs
Message-ID: <20181019091221.GB26696@lem-wkst-02.lemonage>
References: <20181018144251.30028-1-poeschel@lemonage.de>
 <20181018144251.30028-2-poeschel@lemonage.de>
 <F2B73CDB-434A-41F5-8A9E-3E4E76DB89C9@holtmann.org>
 <20181018204129.GA25436@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181018204129.GA25436@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 03:41:29PM -0500, Rob Herring wrote:
> On Thu, Oct 18, 2018 at 05:03:13PM +0200, Marcel Holtmann wrote:
> > Hi Lars,
> > 
> > > Add pn532 to the trivial-devices.txt binding doc.
> > > 
> > > Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> > > ---
> > > Documentation/devicetree/bindings/trivial-devices.txt | 1 +
> > > 1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
> > > index 763a2808a95c..c580be08a380 100644
> > > --- a/Documentation/devicetree/bindings/trivial-devices.txt
> > > +++ b/Documentation/devicetree/bindings/trivial-devices.txt
> > > @@ -172,6 +172,7 @@ nxp,pcf2129		Real-time clock
> > > nxp,pcf8523		Real-time Clock
> > > nxp,pcf8563		Real-time clock/calendar
> > > nxp,pcf85063		Tiny Real-Time Clock
> > > +nxp,pn532-uart		NXP PN532 NFC-/RFID-Chip, using UART interface
> > 
> > is this really such a trivial device? It doesn’t require any GPIO to enable / reset the NFC chip?

It does not require any additional things like GPIO or Interrupts. These
are optional and at the moment not supported by the driver.

> Considering it supports multiple interfaces, it is not.
> 
> The '-uart' can be dropped and the same compatible used for any 
> of the bus connections because the device is bound based on the bus 
> type.

Ok.
I drop the '-uart' part from the compatible string and provide a
seperate, little binding doc, documenting the compatible string used.

But does this also have consequences for the already existing -i2c
driver? This one uses 'nxp,pn532-i2c' as compatible string.

Thanks,
Lars
