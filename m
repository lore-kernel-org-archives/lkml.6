Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-9491-1520980058-2-2622149578898029507
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520980058; b=pIKBArn95PLR7Ko2QVkzme17EEQ89Mm/UHtsZsFwBS+uZZf
    /EmEI5pbRGMncMAOtyeTV5ZK5kKXCLQy2WGiKps7yiaoYHrzQ4ejNOOZD32HHtHe
    r4mCDF5dw/MqkS9lWEkbptxPtecpH0kxMCx19TJNhUqZXeVVcNVeoYThmYO5DnsB
    5ezcOc8pfEjKkp2afHvqNWlzYC/q+mS9Kff3cAJ8utYrVyAeiyZtPFTt3V0Xib+O
    oqa2veAhQMsdYDk880DMQLmoPDmrFlEGHee3/eZB5zp8wjOkAJ06b2gEWExJLCSt
    KqKaZKcsrvn57lTV3FP+sTNJ2gOVXWg/7NiAHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520980058; bh=syIcKxPduwTmqN8rCFqHNtd7pT
    mA+Mv1LJ6mh9FgAKk=; b=hMDGeCLWyuoWFeN0owgJJXPDKko7q+DP+cqAffwCzu
    ZECQzOB72hm+vklnkzma1JPyu6mU6A52Gg51zclHTa9YWFwln+B5O03rKk1m5/NN
    /uzcMY3jRxudZEHPFqHPFIv5K2IifToq/bhEC4wVjFnDHaX14FAt5hi4umqBaDoC
    72RTsxlMD2fK278sKcJy9Q2mFuCityDHkXux46g95NnSFdwEi9KRjvuRTPL/U4jp
    W/F7Kl0gjm7osFFOURzZ6FKarlR3p/7olFFRNwzP3Z9+crXm/1AIMssSxI9HCS2i
    5baVgwf5ScdWbapi/b1TIAnJzle91istEf0VJURUOh4g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=e8W7fXJG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gEm4QF0I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=e8W7fXJG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gEm4QF0I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeCMW1Z (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 18:27:25 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46660 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeCMW1W (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 18:27:22 -0400
X-Google-Smtp-Source: AG47ELt0v4WEVnW//xf3Rk2JjDSmaKSEm43y845bQCQSQJjANztb1Fyg/ggojyhbWLcyDE5vD/6UIQ==
Date: Tue, 13 Mar 2018 15:27:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/140] 4.14.27-stable review
Message-ID: <20180313222720.GA4113@roeck-us.net>
References: <20180313152458.201155692@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 04:23:23PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.27 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 15 15:24:23 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
