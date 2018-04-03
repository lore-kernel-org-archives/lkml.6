Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1905978-1522773125-2-10420762702479128173
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522773124; b=myeUctW58asKenmHh+JIyTz/SK9Nnn3ltqYULbLoqmFurt9A0e
    m6dq0hHtLWzBOc69qncVWTQBz6btgM3mKtbf5OW0tG0jSvFa4dOE5rsq7/iobZGI
    z9zDJFbYWJskfj36T/WYoj4QLuHoNZ3rYQgI7RUmHivYI6EYxxh0rNphrzwn+aQh
    mInKwT8zQ8bQUf9LQ/Bv/2RvHZVCsj2CvMC/4F3JYrlHv9SaMAHr9K/I0pRrQ4XE
    x0ih3DSKR/ldsi7M6FmvVS66Cp80UkVHjIsTMb5FK9/YvUTZCT4s2rEf4+xOfuHN
    Wh8w+AKq1vqCLmy/oPGyUQyAywjlW9mJxlDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522773124; bh=UM0oJnAipQg2eUOQ4YjNmeZvfOM6kr
    qKoM8fJH8x4ME=; b=VeWAgRU3/iPmizVcKmIUZggv07CZHXj9F+K+dLBDOwFVJB
    1HHhRrmEFkYLqyaTxuhiTZEgUPpbR6riAp8mwMUJ6H35z0yVWM8bgr1HkxWVQ08q
    7oSx8HPsVbCTl4A2fGGF3dKPTatmy5R3jtgot2leR7W+c0tdXmUKyvbtKNd/GNUq
    aesrg+GbC/iR2gZjeQx+q5/Iwkln38qPejx2wOHBi0p3SDYu5hTSUY7m8MYZiZbq
    iDnoXV7Yx53vhgKfzlwJWeer12oc4ndNSnYll0qkXe5vwL9ojv7T6r1w0W5S3i4j
    Xw7ysmBpXudv7baxapywS//PIP4FdOp013e/CEdw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP1PpiuNh3KYh37r7InSsYXkVILu+OmLex+CrSBfiwHvRbkjKcjBqX7u6yiVxFg0FzZnc49FXnws6XNSbc1+y8wBvmCwEJw6O5aH3jMz/3fTS2rtBHyi
    DCZc+ot88Z4ehhdJSgVPzK/ZuIcFP5dWeMLCyQTatFoywclVhqGSn8yhjiwKbv4IUTnK/G2KjVuJNs9BSlF9uRNxrSJD6nP3OFAVRX8SU114Sn/pSQdCpFyw
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=6zb38KopAAAA:8 a=R3wYQoVIoFRURugnPIcA:9 a=CjuIK1q_8ugA:10
    a=sLgWHmCJlhLUVLMAeJB5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeDCQcB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 12:32:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37998 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbeDCQcB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 12:32:01 -0400
Date: Tue, 3 Apr 2018 18:31:59 +0200
From: gregkh <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof's autobuilder <build@lixom.net>,
        "4.15.y" <stable@vger.kernel.org>, Olof Johansson <olof@lixom.net>,
        Kernel Build Reports Mailman List
        <kernel-build-reports@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: stable-rc build: 4 warnings 0 failures (stable-rc/v4.15.15)
Message-ID: <20180403163159.GA16449@kroah.com>
References: <5abfca32.5d57620a.a2eca.898b@mx.google.com>
 <CAK8P3a1-VqB8mbixuHdsZbfCbGBpVppO4KX4VuZ5AJCHbYooAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1-VqB8mbixuHdsZbfCbGBpVppO4KX4VuZ5AJCHbYooAA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 04:47:31PM +0200, Arnd Bergmann wrote:
> On Sat, Mar 31, 2018 at 7:49 PM, Olof's autobuilder <build@lixom.net> wrote:
> 
> > Warnings:
> >
> >         arm64.allmodconfig:
> > WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/qualcomm/phy-qcom-ufs.o
> 
> This needs a backport of
> 
> 59fba0869aca ("phy: qcom-ufs: add MODULE_LICENSE tag")

Now added, thanks!

greg k-h
