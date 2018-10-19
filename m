Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68662ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305E420869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsIgMhKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305E420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJSPNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:13:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46302 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeJSPNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:13:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so16055403pfb.13;
        Fri, 19 Oct 2018 00:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JDErUPvQjrQUI0PUQIGFZwln7G1kY7+iNR47A1Xqui4=;
        b=DsIgMhKiEf/HFAxN8EwaXeDTfGNg2JToTZibaK2PKvYi7IVqRva5sqy3nRltY2uuLN
         yKPoCIQnl1mvXVJDKWgs9+pu/brH3UXXzmvWrdFmshmT/a+HVqRrxJjuOmvdzoFh0ESV
         mFM0AAhXWIR21NCI0+OvJfheThaTanK3VmcSnx9FP8zXT/cCl4hveSTwb0RjxSCkHpjm
         V2Au1FhQa5S7Tg9oMxZoPvMz3YuccNfUyg8Vp+W76RjWi2HTmHTsanlnuuJNz22z6DGv
         K2nxQM4rQjVBaXScn5wtJToyJBPy2M1VYLOHS/fuuHwO3R5QMcmTNpcmwGqnQKvH6nDp
         bFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JDErUPvQjrQUI0PUQIGFZwln7G1kY7+iNR47A1Xqui4=;
        b=JUIsZpoHb/rqasFF7J2qgwo+zP2oYHlfYmyREvJjJVVNTcNgJD1UtwHzqouIxRZ/jM
         C9Ro5WwfocTTiGvLytC1hDFBJ6B2LEuFZ8QeMt3fmtlE1aLCTxOYyYcxtd40TnJiOzuu
         G1FYd0t6S3M2AZdUTarNQbZaK7V7XPae2YVN+/2CKnE0mXVmgSEWFpxQ9yLfNEnmxMM9
         2WBv0Lnjpg1NZQjPLRgzdKNbwZJaaLEa+AiobIPxhnPkXHEjvA0c0t7VyjIhj3uzf8Wq
         Yyfie43LlCzSBSDtMWHyqLrbikPCnuoGRfF9swfntVYj1iRmF6rdMsEL8ILWde3juopB
         wUBg==
X-Gm-Message-State: ABuFfogI/WK8Ls6Ko5aOBPHnHhrvSJkFPoeKSNbDG3Dkp80Oe5WN3YUr
        QqRUDtLpGV83NGaOD5aU9VY=
X-Google-Smtp-Source: ACcGV627LkIp7aqxJQUKPOOw8sFOJYBksNVrMqo83f40eErbGfRA39mLXsra00Nc7Xcu0GHQWen5iQ==
X-Received: by 2002:a62:d206:: with SMTP id c6-v6mr8447911pfg.8.1539932901182;
        Fri, 19 Oct 2018 00:08:21 -0700 (PDT)
Received: from Pilot130 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.gmail.com with ESMTPSA id 130-v6sm22296529pfz.174.2018.10.19.00.08.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 00:08:20 -0700 (PDT)
Date:   Fri, 19 Oct 2018 12:41:56 +0530
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Moese <mmoese@suse.de>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>
Subject: Re: [[PATCH] 8/9] DMA-UART-Driver-for-AST2500
Message-ID: <20181019071154.GE13642@Pilot130>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
 <1539749466-3912-9-git-send-email-open.sudheer@gmail.com>
 <20181017060531.GU2400@vkoul-mobl>
 <351eecd5b1b21893e94f76b34c058c6257b7f837.camel@kernel.crashing.org>
 <20181018095507.GC2400@vkoul-mobl>
 <a3fecf7913d6a85a6294afbc5a1a18b7714d6756.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3fecf7913d6a85a6294afbc5a1a18b7714d6756.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 10:32:24AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2018-10-18 at 15:25 +0530, Vinod wrote:
> > 
> > > It's not a dmaengine driver. It's a serial UART driver that happens to
> > > use a dedicated DMA engine.
> > 
> > Then I see no reason for it to use dmaengine APIs. The framework allows
> > people to share a controller for many clients, but if you have dedicated
> > one then you may use it directly
> 
> Well... the engine is shared by a few UARTs, they have dedicated rings
> but there's a common set of regs for interrupt handling etc.
> 
> That said, I still think it could be contained within a UART driver,
> there's little benefit in adding the framework overhead, esp since
> these are really weak cores, any overhead will be felt.
> 
> Ben.
> 
> > > It's unclear whether it should be split into two drivers, or just have
> > > the serial driver directly use the dma engine since that engine is
> > > dedicated in HW to only work on those UARTs and nothing else...
> > > 
> > > Cheers,
> > > Ben.

Initially we wanted to have  a single driver,
however we had an informal discussion with one of the maintainer 
and based on the feedback, followed the Linux DMA and UART architecture.

If this seperate DMA-engine driver adds more overhead than benifit,
we will merge them into a single UART driver and resubmitt the patches.
Vinod,
      can this dma-controller driver sit under dma subsystem?.
      or better to move it under UART framework.

Thank you.
-- Sudheer
