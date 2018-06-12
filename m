Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6A90BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A2F2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlVVdvfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A2F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932831AbeFLGVW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 02:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932448AbeFLGVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 02:21:21 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A7DF20693;
        Tue, 12 Jun 2018 06:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528784481;
        bh=1spcMF/62Z/hqwVq681z9z6YeH7mff2G4NRfI+oCEF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XlVVdvfMQJWH+7jyy5hXq+wdzIi8iEOeQLo/CDAXmfrh0aaqfdf7rW3Q30LeiixM0
         iVLYUBz9B5DZH9QCLyQzvUHbEY6MD2ThjU+9F71vshSNxNeqoGR/0S/KHsKcoV3sAf
         CNlx13Ke7a73Z1mHqIOYF53QfzXIiqxOhUnqG3Tk=
Date:   Tue, 12 Jun 2018 08:20:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org
Subject: Re: [GIT PULL]  FSI updates
Message-ID: <20180612062059.GA26240@kroah.com>
References: <7c268f5bb58cb45a2868020b3c5b8f48ac6844ea.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c268f5bb58cb45a2868020b3c5b8f48ac6844ea.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 02:14:25PM +1000, Benjamin Herrenschmidt wrote:
> Hi Greg !
> 
> There are a first round of updates of the FSI stack, aiming at reducing/removing
> the gap with the OpenBMC tree and a first step in getting dependent drivers
> upstream.
> 
> These changes significantly improve the FSI bitbanging driver performance
> and reliability, and add the new "sbefifo" driver for communicating with
> the POWER9 Self Boot Engine (which will be needed for some upcoming
> additional drivers).
> 
> [ Apologies if I got part of the process wrong, I haven't
>   sent a pull request in years ;-) ]

So, these are all for 4.19-rc1, right?  Not bugfixes for 4.18-final?

> The following changes since commit 8efcf34a263965e471e3999904f94d1f6799d42a:
> 
>   Merge tag 'armsoc-late' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-06-11 18:19:45 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git 

I need a signed tag to pull from, not just a git tree, otherwise I don't
know that you really sent me what you think you sent me :)

Can you fix that up, and tell me where you want this to go and then I
can take it after 4.18-rc1 is out.

thanks,

greg k-h
