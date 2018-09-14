Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB93FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A87C2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obeliks.de header.i=@obeliks.de header.b="d+8lwTx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A87C2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nospam.obeliks.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeINS5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:57:25 -0400
Received: from scopuli.esotechnik.de ([79.143.188.15]:38313 "EHLO
        mail.esotechnik.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINS5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:57:24 -0400
Received: by mail.esotechnik.net (Postfix) with ESMTPSA id AF139AE002F;
        Fri, 14 Sep 2018 15:42:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=obeliks.de; s=jul2017;
        t=1536932567; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eniRlcvYbY4fXagTAFAFBGkGJSzEYcbbjsH1yaz5mMM=;
        b=d+8lwTx57KRZ0qeS3bfgIBGgeMllk/jN9WaQ+EX6vlY70AIDB9fPDtv1fhAaI5S4WqdFKt
        aix8ymv4HC9CjZAPvzWRKKouvzXMNHILoDSXk6RGeJIlcJoV1w3pT0bnpwCjv9VH8IC+5E
        MoB7B7ybNEMf8GQEMBB2rOoM/Wpi+MRi5ObK6dMsU79Jab2WPfczmJT9pdSi/Lm1VGyi6m
        +WHtVP00u5B+ovl4nymwQiWy73eLi/09/MPqhXqvoOvZ7SpenD+CP/4wrep06E/naSaWQG
        JrwFZkU/cKHUlon7wgb4EyR58gVlV9SRWM490zKQkJgqMEC5NNPRTvaV/43uQA==
Date:   Fri, 14 Sep 2018 15:42:46 +0200
From:   Bernhard Frauendienst <kernel@nospam.obeliks.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek =?utf-8?B?VmHFoXV0?= <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] mtd: mtdconcat: add dt driver for concat devices
Message-ID: <20180914134246.GB5913@dellux>
References: <20180908131345.8145-1-kernel@nospam.obeliks.de>
 <20180908131345.8145-4-kernel@nospam.obeliks.de>
 <CAL_JsqL+CMzkyeHLxa+6xf0FkM3mSPiGvoMrRoVV-FS1Q7SQsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqL+CMzkyeHLxa+6xf0FkM3mSPiGvoMrRoVV-FS1Q7SQsA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

sorry it took me so long to reply, I had to set up mutt first ;)

On Mon, Sep 10, 2018 at 04:47:22PM -0500, Rob Herring wrote:
> On Sat, Sep 8, 2018 at 8:20 AM Bernhard Frauendienst
> <kernel@nospam.obeliks.de> wrote:
> >
> > Some mtd drivers like physmap variants have support for concatenating
> > multiple mtd devices, but there is no generic way to define such a
> > concat device from within the device tree.
> 
> That is the generic way, but I suppose that only works for parallel
> memory mapped devices. So is it just spi-nor that you need to support?

I'm no expert in this domain, or regarding OpenWRT, but as far as I can
tell this only concerns spi-nor devices. It definitely does in my
specific use-case.

> Can we just make reg take multiple chip selects just like the existing
> support takes multiple reg entries?

That sounds like an interesting idea, but I'm afraid it's not a trivial
change, as far as I can tell from looking at spi.c. 

The 'reg' property is currently read in of_spi_parse_dt which gets
passed the spi device created in of_register_spi_device. The latter
would have to create multiple devices from a single OF node, and pass
the chipselect value to of_spi_parse_dt, which would have to parse the
same node multiple times, which feels a bit strange. To make things
worse, of_register_spi_device returns the created device, although that
value seems unused in the current tree (except for error checks).

Am I correct to assume that this change in method signature could be
accteptable since both functions are not exported?

Regards,
Bernhard
