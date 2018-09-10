Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF83C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86D320870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86D320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeIJTMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:12:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57874 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbeIJTMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:12:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gerddie)
        with ESMTPSA id D6361276446
Message-ID: <1536589022.4810.72.camel@collabora.com>
Subject: Re: [PATCH v7] Add udmabuf misc device
From:   Gert Wollny <gert.wollny@collabora.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 10 Sep 2018 16:17:02 +0200
In-Reply-To: <20180910133050.tr2lozfmhimqs4c4@sirius.home.kraxel.org>
References: <1536491489.4810.22.camel@collabora.com>
         <20180910083731.o4rryvermyighbtp@sirius.home.kraxel.org>
         <1536571118.4810.38.camel@collabora.com>
         <20180910105309.zmyoo5yhrmqg47md@sirius.home.kraxel.org>
         <1536579068.4810.68.camel@collabora.com>
         <20180910133050.tr2lozfmhimqs4c4@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 10.09.2018, 15:30 +0200 schrieb Gerd Hoffmann:
> On Mon, Sep 10, 2018 at 01:31:08PM +0200, Gert Wollny wrote:
> > Am Montag, den 10.09.2018, 12:53 +0200 schrieb Gerd Hoffmann:
> > > 
> > > By default qemu doesn't use memfd for backing storage, you have
> > > to
> > > explicitly configure qemu that way (see qemu commit log of the
> > > test
> > > branch):
> > > 
> > >     qemu-system-x86_64 -m 2G
> > >             -object memory-backend-memfd,id=ram,size=2G
> > >             -numa node,memdev=ram"
> > 
> > Thanks, but that doesn't seem to help.
> 
> Note the memory is specified twice, once with -m, once for the
> memory-backend-memfd object.  The two must match of course (or, to be
> exact, the sum of all memory backends must match the total memory,
> but unless you want create a virtual numa machine there is no reason
> to have multiple memory-backends).
Qemu actually complained when it was not the same. 

> 
> > Are there any host kernel configuration parameters or features that
> > I should set (apart from enabling udmabuf)? 
> 
> I'm not aware of any unusual parameters required.  My config is based
> on rhel-7, then stripped down with localmodconfig, then enabled the
> bits I want in my test kernel.
I use Gentoo and my kernel is rather stripped down ... 

> 
> Oh, wait, CONFIG_MEMFD_CREATE could be the one.  I guess I should add
> a Kconfig dependency.  
This was enabled, so not sure what else could be missing, I guess I'll
have to add some logging to get an idea.

Best, 
Gert  

