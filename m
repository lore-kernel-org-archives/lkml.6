Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1345673-1517927464-2-12133979535628117433
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517927464; b=eca8+7sR3APJdlWN8aX1Lw7lB3ePMoYgo24bEIPjVchTxPp
    +BhMhg9VOX1+iyQ2pW58fbHAyHnzWL2BCVG0cDUtR5yx5qjdlbV0AYPmQ/1Da+6G
    n1QlZZGxV58KgU6x4nwwguPq/mwbNdogka97w8PVpU6dAHN/vOfxKZYwIjHghKEg
    N8ywxeXQiW/jfq38XP3A9G0sJJ0ov9BnRbwarOgWP8lM49LpRpcJGFjfdlvaKpb8
    YURF3csKw5LBMrkn/CpV/sVlypZFfH6YMiGxJekxZavcCH+2IqKZURIQB+tEckHV
    BYJD7b+YpWdfUfzrQEVr3+sdbXN/qROMb2vmIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517927464; bh=G8oYyHTOC+Siy+V6HLO03z5fq3Ndo6eyHdZQrjIUGio=; b=E
    n+9mLI1iSmPtutMNevTQqnvg+BH6/wdATNWcprXrtNavsZZjirQRGQn5HaEBVq+N
    VyBkl6ZXQbDpoPpxBlpGRxgwvLeTwD1wtsfh7vEdIrRWpXBwI8aRNvOYn0rccpVe
    nxtTZiYAVaFpOZGOlYwgjxZUNEbyIcxaMEfHLa4fgHIo/iY6QlLZUSVQkuRsF0Y1
    bGGhgRvAiiN5Et14aVjuMHazNT0R17ZnYuKKDzkYQxhzJPyZvGZ1wghAS7YwE18n
    tcqopugRUXR0G/GH1UKMElmeY1vYmwsaqn388OQwVzLhL+XeKojGEVx6r1jAQjz0
    S7zvia30q8uf3L5uaRp2g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LaXwn8Ap x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YFPacM9B;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LaXwn8Ap x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YFPacM9B;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeBFObB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 09:31:01 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44721 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbeBFObA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 09:31:00 -0500
X-Google-Smtp-Source: AH8x225bpjj0merRqF8FfW69GHprLjemV1e67DZAcAYB6zdlYxOCqkg6z9dAjErHpAPE2n7dxWJvYA==
Subject: Re: [PATCH 4.15 00/60] 4.15.2-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180205182213.902626065@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a5021140-8cc6-94c1-f6ff-9add3245a27a@roeck-us.net>
Date: Tue, 6 Feb 2018 06:30:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/05/2018 10:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.2 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  7 18:21:57 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 126 pass: 126 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
