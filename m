Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 46E54C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E758B208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueh8H75x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E758B208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754776AbeFNIT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:19:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752933AbeFNITX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:19:23 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B9CE208CB;
        Thu, 14 Jun 2018 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528964363;
        bh=JYTXlPrfNHQ+Wf3fb+jycIrvqv8gmYuFBsq/CFL+fQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueh8H75x/l6+ETywRhJKU7PAXMkMaN3A7FZexPLhD59tN1mRg3Gx3Nru8j+dXwtfG
         qwWYwRb3eL+hyrGMJnAA8U1rxqCD0giogBcF0Lg2e4BvVRl+tDENVWeoocjJEoxtnH
         srQdzojWIcWwNe9HbwGcOTTaTdkkK7jvN511bwuM=
Date:   Thu, 14 Jun 2018 10:18:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Liu Bo <bo.li.liu@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        stable@vger.kernel.org, David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 038/268] Btrfs: fix scrub to repair raid6 corruption
Message-ID: <20180614081858.GA20773@kroah.com>
References: <20180528100202.045206534@linuxfoundation.org>
 <20180528100206.374694208@linuxfoundation.org>
 <1528483367.2289.105.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528483367.2289.105.camel@codethink.co.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 07:42:47PM +0100, Ben Hutchings wrote:
> On Mon, 2018-05-28 at 12:00 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Liu Bo <bo.li.liu@oracle.com>
> > 
> > [ Upstream commit 762221f095e3932669093466aaf4b85ed9ad2ac1 ]
> 
> The diff here is actually from commit 8810f7517a3b ("Btrfs: make raid6
> rebuild retry more", mentioned in this commit message).  (Sasha, please
> try to work out why commit messages and descriptions are getting mixed
> up in your auto-selections.)
> 
> Maybe stable branches should get the real commit 762221f095e3 as well?

Ugh, not good.  Sasha, can you fix this up and send me patches for it,
separate from your pull requests?

thanks,

greg k-h
