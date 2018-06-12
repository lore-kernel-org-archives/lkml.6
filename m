Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 87EEEC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDDE208B5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCcmI0UG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDDE208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933014AbeFLGbf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 02:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932550AbeFLGbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 02:31:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A12A20660;
        Tue, 12 Jun 2018 06:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528785093;
        bh=OpEVbjqYzQU2aexrhPLvMxf+mAkxbarfLbnz4irhzwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dCcmI0UGmjkjrmQENXfKcR16TFIyWhjQC9I2Sn9/2//oYmGDYkHd25t5GWigmcGxE
         VZl0IR3vn/EiRr+RZoGbcBPXNjvUeEYCuZKMj0KTOQ8TQbgZS8rFAQd6oRI2D/Ier0
         xFWy/WZtNKLJF3k0EOPnk0a1L1IuQHYl/WV2Og60=
Date:   Tue, 12 Jun 2018 08:31:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>,
        NeilBrown <neilb@suse.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        lustre-devel@lists.lustre.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: lustre: add error handling for try_module_get
Message-ID: <20180612063111.GC23073@kroah.com>
References: <1528778968-42225-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528778968-42225-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 12:49:26PM +0800, Zhouyang Jia wrote:
> When try_module_get fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling try_module_get.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c | 5 ++++-

This patch does not apply to Linus's tree.  Always be sure to work
against linux-next to catch things like this.

thanks,

greg k-h
