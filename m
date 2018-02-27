Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1199706-1519729186-2-16362238786660714117
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519729185; b=k3Zh0kz6C/bjZ577mSXFx9en+Mk4Cr0v9C7OgTUGyS7uvvB
    5w9ARcNvyKpxcM6Sq8HdWpZk8S2Vt2nqqq7w047w0OCspTFK5nPxT9ZbsYYmsn39
    fRFOdh6ZBe31si2pqRspnIEZE8T311jnt3Wq89r17sBslyuzRLYtsGfof83/cfxo
    zt4cg6C2b/P0Kjk50Ftd50mXrO7qWUpVSAaKUAJE0SiPBjDw/p84X7GTVD3XD0hZ
    F8p6O/12bSxJmyPZrBCqTLJvkE4lxNY1qaXWMxkBnlNEWSq4uD6DpLdEkBp7c4KJ
    Z+KIsbn4S44GuqClhROAn5rn7iOMsI4zE7UJ9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519729185; bh=Ji9aDe75ByJtiRt81ty2iR1881hq57ij9bzabFMA62A=; b=T
    U/Dby8j77sFd/hY8USVbOaC5HHk1+Ujzb7YHyoIWzmTXNOH34wKapmMAuK5HF07A
    sWV+aHrzKFg7XZcli45yB39mDDu8rw8ua1kGAeEA9i8U3Rpp3n+zWp4/Y1q+CVAb
    jVycHQlHPcjT7594rHVbP43o8klNM0nbaJAQk0+xJxuPVZY9llpT23X3np2N45iN
    vnT+A7j1UdKLzYke3zhIvOzyBchDOhc3CExmRLtJM0Q+9FNwvQgt6fskOylavjin
    9hCWipNY0HeV53gba3DDZO7rxFSiffxRHp5apeh5TYaMA73fVka7dAURUFLj6snN
    nushNiPXdKYN1e7iACn8Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SPBAUvEX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NB8njlTt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SPBAUvEX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NB8njlTt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeB0K7n (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 05:59:43 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45361 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeB0K7m (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 05:59:42 -0500
X-Google-Smtp-Source: AH8x225lG0ZmGAEXWD0Z+vxTZ2PyDVB0OWvucRWEV8CGlcTKU22ddoWabEMrAZw3GcaW54kFMjLsug==
Subject: Re: [PATCH 4.14 00/54] 4.14.23-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180226202144.375869933@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d4f09175-d9f0-6251-ef34-14934fce5186@roeck-us.net>
Date: Tue, 27 Feb 2018 02:59:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 12:21 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.23 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 28 20:21:22 UTC 2018.
> Anything received after that time might be too late.
> 

microblaze, m32r:

include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
  #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
   ^~~~~~~
/opt/buildbot/slave/stable-queue-4.14/build/lib/find_bit.c:176:15: error: redefinition of ‘find_next_zero_bit_le’

v4.15 is also affected (m32r builds in v4.15, though, for some reason).

Guenter
