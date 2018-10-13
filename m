Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC310C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5917B2098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0bZZu4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5917B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJMRKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 13:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeJMRKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 13:10:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F294D20859;
        Sat, 13 Oct 2018 09:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539423216;
        bh=NulM7QtVwVgoBhVQHC+iyoYzrytfPSJO0nziTVaVp58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0bZZu4e+iTmMpW9bZqe5ilDRK+7sts2pZBOB10Lk+fSoXia2md/F7hbeU24Gj9CU
         LGoaEcHBJl4q+BZgrqkJtnoIjwyaKHyryPZzqmElBcYpOplUVG9pOP6N20iZeh3wfs
         phl7adW/Y+wbxzPhRgEpVRr0IH8nttS24Ei5oaX4=
Date:   Sat, 13 Oct 2018 11:33:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        dunlap@infradead.org
Subject: Re: [PATCH] ubifs: Fix WARN_ON logic in exit path
Message-ID: <20181013093334.GA11189@kroah.com>
References: <20181013081841.13369-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013081841.13369-1-richard@nod.at>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 10:18:41AM +0200, Richard Weinberger wrote:
> ubifs_assert() is not WARN_ON(), so we have to invert
> the checks.
> Randy faced this warning with UBIFS being a module, since
> most users use UBIFS as builtin because UBIFS is the rootfs
> nobody noticed so far. :-(
> Including me.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 54169ddd382d ("ubifs: Turn two ubifs_assert() into a WARN_ON()")
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Greg,
> 
> can you please take this patch directly?
> It fixes a brown paper bug which was introduced in rc1, I'd like to avoid
> having it in a release and going the -stable path.

Now merged, thanks.

greg k-h
