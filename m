Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FD9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B55218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548859459;
	bh=Mv7v1jASFdV0HKzfj6lGR0f2LAWScrDFZ5xpARsyotY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BYWUaiyKKTLnG5rySXGuZfVvpWYhhUdD4PebCIp1bDytZq/IWK0pTeGwuUmrMYzdJ
	 Tc04TlZ6O8Kx+rnzr+9Klm1GHoNpYit0n+gO23UITtT5XDVAMuU3JwOVvvndh6bgR+
	 IDqb0SFPoPl+aR5f805bZjypLP3eXqu7OSwVayRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbfA3OoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:44:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbfA3OoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:44:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99B2C20882;
        Wed, 30 Jan 2019 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548859457;
        bh=Mv7v1jASFdV0HKzfj6lGR0f2LAWScrDFZ5xpARsyotY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ptbFeVZ+7MBrlVSQDqapqjwKRaMFjyEsW51jIrO6g0k4EvLaAeXlpKOLgjx945w3+
         f5Mnakwu4f1OfxllFuxPZm/d7P99YA4ZPWLKHR/qaN9GZ/3kftUJI5R4mEawxPoNfa
         iirPCKPnti+UdlmeoZpd0lZzY3bqpeZNsFEo9Zr4=
Date:   Wed, 30 Jan 2019 15:44:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Kiryanov <rkir@google.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drivers: platform: goldfish:
 goldfish_address_space: add a driver
Message-ID: <20190130144414.GA8357@kroah.com>
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
> 
> > Please work with the QEMU developers on this, I need their ack before I
> > can take something like this.
> 
> This is a good point. I asked there (nothing since 1/24):
> 
> http://lists.nongnu.org/archive/html/qemu-discuss/2019-01/msg00055.html
> 
> When we were working on our device side, we had to change some QEMU
> code and later noticed that HAXM also requires some fixes (we had
> meetings with Intel). I suppose QEMU does not have this feature yet.
> 
> Could you please tell if we can proceed with upstreaming as is?

Also, why does the other Android "emulator", cuttlefish, not need
special drivers like this and the other goldfish drivers?  Shouldn't you
be using the same interfaces that they use that are already merged
upstream?

Actually, now that cuttlefish works on a mainline kernel, can't we just
delete the existing goldfish code?

thanks,

greg k-h
