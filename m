Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2080671-1520010948-2-15139678806902845408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520010947; b=uxDIDB/z7qIVghlpqZ7YUw8ArUiLNycYTI6zSBGdxGF1nO5
    3fObqe8kx6I5rIl8KrL3umhKQiO+/jyf07cXjMtpyEsi4hT+KihLODr9PfaTi6Wx
    xjFg/ALHuBSU5KJ+ZfpztQq54dLdzEelNN5ro7f525XuF6z0lwh0tU3wP9r0mnGz
    dWd1HKGHKEyB+t+Rhu/e7uiWukhj+ANbBSyZCYglHo5kw7pyZWGx1fqYH71QS8q/
    fXeknhWhEzyE4rPrRW5UQT5Pp41l/KR2zfHpY5seoeF3vm3YjavqPsno8udrs1ZH
    Y7/j8/Eq/igTTuk+AfVPSjqEWuiHVjemnrX3ABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520010947; bh=aYlIloUieEgWBSu7asuaHMRkuN
    LXymXz/UK5dHg9D7w=; b=UZgLEGI8PABcSNwtpRBycP5sdkMViOTv+ZAj12mrgV
    yxxgUl3szmhGPVNWDxQXyZvnJ3d5WE26d4k1UGnT8RFqgk+zGDtsH/Hap5d8d21E
    6uS2FINXxwb5e6MJQlpoL7GPR/quZk7KgXBDyLjdhOhaaumbYHMY1nkQYpdyiEEw
    e0lRPxMMy5T50YnwwSqHShTtpHPxTyvWd+FtSneFLZheVihD+zigWk8bNXuIJokU
    I5QrI/9fvYR6eCjqY4TPsXFd++IvoOr14B6PqhTpdzotYca/3vJMs6U0ssR2Qsoa
    tW0LonH8IGuPOu/OV/Rgs7q3q0CoX20jH4jzIw8N6Rtg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OVFdI7u3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JlD6MBEN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OVFdI7u3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JlD6MBEN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427365AbeCBRPo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 12:15:44 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45943 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424699AbeCBRPn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 12:15:43 -0500
X-Google-Smtp-Source: AG47ELvXSafAB3qkJQ31US/k3GvVTnPotECynMnpZW40YdUKHkWWcLzE4ZhNo9A8JzHITFilmF4Dxg==
Date: Fri, 2 Mar 2018 09:15:41 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/56] 4.9.86-stable review
Message-ID: <20180302171541.GB9473@roeck-us.net>
References: <20180302084449.568562222@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 09:50:46AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.86 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar  4 08:44:26 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 133 pass: 133 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
