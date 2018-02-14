Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2767713-1518612059-2-17346729626012084877
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518612058; b=ZRSNoSgwzx/ZkQ58gVS7VMJibZmzEb4rGPRJfj5TkKsQskt
    J6pFitqvkzvt/Ghl2Qsy9JaJRErEt/JIIa0s0hgWATv/1yBHH/HmXYaKdZIrkpM4
    kMLY0UBV2eiEwiohUmpL00McUz2nbpbHOoexHtFEAWBrk5Ch2SzzP76bA0V4Hg62
    0q/Ok8z7RFaJlTb+FLuZE35YO5S2KGAiOwy67r/eyjmzt7VX2CcH/OrP4fp8tC5H
    QfdPSxvQoWjTr2KdHnE3VH3qMXevQUiUkijuLFGsLzvxPMwzCEZMnOe2Q6oV1jWM
    lIqk/O+oZCsgkQvdXEH5XJeK2zHWxUigPKh3C/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518612058; bh=ntn7ojJ6D2ehr24Pm2+yFELugF
    pcQhxKt5fZd0Ebf8M=; b=fwnetrDmmVhbR1c4We4QinWDbKXdu4HtskdYyqnP1X
    c0lMHnm4A6K53gq7QkApW2ZHNwTw20Z6YGYAsyhbo9+UKoh3TA5nP2QQuG2LlsEY
    iqPQpO5U9I1GmzLak447MUJ3efhAZVZeJAxTTyikDu4x7zPBbWWEDlGD/oShceNU
    o0X/3IimWLZa9lGcQFXaO7xG0EVm4j8OXuB/o9aj19ywrkABPeUH+fDswl7n7+GU
    4yG0Ix15JUrp8i8xZ79SZPTXx5jnazC0lQPqxyN6y5dBahGTuRv3bCgoONXqnoTR
    tqv99PoRvqEFe7KCPxKsO185zTxw8YIrFSeCzgReDPoQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967660AbeBNMkz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 07:40:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41622 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967608AbeBNMkz (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 14 Feb 2018 07:40:55 -0500
Date: Wed, 14 Feb 2018 12:41:01 +0000
From: Will Deacon <will.deacon@arm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org
Subject: Re: [GIT PULL] arm64 spectre and meltdown mitigations for -stable
Message-ID: <20180214124101.GE2992@arm.com>
References: <20180209134811.GB11309@arm.com>
 <20180209134957.GA1677@kroah.com>
 <20180209135131.GC11309@arm.com>
 <20180209150436.GA8265@kroah.com>
 <20180213164859.GA5446@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213164859.GA5446@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey Greg,

On Tue, Feb 13, 2018 at 05:48:59PM +0100, Greg KH wrote:
> On Fri, Feb 09, 2018 at 04:04:36PM +0100, Greg KH wrote:
> > On Fri, Feb 09, 2018 at 01:51:31PM +0000, Will Deacon wrote:
> > > On Fri, Feb 09, 2018 at 02:49:57PM +0100, Greg KH wrote:
> > > > On Fri, Feb 09, 2018 at 01:48:11PM +0000, Will Deacon wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > I've put together a tag which includes all of the upstream arm64 spectre and
> > > > > meltdown mitigations based on v4.15. Please could you consider taking this
> > > > > into the 4.15 stable tree?
> > > > > 
> > > > > I understand that Ard (cc'd) is using this stack to create a version for 4.14
> > > > > too.
> > > > > 
> > > > > Note that there are two commits in here that are already in stable:
> > > > > 
> > > > >   9c9345fb26ff [Variant 1/Spectre-v1] Documentation: Document array_index_nospec
> > > > >   60d6c8a8e54e [Variant 1/Spectre-v1] array_index_nospec: Sanitize speculative array de-references
> > > > > 
> > > > > so you can skip those when applying.
> > > > > 
> > > > > Please shout if you run into trouble.
> > > > 
> > > > Ah, nice, thanks for this.  I'll use this for the next 4.15.y kernel
> > > > release after the one I _just_ sent out for review a few minutes ago.
> > > 
> > > Cool, sorry for the unfortunate timing. This only hit mainline last night.
> > 
> > Ok, then it's not a big deal to wait a few more days :)
> 
> All now queued up, thanks!

Good to hear, thanks! Could you also queue the 4.14 backport [1], please?
Having this in an LTS would be really handy.

Cheers,

Will

[1] http://lkml.kernel.org/r/20180212113801.2552-1-ard.biesheuvel@linaro.org
