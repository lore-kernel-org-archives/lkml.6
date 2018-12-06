Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95518C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5315D20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544113424;
	bh=P2fIXxw8SA4TP0x0ycc2DiUzDEMtrWNJsRfrocsylcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J5HuTXfQ9LxbBP3Zq5++pZ0G4dDEqHedyHfWJuC3sAVtco/1R9xTE86tAm7oJHNhH
	 4F3QGYnyVSr0fx23ABKp9uAuX5ked+h1+1XR2kYU6IzyymdxpW3ZJxttyE8jsozbc4
	 hFeIa4sCYTX19p95oVncvUbrsDFSEmIxd++I/Yh4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5315D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeLFQXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:23:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLFQXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:23:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB0C920659;
        Thu,  6 Dec 2018 16:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544113422;
        bh=P2fIXxw8SA4TP0x0ycc2DiUzDEMtrWNJsRfrocsylcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3Mz1FpiGsCWCoaJjr19rPGGTxuhlIImizYfNBhiwW7RBPEShyGQ03n1gewzHCvWW
         U92V7TO+/NNPl8NepbjoLwxiONKhqtWAzZ11WbM35XeCJwufGjRYi8umoG1l8MHRmH
         AjAtFmj7wM1DHS+0lcIZxz5zUaEIQ7b6aY9al60M=
Date:   Thu, 6 Dec 2018 17:23:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc:     Sicilia Cristian <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, Alex Elder <elder@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH 2/2] staging: greybus: Added space between string
 concatenated
Message-ID: <20181206162340.GA12032@kroah.com>
References: <cover.1543956271.git.sicilia.cristian@gmail.com>
 <5b215b50d4da9a7730450a83fb5e3a167b65e03a.1543956271.git.sicilia.cristian@gmail.com>
 <42632636-9b08-bd75-b789-88ef82f52c2c@nexus-software.ie>
 <20181205210034.GA24054@peano>
 <e7902148-4f80-2d9c-7f51-d6bd21bf9eff@nexus-software.ie>
 <20181206150516.GA1774@kroah.com>
 <131a4c41-2c5f-a660-5190-52ce5d59e532@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <131a4c41-2c5f-a660-5190-52ce5d59e532@nexus-software.ie>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 04:14:53PM +0000, Bryan O'Donoghue wrote:
> On 06/12/2018 15:05, Greg Kroah-Hartman wrote:
> > On Thu, Dec 06, 2018 at 09:43:46AM +0000, Bryan O'Donoghue wrote:
> > > On 05/12/2018 21:00, Sicilia Cristian wrote:
> > > > It doesn't change the result string
> > > 
> > > So why do it then ?
> > 
> > Because it is easier to read this way and odds are checkpatch is
> > happier.
> 
> Fine.
> 
> Sicilia could you please amend your commit.
> 
> 'This patch fixes the checkpatch error "CHECK: Concatenated strings should
> use spaces between elements"'
> 
> and then feel free to add my
> 
> Acked-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>

It's already in my tree, no need to ammend it, sorry :)

greg k-h
