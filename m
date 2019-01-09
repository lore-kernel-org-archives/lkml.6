Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C95C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D0721726
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547022673;
	bh=HZnZ0MPUP117Czzg6MB2ETn5M0DJbPYIPT8d5NLZq6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BHyV8LGiGLb40Ir1r3euY8iEzJz3zHYwGoFuIzKjJaRSKhDPb9aBkTZG1XvF23ERp
	 zOLU6gB4vX/KQzL9n+Dm3XccySjxtS5Yj1lh8FbLf82JtnvZfenLv4n+jsJMGhiHA2
	 UXEENdBm6MqOMNqUaaTJqAIyVTjVs17KUVah2b7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfAIIbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:31:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbfAIIbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:31:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FE220821;
        Wed,  9 Jan 2019 08:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547022671;
        bh=HZnZ0MPUP117Czzg6MB2ETn5M0DJbPYIPT8d5NLZq6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFF7V/Z8oVW2Btv3pLNUbbBP4u+X0fKYVkToOoVFYFlv400jzOBaR5xNMT6gQqCiJ
         KDIS1oOoAStavcjSPYrTi99jxkXsSvlnYVeRK48nXXMu6ez6MFrjlJ9wEaZrHpxZg0
         Zp35MEdZXv87+gsjBCXRPLE4mz8SF64gQQpiG0R0=
Date:   Wed, 9 Jan 2019 09:31:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drivers: platform: goldfish:
 goldfish_address_space: add a driver
Message-ID: <20190109083109.GA24501@kroah.com>
References: <20190109021112.5836-1-rkir@google.com>
 <20190109021112.5836-2-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109021112.5836-2-rkir@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 06:11:11PM -0800, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> A driver for the Goldfish Android emulator that occupies
> address space to use it with the memory sharing device
> on the QEMU side. The memory sharding device allocates
> subranges and populate them with actual RAM.
> This allows sharing host's memory with the guest.
> 

Do you have a pointer to the QEMU commit that matches up with the device
that this driver is supposed to be supporting?  That would help in
trying to review the code to determine exactly what this driver is doing
and why the existing memory driver does not work well enough for you
(hint, you didn't say why you need this...)

thanks,

greg k-h
