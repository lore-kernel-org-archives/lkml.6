Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887BFC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F3021B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549904975;
	bh=h7AXgvqV1fDJKXcGqdTvLCqZ57K+2Fx4RFjj/VRNdlk=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=L7igPZBztEcRhG59x5KUNJlk02D1rvXUKMLHn1xg0U2swu3u9o7RlTh/wUgE5LHt5
	 saeH7Z7E30U8t4CNcWbAi7Dlaba9+IpHhF4uuCA427GwIzHlxbMIO9pqap2u/6vsBJ
	 H8zUawXqGcOWengYJsSpExubRAgHxKBhJrbJrOks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfBKRJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:09:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBKRJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:09:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EE382082F;
        Mon, 11 Feb 2019 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549904972;
        bh=h7AXgvqV1fDJKXcGqdTvLCqZ57K+2Fx4RFjj/VRNdlk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=MCmcjuL9ckZOuSpf3UaJakYAwCj8ILXm87DSo9/QF3MFYoUOFtHCYgRH6O+QLTaah
         lK6Ltws8dgdwK+g5nRrOJeH+ws0QaNNXRfJAKvgDEKXA/9X2Rxr6sL4VB5gPU5nJjx
         9llU4kPOBdE6syVzdCXujkbKkuxt6+1pmwaWNdYg=
Date:   Mon, 11 Feb 2019 18:09:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dsterba@suse.cz, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 153/313] btrfs: reada: reorder dev-replace locks
 before radix tree preload
Message-ID: <20190211170930.GF21634@kroah.com>
References: <20190211141852.749630980@linuxfoundation.org>
 <20190211141903.761515995@linuxfoundation.org>
 <20190211151758.GU2900@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211151758.GU2900@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 04:17:58PM +0100, David Sterba wrote:
> On Mon, Feb 11, 2019 at 03:17:13PM +0100, Greg Kroah-Hartman wrote:
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> 
> This does not IMO belong to stable. It was a preparatory patch for a
> locking rework and the dependent patches won't go to stable either.
> Please drop it, thanks.

Now dropped from here and the 4.20 queue, thanks.

greg k-h
