Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3418695-1520696555-2-15088936367029312400
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
    t=1520696554; b=qQw9KobOuxpWa7GP9sFWfI9w27qQ+jK0aDx3JI0WSsmktyz
    gWgjiQ1B25Zvadiw3BeTlMXSnwR0C59GWFmCh7BEolFzed/UxTJEjiQTecoEDnj2
    kEu62VzQoebq5kUsmZ2AqyG4opB1zeQeCJL1GZ6m7oCbdqfE+vj/LCRqPXzVqxkb
    IwS6wMwUrVCUL+ttDTatv+ZeuiiXdPd/4X9ycjw4BFUKQg+SLD3OlbRi8GaJ/1gR
    P1SD6NbQxxiLyZTwo9CTj4j6Z8aRmNA0RZQ2AirW1HJaQc7qJ9Ht+uhpwsxo5UYU
    ArXAOnybqJj2aq+zd517nUg3o3aKI/krckHE1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520696554; bh=iXZnG+/po6pP8Sz/izl/pVkZLvcSkF142yds4ZMybfY=; b=V
    FdePS3xa9ityXFyv6Z3BbNR+eQNLIe9UGvlunkAOenGIUJ6hOeV7diJgXL3wS2dx
    lGYql9yLsJhRhdktgLZtbNdl4LXQk7TK5r9NkzJk08lpjhgJIMmJ+hR9fliJFG44
    fcUdVAhr5g202TvIZrAtrkMpOZtB6Z0B29EyO/T6GdFqYTOMxFmE93k0VV8vkzip
    TdeItqHdulIC75JsruY3wlQauxJBGwQfXnv+EnVxh+cR/32cbMptGDhzO3ZGkSVX
    YjeK9zNP1Z3VogyRmvU8f5jE16SchCjiBEr3VE6jaBmJbwFB/8pyBhlK+oQvqeVN
    aXvvjRGng4XAfShbUSGyA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GAtGjmtF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rpRKHJ3/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GAtGjmtF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rpRKHJ3/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932168AbeCJPm3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 10:42:29 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43461 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932127AbeCJPm3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Mar 2018 10:42:29 -0500
X-Google-Smtp-Source: AG47ELsXAhQsNvBnw7qlHy7Y0r4yueaW9yYALnH6aJ0PzsJV1Wxgb+zc4bsjc73PYeCzWEnBNt0ZJg==
Subject: Re: [PATCH 3.18 00/21] 3.18.99-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180310001801.045114869@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f874a3f4-5047-06d7-fde0-01968718020b@roeck-us.net>
Date: Sat, 10 Mar 2018 07:42:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/09/2018 04:18 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.99 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar 12 00:17:44 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 119 pass: 119 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
