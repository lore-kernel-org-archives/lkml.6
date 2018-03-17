Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1672187-1521297717-2-11062782887126504032
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521297716; b=B93kC4245NoGg/byHXoy2t9wLVxiFfAfnx8XccGdF5DqF8O
    xjlbhU2BIp31/x/MmN9P2wKnRtLk8pFk697KabSJXYEzfiqiRfl5y7UbTpqNOLgf
    /aVxqAKw6DVjJyc0iBa8UyQP2s2D4JMDnd/3CeRO3/GrHmxeWM1K3QQcgnycToKE
    gSXTT9yagxdG7ptt7YA6eAMt9wrH3gGDR/FBNweGao74zBmnRbl+F4VD3OsLQCND
    Y8mWnZeJqixzpPPBtoUy1l9J9xtPFbPxKJzLfRHk0KSJP3mQNkxQ3cTrGr/esl7t
    pKvR6Hy6iSFDFd5P+/k/q1xuqhVZgkzLQsbM4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521297716; bh=i0aEfqmlKg5DnDniIcG+z2exIPi2mgpvtkAcObv384M=; b=I
    FdJIN5SAqDteFU8dZXryiyUF55SqQEEdlpDluwSPRatcPCLOdnIMfOmzfgC49cis
    fJTB7WlLMjR3pbbfE2btgCbU4p5v1rq0UOqGoSboMHYEYt05k9VtzlspmVanq6qW
    /NYdVFcBEuac614SylK83Z2Q0yY1PYInkEiOLNcqA/jEBFxSYLQHFt/2fpj3VM5o
    IipOrglbt4MGz3cr/LM2EYU2rzbzljd+e9sGQpN4Zc/X/Ho4yH0dGucPnJcqojJq
    06beyUvH5xcoTInP2hUMhlPPQNgLWL9jqhd5y6K4+TM26BUowJn7lw/9up1uD5RF
    1QXA0dWMISW2EBXzDFjGA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AfVTygxg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CjY1edIT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AfVTygxg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CjY1edIT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeCQOly (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Mar 2018 10:41:54 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34199 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeCQOlx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Mar 2018 10:41:53 -0400
X-Google-Smtp-Source: AG47ELt964m4NqN22AfNzelKDopQzE5n8ZTFj+hCfV8PCHCv4jt9zEE/0ckUwf/wuZ9HMNnHFOfV7A==
Subject: Re: [PATCH 4.9 00/86] 4.9.88-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180316152317.167709497@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <34857d7e-34ec-a94e-470d-4ba5a0b9534b@roeck-us.net>
Date: Sat, 17 Mar 2018 07:41:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 08:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.88 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 18 15:22:47 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
