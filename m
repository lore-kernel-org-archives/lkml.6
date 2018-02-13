Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912204-1518555158-2-12851979929697813081
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518555158; b=BdA/m71ChYBiLa4BimkPbbWBSqGlVSBrqOf5MXVZqgtiRDH
    GO6GDfWD9lUtriGyjJ2qK24iUvpquvEPNRUwhCp2vx9ss5THI0SPf4RK1rypQ5v5
    vT3XoBqJD9OWgRhbA/OhW2Y3m62PWzT1XcqfEbDXk6d2pU/+LrNoYAh+kIJNaC0u
    GOBJmJUpi57tPE0bbOFY8D024Zx5CTVUI8jDpBWXrWdP0uhTZM4JRgCzDjZfq4G4
    xyCNQwEZvCg3vvN2MAPoW1J+5Y4kduq6KVCqIt/TMT/O3vsbF0KE2v2FjMyaF5HZ
    em5V+Ff/pv0XODcr3eXRfc6Q9KHvjZqMbBDp71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518555158; bh=57fHQHaSHojKFH6OGtuZfx2+fUqA2Xo++VqRen
    t/tVM=; b=oOBRWWjv/0f3taKxb4YaIk9kuLIVh5SWv0ziRXzLFmOKn/2xMtKutV
    fRX2ZjYZbC5abDnVKYn8RUA+IZ0qwjeUQPpWnDoQk6203WB5VfuLT+wH+nTGwDw+
    dnXqpvktWaqHJQtviis/Ewjqt0QZ6NzjUGqp8YfNOJvSnL1nuAQP1O6bYYjzfby1
    4n6JnRhX6ZoNWb5zOMtI+fwq1yVlz1PKjoS2WCZpMMrzyUfCmwKkf6P+LFvq2Rwh
    YecxBwVmlpxMUF0moBDjvLoKuqqyyig6OfZZMhjX+xUWFhH/OIQcf2UbQXg7Nkyo
    VEjBlkLPKJcDaSjY1AiV2j1aQ6cm4r9w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=JPn0XilV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oKzwg6e+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=JPn0XilV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oKzwg6e+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965757AbeBMUwY (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 15:52:24 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:38077 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965719AbeBMUwY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 15:52:24 -0500
X-Google-Smtp-Source: AH8x2258VdcyJ0e4mDZ04LH/gHsUMxkuqbPxWsKPeiELxZWCrRMjqyNQ0Q/gB/jZODWB7dkJNnqES6bQle9JdZxc640=
MIME-Version: 1.0
In-Reply-To: <20180213192204.GA13682@linux.intel.com>
References: <20180212230558.5546-1-ross.zwisler@linux.intel.com>
 <20180213145404.GB14657@lst.de> <20180213192204.GA13682@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 13 Feb 2018 12:52:22 -0800
Message-ID: <CAPcyv4jgc0yhZ6mX4az4HJf79q=t0dNy5h=rXHyJYFWhR8Zatg@mail.gmail.com>
Subject: Re: [PATCH] loop: Fix lost writes caused by missing flag
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 11:22 AM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> On Tue, Feb 13, 2018 at 03:54:04PM +0100, Christoph Hellwig wrote:
>> Looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> Can you wire up your test cases for blktests?
>
> Is blktests really the right place for this test?  This failure is highly
> dependent on the configuration of the filesystem that is holding the file that
> we are using for the loopback device.  It doesn't seem like blktests has
> support for mount options (dax), etc?
>
> Because of the interaction with the underlying filesystem this seems like a
> better fit with xfstests to me, but I don't know if we need to add tests there
> because we already have pretty good coverage of loopback device failures.
> That's how we found this - this bug causes all these tests to fail:
> xfs/074 xfs/078 xfs/216 xfs/217 xfs/250

The problem is that those tests don't configure the device in 4K
sector mode, so we're still missing a regression test. That seems to
be where blktests can come into play.
