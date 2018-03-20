Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1722532-1521562305-2-2876458080701379683
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
    t=1521562304; b=iWD1J7jQm93GsCf6It7x/wOCJ9qtkqZA7lUi3k2cHP3JsMz
    TBclo9Tl8cageSXAB2WvA4YnRuYW8FzFWVHNhHor7UhYltvKu+KNBo5HtsnJ90+n
    TUiB7o1XObtOHLMBhVt27x124olObqjHkJaic0C2OGgGWsWllYIoM+rta50ahLUe
    yu0D8U7uzAD66+rmgq9B8wwePbm5xjUuddc+i0mWia5zG+a+SVdRZl22/w7m3IhM
    l0ozX3UD9NIAXK67HhtZN7Mr1zwYw82yS61Zs43oVV5qZKs1VLHyezpLzW5a8mz6
    Cd//gHA+FTmPyVuRZSGf8R/n6ah6rT6kEtph/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521562304; bh=RYhXtz/q2KnDDLbSNpvH02+IEt
    3OGtKjS/mY7Jg0bLw=; b=bkZomVagwpuBfr0FdqwkY1MXOHYhDRqRjXkINjcr7u
    tqDXeMTJHQfp3x/zK9QkLC+HIfGb1y1Y4m5dqmtKJZjVx6gVQsaMzORYje/TCxiO
    ywFhw24wyPWhvq8IK+IG7ynCAgDWU8XeXSaSiPRb5Hf9+37IxxEHtfPOjozlvEIJ
    qJWms7QFTH8uAozOQ96u6bzmR7+YE1n9HpNPkH8gjtQ1A+pvJQW/e6LKA1FDC3Zj
    3/KsvWuHkEc+uWnJFQmfZ1dF/hQHjWb47fBxOgIulCXQzu9n8x2kZhaE7Bmq8V0T
    gdE7ckNqCe2nLhnri9Qt6y3pQ39meLGwsAoi0Ie0AWVw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YquxmniB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OJSjgHMt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YquxmniB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OJSjgHMt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbeCTQLm (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 12:11:42 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:39493 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeCTQLl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 12:11:41 -0400
X-Google-Smtp-Source: AG47ELtewzmtgLmo/seyy7zz8wOTuuGcv4nw9RPfo6ruXZiKdveVF5PiPaaeAUP8fyxwYxERqtxxJQ==
Date: Tue, 20 Mar 2018 09:11:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/52] 4.15.12-stable review
Message-ID: <20180320161139.GB671@roeck-us.net>
References: <20180319180734.976730813@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:07:58PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.12 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 18:07:15 UTC 2018.
> Anything received after that time might be too late.
>

For v4.15.11-53-g3c07abd:

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
