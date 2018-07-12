Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5155C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6A820BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NGZ9eX3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6A820BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeGLQuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:50:02 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36793 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeGLQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:50:01 -0400
Received: by mail-io0-f195.google.com with SMTP id k3-v6so28794675iog.3;
        Thu, 12 Jul 2018 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBSrpycUf6ADtvbqlfgOzLlhjDsMWn/zuemyfSnSpVg=;
        b=NGZ9eX3sXNY3EpOfF0DUseouV+l2B/haDXuUPe9eL0CYk/2ujd2hg/qBE1D5b3Vw9h
         bk3gS+chmAUII8e7y8gd9N9gVJOt1iHcrQbmsBCUOW3m2BFEjfQMMytrNOoFYAVB/WU+
         02wKZ9NPgrr5PFuClV/uNVLrxrq2I6HiSKcMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBSrpycUf6ADtvbqlfgOzLlhjDsMWn/zuemyfSnSpVg=;
        b=T59VCceAm9Aw28eVoK6Sb4e7s8l0t6ia0AQ/0EheNWez99yeGAy4G7v3+QC5mRimBW
         GM5Hz13Hw1Nc1OH38pkHwV6YUSbhm6JXaTE3AszLXi6wkcI/Row84d4Y7PyBdfhyce9P
         Yxz087AXDwUuqzVVkLOkq9AVyk0z36Vw3BJyZYpmrauignVrc77n7PUJaqArdWZkflOF
         Vb72XPBnI5rMvUSsAkKLiQGi5nSwbaRkA2DuuinPmbKRp6sIWkmfxDpTZte7ZzgAyV4t
         LP5C0XkRjEidk1SttrqiLGqBknjrzeu/kjPu9GAZjntHH0kAQwCJAaHk3A3ZgguP/DAJ
         Hv9g==
X-Gm-Message-State: APt69E3OQ+iRkxDgvS7lz7nxYhe4aTJS6RFdNUPC2fYkTlnwmPU74AVv
        ifDBwiM+zjvBjWwBN9c++8MxMJHONLdIN/W0W8k=
X-Google-Smtp-Source: AAOMgpcSWRUjxkUukAjhbLJgoh1dlrBEqecFBxFX4WL0itYnPeQlfHYCUR2iF1Epzy+fa9XSGoYVEN/AgzuHmwPR2k8=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr13259337iom.238.1531413582469;
 Thu, 12 Jul 2018 09:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk>
 <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
 <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com>
 <20180712160030.GV30522@ZenIV.linux.org.uk> <CA+55aFwkiFdhGmT8gaSohAQGMWpGUZBQ0dhGNGWEN4cpjK7XHA@mail.gmail.com>
 <20180712163107.GW30522@ZenIV.linux.org.uk>
In-Reply-To: <20180712163107.GW30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 09:39:31 -0700
Message-ID: <CA+55aFz6Uaqag5qPcT2M3Q07-yc_6y2cAarfw7hjXEiQq4tTYw@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 9:31 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> And seriously, ioctl? _That_ has a great track record...

I agree that a system call is likely saner. Especially since we'd have
one to _start_ this (ie "fsopen()") it would make sense to have the
one to finalize it.

> [1] one man's data is another man's commands, for starters.  All networking
> protocols would fit your description.  So would ANSI escape sequences ("move
> cursor to line 12 column 45" does sound like a command), so would writing
> postscript to printer, etc.

.. and all of that is just data to the kernel.

Yes, vt100 escape sequences etc _are_ commands, and boy have we had
bugs in that area. But there the excuse is "that's how the world is".

The thing is, "reality" is the ultimate argument. You can't argue with
cold hard facts.

But when designing a new interface that doesn't have that kind of
constraints, do it right.

> IME it's more about data structures that are not marshalled cleanly - that
> tends to go badly wrong.  Again, see SG_IO for recent example...

SG_IO actually gets it right. It doesn't do async, but that's part of
the design (and a big part of why it's a lot simpler - the read-write
thing is actually broken too and just forces user space to basically
know SCSI).

              Linus
