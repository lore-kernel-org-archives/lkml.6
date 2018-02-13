Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-716954-1518549735-2-5676976053299419923
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
    t=1518549735; b=tIcccVR+fmPJyURgUfecuX+VRK253F9Gdvc5n5FLXjxBrLd
    ZwUYmeCXfEPZ/RKzQM6PP9SV5ossInz0pVv2vlSJBzYQFOJMtk8BE203zVilwCYR
    mnEz6aNwcrC08/aD5woYOPmru5K0vgtXd2BmrYlphjFkePM0s+3T8DVGVMOj/eQN
    lNf21Aglb9i2+KYBrdtXzlUcNjIqJS44ZAytUTU1EGj0UeVHu8D0ktdv7ENgfQ8x
    zdg9u4fTOjEJwEm9ITeQn07rW4qXgSZBJMrrg66hzDk3/IZU0FiogMH9j/R+oxsL
    B9rd+HeB6mH+lExrUUagPGthdoytqCodNzmY8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518549735; bh=dXnQXsAGxcYwpKttC5PfpBE/mR
    RGh2mxPSdfzkp7Fh0=; b=YZ9izvgHCnsKVdksugVTm8tyjq97SLbQj8pRAu+Ruw
    GJyEFUVV/SSZcDW/7CJ/JwuEcVyADaX7RzGjQ5Dz0mQKSBYj3v+1GKf3s6b780lP
    U1a9VF13HZGyaYKNQB4KLQmWEl2EXLIUGpRRIzetjtr+gh6p6loZY0MhGaR5aCdu
    aWNoD2XC2tKxdKAz9IdOzDT7Hl5zIxb5o9zswue8OnYYEUFcy+gSCzGg21nDV3jK
    jYeqy3Mmsui6MWOQGJ4OTUgPUbv80RRa0RvcTFkQdCqOAnyqgmf19NyOm/gF6vWL
    00PKe1oVqdTPmkhmJFqxTG3SRwh+drEQ7QngpzivoJiQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbeBMTWJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 14:22:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:7067 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751819AbeBMTWJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 13 Feb 2018 14:22:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,508,1511856000";
   d="scan'208";a="31135901"
Date: Tue, 13 Feb 2018 12:22:04 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] loop: Fix lost writes caused by missing flag
Message-ID: <20180213192204.GA13682@linux.intel.com>
References: <20180212230558.5546-1-ross.zwisler@linux.intel.com>
 <20180213145404.GB14657@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213145404.GB14657@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 03:54:04PM +0100, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Can you wire up your test cases for blktests?

Is blktests really the right place for this test?  This failure is highly
dependent on the configuration of the filesystem that is holding the file that
we are using for the loopback device.  It doesn't seem like blktests has
support for mount options (dax), etc?

Because of the interaction with the underlying filesystem this seems like a
better fit with xfstests to me, but I don't know if we need to add tests there
because we already have pretty good coverage of loopback device failures.
That's how we found this - this bug causes all these tests to fail:
xfs/074 xfs/078 xfs/216 xfs/217 xfs/250
