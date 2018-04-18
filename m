Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-732471-1524065936-2-6154679889404126513
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524065936; b=PALj0WtAc+zsbxfaO9ihIx5Lq6B/ycZpad0u8ql8lh1mwriOjY
    74i5Tv8kP3FzE0ZNqZE6usi8i643IkYLUUuxNxI4zK4Gwk4wFfMi8aN+A7RWjmMr
    yp5jdkOyav8xq+6iT+pDYizM5KSJwqY20HtoV4/tVbrKmxqYcN0lkuYTVtK7rwDh
    vgU/6gj7tCi/hUroJ7S0ntVDLfvvY7UN5AxGwaosMWlhroaKmW43rg2FCWRSCGTs
    ne6ysp+R52e+Wi2QQMKyTT9jkGzxH4c/kc8ClJnkGBoxvsNhlKpPdX4Tadua8Hi5
    xAorkcN8G7pMw37GUpOONlZT8qNpo0dh3wUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524065936; bh=ncm1NzWqVr7691GvtfcGDK4DD4kVoe
    uzhAmHuI+MA9g=; b=mu1rD59NTuLhqNZy0yLh67SiFNABTpd65RgfKGnH8DUg5N
    77t0x0L33Lf5rg6eO89xri8GjRs1cp1X8gVpQ6dEUZHuJGOo8JS/Q5SWtJzySmtE
    FSU/Y73mCexnWJrj6ImuyO84JSpcdCg9SmvmNbsSanu6JqXCEpEwVe1h4/sxJe0J
    r2vqSkhfhtz5/kQA2Zudvq+czibJWRX6zGk8HPlTj5xcGbXTbyiX5HW7y5AEapWi
    puZ9HafkdzBROr0tYlmSrk+elYGNIcnFe0GdQRIzbJnvnNVhfrRrN20ALe2fmL4N
    VruUtGDQ/b/pVJVx7CTSvFOz9IMBovVfcd5rSnAQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=yUfDFaXG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=yUfDFaXG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLg/Ygyu3VHSxKKvKgl44fGEGOa+9VG0ePN0FGMCW04JAq3sXTgXHPJ6EFo5wNZfDKIo1rfBYsSMWNgSXoNohcllOzOikAiQtYO85AJyF8oHBfIEMlwD
    4ooBSZo83lkIia2MNjo+0S6aREQ5eWcHjhI+hvwl0+sLqVh8J8pN06o5Lzc/0SFo99GT5WuVEOc98YRbEtAXdEiQE5UBR0XFCya4dIRIs7r0scO0FTg4QhFU
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=dj8Mge5Oz2kA:10 a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8
    a=wSFAT0bzRL9SllPayaAA:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbeDRPiy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 11:38:54 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:52109 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753894AbeDRPix (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 11:38:53 -0400
Date: Wed, 18 Apr 2018 08:38:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/49] 4.14.35-stable review
Message-ID: <20180418153851.GB8888@roeck-us.net>
References: <20180417155715.032245882@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 05:58:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.35 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Apr 19 15:56:59 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
