Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1689738-1521298145-2-8576394501481139878
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
    t=1521298145; b=Q5jLEdrY/iKJKkyw5DeIH11KzJL5BfZQjz462JU0J7kigWs
    /OJHRbc5yJHyASsTxd92tmrO+YLdkWLlmaTz/LDy+IMgeHQw3ePX4bjwwx0gDAHf
    y1opcOwTQ7pfNyEcgyxO6M4r9c4QZjpj4wcUv7HCo5dhKOmKVVRpKPfTQvFo0HFP
    EdhL6i0o68a5o3NZljDeDqo9wPX8YLmJ6WmJiL8dsgFsn6VWlVAITtAEH/ECfplg
    Wiblh/gQUZC5me8asFxh/+OjEMLaP7xHENI2VNq2jcaxLHZAR6Zc2ZGrO7hYk00S
    TwUXPiFypyDEZcX2ZG2VBI9fSNNZ6Ri9XeuB64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521298145; bh=/mAr/W1hewnM4bSjb7jtt2C/NBxpseqMwR+iY9IhMW0=; b=J
    cWwC5H7MReRQmLyLkPy1Zr0wu8CuURc1+rbwM0naNe0IVPc1c/pujjdtdmL54jy9
    I+ghxEI3Zz+Xrkkq4fcjlo7V0Zz2hsq0HCKxVIH5WqSOcXiwOaNx1zjWDpjthIJU
    xBOj8K3q8E0R7Ho1931N215UUBI/usW7bYCAgf+b+FAv8yPJPqfPBRjR8/xE/Ps4
    LnpQ/TgHrbiMHt/q2ZHLjSAW6N6+FaO2Nyqf3MorCoAakNqizNsxc2CjdNp1TWTg
    4a1x+uIlyrzkcktZhyBnrV5/mtppW9pPhnYKbZXigEPtLeYCury5QcuSbRl/eDXp
    IXcD4aw6V72f/StaGUEPg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J5czkcsN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MdV0twz1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J5czkcsN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MdV0twz1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeCQOtC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Mar 2018 10:49:02 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35348 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752589AbeCQOtB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Mar 2018 10:49:01 -0400
X-Google-Smtp-Source: AG47ELuPUe0S4H4Yd962KB5BjcJLJtoW2F/GwFFdyKDQ5onR9U9acJmyoPJBdDX0htKAPLpGQBDMnw==
Subject: Re: [PATCH 4.15 000/128] 4.15.11-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180316152336.199007505@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <120779fd-01fa-fd6a-66d6-fcaefa12ca2e@roeck-us.net>
Date: Sat, 17 Mar 2018 07:48:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 08:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.11 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 18 15:22:57 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 147 pass: 142 fail: 5
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

drivers/dma/amba-pl08x.c: In function 'pl08x_terminate_all':
drivers/dma/amba-pl08x.c:2185:3: error: implicit declaration of function 'vchan_terminate_vdesc'

Further details are available at http://kerneltests.org/builders.

Guenter
