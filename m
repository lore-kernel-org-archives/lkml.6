Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3103126-1521208992-2-9249444328752123054
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521208991; b=MpPO9YyjR2Q9N3Tb6AfR/oYMYz+gaZlO2QCzIwSYxBHC0XR
    QPsll4R7dkln1rImAxhc27UwtqIvGtm1S7Epm68BSBB+MT59rUGQhuM4cWmyqJNM
    UTjKFeJcYUyE3bTcQxd26BZM1+6z+ltgjxWWscKQhKv/+dVLpbFIpvv0FyBJRCr9
    KKklrRlXwiWDjQ4L1p+/Xb9UCxdGmyP3sQkE6/AbVpC1KjayO7kDdufkglG42whb
    /qqEHsOr+3czpHuVemos+mIVNbAGlLdB6rzOJ2eleI07+YjrGOlov9JmTblQYXgs
    fhS9mjWmuh8r7OkiWQPVhUCFqAKthY8SrvmIm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521208991; bh=4KD1NPIrhk3Q9vl5GPXv8QmpP6
    gA83wXSQDggfNIwZ0=; b=F4FR0IXug2kPKD3Xlj8tnyi7AYFisdybPobhMyJkMv
    sjYbx9TGX4WajUKOFhGM8drpiecRIU6GTXMr4dyXAYSw5uFHH58JLzLFrWlQkJag
    2las1AQUz1fNbi+WMwqopPUUzQ4I5/HCJhUbTz1sit+2DR0C5LxsfGBDAKTH9dhg
    YRq3KkkOllNc/Gto24LDtQdQ6lvMAr/b5w9COPNfqp7X7mf/uKQazXA7Ns4nWMOk
    kvhLlvbv1cLmiSgNi74zzMoyhN/CIpUmMgp3rC/OVZq2Djxx4GaVdZc/trWHG/px
    QhZkgBHXUh2t0yLLGdYhgzlsFuIEk3Lkjvqysd3JzHtA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeCPOC6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 10:02:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55128 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeCPOC5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 10:02:57 -0400
Date: Fri, 16 Mar 2018 15:02:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: dsterba@suse.cz,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 4.14 024/110] btrfs: use proper endianness accessors for
 super_copy
Message-ID: <20180316140256.GA9735@kroah.com>
References: <20180307191039.748351103@linuxfoundation.org>
 <20180307191042.810088712@linuxfoundation.org>
 <1521139304@msgid.manchmal.in-ulm.de>
 <20180316123049.GC25079@kroah.com>
 <20180316132202.GB8297@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316132202.GB8297@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 02:22:02PM +0100, David Sterba wrote:
> On Fri, Mar 16, 2018 at 01:30:49PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Mar 15, 2018 at 07:55:42PM +0100, Christoph Biedl wrote:
> > > Greg Kroah-Hartman wrote...
> > > 
> > > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > > commit 3c181c12c431fe33b669410d663beb9cceefcd1b upstream.
> > > (...)
> > > 
> > > > If the filesystem is always used on a same endian host, this will not
> > > > be a problem.
> > > 
> > > >From my observations I cannot quite subscribe to that.
> > > 
> > > On big-endian systems, this change intruduces severe corruption,
> > > resulting in complete loss of the data on the used block device.
> > > 
> > > Steps to reproduce (tested on ppc/powerpc and parisc/hppa):
> > > 
> > > # mkfs.btrfs $DEV
> > > # mount $DEV /mnt/tmp/
> > > # umount /mnt/tmp/
> > > 
> > > This simple umount corrupts the file system:
> > > 
> > > # mount $DEV /mnt/tmp/
> > > mount: /mnt/tmp: wrong fs type, bad option, bad superblock on $DEV, missing codepage or helper program, or other error.
> > > 
> > > # dmesg:
> > > BTRFS critical (device <dev>): unable to find logical 4294967296 length 4096
> > > BTRFS critical (device <dev>): unable to find logical 4294967296 length 4096
> > > BTRFS critical (device <dev>): unable to find logical 18102363734671360 length 16384
> > > BTRFS error (device <dev>): failed to read chunk root
> > > BTRFS error (device <dev>): open_ctree failed
> > > 
> > > Also fsck is of no help:
> > > 
> > > # btrfsck $DEV
> > > Couldn't map the block 18102363734671360
> > > No mapping for 18102363734671360-18102363734687744
> > > Couldn't map the block 18102363734671360
> > > bytenr mismatch, want=18102363734671360, have=0
> > > ERROR: cannot read chunk root
> > > ERROR: cannot open file system
> > > 
> > > 
> > > Trying mount or fsck on a little-endian system does not help either. So
> > > I consider the data on that device lost - luckily I use btrfs only for
> > > files where a backup exists all the time.
> > > 
> > > 
> > > Reverting that change restored the previous error-free behaviour. I
> > > didn't check HEAD, i.e. v4.16-rc5, since the upstream commt was the last
> > > that affected these files. Still I could give this a try if anybody
> > > wishes so.
> > 
> > That sucks.  Can you test Linus's tree to verify the problem is there?
> > I'll gladly revert this if Linus's tree also gets the revert, I don't
> > want you to hit this when you upgrade to a newer kernel.
> 
> I'll push a fix for the upcoming rc but I think it would be better to
> remove the broken patch from stable kernels ASAP, so I'd recommend to
> revert it now.

Now reverted, thanks.

greg k-h
