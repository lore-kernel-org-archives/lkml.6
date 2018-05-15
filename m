Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2185938-1526366890-2-12698227306991847707
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526366890; b=HQTRljO6WMnuksjMKCiXJjpiLuyNCbHPOWl9k8JM5AAUY5L4Vd
    66rLoHM840l9Qe04w/GtnHTuA4MaGxHTG8G6fCIAnV+ywhvHExqMBc9rngqpb7xS
    IK3oVQFgyAAUVcQWO4cZeUdiL9ECyjwbfohKxj1yMEVkZfDM8rhuqtI4OAL9tEtA
    sd+IVwbvbnbIUxqEWU5m31cA70Wt1HVoa4IZ5c1puVdHXYOaJZwF7Xm6zdnufAK+
    qfnU0Ux7Jq1qngOvmvpnhv4Kx/BS9aL03nuYLBDbMZ9ZcNEgRJmeYaxFWOpEaFi7
    FhoYKulM4LV3mZHkxhhKY2XQP8Ljm66kejiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526366890; bh=ThT2k5/f8K8
    QnWuP1D36TAK+F8XfRUuMjjP2tsaxZWg=; b=e0lG0bak1p9vZpcShUb3etgzdIN
    mLhKq7/nwhdwyhiPIAHSkx+txaj9TvdGluc7eqgwpowOX1SGIXZ0pZE5Iwx4BZhP
    kwGYT9wC6dCsY5Yi2GZuq43eT7d7ZTTuZszLy9SsQbnHNFQ8W3lNpNZqku3YWm69
    C5nuVIq74CiKDZlej8njTuFIUsCkcgAotcAiYhXNHjzS9DTfYhGV43z2VWFm1YGU
    qTWWfH69lXG27ULGimcqyYnPenmbMttuoAYf+JRLNFhG1RCKgvcp9pOwXN8bfjI8
    PV1UGpXDzWi2QBsbFj+X0V4zxjnQ+g7RQaNwD/1WKkcfnYlrYmPuIQKuJzA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=rooEuOfC x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=rooEuOfC x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAQ5xcpvYChv9KeZw5R8jjKrW1y6E03h2YTskA38RpQ0v9PHFP7Pdd6/kUVAqc64rdqve9LEZv/v2fkOQ4FTvXbQpGdJ6s03WRb/6OS5ufPj/mY/sHX3
    FAuQCc4Bl+MSp45DEWm4QxuGEdi/gjy6wolQzPnsh7HeTdO9W8HSZhYZ3VksCwJkKmfn/i9aGToN5p9I8LVjqRoyy2OrKW/8n8RzncnL1LDrEjK8yrPIVi4W
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=9wKpNP2GB4IA:10
    a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=vFMo7b8s74zA3PMuTu8A:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeEOGsI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 02:48:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752247AbeEOGsI (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 15 May 2018 02:48:08 -0400
Date: Tue, 15 May 2018 08:47:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.16 00/72] 4.16.9-stable review
Message-ID: <20180515064751.GF4335@kroah.com>
References: <20180514064823.033169170@linuxfoundation.org>
 <CA+G9fYsVQ1NhkXYNxU7_36DTDb_QxUTNhBYGbX8Hjb=9kViUfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsVQ1NhkXYNxU7_36DTDb_QxUTNhBYGbX8Hjb=9kViUfQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 11:01:53AM +0530, Naresh Kamboju wrote:
> On 14 May 2018 at 12:18, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.16.9 release.
> > There are 72 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed May 16 06:47:58 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.9-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Wonderful, thanks for testing all of these and letting me know.

greg k-h
