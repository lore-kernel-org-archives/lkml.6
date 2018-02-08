Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3209140-1518110840-2-9926637040928790999
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518110840; b=tvWDyvDTnsEZdhfQJbhbBR3XI2PTo7exZxL7/ZQe62DwJ3q
    VQZMDBYmKELtD7+JAFkosrhTN63HctFKNdVcqupvUgFycOvHH6To7JA6pHKl9C29
    QjqB29Z0ZmGC9dO04LReQrdsQklr+4ai4ZC6frbCt2+/46eSyoQJ4z9z42nmsrON
    MzpuV0kV42DR/Q6JgEXRqAIJlY6RLaZksDEnm85ZodpPB5a70wZZb0Uucu88J/Qx
    yEar9/x9MwD+mhnBaVG6/pwOpGGWzOAvZztYitXvDUFUdkEhb69PlALt4U8UQXb/
    kIaT6reaflsDZpMIVuz8DV7kknZocBJJY8YqOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1518110840; bh=bKw7nQt
    0QNVJ43Whw+J3IcPPidBkcyL9pV3Ls9u07i0=; b=vXmt9EHCs9ELHQKOE58sCGq
    uSwtGsWUrH1UimzHjWz+Q2/xkZpp84A3YPDrlsVeX9w87fAg5tQwQRG1QdWDtSQ6
    7Jx17AEve+kX6SEEBplQs3ojHT/hxyDRSHT2PhIUf7+b723J0mrtVnfDxuuMbtOx
    lTrWmPbR+kEY8ReB+MLUZwr5Bk1w0alrtwmZBxnQZWvU75ceHjOj45qtajsMhA+G
    hZyEDii2NDRV8v/4ykoFWn2i8VHbb1H2tHQ0hLhXlDYx4lomcK79+Bzvcgg5/4el
    u1yBedFgWmJlSe9yzvI0L1Jm1BnySPZ1SzXzJSSTtBbe8zRH9lxOja8b2g2mF0A=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeBHR1S (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 12:27:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeBHR1S (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Feb 2018 12:27:18 -0500
Date: Thu, 8 Feb 2018 18:14:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Woodhouse, David" <dwmw@amazon.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>, stable@vger.kernel.org
Subject: Re: [STABLE 4.9.y PATCH 0/9] Backport of KVM Speculation Control
 support
Message-ID: <20180208171436.GA3521@kroah.com>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
 <9ea4d52a-7ae6-a179-2f86-1e7b77255387@redhat.com>
 <1517951146.3677.34.camel@amazon.co.uk>
 <20180208024959.GA16399@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180208024959.GA16399@kroah.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 03:49:59AM +0100, Greg KH wrote:
> On Tue, Feb 06, 2018 at 09:05:46PM +0000, Woodhouse, David wrote:
> > 
> > 
> > On Tue, 2018-02-06 at 19:01 +0100, Paolo Bonzini wrote:
> > > On 06/02/2018 18:29, David Woodhouse wrote:
> > > > I've put together a linux-4.9.y branch at 
> > > > http://git.infradead.org/retpoline-stable.git/shortlog/refs/heads/linux-4.9.y
> > > > 
> > > > Most of it is fairly straightforward, apart from the IBPB on context 
> > > > switch for which Tim has already posted a candidate. I wanted some more
> > > > review on my backports of the KVM bits though, including some extra
> > > > historical patches I pulled in.
> > > 
> > > Looks good!  Thanks for the work,
> > > 
> > > Paolo
> > 
> > Thanks. In that case, Greg, the full set is lined up in
> > http://git.infradead.org/retpoline-stable.git/shortlog/refs/heads/linux-4.9.y
> > or git://git.infradead.org/retpoline-stable linux-4.9.y
> 
> Many thanks for all of this work.  I've now queued up all of these.

There's a problem with the backport of 6342c50ad12e ("KVM: nVMX:
vmx_complete_nested_posted_interrupt() can't fail") as there is still a
check in the function that can fail:

		vapic_page = kmap(vmx->nested.virtual_apic_page);
		if (!vapic_page) {
			WARN_ON(1);
			return -ENOMEM;
		}

Do we need something else before this patch in order to fix this?  I
guess kmap really can't fail, should I just drop the whole (!vapic_page)
check?

thanks,

greg k-h
