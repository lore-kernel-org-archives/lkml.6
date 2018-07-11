Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA86DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9416D20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5wghZab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9416D20C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbeGKQns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:43:48 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46267 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389802AbeGKQnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:43:46 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so18758889pfl.13;
        Wed, 11 Jul 2018 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+ebf4ZXzRQYbSbTPnCpW8zyb9K3PtxjVjmsLpWiuk40=;
        b=U5wghZabkKkisIhCWC70RW/bajB8ELoRwF/NLYsOx49j2JNRzc37scsWOygCS4EwrE
         mnN8zF+jpSV3XRATjdX7J3vrcgw98yh2zsU/vMCGZEaUFChdBtWbK5iAHpGJkoyJD58N
         l2PGjMmaSMSzuo/HXZCqZ8SwPltxvsnCiVjqd2BY5uGBlvmWzYPQx89gkrSpSL3uAX+O
         Pt0uhPDy+XQZHzTCwNvNBynLB6GZKBZbx//GeVLiVZFDzLIH5RsM6avD6jvQ7zWUc6pc
         jxRnyYG2F8YJEqb/yWuJc2dDjYoJ1uf82BgIUfWZ+yRTYFFV+jeFRwQe8X5IQ0Ph41QI
         mSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+ebf4ZXzRQYbSbTPnCpW8zyb9K3PtxjVjmsLpWiuk40=;
        b=rAs0/1uVrH3gQGFgKmVhxFg30iiGsex/tbN2f/wyhToh27VpPI1hi6Rd+GXuV4P9G5
         JDbDOPy4JzeZC7pCJrCvU5VZqzV63yYeW5yd4Ia62fCVXnYSs4MJYQm73wFUlvbHeqEo
         X7qzmjpIrdIaTsK1pBooFdUBZqYhDkshC/90XPy3fJlESIJNo0/N+Cg7gvyEI/cHpqKo
         ZR1zcDq/zTS9L/Mw127vDGu6l+zVcxOfybQH17m7Jtrmow0BzJXN4H3ySRmnkeDJc49N
         fgpnXzWmmsQhzLSjtAVa4KlYw4W4Eixsh1LMx+sbPaZYmhI5E5J/IleaiGei3eo+u8WD
         fXHA==
X-Gm-Message-State: APt69E1A496yoo7JZkMM3HIkWiXveZ5XpePFvbI804r2fLWJbFRwg5rZ
        dGXVSMLBJTIShBQ/zJLTkjc=
X-Google-Smtp-Source: AAOMgpdpohMsJrwc5nE/dDRTmYhiipTC2S6g2zBzkzNgplPLqXV6n9/PUzm4uXlOI4yJt+qTjN2sGA==
X-Received: by 2002:a62:569c:: with SMTP id h28-v6mr31062973pfj.201.1531327117204;
        Wed, 11 Jul 2018 09:38:37 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id b62-v6sm91386551pfm.97.2018.07.11.09.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:38:36 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:38:35 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>, viro@zeniv.linux.org.uk,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        jannh@google.com
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
Message-ID: <20180711163835.GB27454@gmail.com>
References: <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net>
 <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <22370.1531293761@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22370.1531293761@warthog.procyon.org.uk>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 08:22:41AM +0100, David Howells wrote:
> Andy Lutomirski <luto@amacapital.net> wrote:
> 
> > >    sfd = fsopen("ext4", FSOPEN_CLOEXEC);
> > >    write(sfd, "s /dev/sdb1"); // note I'm ignoring write's length arg
> > 
> > Imagine some malicious program passes sfd as stdout to a setuid
> > program. That program gets persuaded to write "s /etc/shadow".  What
> > happens?  You’re okay as long as *every single fs* gets it right, but that’s
> > asking a lot.
> 
> Do note that you must already have CAP_SYS_ADMIN to be able to call fsopen().
> 
> David

Not really, by default an unprivileged user can still do:

	unshare(CLONE_NEWUSER|CLONE_NEWNS);
	syscall(__NR_fsopen, "ext4", 0);

- Eric
