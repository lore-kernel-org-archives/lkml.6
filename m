Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1887712-1519495143-2-8377707163034494123
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519495142; b=p1LquetdZf+XbtCWwI4i9TbkUada0Dng456ZOPULC6bTQkB
    2gtr2dhcJmlYHdkGdRcUAZjJOtb7FjDfiYYTFd/gy/RZ/Mss4a5YEw1wxKOB9WOQ
    Srd8IPZriQd40ZyxAkkvs5/5o0J1XV6rwMY0yY6E8bS1AW4mP/yPvE5rjxmYmtJV
    aBBtJT1QI+nPkcRmlwiV3T4ICyif9ibYXmyFTf9Yir4F4ENDoNxvBZOh1FzZTgw6
    D6TWn1IKnv7C7CSM1dZUvAOBSZOcfAp41/by1W32ON8XOcLRuIMyCUnSZ5Q/CnS1
    G+uq28z68UflHlIzdnMmXXT1+F1FTtIcRrIGZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519495142; bh=PiZkcoar65NGHDkXJai+XPjtAnYS3yNZZ8soPllhuz8=; b=N
    TJ+dSOWrr4AZDqywGWTxc9g1FhFHpJ9eQGQXx2QE4aE7us1usNO3bQWZqHWvFMMg
    sfksC8+y+/Y/lC8v9vbPkIluHnZ9ERwTIVqrgKSq9O4LXM2WIN4C+Nvu/7pEw7OL
    p1nogeTUx334lQNE0DfjseHvf5yzwhOKKtaifQ2cYVuf8rWQpa3iMQTXHALI5iMw
    PBpypfwMheG2QTzTxaJoZRMwcetIuvnXn1L8iEEA1zwKGKPRiUnqPVyhwLYR+gS8
    epJxJ3E5E4TENVQNEi8qtrox7a/FN91rb5IbsbMa3gzBxzZwiAJoGdGvr/PLWHi+
    xE7fqt+pXluLRy9XdnjqQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kMLIIjd0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FDJi7tfI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kMLIIjd0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FDJi7tfI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeBXR7B (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Feb 2018 12:59:01 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33528 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeBXR7A (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Feb 2018 12:59:00 -0500
X-Google-Smtp-Source: AH8x224MFKynwJHD1kPBOxo8yfTITuSl/cXaI4OOtiT5DRzySVVQ7L0itpZraAd92pj492OmqvFmKg==
Subject: Re: [PATCH 4.15 00/45] 4.15.6-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180223170715.197760019@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d751b526-1ce0-8308-3413-8652756a0368@roeck-us.net>
Date: Sat, 24 Feb 2018 09:58:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/23/2018 10:28 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.6 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 25 17:06:43 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.15.5-46-g82ca63f:

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 126 pass: 126 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
