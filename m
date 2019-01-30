Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2644C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F151218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548840421;
	bh=tUq72VSzYnNFVYGVT8BF1ZCDNBx1RY5oWvsyX6oy5MQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SYsG8kq/5mTPuK76Mm1EXFPQ4sTGDtkQvoRFLKQvwRxyy9m+zUh0yXDd5ySCxdFU4
	 3ZcBeLNiAS8ykiSGEAFvvcxeZdo6sl4+L7Pf5Xi8etTG53pD8Jl5KjDcDZ5L+FHCSs
	 BfJ2GmnkZai4q1vDmWQuc/5M1dzxhDevw1WIZmDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfA3J07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:26:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfA3J07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:26:59 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A76820882;
        Wed, 30 Jan 2019 09:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548840418;
        bh=tUq72VSzYnNFVYGVT8BF1ZCDNBx1RY5oWvsyX6oy5MQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ONG0lOxvnARllj/oVOC/uCAsh30UDos1+xUH2PSbsFCAuPQPT6UW8SyDPxK9P3Tgn
         RXRHnWnTObp0rwsdvjPWzv1SLvA6vTRyBnCPelNWWfGTW8VVtM3bBicDXIcnqCBV0K
         CAxEBjvtFNzvSXliH5gczu7xspCf1cMdNPADzpT4=
Date:   Wed, 30 Jan 2019 10:26:46 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     masonccyang@mxic.com.tw, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI
 controller driver
Message-ID: <20190130102646.23c798fc@bbrezillon>
In-Reply-To: <e4351834-5c7d-b751-b3c7-97dce5207783@gmail.com>
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
        <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
        <bb63b646-b549-dc3b-a604-17ba156e735c@gmail.com>
        <OF767ACC95.EECC73BE-ON4825838C.000BD6A3-4825838C.000D23A6@mxic.com.tw>
        <67fa5f94-886b-f09c-c93d-832e427ffec8@gmail.com>
        <OF891E176A.614DBEEF-ON4825838C.0022D454-4825838C.002396ED@mxic.com.tw>
        <0b3ea94f-a4f3-0780-301b-f88ff2ad2fb1@gmail.com>
        <OFEAAE10B4.20C3E45D-ON48258390.0007CD37-48258390.0009066E@mxic.com.tw>
        <2d762c16-d714-9171-9450-b6adf1a6509c@gmail.com>
        <OF1DC7FF88.3574E5B9-ON48258391.000A5001-48258391.000D5DDE@mxic.com.tw>
        <a0f86e7c-dd16-f3fa-5387-b0da6900975c@gmail.com>
        <OFA6EF1EB2.198B44D0-ON48258392.00099520-48258392.000D03A4@mxic.com.tw>
        <e4351834-5c7d-b751-b3c7-97dce5207783@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 08:15:25 +0100
Marek Vasut <marek.vasut@gmail.com> wrote:

> >> > So far as I know that HF is provided by Cypress only and
> >> > any mass production product use the component which is provided by only
> >> > one provider
> >> > will be a big risk.
> >> >
> >> > Compare to HF, there are more provider of SPI/Octa could support the
> >> > mass production product
> >> > as their second provider.
> >> >
> >> > In addition, from the technical points of view, mx25uw51245g is more
> >> > powerful than HF and
> >> > good for complicate user application, i.e., OTA and so on.  
> >>
> >> Did you consider protocol overhead too ? I don't think you can compare
> >> them just by raw numbers of pins and bus frequency.
> >>
> >> Note that over-the-air update (if that's what you mean by OTA) is
> >> completely separate from the underlying storage device.  
> > 
> > It's key feature of mx25uw51245g supports Read-while-Write capability
> > that allows read access from one memory bank while writing to another
> > memory bank.  
> 
> Note that this sales pitch is rather off-topic.
> 

Fully agree with Marek on that point. The discussion is about
supporting both HF and SPI-MEM modes (or, at least have a plan to
support HF at some point) not figuring out which option is better.
