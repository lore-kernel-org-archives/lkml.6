Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5C227C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E4E2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pvCMFEHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E4E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934783AbeFLWEZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:04:25 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:50908 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934517AbeFLWEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:04:24 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5CM47An019373;
        Tue, 12 Jun 2018 17:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528841047;
        bh=zO8tc1lOgS80sb9AKW8h0tOGqTIGKD4d/N+bbpXdf8A=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pvCMFEHRF3kaY1hrA2Y13uec4imBQawAzj9hvpnnKI3YgEgctAh2I+64O8wIJJ0Fx
         RxQ1lBMdzCQXYbvFp6kGT1lrmih9KPty0kV+gJ6uvqPDHfs89XR5Iu7/Q8zbdZfl1n
         +7j1URQJqbNhcdEDflHoITFNRsi9WQC/aot0SW1Q=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5CM47av015437;
        Tue, 12 Jun 2018 17:04:07 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 12
 Jun 2018 17:04:07 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 12 Jun 2018 17:04:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5CM46BV001565;
        Tue, 12 Jun 2018 17:04:06 -0500
Date:   Tue, 12 Jun 2018 17:04:06 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>
Subject: Re: [RFC PATCH 5/8] dt-bindings: mailbox: ti,message-manager: Add
 support for secure proxy threads
Message-ID: <20180612220406.t4mkcht3ubwo3hej@kahuna>
References: <20180605061629.4759-1-nm@ti.com>
 <20180605061629.4759-6-nm@ti.com>
 <20180612211128.GA22038@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180612211128.GA22038@rob-hp-laptop>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:11-20180612, Rob Herring wrote:
[...]
> > diff --git a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
> > index ebf0e3710cee..de796e90cac6 100644
> > --- a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
> > +++ b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
> > @@ -7,22 +7,40 @@ manager is broken up into queues in different address regions that are called
> >  "proxies" - each instance is unidirectional and is instantiated at SoC
> >  integration level to indicate receive or transmit path.
> >  
> > +This can also be used to describe Texas Instrument's Secure Proxy
> > +controller that allows for individually configurable "threads" or
> > +"proxies" which allow for independent communication scheme.
> 
> There seems to be very little re-use here. I think I would make this 
> its own doc.

Agreed. will do the same in the formal series. Thanks.
-- 
Regards,
Nishanth Menon
