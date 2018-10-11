Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC015C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E422077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="SeY86FuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E422077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeJLFJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:09:51 -0400
Received: from imap.thunk.org ([74.207.234.97]:50118 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbeJLFJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pa8arxrR6EEaswkCZGjNLBp6Ps3tRPa/PCCHGEfFTtA=; b=SeY86FuNqkh3Ur/JjIg907crqE
        uudWgRmxOrFzS0MjK7Lb3ng15UJDd1xjfPCqHqxtcMbWKhtov7YBCQ4WFU5QXb0k4YNUah5ly8Tzc
        FFXr4P3kNSRHcLgRuPhR1QOAnx+DPgdPSXIRgqBQ/TgAEId24vwD03dPmFLv7K2Cg8dA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gAihA-0005Mo-Fj; Thu, 11 Oct 2018 21:40:36 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B9EAD7A51DE; Thu, 11 Oct 2018 17:40:35 -0400 (EDT)
Date:   Thu, 11 Oct 2018 17:40:35 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     hpa@zytor.com
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Insanely high baud rates
Message-ID: <20181011214035.GC565@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>, hpa@zytor.com,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
 <20181010211717.30c1f052@alans-desktop>
 <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com>
 <20181011133134.085624af@alans-desktop>
 <8A583BC1-A295-48D2-B4C3-3E70AA50D035@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A583BC1-A295-48D2-B4C3-3E70AA50D035@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 07:14:30AM -0700, hpa@zytor.com wrote:
> >
> >I mean - what is the baud rate of a pty  ?
>
> Whatever the master wants it to be...

I think Alan's point is that it is highly unlikely you would be able
to push the equivalent of 4 gbps through a PTY layer.  The TTY later
was never engineered for those speeds, and the real question is ---
what's the point?  That's what Ethernet is for.

       	   	   	       		   - Ted
