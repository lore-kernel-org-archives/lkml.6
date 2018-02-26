Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3237508-1519661003-2-6313633956979918984
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519661002; b=STQYYfLMHwLHBLBPNhZ7pag6wDVVMaZuIuCIDdzf0nmkH4e
    DQh/pqkk6jigurOVExmqCADYO35sNJlE8WUWvxllr8tMuDfjUqupKTp69CecxrDL
    08icBHdpb8UDyEGWeLprIAcMBMQy/2eQKDUdTGJ44Fvqk1zJ9pyRyTAQSp6dtk9O
    ipWkttvsdN5dcnzveLBku7m/88ysKrxH095TzwXXZExgN07SI2tVFVaCr0XQWf5h
    oeAId79XI3m4zF8uR5H206wvavIOwxT4YOmZs4yJjKtgqVRTFaJX2/b/Z9m1HSFM
    19h64zL/fFSHJyN23bWEJn/EvtaAk66JKQH8V9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519661002; bh=mqMw9PVD7ptY9UJwQWK5xOmS3y
    xLRM/egj7v2YxzyGE=; b=QC3KPKR3TYk1TrFqrbAmcTR0pAGdKj/+uKmAEIsQeS
    xwSl4PkJxCqULmUJOLRzf17CuUEbv7eXfiN4CiKU8UGI/y9EO8S4DMclcEIamcme
    VSe0cS/0FyEEYf+NBtPmvKaXsgV60hWRS0XuIyhos0RhWqvJGioz+/3EMCHpsLQ+
    DFkjDAIPCkyrIFPNYnwGuvIyiAmdc3bDr0lo9Gj0nEYHNb7MYAyKsF7TWUdw2eJU
    BbJcfL8mjdsLxXZaNHc0gSZyuXP/SM6ciNEVgnM2kALtHJySsCu7BALeB0EBkEyf
    CgT/QOvEeojWBOP3qujuOl7h2fbNO7fqoiOD1rIOSd9g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=i5W0zKFn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=evpGxPkt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=i5W0zKFn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=evpGxPkt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbeBZQDT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 11:03:19 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34485 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeBZQDS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 11:03:18 -0500
X-Google-Smtp-Source: AH8x227sF/o3KPJ5srfV9D1wPWV7fxEYg1SLPGEh4P1mopz77ySd+rM85n4OOvm9JpW5TyOY9Epayg==
Date: Mon, 26 Feb 2018 09:03:15 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Manoj Boopathi Raj <manojboopathi@google.com>
Subject: Re: [PATCH 4.4 002/193] net: replace dst_cache ip6_tunnel
 implementation with the generic one
Message-ID: <20180226160315.GA9137@flashbox>
References: <20180223170325.997716448@linuxfoundation.org>
 <20180223170326.406395326@linuxfoundation.org>
 <20180223230008.GA30215@flashbox>
 <20180226125901.GA13889@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226125901.GA13889@kroah.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 01:59:01PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 23, 2018 at 04:00:08PM -0700, Nathan Chancellor wrote:
> > It may also be wise to take these two commits from mainline, as they
> > are along the same lines as this one:
> > 
> > 09acddf873b ("ip_tunnel: replace dst_cache with generic implementation")
> 
> Your SHA1s are odd, this should be e09acddf873b
> 
> > 27337e16f2d ("ip_tunnel: fix preempt warning in ip tunnel creation/updating")
> 
> And this is f27337e16f2d0e52a8d05ea599ed13cd266ac291, you lost the first
> digit for both :(
> 
> > There is a minor conflict with the first one due to stable commit
> > 6f99825e7632 ("sit: fix a double free on error path").
> 
> Thanks, now fixed that up and queued both of these.
> 
> greg k-h

Gah, sorry :( I'll double check next time!

Thanks!
Nathan
