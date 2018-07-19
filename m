Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC38EC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B5E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yrfhCsg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B5E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbeGSTSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 15:18:43 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60910 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbeGSTSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 15:18:43 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6JIYH8A085016;
        Thu, 19 Jul 2018 13:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532025257;
        bh=LR+wVegPcsrJwgcyyp2M5e7JGdgNRc+u1B0h55KHgS8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=yrfhCsg77RnVSJpmmjV1xwk2x52bJVhkcXWPS3J5meEFu5YSoFY1rTbnrJsuJoGZZ
         s2tZHdysq9HYl/Fyj5zvz7/tkGHCc7H3cPJXaNSepOuDg+QZuHF1dJ4llOm1gqePEE
         m1uK9SimPxxc2M7sBJ89r+kpeCndx8T7xpERmtN0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6JIYH6g030820;
        Thu, 19 Jul 2018 13:34:17 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 19
 Jul 2018 13:34:16 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 19 Jul 2018 13:34:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6JIYG3l005379;
        Thu, 19 Jul 2018 13:34:16 -0500
Date:   Thu, 19 Jul 2018 13:34:16 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Call musb_platform_exit from musb_stop
Message-ID: <20180719183416.GE3949@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20180719101038.9465-1-jagan@amarulasolutions.com>
 <20180719153706.GD3949@uda0271908>
 <CAMty3ZCTFMvOtc78eoLULLzhgufVEcX0YUexCn94QAkpLLpqMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCTFMvOtc78eoLULLzhgufVEcX0YUexCn94QAkpLLpqMQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:16:18PM +0530, Jagan Teki wrote:
> On Thu, Jul 19, 2018 at 9:07 PM, Bin Liu <b-liu@ti.com> wrote:
> > Hi,
> >
> > On Thu, Jul 19, 2018 at 03:40:38PM +0530, Jagan Teki wrote:
> >> musb stop is musb core call during unregister or shutting down
> >> gadget or host musb. For graceful exit add musb_platform_exit
> >> on musb_stop so-that it can exit the musb platform driver as well.
> >
> > Thanks for the patch. but musb_stop() is called in the .udc_stop() and
> > host .stop() hooks, which can stop (and restart) at any time by the udc
> > or host core, not really during unregister. musb_platform_init() is not
> > called in .udc_start() and .start() hooks, so we shouldn't add
> > musb_platform_exit() in musb_stop().
> 
> Thanks for the explanation.
> 
> Look like musb_platform_exit calling during musb_remove call of
> platform driver. can you explain how the shutdown sequence happen
> because of if udc_stop call musb_stop to shutdown how come

musb_stop() only disables for example irq and session. I didn't read
how udc_stop() is used though.

> platform_exit will shutdown it's PHY and CLK bits. or is it in

platform_exit() is called in musb_remove().

Not sure if this answers your question though.

Regards,
-Bin.
