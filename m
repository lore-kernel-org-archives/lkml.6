Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E5AC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1272087D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rc596Hez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1272087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeJMPE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbeJMPE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:04:29 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2E4F20835;
        Sat, 13 Oct 2018 07:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539415705;
        bh=OxbxtWQaZ9xonRoM0k9sFmmLwxckvA0QOIC2kMj22/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rc596Hez/o1tOxALCrVUoC2znK/Umg+5NQFQxK3yU5i62URGQCKbNanULyUDeZvFs
         lUcsC2YuxnwFIhzG9FHRg9UuSctAOKZekG0mPHEb72lI21fq5UDswSvZITpXSrooQ6
         0ERMLl/TGOnR3R6yMOhYYdf969UFxL8Ke4cQrtjY=
Date:   Sat, 13 Oct 2018 09:28:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com
Subject: Re: [GIT PULL] Couple more arm64 fixes for 4.19
Message-ID: <20181013072823.GA27804@kroah.com>
References: <20181012154629.GB11387@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012154629.GB11387@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 04:46:29PM +0100, Will Deacon wrote:
> Hi Greg,
> 
> Please pull these two arm64 fixes for 4.19. One of them fixes a nasty
> WARN() that has started triggering because we assumed that memory
> reservations from firmware would always correspond to regions of the
> physical address space that we have mapped as memory. Unfortunately,
> some existing device-tree files break this assumption and we need to
> continue supporting them. The other fix addresses an issue where a
> CHAIN PMU event can be requested as a 32-bit counter via perf, which
> makes no sense in isolation since these events are intended to be used
> in conjunction with another event when creating a 64-bit counter.
> 
> This is summarised in the tag.

Now merged, thanks.

greg k-h
