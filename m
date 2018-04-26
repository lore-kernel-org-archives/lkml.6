Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2141624-1524725979-2-10899072363149544063
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524725979; b=us+VOXJJ2UWTBIMKsMZcvYX7ckh4h13CMifE11yyA4T4NVNvr9
    vAMkCLjHdiDS8Bh7m1GIx5KWROirSrIc6MKNQP15+y2jaEEeCWvR5cCV6FUPjWRx
    bzZLU82KCfY4OFd7Y4ES0zX0wWzPhVyKo7tOFeh6lOJV/tkEMlq7Q0B85a/ofHB8
    odapl9YvIGwmf/cXO+a58/nV3N+xpgPehsNo3g1/SMrpt4dh+g+1lI8D5F2mduR+
    ztg4BjEx6Vjy4CW/VMtgyx8qkfBk9BLzNtV77fMExYXj5v5twlsUR5n3KB1kcH1k
    2StZghxFnA6LQb5h0AA5mtZhAPeI/9rskO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524725979; bh=bG4urCqrfS6
    AuyEBid4cVAZHf1rjM2+5Jk/ADPTsalA=; b=df+RVzPCSP9zFsRUSq51/ksgK6I
    WDRQ+F0xQI7CxnirE57pMzGSBobuLwEwrAQS5Db3fyiVkKHtAnk3HQyjR1w17+t/
    mnMjy9w47U9IcJfhZesj/dVZbKmY13nCuyRh/n9j5zr0zmg61ncGa9ZMlarGP+HA
    9bb9RLxImIhQFHMOcAJdiX3gs0beqjOdBqZjxSWJDb9gT6grpx1gZNYXzjS+4e2v
    ZFyf9M+2X5BmD0SQfCRCm7AtpaBoRatEOTVAC7qboqtDvizbcMN9Uk5W3ykmEtHY
    yEsZtFo1iUp/CIxMbbUSdU+19aktAXztt+hKKElRDfQYCu5DP2d3ncYE1gA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfK0k1RYUVj2mxKY4pExDpcs4YPzmxnEn9pUSEePNCVVc+d5qEQr455AU1A9qZE4zzusIURqjgEC9UDvkfJ2qo8QdKTrCbSRUJHHaEEdwVgr5wsrIbuW8
    Z78l1CQMyuAITxMXf157bhhG1liBf486vOUukQTwdBBN0FM8FVeMDl+CPDYy0HQJhChkQYp0Yw06DwkmwpSi0KqCbVjFdNKs5xaeIyJuDF/dQUcTUyugO4/I
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=hoiGki7t42oA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=DnoLg5nJ210BuBmKe-0A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeDZG7i (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 02:59:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42468 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbeDZG7h (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 02:59:37 -0400
Date: Thu, 26 Apr 2018 08:59:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>
Subject: Re: [PATCH 4.16 00/26] 4.16.5-stable review
Message-ID: <20180426065928.GD14025@kroah.com>
References: <20180425103314.842517924@linuxfoundation.org>
 <20180425214220.iec6p5elwu676xrc@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180425214220.iec6p5elwu676xrc@xps>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 04:42:20PM -0500, Dan Rue wrote:
> On Wed, Apr 25, 2018 at 12:33:09PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.5 release.
> > There are 26 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Apr 27 10:33:04 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.5-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> > and the diffstat can be found below.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.
> 
> We did find a regression in 4.16.4 that is dragonboard-410c specific
> that we missed the first time around. Discovered using
> kselftest/printf.sh:
> 
>     /sbin/modprobe test_printf
>     [   22.725551] test_printf: hashing plain 'p' has unexpected format
>     [   22.726031] test_printf: failed 1 out of 236 tests
>     modprobe: ERROR: could not insert 'test_printf': Invalid argument
> 
> We'll bisect it and find the issue but since it was already released,
> I assume you won't want to hold up 4.16.5 for it.

As it's an old issue, no, I'll wait for you all to find it and not hold
this release up :)

thanks,

greg k-h
