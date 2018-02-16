Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2984537-1518749117-2-5601780671450807615
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518749117; b=LIgi70vBh++AGQ9CDxOo8nJfWPZWSiIuDOykhxjbctZekO8
    by6bc1uz7t9Pk+iW45B9p2K2daG6Qjg6p+00wr3Zck7aPlmYi+E4Ysz03j8ZUDs8
    0sS37QzG3N6OycfenHf+wbEo+WwN+62sf/qK4kvac0q+ib2lFvjB+tziqay2XCQ7
    F13dZAACCQGIX/QgWVkY2F9mZU4xjejmeuIsLRf7VLjXuaf6P430Rk/SKhQiI/W/
    sUYdTJ8evoA5P/TrVEFg7tRRvfS89dZtoazL98+JJWlhAKIAUTsrkRW0gQQNtEs6
    ZoiWbssTmDbb/mdg1ypOXJw0Q2sLhs9TkmPGwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518749117; bh=YTOYjLa063kW6ym3vVXfcUf1Ql
    z7ZCGhKBUi9VLhaXg=; b=j8343rcU7sK51QuZCh2Bx7DMbbWo0Um2nBEqzWlXBN
    iJrboazPUXbeXHOH+FlERcRkyBD5oBcKEvUIZ8ncejIbt9MufHfEmH+Fprc/+E26
    lHPId2WrZF24Ria3r7KD1CZmT1cu/RjWbNI1xL6lQfMKFhh1Dj6xSIG2Xr+mu3KE
    UKaBeAHVPzIJ3LARgLutJ7iT62YQavm8JOVSEuqdykAzop8vHj7cCCIoWvxLqWb+
    62D09MyNuVnnnWeRoSwHOCsA7M7rOmNtKySWTCykdnpO9e0mzSH8xYFLhna12X9H
    6d+Pq10GtJmYi12Ted9viJpx9sPeRVu0cVoLvlQM/KJw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bt21i1aT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Znl3Dtap;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bt21i1aT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Znl3Dtap;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757332AbeBPCpO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 21:45:14 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41108 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757285AbeBPCpN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 21:45:13 -0500
X-Google-Smtp-Source: AH8x226o+rR5hN2jP2O+n2VvkXjf5NrDQ1oTNaYSnN2rDHiMoo2ATpjlTJOt5IqK8GO0XoOQX5r4aw==
Date: Thu, 15 Feb 2018 19:45:08 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/108] 4.4.116-stable review
Message-ID: <20180216024508.GA18379@flashbox>
References: <20180215151222.267507937@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 04:15:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.116 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 17 15:11:36 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.116-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
>

Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.

The v4l2-ioctl32 commits were interesting to sift through merging... I
think I got everything correct though, the changes are in my trees under
temporary tags if anyone cares to check them out:

https://github.com/nathanchance/wahoo/commits/queue-2.17
https://github.com/nathanchance/op5/commits/queue-3.10

So far, there have been no visible regressions in dmesg or general
usage (I focused pretty heavily in the video area since those were the
biggest changes).

Thanks!
Nathan
