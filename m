Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2537421-1520026150-2-10813879011191842777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520026149; b=K8511UViAEhh7Pmx4BJJ7CegKDy3klXwEghdPg9H5ZUhXrp
    FN0ynDYzezsIsCfOXIckd9CoS2Kq7s9suzjxsxNpf0A7bPbN3oQyFpIgXaSvPHoo
    Vpt8/eha/vnV1eWVjRxH950mQDrafnVvq1U6BKVV6p5ne5zBXrYy1/2fh2DyCD1H
    4GFnAoDO49I6Ob20KSxjuwb7EYVPAY59gBK1cXNePOGoRdfTrpC+npQXoLpCa9qM
    P5uobUl1sxS2dTlvv0Rp8d+WphS22V5MMNqTGdT8776wMQCsnBlxQ/aL8bfj3srE
    u61lEb3g0YzuRXotZB3Hs62bjZKTVP0qE1pueCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520026149; bh=msi+BV/emgRhYUUjwHhD9rTnARltWfiK1NOwaPzYjgA=; b=m
    21e4Y6WvN9rGih/8byEiggb1yYSZEzfGjkCfBzj6lA1YZPBeGWhh1B5n8R+W2Ejx
    HSEDfiuWl7sxnlHXW+NFu/Qt+1e1nfbR4f7ky0HQT0S7IRzb7pH6Jqpb7fNZquVV
    QeeqJRn+ZR+Fj/OoYKvP63N/IZx1CS7KRAEpJ4i6KO3m4l9Dy5JhjF80gLQuKufp
    wdIS+Tv3FZs2NJ/V2khK0MBupHEJMsjoSMj0F55U7nRn3YvR7mkoocX5/9AuOh2B
    Yzrba/AhkvZ/mr9YmZVFFBv5gOALtgleKhd0QmdxD5gRAS/Hmt+eVtPLL7kIX9n8
    k25BFJ9u1Awg5Ivu4edQA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933785AbeCBV3F (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 16:29:05 -0500
Received: from osg.samsung.com ([64.30.133.232]:44947 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933687AbeCBV3E (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 16:29:04 -0500
Subject: Re: [PATCH 4.14 000/115] 4.14.24-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180302084503.856536800@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <d26769b0-5a4d-5dff-ee8b-54482b89df4b@osg.samsung.com>
Date: Fri, 2 Mar 2018 14:29:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/02/2018 01:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.24 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar  4 08:44:32 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.24-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Thanks,
-- Shuah
