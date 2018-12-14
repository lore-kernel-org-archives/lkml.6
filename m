Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5EEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE8320675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544797584;
	bh=7AoKG3eqe/WO6bQ1bLcmlTBRXX0iKUFEjRfylaAotLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RypZuKI7VKTO0kXxiz/27SuwTShm72QcqrwjFtImue8yz6/6iGoji1Y1C+6bCNjoN
	 nWaykqqDWD/VSJ2/p4UBlcTw8A1ehFgRj3gmkqJTFcEdPRSw0HQW2nNJ0nE0CANVfV
	 GGBUNV1J85RnzQ8DFOTkJKVLYUpcQPVfU6SghLNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbeLNO0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:26:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbeLNO0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:26:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7755620656;
        Fri, 14 Dec 2018 14:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544797582;
        bh=7AoKG3eqe/WO6bQ1bLcmlTBRXX0iKUFEjRfylaAotLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y021M+mQzxobi5qczRM3vfT5UxyZR3HMWF4eY1ftgJ4sypeCtG1ISGJq0Ux3F3Amv
         IgxqtfpqPb+B+W1dRHKI1NGeC/DkiOrvLBbcnxhscFVQ+moHyUFTNlzY+iulq6sDT5
         yikaz4zwr4s3qpcagyiIadG0V06WrMCVsHeatQjw=
Date:   Fri, 14 Dec 2018 15:26:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, edumazet@google.com,
        soheil@google.com, ycheng@google.com,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.14 12/89] tcp: Do not underestimate rwnd_limited
Message-ID: <20181214142621.GA28340@kroah.com>
References: <20181214115729.658859279@linuxfoundation.org>
 <20181214115730.277730409@linuxfoundation.org>
 <CADVatmN2tM+zNFmz+upPpV4+g1R1+kg62yL8Q=8jJ4Sy2EU6Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmN2tM+zNFmz+upPpV4+g1R1+kg62yL8Q=8jJ4Sy2EU6Xw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 02:03:55PM +0000, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Fri, Dec 14, 2018 at 12:08 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Eric Dumazet <edumazet@google.com>
> >
> > [ Upstream commit 41727549de3e7281feb174d568c6e46823db8684 ]
> 
> There is one upstream commit which fixes this one.
> f9bfe4e6a9d0 ("tcp: lack of available data can also cause TSO defer")

I can take this if Eric and/or David ack it :)

thanks,

greg k-h
