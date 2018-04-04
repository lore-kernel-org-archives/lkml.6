Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-375845-1522855454-2-11375412712218908058
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522855453; b=STihdQ7yz1TqFd+OcnqhRxTIDc6JHXSLMjwEkUJge6WfOoLEut
    B/uODSgFjCP7kAkGuL259aPkkep7SJR++t4572c08Cq9DmZdjuUGPnBXDPM2ZKvx
    C+klJMeBbtJOq1XuoAtJA19Jz5Nh8wN5S8LUDM7/I2ofXUJJeZKhAA89x1h2E8H+
    V1CqMqxdmnG/143KbCaP5jR7P+nBw5lgpn9IPiYbicfPzOzOImLiEHspc9+mrO1M
    /yhCb1nBmEjb6mLPgnXqAa1pOSlawnxAFkqtV6a0RlUOyMfT9Z3GybWUjToDtGx9
    M1nqi4pTzrxRFdCtuH9p3dSPbN7Eq/PsJV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1522855453; bh=0/L6+6qa6j3
    ZELAZOG75IRMIuGhQBXmu/q0vbLsDzeU=; b=vx4xYfXVBdz9/lcLTWRZv8iAB3O
    CdpnG4pNs+4ecV/RQKf0p3CoBXtOuJ4rcoVd4g2Frrhbjuqd6g1pybU0xK6tzPua
    BrH1xttDA6ERC28M77Btwi8M7JLq0hX86SOxP0Xvt8axerbmRbEbbmnYI5fEo7el
    kxi+YyJbHdyH1MKNjNpzwRY90+m8/vHv2NcXmBsdSrtcvTRCJi3zuh0t2GzyODtB
    hqn2cUbtqLJlVYwuhKhbv4jGR8m2QprS+EhnI//RYlgZ05VPFMSqZlEOdmIPwVrq
    U3oHEXGKFK3koKfiMaUKh6lEtR5X6PEPj3W5TpznFVXjkYQrygt/lhmo6Aw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKsWdcRVio2BWuMf8dGuWNe69LjWwTEHYUosZNeCRfUsvaR6BLJeQNUeT0+rrRsRF8H+RCK/pzQFqelipieAF1aqSgnd2xrLEy+tMpfwBe+ZkaY7DdLx
    V2QSQKcTAqT4kgbHgaJ1XJycDI2ITskfvFQ3QRwnEdrQhsIkroEWV4nv7Wnd8/w9CARpWMM3evqJnlJxXJZMIRkBE/0fW74JgZrDteqFqlyM4udgrPbTFIF3
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=YPbXhQfMpM-RhLZGfrUA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeDDPYM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 11:24:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeDDPYL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Apr 2018 11:24:11 -0400
Date: Wed, 4 Apr 2018 17:24:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Prarit Bhargava <prarit@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Myron Stowe <mstowe@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 009/134] PCI/MSI: Stop disabling MSI/MSI-X in
 pci_device_shutdown()
Message-ID: <20180404152410.GA25048@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180319171850.444128621@linuxfoundation.org>
 <1522337334.2654.14.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522337334.2654.14.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 04:28:54PM +0100, Ben Hutchings wrote:
> On Mon, 2018-03-19 at 19:04 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Prarit Bhargava <prarit@redhat.com>
> > 
> > 
> > [ Upstream commit fda78d7a0ead144f4b2cdb582dcba47911f4952c ]
> [...]
> > The MSI disabling code was added by d52877c7b1af ("pci/irq: let
> > pci_device_shutdown to call pci_msi_shutdown v2") because a driver left MSI
> > enabled and kdump failed because the kexeced kernel wasn't prepared to
> > receive the MSI interrupts.
> > 
> > Subsequent commits 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even
> > if kernel doesn't support MSI")
> 
> This went into 4.2 and hasn't been backported.

To backport that to 3.18.y takes 2 other patches to get it "correct".

> > and  e80e7edc55ba ("PCI/MSI: Initialize MSI capability for all
> > architectures")
> 
> This went into 4.5 and hasn't been backported.

Yeah, but that really isn't needed unless 4d9aac397a5d ("powerpc/PCI:
Disable MSI/MSI-X interrupts at PCI probe time in OF case") is also
there, along with 1851617cd2da.

> So I think 3.18-stable and 4.4-stable will need backports of the later
> changes in order for this to work properly.

I think I'm just going to revert this as no one is complaining about
this issue on 4.4.y and 3.18.y kernels.  Thanks for the review.

greg k-h
