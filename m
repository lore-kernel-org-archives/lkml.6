Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6DCC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 09:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BB220874
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 09:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X66u0urp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BB220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933214AbeFQJgc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 05:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932726AbeFQJga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 05:36:30 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D689A20874;
        Sun, 17 Jun 2018 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529228190;
        bh=RMLUZxLS+wQZ/GWppcbOCY3IpO/3sMgYj7nSHFA/7GI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X66u0urp2rsWdsP3/TA9k6yZm9TXQQQVuuV+tQxa8s38w0isKzfNTSXC8nbVMiEt4
         jc2aN4b5zu92O/f++HiqppgU6BOAgEaISvSIi8FMRnGdQ4lztoG8etGAuWEHRneKyU
         tqSO72yqKiYGqsbu2hc8ZP+Om9ja4kUlpnlJRyPY=
Date:   Sun, 17 Jun 2018 11:36:07 +0200
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
Message-ID: <20180617093607.GA27652@kroah.com>
References: <1529163551.16103.16.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529163551.16103.16.camel@gmx.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 05:39:11PM +0200, Mike Galbraith wrote:
> Greetings,
> 
> Running a kernel with ATOMIC_SLEEP enabled in one of my VMs, I met the
> splat below.  I tracked it back to 4.14-stable, and bisected it there.

Why does your virtual machine use a drm driver?  Ah, it's a driver for
virtual gpu, nice.

And if you revert that patch, does everything work again?

> # first bad commit: [848dd9bf51544c8e5436960124f3d1f9c51cdb99] drm/qxl: reapply cursor after resetting primary

You should also cc: the other developers on that signed-off-by list,
like I did here...

thanks,

greg k-h
