Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3678177-1521368660-2-10861999256319890498
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521368659; b=veI6nRMyH46Wpb/9wMBE6eTIsNEtkT3uqm9rOavQPfgNSDX
    Y7nn9jq/kwnArEq25rppo0CdbxQyToDJALuKZ8oRuSJJUMHe9ncYdPXc3Q67VlZ4
    PWVlliSXNSb3bTFsL8nfBAfdLfE/NbeYhKIV32SUUAH/JjEnuMz6FCMi4HoFghvb
    QDrlHdSOetWlwNjhDWIynErI7PT481kGuxuzcb6aHa4Ovaa75tBEJk7ezNMQlWZJ
    npJu/NPh5rr9deNaw5R1JuzLokykxQvjlcUyANcN4w8n/qzOExtiJ2DKW9XAldfN
    f4FtgudaejxEHMTmArGHc6drrW+HKx8uQ8rCvVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521368659; bh=PVTmYehXAkjWmardpTglOO8shs
    rZzOwPUVRuwJuoTHk=; b=bxhZf3P7oW1DOropqgC9nzFLd7RtI+ZCI2is99JDLh
    VEMHCCDbn/mJ6bBplFm89K3PYKtul0RQpt0aRiNTk6j90j21+nj39tf+htEXVUJy
    NSi++819KnbcgXoxbVDghlY7YVNc1Euak0MVnGXzfQbTrJ5zWUgiM61FS1WZcm06
    5LUP1DJYgsSEEOr1qO9UIHbyGa1pgjQ9aa9ukJKDkAEU17dItfy52edBeAIo0oLz
    nOE/AotQ2tY8eMoDDo4/44f9EAYUbjoPBnSlXwb2fuBAkGOKdjf/MG64iQjSyfP1
    HFUE5Lwp5UMFpzbbjBvmUsOniqxe6+Ylkjh6sh7etUXQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbeCRKYS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 06:24:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCRKYS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 06:24:18 -0400
Date: Sun, 18 Mar 2018 11:24:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Eric Anholt <eric@anholt.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.14 064/109] dmaengine: bcm2835-dma: Use
 vchan_terminate_vdesc() instead of desc_free
Message-ID: <20180318102417.GA30164@kroah.com>
References: <20180316152329.844663293@linuxfoundation.org>
 <20180316152333.462064800@linuxfoundation.org>
 <20180316184640.rxw6kwvqghsmdgcc@xps>
 <20180317143253.GI15443@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180317143253.GI15443@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 08:02:57PM +0530, Vinod Koul wrote:
> On Fri, Mar 16, 2018 at 01:46:40PM -0500, Dan Rue wrote:
> > On Fri, Mar 16, 2018 at 04:23:33PM +0100, Greg Kroah-Hartman wrote:
> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > 
> > > 
> > > [ Upstream commit de92436ac40ffe9933230aa503e24dbb5ede9201 ]
> > > 
> > > To avoid race with vchan_complete, use the race free way to terminate
> > > running transfer.
> > > 
> > > Implement the device_synchronize callback to make sure that the terminated
> > > descriptor is freed.
> > > 
> > > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > Acked-by: Eric Anholt <eric@anholt.net>
> > > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > This patch is causing a build error on arm and arm64 per i.e.
> > https://kernelci.org/build/id/5aac017e59b5141cb1b3a4d5/
> > 
> > Builds are also failing for arm/arm64 on 4.15 and this patch seems to be a
> > problem there as well, but I have not verified it yet.
> 
> I think we are missing commit 1c7f072d94e8. Pls cherrypick that as well
> 
> commit 1c7f072d94e8b697fd9b70cdb268622a18faf522
> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Date:   Tue Nov 14 16:32:04 2017 +0200
> 
>     dmaengine: virt-dma: Support for race free transfer termination
> 
> This adds vchan_terminate_vdesc API..

Thanks, that helped.  I've now added this and send out a -rc2 for this
kernel.

greg k-h
