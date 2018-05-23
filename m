Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3994145-1527065193-2-14535610180585525780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527065192; b=mDvQ+Jp6pfqeLoGlkMIbCw712YYD0KpSvPNXh6QgJDorAtf60Y
    Q1Y9eqWvRqBNeUJ4lH3/ilw5yh0ALJ+AgeoUYLtW3Pf7hNNSKfM3Ef6DWm4ok5if
    xNnc9jt3uWqozhs/wPpQem4zVccjzdQQTWJhEPb+Dr4ldQxg8gDOpZ7y+97hSjd+
    ruH0SIWr60hOj4SCAi/NBM5KCpdGiGOCNPoHJlSxO5L75PzeNjOcZbx8tuQ4x7hu
    2GZz63EkVPq0FDFq70oe1LKioQ/wOt0Il+H34f2/XwnP5UB0ZW21HLilqyH/O124
    cqe+u6FyHu4X9ZXeXU350fMnR0vQd7GCpx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527065192; bh=d6OLU63o93DsIGflJS8pgvowqQnfrI
    aVQG9HYv+7OLo=; b=lteHtrJCT8oNgPPKw4TiXyUWklxn+WDkP+l4Crq7ie05D3
    qMkTxDxJYyepH4q9ZrDTR05gM+NYs6UhQQC3w7Qblk+0xw1te+6w6JG/nJK6nyJg
    yikFwNtXoAvdqo0wf9ANy2nBrTayt4Hk69PxVJGgEAcyB9pNIj7q/N4ibk+gVlRg
    yso2utnxABW6kQ2PScwL8DeKZL1V9gUUryDA/eIk0GFCOCZ/fjx0u58cXcHR7rM4
    0DTlODhLWWWkmhRmARee8JbU9/JEzISw2cMhiWWvAxoKqGNvgxAuvaHIgG2lR+Bs
    Ks5s8NA8+eF3MFN78X3ZnFyS3yTvINyEJAlC0S8A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIyMzkBduOlrn5S+//Vl8h2jTUgN1Dg00P752JbDV1ae2y5Rcc/nNRilAWFbD1cb1N+mXypMg2E2LFQXO8vcqUzi/A9kzUKSBWT9RniGUCX0eGTRvZQ3
    OxQn9iZyNn90EPZp89OYfEYZXrVfw00F47zVH09YOgZG9I8R7jAWAin+EluiW6nw54YiWTFUl5ZMdnp4k2g54c0upYaeVgn4XVLUGKU6TImrekHnwSTTdz1I
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=D19gQVrFAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=RJBD1n0rJimfiXNFn0wA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754539AbeEWIqS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 04:46:18 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:59284 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754340AbeEWIqO (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Wed, 23 May 2018 04:46:14 -0400
Date: Wed, 23 May 2018 16:46:03 +0800
From: joeyli <jlee@suse.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 07/24] hibernate: Disable when the kernel is locked down
Message-ID: <20180523084603.GD7474@linux-l9pv.suse>
References: <20180413202234.GA4484@amd>
 <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346392521.4030.5108539377959227838.stgit@warthog.procyon.org.uk>
 <27926.1524148733@warthog.procyon.org.uk>
 <20180426072646.GA31822@amd>
 <nycvar.YFH.7.76.1804261018030.28147@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1804261018030.28147@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi experts, 

Sorry for I missed this discussion...

On Thu, Apr 26, 2018 at 10:20:29AM +0200, Jiri Kosina wrote:
> On Thu, 26 Apr 2018, Pavel Machek wrote:
> 
> > That's not how the crypto needs to work. Talk to Jiri Kosina, ok?
> 
> Yeah, Joey Lee (adding to CC) implemented it here:
> 
> 	https://lkml.org/lkml/2015/8/11/47
> 
> I think there have been more respins, Joey definitely knows more details 
> and status quo.
> 
> The design is specifically tailored for secure-boot environments though.
>

I am working on the next version of hibernation encryption and authentication:
    https://github.com/joeyli/linux-s4sign/wiki 

My plan is:

- Hibernation encryption:
  There is a draft patch to encrypt image by ctr(aes). This patch works
  with the first version of hibernation verification:
  https://github.com/joeyli/linux-s4sign/commit/6a9a0113bb221c036ebd0f6321b7191283fe4929

- Adapt hibernation to key retention service:
    - Using the encrypted key to derive encrypt key and auth key to
      encrypt and hmac snapshot image. Put the encrypted key in the image
      header of snapshot.
    - The encrypted key will be encrypted by KMK (kernel master key). Either
      trusted key(sealed by TPM) or EFI key (explain in later) can be the KMK.
      If there have appropriate UI support in initrd, user key can also be
      the KMK.
    - Similar with the enrolling EVM key, but more earler:
      The systemd and dracut must be changed for enrolling kernel master key
      before the swap partition be mounted.

- EFI key:
    - A new master key type to key retention service.
	- It can be a new option beyond trusted key(TPM) and user key.
    - EFI stub generates a random key and stores in EFI boot service
      variable:
	- This random key in boot variable can be called ERK (EFI Root Key)
	- The ERK is secure when secure boot enabled.
	    - User must aware and enable secure boot by themself if they want.
	- ERK can be a secret to encrypt a random number for generate a EFI key
	   - The EFI key can be used by hibernation encryption/authentication.
	   - The EFI key can be a master key to generate a encrypted key for EVM.
    - Rescue mechanism for ERK:
	- The ERK may be regenerated after the old ERK be erased by firmware update
	  or firmware recovery.
	- Current idea is using the public key in first/second trusted keyring
	  to encrypt the ERK for backup. User can enroll the EFI key with old ERK to
	  request kernel to re-encrypt the EFI key with new ERK.


Thanks a lot!
Joey Lee
