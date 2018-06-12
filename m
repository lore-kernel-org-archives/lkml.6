Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9A803C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468CE208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa/0ckQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468CE208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932675AbeFLLTC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752853AbeFLLTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:19:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50BEC208AE;
        Tue, 12 Jun 2018 11:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528802340;
        bh=qsOjIgZJU5bUiJxaRCfAwRiXxYdGRP1625rn+Yxyisg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fa/0ckQzit6595BZd9nfmx2nRwKjrlmHC5pEV6cl24gko5zOiVBFw1v9bSMNHZM8S
         AeYtW9t0TlX0OKSc2/f/4WLmIREr/l9awoGzLkcQXofncoTih3b9rSjcKyDcZFDAMo
         nscUh/QikKg6dl/V0ibQsCCRcIrrWzvbtgGwOi/4=
Date:   Tue, 12 Jun 2018 13:18:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org
Subject: Re: [GIT PULL v2]  FSI updates for 4.17
Message-ID: <20180612111839.GA3536@kroah.com>
References: <7c268f5bb58cb45a2868020b3c5b8f48ac6844ea.camel@kernel.crashing.org>
 <5c7f9044fefed8bc0e4ca5688801ffa379f38f62.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7f9044fefed8bc0e4ca5688801ffa379f38f62.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 08:54:39PM +1000, Benjamin Herrenschmidt wrote:
> Hi Greg !
> 
> There are a first round of updates of the FSI stack, aiming at reducing/removing
> he gap with the OpenBMC tree and a first step in getting dependent drivers
> upstream.
> 
> These changes significantly improve the FSI bitbanging driver performance
> and reliability, and add the new "sbefifo" driver for communicating with
> the POWER9 Self Boot Engine (which will be needed for some upcoming
> additional drivers).
> 
> These were posted to the list as patches a couple of weeks ago and were
> prior to that tested in the OpenBMC tree and CI. Some subsequent driver
> work depends on some of these, so merging early is probably the best.

Yeah, but as they are not "regression fixes", I'll put them into my
-next branch for merging with 4.19-rc1.  I'll do that once 4.18-rc1 is
released, can't touch my trees until that happens.

thanks,

greg k-h
