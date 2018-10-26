Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F0C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723BB2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+VP3fvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723BB2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeJZPjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:39:37 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50456 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeJZPjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:39:36 -0400
Received: by mail-it1-f196.google.com with SMTP id k206-v6so450287ite.0;
        Fri, 26 Oct 2018 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xXhSABEiYpQX7leb47qhFB5v2XKSmiTokszviA/+7mY=;
        b=K+VP3fvvHpyLIn9YLQT1kpal3NCKlEjW83nvlWbN85GNcJRpvbUpXA0WDFJEsGRUlu
         GFwI9+IuTKiqH/yDVsWvC6HmnbUlzmXYQdLNv5GF9SrHoclE71xY1k7pmsR8Cbq6ukbe
         IT2SOUYqBIInrmg7feibnskTDKJ3jgAnSpvHL8Z+Vfvn2KcY5FTfvw41mfXsfmYpJE9e
         vEgSdsc1NoSjr5FUMPNZueVYPy84FaMPd1sqHYDkMFVMsQnk0FLtJnUFsMaZ4Ws+QtpS
         Ps1cQ93DXeJSSu8AJLDnsxeL+bn7eeAAJ7vOWtCit8fZCwPN/pG31LFFIMz8/FsqOFa3
         2MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xXhSABEiYpQX7leb47qhFB5v2XKSmiTokszviA/+7mY=;
        b=mUFWawS1+nEukl72P34i/XF/QeQqmrItqIU8UVEMr0tYHzEFAy+zTNDCsQ907Fq6gW
         1DpmRPmTeaK3eyOqEzOas5jF+4lFHd+/RRks9nmMXrD45dgt5Aqwm5Tr2zxSPZBK3A8z
         ePWcjjWXDS4yWc0LYiZrn7vDBuX1hmqp7b1uhvwlnm2UHask9ZlqLUtiptVLbZWKKkPQ
         1Wkp9g6L57KgUbdcEh2YFPsf5NjQLg3NcU7Q1zPlBb5xNKZDvBcHySMOYDdQVTKONauy
         MjtZsMFjUma3qcIel+c/GEStsPqdKrQw/l7Geg6Nn8F3Y9nDzGs7zs3iLwy+B6AqUCrr
         GTYw==
X-Gm-Message-State: AGRZ1gJvwKas5Dr6LhAg1pxsGH1EoRhwL1W9iBc2f9xtWthgdT4zfVJo
        Al6yPhC9CSPqIs9Jta5M1cf0FNJx
X-Google-Smtp-Source: AJdET5dGr/5QyPCBoVn5c09ToZZUb71C5IhfkD5zeZcm0bT+YTXWdNQwRHwtwTARj+ZqcaJQCrhdng==
X-Received: by 2002:a24:3795:: with SMTP id r143-v6mr3077550itr.43.1540537428678;
        Fri, 26 Oct 2018 00:03:48 -0700 (PDT)
Received: from Pilot130 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.gmail.com with ESMTPSA id p185-v6sm1559468itg.34.2018.10.26.00.03.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 00:03:47 -0700 (PDT)
Date:   Fri, 26 Oct 2018 12:37:28 +0530
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     Vinod <vkoul@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20181026070726.GA30088@Pilot130>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
 <1539749466-3912-9-git-send-email-open.sudheer@gmail.com>
 <20181017060531.GU2400@vkoul-mobl>
 <351eecd5b1b21893e94f76b34c058c6257b7f837.camel@kernel.crashing.org>
 <20181018095507.GC2400@vkoul-mobl>
 <a3fecf7913d6a85a6294afbc5a1a18b7714d6756.camel@kernel.crashing.org>
 <20181019071154.GE13642@Pilot130>
 <20181020162624.GC2894@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020162624.GC2894@vkoul-mobl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 09:56:24PM +0530, Vinod wrote:
> On 19-10-18, 12:41, sudheer.v wrote:
> > On Fri, Oct 19, 2018 at 10:32:24AM +1100, Benjamin Herrenschmidt wrote:
> > > On Thu, 2018-10-18 at 15:25 +0530, Vinod wrote:
> > > > 
> > > > > It's not a dmaengine driver. It's a serial UART driver that happens to
> > > > > use a dedicated DMA engine.
> > > > 
> > > > Then I see no reason for it to use dmaengine APIs. The framework allows
> > > > people to share a controller for many clients, but if you have dedicated
> > > > one then you may use it directly
> > > 
> > > Well... the engine is shared by a few UARTs, they have dedicated rings
> > > but there's a common set of regs for interrupt handling etc.
> > > 
> > > That said, I still think it could be contained within a UART driver,
> > > there's little benefit in adding the framework overhead, esp since
> > > these are really weak cores, any overhead will be felt.
> > > 
> > > Ben.
> > > 
> > > > > It's unclear whether it should be split into two drivers, or just have
> > > > > the serial driver directly use the dma engine since that engine is
> > > > > dedicated in HW to only work on those UARTs and nothing else...
> > > > > 
> > > > > Cheers,
> > > > > Ben.
> > 
> > Initially we wanted to have  a single driver,
> > however we had an informal discussion with one of the maintainer 
> > and based on the feedback, followed the Linux DMA and UART architecture.
> > 
> > If this seperate DMA-engine driver adds more overhead than benifit,
> > we will merge them into a single UART driver and resubmitt the patches.
> > Vinod,
> >       can this dma-controller driver sit under dma subsystem?.
> >       or better to move it under UART framework.
> 
> 
> My advise would be to see what you can do with the DMA IP block. If this
> can/would be used in different places then it would make sense to do a
> dmaengine driver and solve the problem for everyone.
> 
> If this is always going to be hidden behind serial then maybe it makes
> sense to be inside serial driver and not use dmaengine APIs
> 
> If you decide to prefer the former case, please move it to dmaengine and
> resubmit :)
> 
> HTH
> -- 
> ~Vinod

Hi All,
 As the DMA engine is dedicated only to UART,we have decided 
 to rewrite the driver so that no code will come under 
 drivers/dma.
 
 I will resubmitt the patches after merging dma controller
 code and uart driver code.
Regards
-sudheer

