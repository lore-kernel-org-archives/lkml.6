Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E18FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C31921848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551182186;
	bh=Bi2fXzzoPOK1FxhVVmOD2F7susx2YxwI0EcSn7UUr04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LXDOljIgQJi9cW4CDJjCs/wJcbsk0fiSlExowv7rtLOUhfzoUTj3BxZAoobYL618X
	 rRtYwZT32LxeUA3t2XE5Sl5lvO0Iwt25q671Q4Np18g0hDHvRwHa2V5WY5031BRLYt
	 nFkWOuvyBJl7Is6fXF4hH/K5oKkx3PAZUXiacqc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfBZL4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:56:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbfBZL4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:56:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEFC52184C;
        Tue, 26 Feb 2019 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551182180;
        bh=Bi2fXzzoPOK1FxhVVmOD2F7susx2YxwI0EcSn7UUr04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPsPRcQE+vu2xSpo+cQsQA+wMCtxEZps+T978KJdoFsxE6Ah+b7THO3tw81inF3Ai
         UoK7N1/Isq/qiyuSAxzFD8/42vUMHY1QYFsIgpDPnO5ccVZL96VMcOGIN7CrEsrgQo
         4ncL0KrDZ2wccD6U50CMjfg/07g2EvmdcQoWWWO4=
Date:   Tue, 26 Feb 2019 12:56:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH v2 char-misc-next 4/7] mic: vop: Add loopback driver
Message-ID: <20190226115618.GB4094@kroah.com>
References: <20190222153056.18878-1-vincent.whitchurch@axis.com>
 <20190222153056.18878-7-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222153056.18878-7-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 04:30:52PM +0100, Vincent Whitchurch wrote:
> Add a loopback driver to allow testing and evaluation of the VOP
> framework without special hardware.  The host and the guest will run
> under the same kernel.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/misc/mic/Kconfig            |  10 +
>  drivers/misc/mic/vop/Makefile       |   2 +
>  drivers/misc/mic/vop/vop_loopback.c | 382 ++++++++++++++++++++++++++++
>  3 files changed, 394 insertions(+)
>  create mode 100644 drivers/misc/mic/vop/vop_loopback.c

You sent 2 4/7 patches in this series, is that intentional?  Are they
different?

I've applied the first 3 here, can you rebase and resend the rest of
these, without any duplicated patches?

thanks,

greg k-h
