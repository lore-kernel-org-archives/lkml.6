Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522175093-2-4103892773099021209
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522175093; b=t8vKwHzK9vCFVkokS+vURm+L7tErjVpqA6RbzFZwJV0rMxL
    v5xUISEBibXjsy/dDucw8aggZWPRCnpvv8tZiF+xUY83/XUKMXPbK7AeqbScWFK8
    yZha29uCoj/Ac3078n5fgQhy9xBJQzURi/qjvTFdYC3koJywDR1oHCDw/2rUj5X7
    ErbEpAS/oS8Gy/lxtEjU+oeQE6GSp3SUzV7ViBU6XIZo3gpPVqJi0jCxKoOkFhfj
    uFCDlA2oFdvJPb0Qardg8JlPEKV+cdOPfguN9A+M3yFa0b75NJ0gByHUNJj1LbOT
    o1HFqb1HCU9krTVQfxTL1pX1L5LrCLTKNqnujvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522175093; bh=r6ogNygRcVk9jycjVDNHGjrxKg
    mnYQhx55mF3goD2H8=; b=BTFYGwbqQe2G+ie5SXbdG6KUG99/zcAxrxhAwWI62v
    Spdbcc79uIj7mY0CjEooqWORu+Bfe1iRcxOX0foCtnHzGFmQaOORhnVg/GwVtHXA
    4tQEfS53/GRHJddEYMPEKK0P2+y6OHK7WOrK65l4nowf3MnVBoiJnqVe9w5sIU9M
    8+WZm6kUrYIHBzAcf4t4zxHWbsY8j8eBwcz6qwXlSsFnFW4ARqwGax+TevVMXx15
    NUccq1kTzOEjAdYKQqe48lSiiKkP/wX02qzcwL5RdJWwcijAxrqAAkECGylA2rcX
    tatSR4NENhDbBDFWCnw3T8NI1exxE7XyemnTQoXbXQIQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mT/ziAJi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qLlIqGSv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mT/ziAJi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qLlIqGSv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFdtddjIBbYqRluSz8rsXQmG6654NpmQQpC8xqyQpag21wU23w82Aq36wi0NqPKzmojfQplvzgO72B20/VUigguHK6VV+GeBN+/lmvRLnkEPjeUG0e88
    9TQIoou+v6sdawf/qnmzacuuV+RysHp/QUB4KNz9RtSGj3i7q11qvb6Uv6m5P45E6QT0mEeSlR/eJlW4xcM2dG9V/cCmVTSbKQx2uhcz3gtf5HxdmrTiavIi
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=vY_346TuTMEA:10 a=y98JahJlUwsA:10 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=yyAEcxHfpwDTe0XdrkMA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750873AbeC0SYu (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:24:50 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33555 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeC0SYt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 14:24:49 -0400
X-Google-Smtp-Source: AIpwx49B7+TFFPq2xXYiKjlqMclMd2FwRKmxfUIdQz9R0ASlMsuSjieenMSc+TUE9uLaiXo6dMSBmA==
Date: Tue, 27 Mar 2018 11:24:44 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/43] 4.4.125-stable review
Message-ID: <20180327182444.GA11972@localhost>
References: <20180327162716.407986916@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 06:27:04PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.125 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 29 16:27:00 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.125-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
