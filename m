Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA6C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0482C2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltnUFOJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0482C2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeJLBNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbeJLBNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:13:16 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C36512085B;
        Thu, 11 Oct 2018 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539279901;
        bh=YN72YO2qJ4sFCX/5sV/vtdUpy7+Y3GKHKr9QA0Ga1Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltnUFOJYWhMVSzVa2jvT0qJwsx+5diZNtreoEPtRn2NhjVe4G96kKDGbgTsNzAmQq
         nIe9PjWh0yYs2sKHhEJvI4+xO/B6VdjT41+N+OyYszru3P76OKJmSwahIimciJTd4M
         VKp8BUQY/pVBJs72wX2eEsc7LWILP7XDElSgj4RI=
Date:   Thu, 11 Oct 2018 19:44:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] allocator argument fixes for v4.19-rc8
Message-ID: <20181011174458.GA23310@kroah.com>
References: <20181011165256.GA34463@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011165256.GA34463@beast>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 09:52:56AM -0700, Kees Cook wrote:
> Hi Greg,
> 
> Please pull this fix for open-coded multiplication in allocator arguments
> for v4.19-rc8. This has been in linux-next for almost a week with no
> reported issues. As discussed last week[1] this catches 4.19 up to
> the same level of coverage we had in 4.18 for avoiding these kinds of
> unchecked multiplications.

thanks for getting these in linux-next and a bit of testing.

> 
> Thanks!
> 
> -Kees
> 
> [1] https://lkml.kernel.org/r/CAGXu5jJfs0KpRa6yag=ud0sJVW-tM-E4xuvgCMnBdFfDck5E1g@mail.gmail.com
> 
> The following changes since commit 57361846b52bc686112da6ca5368d11210796804:
> 
>   Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/alloc-args-v4.19-rc8

Now merged, thanks.

greg k-h
