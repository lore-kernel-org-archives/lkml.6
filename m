Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724ECC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F0320879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547363075;
	bh=vSU8FAun082LwfcGpgfmb0Zg9mLVukBPNNuJ90qkE/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GJKIV954i96uYbluO+zhJYwYAbyERUlDgFpfwaTI/5ga8WwTYriEWbhl/v/YcYeEO
	 YXDkWpT+aTaKVBokigtO1bKDds4mRv6dfshkO6INoT4TrKvMI4V5z5yQHvYuMOs/xD
	 9HyDD7iAxxBOWiFq6/clu3qSZmEbVLH3WQE4ClX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfAMHEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 02:04:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfAMHEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 02:04:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB92920873;
        Sun, 13 Jan 2019 07:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547363073;
        bh=vSU8FAun082LwfcGpgfmb0Zg9mLVukBPNNuJ90qkE/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERS8Z++E2U73Ekxp6CxX+nc3dviF227RCj/eNVUbhs/T/uLr9zdbpox+Xqy7W9uOX
         LphZfXEwRWPfzTCzOig0DPUTYxYu2Tnv/j8dNFUTYDYBBOwUmn/NvuGiCBD/QcBy88
         0Q26ssRmB9o1jTSIC5leO6MVpO9R6U6yzjHn0N90=
Date:   Sun, 13 Jan 2019 08:04:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 024/105] bnx2x: Remove configured vlans as part of
 unload sequence.
Message-ID: <20190113070430.GA1137@kroah.com>
References: <20190111131102.899065735@linuxfoundation.org>
 <20190111131105.377370861@linuxfoundation.org>
 <CADVatmNVbJtnkgXrsEy0=pB3+H-ap4zdpOdD=mPonxjvVZM2Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmNVbJtnkgXrsEy0=pB3+H-ap4zdpOdD=mPonxjvVZM2Lw@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 09:22:40PM +0000, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Fri, Jan 11, 2019 at 2:33 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > [ Upstream commit 04f05230c5c13b1384f66f5186a68d7499e34622 ]
> 
> This was fixed upstream by 38355a5f9a22 ("bnx2x: Fix NULL pointer
> dereference in bnx2x_del_all_vlans() on some hw")

Thanks for catching this, queued up to a bunch of trees now.

greg k-h
