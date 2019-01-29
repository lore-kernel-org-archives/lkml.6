Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15F6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896DD2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548754668;
	bh=doIonAWKoafhyUG7JK+cgD206ImIggTtuppv7FeBOdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lV9KjBwWS7gOBWn5TZ6OFOyEYdQxHvDxYwyJW80BL8n1PmToVx9D9xkKuAR4watye
	 qbo5h5AiVm8C4bQvvCoBt+h5RGp2jw/S+k0aJ2pJ2qGNCKavrwXS5I06DKhb1RSCOR
	 x34cxUGO9d6I7LBDQ9BXmZU2Ftkzza3uy1lp+Ka0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfA2Jhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:37:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfA2Jhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:37:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A904214DA;
        Tue, 29 Jan 2019 09:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548754666;
        bh=doIonAWKoafhyUG7JK+cgD206ImIggTtuppv7FeBOdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBRe2PGV3zx5zvoUymZetlt3OJWC9B+qVa2oPpg8n0mP9F4Oou4uiv0TFK6RQbYWd
         oVZqHpBeT1IIrQWl2LfFKOPjXfbwTX2eV1TlPeo0UPXPKHNr0xZ+sgrHZjbkPYZdSl
         6x8LOgnT6tbZkKlEFofN4svTp7vGDnHXKdN+gRRE=
Date:   Tue, 29 Jan 2019 10:37:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Kiryanov <rkir@google.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drivers: platform: goldfish:
 goldfish_address_space: add a driver
Message-ID: <20190129093743.GA20334@kroah.com>
References: <20190109021112.5836-1-rkir@google.com>
 <20190109021112.5836-2-rkir@google.com>
 <20190122110712.GA1004@kroah.com>
 <CAOGAQeo1Kv55EUn2sYPOt9EgBMfN=+o_A4KOPVgqbJHo+HN-Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQeo1Kv55EUn2sYPOt9EgBMfN=+o_A4KOPVgqbJHo+HN-Sw@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:32:12AM -0800, Roman Kiryanov wrote:
> > How does QEMU do this today?  There isn't a virtio or some other virtual
> > memory device that allows memory regions to be shared?  I can't believe
> > that there isn't one yet.  If not, then this should be some kind of
> > "generic" QEMU memory device, not a "goldfish" specific one, right?
> 
> I also thought this should not be something unique to us. So I asked
> in our internal mailing list, I heard nothing back.

As we have no idea who is on your internal mailing list, that's really
not a good representation :)

> > Please work with the QEMU developers on this, I need their ack before I
> > can take something like this.
> 
> This is a good point. I asked there (nothing since 1/24):
> 
> http://lists.nongnu.org/archive/html/qemu-discuss/2019-01/msg00055.html

less than a week is short :)

> When we were working on our device side, we had to change some QEMU
> code and later noticed that HAXM also requires some fixes (we had
> meetings with Intel). I suppose QEMU does not have this feature yet.
> 
> Could you please tell if we can proceed with upstreaming as is?

I told you what the requirements would be to get this merged in the
previous email, that has not changed.

thanks,

greg k-h
