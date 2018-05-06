Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3584689-1525629408-2-983105300611757671
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org', XOriginatingCountry='NL'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525629408; b=VJvv+M2GdLD09R1jpuuLLrK4bXIKGkrARmmNyoNpG21l0COKqr
    p/yVOmJA34XDSFBOLIz7UOeruaBqmQVcioUX+Fq4ePGSQbfAGKcNmYvkv4w68fIF
    rKoRz6F6EtnTrxHRBwf/uhwIjX1ShPm5zlen6gwQLjiCekI406LsUHuAH+qNZgII
    dqgTZmwkkMCAmdu4JiPepEAzB+dPsJcyik6Z7QjnhltQNeKuzIzxl5eH8fvQAQDX
    0FZYsECpi2wGPZ2dluCaINJ/rcJ5fXhgpvvNWRsx3mEnGPjcIXSCPyINH30hJPgY
    z1mV5Er8cWrkCxe4xoaCtkRaC3pUcOsimlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525629408; bh=TmKdTwdPE8FraUrrUSpvK7p0n0j75/
    1Tb93vNA8uxpo=; b=Fvesee98wvE0eE8vR6em5jyynn7/RUBhzVC9eEpwEyZmWe
    bx4JHl+cskwClx0Ou2pMPH4F+q0HirfSvJYN5Vl6OXwb0gZZB3DhknOyUehSSw1p
    zDqXXFsXBlUR6JL1iuvtqUFmnKbenYsr6LAnxPvxDdgB2/bxHoRhRDZHPPhI8Je1
    NZqAFL2nnXjwVaWOg0Sd+m685qi0yz2mxIUMuaIgi2UwviY4Zl+COzpaW2Gk4Pip
    kNh5cQN0jmQwCRXkifbs0cSIgkTjW1CmZxasuoywrzZDxbAr7xeE6KX1kGb4c1vf
    DCQLeDHqW/e3uCTfmuBWj4QTE6c+ZlNwqWqVbApg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmx.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmx.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAMks6+K/jIa0ZKP9zKsnKVFHVmmCm1itZMYq/R3NfOYLsIfRn+TjkbABZU34zz8wcmwlip9yxgYRBJl9jA4rxqXa9UD6jTDvKv+v8tetWjG8s9CxgA/
    G7N6lGcgufdkQnPjrEsVtfryyjADQclr/UTHwJ1h/PhKjcq6TQeZRc1t6wVYbRYveLg+m9QNSl3oA5cNR2p5XPLRp8Q6eM9qJ0YKGijtRejt/EGrdAACORAa
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=z23cOI0_S6MA:10 a=kj9zAlcOel0A:10
    a=x7bEGLp0ZPQA:10 a=T2yecT_mJLMA:10 a=VUJBJC2UJ8kA:10 a=CjiYaNSMAAAA:8
    a=upcVB8dDxfcr7PmfBDcA:9 a=CjuIK1q_8ugA:10 a=jFRs6jQBfVEfJ4qOU6Pr:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeEFR4p (ORCPT <rfc822;greg@kroah.com>);
        Sun, 6 May 2018 13:56:45 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47233 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeEFR4o (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 May 2018 13:56:44 -0400
X-Originating-IP: 212.92.108.144
Date: Sun, 6 May 2018 19:56:40 +0200
From: Amit Shah <amitshah@gmx.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Amit Shah <amit@amitshah.net>, linux-kernel@vger.kernel.org,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/6] virtio-console: spec compliance fixes
Message-ID: <20180506175640.GA19628@grmbl.mre>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
 <20180424214104-mutt-send-email-mst@kernel.org>
 <20180503034529.GA16676@grmbl.mre>
 <20180503222702-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503222702-mutt-send-email-mst@kernel.org>
X-Remote-Spam-Level: 
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On (Thu) 03 May 2018 [22:28:32], Michael S. Tsirkin wrote:
> On Thu, May 03, 2018 at 05:45:29AM +0200, Amit Shah wrote:
> > (apologies if you received a dup)
> > 
> > On (Tue) 24 Apr 2018 [21:41:29], Michael S. Tsirkin wrote:
> > > On Fri, Apr 20, 2018 at 09:17:59PM +0300, Michael S. Tsirkin wrote:
> > > > Turns out virtio console tries to take a buffer out of an active vq.
> > > > Works by sheer luck, and is explicitly forbidden by spec.  And while
> > > > going over it I saw that error handling is also broken -
> > > > failure is easy to trigger if I force allocations to fail.
> > > > 
> > > > Lightly tested.
> > > 
> > > Amit - any feedback before I push these patches?
> > 
> > The changes look good spec-wise.
> > 
> > There are a bunch of tests in avocado-vt that test virtio-console
> > functionality.  Can you give those a try before pushing?
> > 
> > 		Amit
> 
> I pushed before I did that test, will try to find the time later.  BTW
> do you still want to be on the maintainers list?

Yes, I want to be on the maintainers list; but won't mind
co-maintainers.  The recent changes seem to be spec-related, and I'd
expect you to have a good handle on that anyway.

		Amit
-- 
http://amitshah.net/
