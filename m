Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2080671-1520010911-2-12270858014855382622
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
    t=1520010910; b=vHoGKJbRrDg/ud52SCw4Gztg+1xNggDBhMeRq+q+ObUOaVH
    Ij+UH6JJWAe/AdcNGhGYmNxyiuFSgiEV4ghlooQQEjdj+zZJTHjm0KXaAoJMudS9
    uaM/S3adro0vdzTdenQ6wVePeQICU46oKkIrcHg6PSYIOzlzASN7gO1q6Bp77RLU
    fnt28W0RLtJElRbDkkLHxb4vNyzxIkHfquFo7TUQj5gKWkqTedij+U0Qk3JT93Ba
    ozRurmSgmaUEbF5iy/hMnt3DotUra79yMYEqMMyZPCYTspVyZbM6+bMt+F707KTm
    ajvNc3mM2McCpM1eMvk25l6kRnMCz9DqO42jKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520010910; bh=UreSuFa26TF3Hq04PFx7dj1gc9
    tCPvjMbGQw5UXPbjI=; b=lilsVJvyq2Xz+35gkEpNT9mUJhhccYum2s2EYVRRDn
    snpczL4RodNwip9E3umy5esArhyzFGZYYdTl9LqL24xIsjD+ZxkR+STa/IYcsmC1
    qn531x5ZDrOImWRfO6pc2WSqWS1+eBkhXuOWkqQAHSdHmZvmDKa2w8EpHAOy5prw
    ns4uknUyGEja17/233OqGOKsnkrvQVmQh5At4Dfiy9UkA/5WeKEFyxucvk5AEfRK
    Lvx8pbMwx4iEyhmnFrvzQjNBTMDyGMLgWoziymeBlJukc1pLesQqHajZp3mP4iv6
    hRKhRIf68RN1T0S35863s3MNDqlnQ9ins8w9XO/2wsdA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZaKD3gIl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eW2spCx0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZaKD3gIl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eW2spCx0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427133AbeCBRPH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 12:15:07 -0500
Received: from mail-pl0-f54.google.com ([209.85.160.54]:39177 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424699AbeCBRPG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 12:15:06 -0500
X-Google-Smtp-Source: AG47ELsj9n8GA9uc341BIWBOyPRmYnrUsHbuaTi/KiiMqoIhEoQum8mWazPdlUpP0BT/kTea1m2eQA==
Date: Fri, 2 Mar 2018 09:15:03 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/115] 4.14.24-stable review
Message-ID: <20180302171503.GA9473@roeck-us.net>
References: <20180302084503.856536800@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 09:50:03AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.24 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar  4 08:44:32 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 134 pass: 134 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
