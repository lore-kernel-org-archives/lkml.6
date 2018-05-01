Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2240368-1525136073-2-5684518055835134792
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525136072; b=W3VUAxsoKpNaQIAURqaiv681+K/50wjKuDGowHjLGCWjoirO3h
    LmEHPS0MVHfpsLnpbUB8fSZgMVmlU9QWcBX1o11prg5RrVytzDY9dtyuOpYWZgtq
    /m2gTLU5765EkRPJpqu4q9Gq3f9OpCjrnRo0HzDbhymB7PIiI9GBs7MTELQgst+6
    0q+/367vYJoTcePUmkuAWiJvY6kHiq0JThOG3ztrOTgRBmYCJpjfnnhi/pVQef0N
    /GCE2bh8lO16NzEbded6ZXPNqxOt5u/XDJhudtXd1YE59Kvtcj7GzEM4FeDoc+9T
    YsM9anqjlATBXKD86oJUz3RkF9vnzIQMroqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525136072; bh=beS2RwOEg77asNpy36D2zXcmdbXFkp
    ZlAMlHtP3+A8Y=; b=QEt0DmXySV+NGWlzKNYbm3bCr5ks9nB5OSIrdY1OFfYE/k
    O6E39+a99x1+Flyt+D+3Kx8zSHScjO6nCX6MsjoZGfwRHjBwheZzlqCQCXWwusZ1
    OKYJlDKexn0ea8oa4Ub4kfdwz6SrzdHuALJPaVJhoqx1cBFIuFAHHp79IShqqGA0
    4iBWajlBIwyBr5IDhHqtcMJdTdUXtWekf1i1jsU2x2fYPBbLkeLRAeG9rVYvE/b/
    hSi+9lWEeXCBpv7Xb5nC8Knw6nVHRC9C7HMCrE8vWw6UQx5utnFGQ0LCKQVCM09U
    l/WHUAkBajJsE2QILb1kO/cOwpvOpi+1L05a/JZQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=RvQcBsYt x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=b8dxTIqa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=RvQcBsYt x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=b8dxTIqa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJx4O3FuBpUIZALKZ5wlC3O46eF33PfbqicW2e/c4cokxgxkaC402XMx6KfvNhm0u5bxE2TzOTQnE57XsovwGjmiJ9bZ0HYaxhvwNjTYmBqizpksHxdD
    9xCgKuJBVNI15E3GnQ9jHI3RhCwhnY/zFVXbc0st5uyKuzMJSCNca1v9bR3a6ntv33CZk71ruU4JLAjbZOg7WAbSQIOByt7HaiDqZL7/BIZPR44J5JEhCih2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=E1qZANYqsVcA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=M3hrWTldcfwBpGn3HRoA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeEAAy2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 20:54:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34363 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbeEAAy1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 20:54:27 -0400
X-Google-Smtp-Source: AB8JxZrce6+ar2t7yNdoggxA1f4UFSbnKIzJb9ZHOF2phfRrCUNqbKut+Ip0ma/K68Zvr8u81xu60A==
Date: Mon, 30 Apr 2018 17:54:31 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/91] 4.14.39-stable review
Message-ID: <20180501005431.GB4711@flashbox>
References: <20180430184004.216234025@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 12:23:42PM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.39 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 18:39:37 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.39-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and installed onto my Raspberry Pi 3.

No initial issues in dmesg or general usage.

Thanks!
Nathan
