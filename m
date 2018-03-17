Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1672187-1521297986-2-6661731126630815424
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
    t=1521297986; b=BxurThlq3zlUcRT514GAqTRSv5w4GOpakRPU3S/am+RQNE9
    h+rNE4akIGMsKCjJv+2HY7HHLJOJK5S0fZLI21Wl+rOjRqE/SdQkmJ5Esig1j6v5
    69AoKtZSGyP4Mj3+zNlkLTP5kxXWLcQoYFlyPG7iHF6+9MRBhOrFrhl2fVU6y/Qj
    eJfYwlmbLpzYnkj5QRGXCp3HZ555x/4NNbCh1XQxcqJRVKfXD/+tS8I3kJbzhrYf
    5HZ6Gd3ZmA651qnMrD4I3VewW56/5RuV2g9IdY9RkAatossS6wQaih7bmD4oh5dM
    8hdd6xIgzfjZo0ct0OUKBdLKGJnFVPHm1QM55kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521297986; bh=S53+och+0DmBLYwZAYjXn5orI+qpL2WiXAiRGBmtYiU=; b=M
    9cDLrarDTDkIIxjxpXg6eNqrZGOKufzTo0kskNfYW6IMFwZ+pfa7SHOtPWUrASN/
    fL7Yv2BMej6kqpI35qwE3FaEV4reV1l1hvZ73XXkwz/KnHvNS1zk6VPAr7X2P3ru
    heZNG8YutX1t8B9lGDFMyJYCUUIAomez7KeruxaRSkKAeHVBAzYQ7bdO9NP2kEd1
    GbNpEa/7QvSeGr4l91hh8aZbDPA5MkAiXIK+ao0ZdSLoykNImqco17unb3YByVUz
    0nWnCMXxhVCjurOIpim2zjLpIkoC/bjdtPiDqFD0MmkmtUcRupQropWUYaJUu6No
    u4s6msK2o17cXzjIGVlLg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=toygpOZy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WO1gkz5N;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=toygpOZy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WO1gkz5N;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeCQOqY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Mar 2018 10:46:24 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36985 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbeCQOqX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Mar 2018 10:46:23 -0400
X-Google-Smtp-Source: AG47ELtK4Av/YIMyg5m52wkSSXFz4JIyFz/loyrjTbtS6klmyf8PuJFBveokNB83Lgqyh+aojQfD/Q==
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180316152329.844663293@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e3602cfb-31ba-b3ca-0c74-01cf172eface@roeck-us.net>
Date: Sat, 17 Mar 2018 07:46:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 08:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.28 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 18 15:22:53 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 140 fail: 5
Failed builds:
	arm:allmodconfig
	arm:lpc32xx_defconfig
	arm:nhk8815_defconfig
	arm:bcm2835_defconfig
	arm64:allmodconfig
Qemu test results:
	total: 141 pass: 122 fail: 19
Failed tests:
	arm:beagle:multi_v7_defconfig:omap3-beagle
	arm:beaglexm:multi_v7_defconfig:omap3-beagle-xm
	arm:overo:multi_v7_defconfig:omap3-overo-tobi
	arm:sabrelite:multi_v7_defconfig:imx6dl-sabrelite
	arm:vexpress-a9:multi_v7_defconfig:vexpress-v2p-ca9
	arm:vexpress-a15:multi_v7_defconfig:vexpress-v2p-ca15-tc1
	arm:vexpress-a15-a7:multi_v7_defconfig:vexpress-v2p-ca15_a7
	arm:xilinx-zynq-a9:multi_v7_defconfig:zynq-zc702
	arm:xilinx-zynq-a9:multi_v7_defconfig:zynq-zc706
	arm:xilinx-zynq-a9:multi_v7_defconfig:zynq-zed
	arm:midway:multi_v7_defconfig:ecx-2000
	arm:smdkc210:multi_v7_defconfig:exynos4210-smdkv310
	arm64:virt:smp:defconfig:initrd
	arm64:virt:smp:defconfig:rootfs
	arm64:xlnx-zcu102:smp:defconfig:initrd:zynqmp-ep108
	arm64:xlnx-zcu102:smp:defconfig:rootfs:zynqmp-ep108
	arm64:virt:nosmp:defconfig:initrd
	arm64:xlnx-zcu102:nosmp:defconfig:initrd:zynqmp-ep108
	arm64:xlnx-zcu102:nosmp:defconfig:rootfs:zynqmp-ep108

The failure, as already reported, is

drivers/dma/bcm2835-dma.c: In function 'bcm2835_dma_terminate_all':
drivers/dma/bcm2835-dma.c:815:3: error: implicit declaration of function 'vchan_terminate_vdesc'

Further details are available at http://kerneltests.org/builders.

Guenter
