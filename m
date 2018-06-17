Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FBBC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E519F20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSp6hzaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E519F20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbeFQLCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 07:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752659AbeFQLCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 07:02:24 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56E2320896;
        Sun, 17 Jun 2018 11:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529233343;
        bh=SCfO6SBgw+JoIPhB68HYCmSX/AEWp3TBIHUgKeOsFzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qSp6hzaEIOaMQpXgOtxARXXumvHFiZ2tdK83cXZt66ncBpeEozAx38XcwX7iLvlF6
         eY8BrW5gu5RmOl6tOGY1b0ie5LdfggblN5NQpcefnjujo7MLyGS8fo5ltJx+MEEto/
         jTsOI+Mxw31rpqTIp2GV3hd4NkaH5H/FXFIIg5P4=
Date:   Sun, 17 Jun 2018 13:02:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Ray Strode <rstrode@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: v4.14.21+: ATOMIC_SLEEP splat bisected  to 9428088c90b6
 ("drm/qxl: reapply cursor after resetting primary")
Message-ID: <20180617110200.GA19216@kroah.com>
References: <1529163551.16103.16.camel@gmx.de>
 <20180617093607.GA27652@kroah.com>
 <1529231886.5303.6.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529231886.5303.6.camel@gmx.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 12:38:06PM +0200, Mike Galbraith wrote:
> On Sun, 2018-06-17 at 11:36 +0200, Greg KH wrote:
> > 
> > And if you revert that patch, does everything work again?
> 
> Yes.

Great, Dave, care to revert this in 4.18 so I can queue up that revert
in older kernels as well?

thanks,

greg k-h
