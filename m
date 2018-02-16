Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-268172-1518790382-2-7786340098197851715
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
    t=1518790382; b=Ke215e/UpwAxlA8pDSX/yInRszWH129DeREOrBjfgSgSGy1
    lXVtdAsNtEisNhU2R5sZXUeANUjbe/mKJb2H1iPjOspg3FRKUdZXpT6R2XLOXAgB
    FHRLGx+1oh/CFz5OqiSluFcwlcxxNfaVGHUGEn/53Dv7vHB64PfjaejOr2pmR7ad
    EYiKXAsyJdKkm5SAlY1Fvo/lW0odPnMrVIuWJxnGnJ0iUdx1hT7SFj1a236SHlQS
    DO2BrWe7hbMum77nHpoX0YlPQjRXswn71Mk9wqItKK3Fm3nMycSWLde41kvM74mx
    kBpGSUgO6eoENnuqkg7QtSGC+JRlCC4QYdiD6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518790382; bh=ir7DFAVXMXOf67M4yuOgLj0cu0I5WYyxU/36qRVx9zk=; b=X
    Kv6AcoEW448FRHP20W/o6ZAqyr3e4OOdDt+OBcSOOEUhCfD4JU/duGzlHI79RFxU
    htTvGz4Dvf8otSwMFITQGEivzLWGLp8tMIKS5PXScoibE8bKAxDfNBumNNDGifum
    Y8yUzP9pRQa0UG4EEdM3PpUF/VPcOhyuyKaXb0xFEn+516bg3PuVm3l3lOtSGj09
    tYfO10Rbj8QTIy92jAINy/IEorZKdxm2OJ32XRsH6J8oNL/jegEqxX2qGfEmHxQC
    uxXa+o4NJkoEbUFAOg1QhXKL0FZfApHTDKhmhr8aN8zPfF9Jy7eOEtePOFkk/H3F
    9niQTtp6ZKrbssa5PJIZg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NZl0ZUi/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NWKxjkVi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NZl0ZUi/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NWKxjkVi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033967AbeBPOM7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 09:12:59 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41127 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033893AbeBPOM6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 09:12:58 -0500
X-Google-Smtp-Source: AH8x227PXQrtjREaH37ivBaZlN0zBXrdTvGkiTqNge07QhdRBccYd8Zd8n98SnWHlPIgry6ZUFIHFw==
Subject: Re: [PATCH 4.4 000/108] 4.4.116-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180215151222.267507937@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <47ebcf21-490e-9307-5796-6dd7bf5b95e5@roeck-us.net>
Date: Fri, 16 Feb 2018 06:12:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/15/2018 07:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.116 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 17 15:11:36 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 118 pass: 118 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
