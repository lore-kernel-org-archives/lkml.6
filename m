Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520BBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D107218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551255448;
	bh=g/ZV1pkEEy0XClgtufGkGDhEeLkUApwP3TdieR+y+nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z6THTvm5o/NTxp9R4K16TlnLSNzu+d6Blsac4+CWMKCimIXJwlqrXA/cEyCP/TPXv
	 CK3liQNeLrKSCA0zhyeSed9gedqdi6Pj/7bc5SThtxUti5M3nOwCUNhjUcPqtaixAT
	 lVd0FhHtDirSnOkd91tFOlvBg5cjGWppEy7N214c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfB0IR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:17:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfB0IR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:17:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E030218E0;
        Wed, 27 Feb 2019 08:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551255445;
        bh=g/ZV1pkEEy0XClgtufGkGDhEeLkUApwP3TdieR+y+nQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrGLf8MivPeLxRfgPHuLMs3VTtrlyoXDUiMbYZR001NvW8GoRTVu06e/pycF02Taw
         mgzsU8GSSp+f7jEAkNDR0HkknbnX4S8QZriqB4OSSKsbZqjnLjev3QaWC1SGVDQr3R
         IrCAXXhziGTxptVwXmWL/kzOUbLRHnrslgLJQXm4=
Date:   Wed, 27 Feb 2019 09:17:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Morris Ku <saumah@gmail.com>
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Add support SUNIX Multi-I/O board
Message-ID: <20190227081723.GA20777@kroah.com>
References: <20190227071702.4103-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227071702.4103-1-saumah@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 03:17:02PM +0800, Morris Ku wrote:
> Add Kconfig and Makefile entry.
> 
> ---
>  Kconfig  | 2 ++
>  Makefile | 1 +
>  2 files changed, 3 insertions(+)

<snip>

Oh, this series has lots of issues, not the least being this single
patch breaks the build :(

Every patch needs to build properly, or at the least, not stop
everything else from building.

I recommend reading Documentation/SubmittingPatches for how to do a
patch submission properly, and if you have specific questions after
reading that, I will be glad to answer them.

Also, please use scripts/checkpatch.pl on your patches, it will point
out lots of issues that I'll be nice and not mention at the moment :)

thanks,

greg k-h
