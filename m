Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746DFC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299B2214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmAYrLgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299B2214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeJIQqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbeJIQqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:46:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B053214C4;
        Tue,  9 Oct 2018 09:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539077451;
        bh=mVU6/J+bGNmSusKTQ1FYe680IBaaKpxFdDl/1JQTUf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmAYrLgGPIyFYsX65eJh8XJNlo8x8jvXncsao2Gwmr3JobIryGQY3t0FbsXE/q6vi
         H/2/d4ewL7jddzshK0ZMsX/JQioyd6B07wioJiC3lqmtuun4blJEkdV8k3aovZNB3I
         l1sUm7w3W03CFAjgIsE06JBPu7c0W0czIAp5ow2k=
Date:   Tue, 9 Oct 2018 11:30:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, ejt@redhat.com,
        Mike Snitzer <snitzer@redhat.com>,
        alexander.levin@microsoft.com
Subject: Re: [PATCH 4.14 66/94] dm thin metadata: try to avoid ever aborting
 transactions
Message-ID: <20181009093049.GA15436@kroah.com>
References: <20181008175605.067676667@linuxfoundation.org>
 <20181008175609.656421529@linuxfoundation.org>
 <CADVatmODtvLS=1Bb2Oi-o2_fQOFAykhiAXLk08x30pNmFDseDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmODtvLS=1Bb2Oi-o2_fQOFAykhiAXLk08x30pNmFDseDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 08:45:57PM +0100, Sudip Mukherjee wrote:
> HI Greg,
> 
> On Mon, Oct 8, 2018 at 8:06 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Joe Thornber <ejt@redhat.com>
> >
> > [ Upstream commit 3ab91828166895600efd9cdc3a0eb32001f7204a ]
> 
> This has been fixed by a later commit 013ad043906b ("dm thin metadata:
> fix __udivdi3 undefined on 32-bit")

Thanks, now queued up.

greg k-h
