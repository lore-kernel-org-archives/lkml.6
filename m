Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-977033-1521140148-2-14607863818307892106
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521140148; b=JOanzGGDVxjDZWJC5pfPhPk/vXRROsSg/GibTIu/VLzGtTg
    m6UXgFPy0Om1xD+VrXK3PiRkAGDTFfqknQKflKDnXtcoWNdbCdspi78b2QfSaDZg
    pC9ZVnrIzulxRWCBVKumkSy1wg5k2tBaZ+3PGILrlF+sbtj1MgJo/v7C6G8XdeYY
    Bm9zDhClcmlaeTldEKvgL82Q5vtZ+c/k4eOvQKMs3c6vstRR8l9a678LDZI3P2uB
    oe8WQfL0x/L1KcTlMG2B+tmYwTBmyKXjFC2gYqyVw/JtRj1Bi6YJwVKAhKp4gzyb
    kJEWiLo+KfJf9gelehGocqS0nvlc2scN3QiSgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521140148; bh=o/ztID0C6Z34xpbLHIwJNhfO06
    thABotL6OtLYxK0UA=; b=SiwFuOEEF3WkOFNDqvJPaxl2njz9ZkDrNkPaxVkN5y
    +d2/RAGLAhGEpRRRHwNpOSYWIHnQ6p4yqmZlVsUbX4Qnu2N+8oq5RzE7LLrXixAG
    i0ABBjI9p6Y6RChl3LUTBIgxOhXbFtziQcN1QbP4stzuAk75YsCTFGJ9cvYRiyIz
    CrBtGknylPAMlta21EBtWYgzd2JjXErkasnxnUIeqeEn60ssZaDrmPYqOTbkRbil
    7LFjBi5GxJ/aTLnni0PI2nDXVWWShKQDgpha5xKXwEe1tdYgRu2oKlH7lVz6GnOs
    DYhxuvfFX2c4oOSIXnuhgOGyvncByJVsI8raOdqLvzog==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=manchmal.in-ulm.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-50 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=manchmal.in-ulm.de header.result=pass header_org.domain=in-ulm.de header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=manchmal.in-ulm.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-50 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=manchmal.in-ulm.de header.result=pass header_org.domain=in-ulm.de header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeCOSzq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 14:55:46 -0400
Received: from manchmal.in-ulm.de ([217.10.9.201]:49990 "EHLO
        manchmal.in-ulm.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCOSzq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 14:55:46 -0400
Date: Thu, 15 Mar 2018 19:55:42 +0100
From: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Anand Jain <anand.jain@oracle.com>,
        Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 4.14 024/110] btrfs: use proper endianness accessors for
 super_copy
Message-ID: <1521139304@msgid.manchmal.in-ulm.de>
References: <20180307191039.748351103@linuxfoundation.org>
 <20180307191042.810088712@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307191042.810088712@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg Kroah-Hartman wrote...

> 4.14-stable review patch.  If anyone has any objections, please let me know.

> commit 3c181c12c431fe33b669410d663beb9cceefcd1b upstream.
(...)

> If the filesystem is always used on a same endian host, this will not
> be a problem.

>From my observations I cannot quite subscribe to that.

On big-endian systems, this change intruduces severe corruption,
resulting in complete loss of the data on the used block device.

Steps to reproduce (tested on ppc/powerpc and parisc/hppa):

# mkfs.btrfs $DEV
# mount $DEV /mnt/tmp/
# umount /mnt/tmp/

This simple umount corrupts the file system:

# mount $DEV /mnt/tmp/
mount: /mnt/tmp: wrong fs type, bad option, bad superblock on $DEV, missing codepage or helper program, or other error.

# dmesg:
BTRFS critical (device <dev>): unable to find logical 4294967296 length 4096
BTRFS critical (device <dev>): unable to find logical 4294967296 length 4096
BTRFS critical (device <dev>): unable to find logical 18102363734671360 length 16384
BTRFS error (device <dev>): failed to read chunk root
BTRFS error (device <dev>): open_ctree failed

Also fsck is of no help:

# btrfsck $DEV
Couldn't map the block 18102363734671360
No mapping for 18102363734671360-18102363734687744
Couldn't map the block 18102363734671360
bytenr mismatch, want=18102363734671360, have=0
ERROR: cannot read chunk root
ERROR: cannot open file system


Trying mount or fsck on a little-endian system does not help either. So
I consider the data on that device lost - luckily I use btrfs only for
files where a backup exists all the time.


Reverting that change restored the previous error-free behaviour. I
didn't check HEAD, i.e. v4.16-rc5, since the upstream commt was the last
that affected these files. Still I could give this a try if anybody
wishes so.

Cheers,

    Christoph
