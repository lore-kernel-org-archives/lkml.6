Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB014C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27CC2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="kfQ89CHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27CC2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeIZE4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:56:06 -0400
Received: from imap.thunk.org ([74.207.234.97]:47276 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeIZE4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 00:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1AKVkItclCGHEaCR5sP1WIq8GkjW7eekSl1fEgXo504=; b=kfQ89CHMQy7PuBPUE7PDvCjqI8
        hpNB7+SzgcYXTqP3X3wLqj5tmGhthKC5EylluDbmtbuJu5+afOc9iHfZlMqoXKlvXJMX5EDFFg+Sv
        WTm72ecZ5E08ljJtJjXdB7HJoTyxYT82w2q2rDRjyP5BUdqR6j+fHdBQS/WYEDPtrNdg=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g4w5u-0004B2-5F; Tue, 25 Sep 2018 22:46:14 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 67CC67A54D5; Tue, 25 Sep 2018 18:46:13 -0400 (EDT)
Date:   Tue, 25 Sep 2018 18:46:13 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: POSIX violation by writeback error
Message-ID: <20180925224613.GI2933@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Adam Borowski <kilobyte@angband.pl>,
        Jeff Layton <jlayton@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
 <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
 <20180925003044.239531c7@alans-desktop>
 <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
 <20180925154627.GC2933@thunk.org>
 <20180925173510.273hshp4iapd6dcd@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925173510.273hshp4iapd6dcd@angband.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 07:35:11PM +0200, Adam Borowski wrote:
> Isn't this what the snippet for O_TMPFILE in "man 2 open" does?:
> 
>                   char path[PATH_MAX];
>                   fd = open("/path/to/dir", O_TMPFILE | O_RDWR,
>                                           S_IRUSR | S_IWUSR);
> 
>                   /* File I/O on 'fd'... */
> 
>                   snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
>                   linkat(AT_FDCWD, path, AT_FDCWD, "/path/for/file",
>                                           AT_SYMLINK_FOLLOW);

Huh.  I stand corrected.  I had assumed O_TMPFILE worked like any
other file where the link count was zero, and linkat(2) wouldn't allow
this.  But obviously, this does work.  In fact, from the linkat(2) man
page, using:

	linkat(fd, NULL, AT_FDCWD, "/path/for/file", AT_EMPTY_PATH);

is an even simpler way that doesn't /proc being mounted.

TIL...

					- Ted
