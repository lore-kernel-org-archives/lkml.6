Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E3BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EBD21871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545223057;
	bh=vlus8rhxWwlNHWCag+8TVlQmeMtIrZBLX/cVphX94tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qvvv9jX2B+jFrCXWAyYMegY4U15fIhzftAhljKh327/M9WSryj0bIaqkdIa6BZ8A8
	 yUcrcTK4TgDFE1xA8FuaDW6zhiNi1I2dnVFT5DmArlVVZdxm6yY/3KWVyM5m+l/xwR
	 alcs1zJMEAwRrqzZwFmwSfriCgJW39L+Js2Ypvho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeLSMhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:37:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeLSMhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:37:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 306CD217D6;
        Wed, 19 Dec 2018 12:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545223055;
        bh=vlus8rhxWwlNHWCag+8TVlQmeMtIrZBLX/cVphX94tQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4866wpFcyucOTlxjpqDys6DNDpyDJUb2wZ0k71yelBEtAnmdHkVc0CtdmPJZnfhm
         zexddlG9i9toEapS79omvr0GyqkBaxs6Tim6En1Ia/yCICYr4T9lN2nL+vSVSEcOld
         zc6K16j03QuvmkPB/juiO2onosJLh/ChR3KJyKEs=
Date:   Wed, 19 Dec 2018 13:37:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Buland Singh <bsingh@redhat.com>
Cc:     clemens@ladisch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        trivial@kernel.org, prarit@redhat.com
Subject: Re: [PATCH] hpet: Fix missing '=' character in the __setup() code of
 hpet_mmap_enable.
Message-ID: <20181219123733.GC20670@kroah.com>
References: <20181219092502.3079-1-bsingh@redhat.com>
 <20181219094627.GC11441@kroah.com>
 <2c7a66e5-9488-b1a3-d08d-e4f508d3ee53@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c7a66e5-9488-b1a3-d08d-e4f508d3ee53@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 05:34:32PM +0530, Buland Singh wrote:
> On 12/19/18 3:16 PM, Greg KH wrote:
> > On Wed, Dec 19, 2018 at 02:55:02PM +0530, Buland Singh wrote:
> > > The kernel command parameter 'hpet_mmap' never takes effect due to missing
> > > '=' character in the __setup() code of hpet_mmap_enable and the memory map
> > > of the HPET registers never get expose to userspace.
> > > 
> > > Signed-off-by: Buland Singh <bsingh@redhat.com>
> > > ---
> > >   drivers/char/hpet.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> > > index 4a22b4b41aef..9bffcd37cc7b 100644
> > > --- a/drivers/char/hpet.c
> > > +++ b/drivers/char/hpet.c
> > > @@ -377,7 +377,7 @@ static __init int hpet_mmap_enable(char *str)
> > >   	pr_info("HPET mmap %s\n", hpet_mmap_enabled ? "enabled" : "disabled");
> > >   	return 1;
> > >   }
> > > -__setup("hpet_mmap", hpet_mmap_enable);
> > > +__setup("hpet_mmap=", hpet_mmap_enable);
> > 
> > What commit caused this bug?  Should this go to the stable kernel trees?
> 
> Hello Greg,
> 
> The commit id is 3d035f58. The bug is there since the initial patch which
> introduced the kernel parameter 'hpet_mmap'. The fix should go to the
> stable kernel trees.

Great, can you resend it with all of this information (a fixes: and cc:
stable tag?)

thanks,

greg k-h
