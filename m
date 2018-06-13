Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6CE6DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FA32086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD/Y9+zZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FA32086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935162AbeFMRNo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934817AbeFMRNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:13:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBB90208D4;
        Wed, 13 Jun 2018 17:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528910022;
        bh=C7ug3XdYYHSl6VhZLmCOTDu/lnL73BgHVzO201kyVOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fD/Y9+zZa3kWnW2ktzLvAPH28K720jvNGw2cWb+otshc8ilrmc8bPuuM7Cboomm04
         5vPLOd3kc8EGELutsoeqkkUUKDLRsj5lxcBq6632lP30exkz5Q+LReksvwMeiF4gpu
         2BE1wf/9xPIkNPC/hPG3mqULcj+aapE2bKSAGP9g=
Date:   Wed, 13 Jun 2018 19:13:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.4 110/268] nvme-pci: Fix nvme queue cleanup if IRQ
 setup fails
Message-ID: <20180613171320.GB28828@kroah.com>
References: <20180528100202.045206534@linuxfoundation.org>
 <20180528100214.621806271@linuxfoundation.org>
 <1528906474.2289.155.camel@codethink.co.uk>
 <20180613163007.GD5574@localhost.localdomain>
 <1528907855.2289.157.camel@codethink.co.uk>
 <20180613165631.GE5574@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180613165631.GE5574@localhost.localdomain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 10:56:32AM -0600, Keith Busch wrote:
> On Wed, Jun 13, 2018 at 05:37:35PM +0100, Ben Hutchings wrote:
> > On Wed, 2018-06-13 at 10:30 -0600, Keith Busch wrote:
> > > Thank you very much the catching that. This particular patch is indeed
> > > not correct without the following:
> > > 
> > >   161b8be2bd6ab ("nvme-pci: initialize queue memory before interrupts")
> > 
> > Oh, now I see.  Do you think that commit is suitable for stable
> > branches?
> 
> Yes, we can safely include that commit 4.4-stable. The scenario it fixes
> isn't very common in 4.4, but it could happen with quirky hardware or
> legacy interrupts.

It does not apply to 4.4.y right now, but it does apply to 4.9.y, so
I've added it there.  If it needs to get to 4.4.y, can someone do a
backport?

thanks,

greg k-h
