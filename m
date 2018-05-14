Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065765-1526314915-2-3535658166938641457
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526314915; b=IB+/h1SWQ3jRaU4c7W8X+kuzDwOycLTd32cOsDlQ77225kSrV8
    dqJov/q6CbfnCByP7ONn8YTCpzGg/aIPXYA+DaFTouDqKcRRAk7P17M8EoDY3NrC
    BFNu4Gz5NvBfDPF7NNzZQwFvBDrstz+4Yq8VwjMEbiI3cxJXlx9zRe24ljnfZ98c
    QQ4IrMQShQr/n45rwBgZMkdZfKhyrxmZdTX/1mw9V1gQUu6ns0pR7APDIHng9CQE
    xEiiSliOAFOeta9k+WKIDhHFaV+HbFgxPbej2xh1VQA5Iq226W2jsrULb8mTXYS9
    qTnxSqSvBQHczHaIO4XMZd4raXsXPAoRmo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526314915; bh=dNiJMbBnaFrIjH+X3I/QUF1DQpx7D4
    w7Zr5DV6aOEVg=; b=FCVGBd0Oq0jrrg08klCtDw3+OBayA2ZU3ALaM+BtQTKWUJ
    7spgUj2b/xpH9jDD1M4GX9am8MnuDil0alfOXmOwf53umF4i18GeQ8pI7esr9jTg
    S/fBhvQFE3YEhhyKCsGb+GfOIuAthqwttvI2nx4ExfrvDYExgD+KF+O+i+dnRZtn
    Sqbu5ZlP90mq9q7xZaG7863Yh2GyMKg+qlW+zzH6tQGmPNuZ4xZC58E4OkDOp4gT
    AGscbGDqnRqzg3tdy4SdEfWVSoY4TV3j3Pj1C7dEF1EThkF+iLmkd6vwPPG42Y0D
    3ooPyUsNg07zdn+3vMDjS35xXg+RehsTeRs37SiQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=GpqJVwrS
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=roeck-us.net header.i=@roeck-us.net header.b=GpqJVwrS
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCb3V5qH/rEjY6pMUM/wyQ1+dpKKcTZ1zmmkkawZ3HlVSi7W25beSeinLU97OR8THnxx0cXtjc1PfmTWzK90HB/D7q4HZ9Zw1FreWctVMfDRQKm6LYjP
    gv6IQhypMb2pEQw35yJ3p4RRP+RQ8HC4eCD0PYhQ+XH+7mGnbrZixUUcInAtbWIav260WUrkkkUj+8syJHQ43/mqqbGvSZya5n0TSd2/+blWuqI/oo/2XoRM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=UNgQRUVOudEA:10 a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8
    a=HoCkWmlCV56ydFt2py0A:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755062AbeENQVj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 12:21:39 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:50464 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755049AbeENQVg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 12:21:36 -0400
Date: Mon, 14 May 2018 09:21:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/62] 4.14.41-stable review
Message-ID: <20180514162134.GD31622@roeck-us.net>
References: <20180514064816.436958006@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
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

On Mon, May 14, 2018 at 08:48:16AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.41 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 16 06:47:52 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
