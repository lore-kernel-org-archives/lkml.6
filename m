Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1816815-1521563483-2-9361362086531566773
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521563483; b=Ks713j91S9tuv2rqqpTi5GCoZtvfUDSYXgKxRY6aOob33RH
    YA/9aWFiWkgZgVEZKaP1rDcJI79De7NVKKHxi8ggclq/R6D/VFrR7y/NhiVZe2s3
    fpxX9cdVjzgLVCHFhlHvsUFk2rFf3Cjhmod0qo6/tHEjUCPp/yVy0M9fcuNULYV7
    Ob1fROEMJon9MS+pDv98bYPg59+94u0FH+ivE3VmcQtI8KIe2VkGq+Wk54U4qo25
    YTLtckzxFr2GW0B5VDsLb4/aEdzyiKAQovYavsRtcKKlOLlTZ/ey+V8OMsnlmGkS
    W2BotXD4Zl8DRFA1SK7LMMu1ODvcQGWhJcUa/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521563483; bh=WGnbZvsaI+oflWVmbJi6V4ZsVlhckUR5sSsoIo
    Xdndc=; b=YHn/fRliDyZpSmu5MLQjHAfYFF8Z5DU0aSg751rMBKrd07wrl4xRw7
    UH0irJl4jg+LCWVpEI2EfaDoLDSytFd6TD/2YccWUrc/mt11JTvrqn4BQLYvUE0h
    K4PKVuuWwKWMS1aq1GF43ISvzSWibz15rzGUWWTbcCwW6KeTpMJ+Z5BvL3fMZ6c4
    FBiAz6jb9hllrvwijB71O2QAC82NG72+Ate2pUfJ0tMa3cEXOvhXTq3eZQ5az8L5
    nfuEr77i2rCxEJzIh9RiJCRNI1TB64HPHQGb8x2P8OV3p9QhLltAQYr59TX7g8O4
    SN2OdwCirS6gi6d3KuD94qJ6CCfbj8yQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CBVQKmJt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kLj5EAuL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CBVQKmJt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kLj5EAuL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeCTQbW (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 12:31:22 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34090 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeCTQbV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 12:31:21 -0400
X-Google-Smtp-Source: AG47ELuZwfA5GR9haWwmVhyQq+zdMdXbW/ErjQQEl43cGrkYlfl0WZM/leSWP1r8N3SmA/4FW+/+zpm/q7LRB76G4jo=
MIME-Version: 1.0
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
From: =?UTF-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>
Date: Tue, 20 Mar 2018 17:31:19 +0100
Message-ID: <CAD9gYJJq8Bpc_4ACt499w+B_yW7Y1gALnevr64NmELNa6_uOVg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/41] 4.14.29-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        "v3.14+, only the raid10 part" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-19 19:08 GMT+01:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> This is the start of the stable review cycle for the 4.14.29 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 21 18:07:09 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.29-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Merged and tested on our test machines x86_64, no regression found.

Thanks,
Jack Wang
