Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D2EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C221A2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJwwHm/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C221A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeKCCLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeKCCLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:11:11 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C44E12081B;
        Fri,  2 Nov 2018 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541178203;
        bh=JH2XyvhCIFBCFenBlFuuHkSsW6eaoyd3ssDvR7AKCaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJwwHm/t3bZyWG8oW0k3MR4u9PipkkPjYdHMy3vEHRr0NDhVIsQFVP4l2F40FazKD
         RsKwrHU/pfB1nbb8gGI+rE8w/RjMjdmdgW4IRj96S1MzFKYKb8XBBXmExYYwpf91zq
         I9J05/JLd6nPdVIxpvRgZItJ8YNiDgVwGdQ3hCp4=
Date:   Fri, 2 Nov 2018 18:03:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        jannh@google.com, mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] mremap: properly flush TLB before releasing the page
Message-ID: <20181102170320.GA26634@kroah.com>
References: <1541164962-28533-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541164962-28533-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 01:22:42PM +0000, Will Deacon wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> Commit eb66ae030829605d61fbef1909ce310e29f78821 upstream.
> 
> This is a backport to stable 4.4.y.

Thanks for this, now queued up.

greg k-h
