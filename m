Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2776020-1521724536-2-9557634642501485841
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
    t=1521724536; b=aYixumlODR9HBA9e76tBqmC8XYbcTZ2hNTmdwBeK0ah72Zh
    nUkKWFUZ9piQs5mPjRJS9G7zlh+hGKB7sUSV1DyQclWYUJqICap0W1JgnLrVOJml
    Fi2dN5nRSZYD+NKb7JCh5/SqVNloacDjd8TlScV8Mxd0wr0uwR3cY04rd1kj6AWA
    dP08L30we8FeJzAEMPJlnDZv5ELwK5QVbexxoNKffm6C8QrNnvvYn8/5w/qPe1Fu
    bbBjQeQlS+j1CJa9nmFReETJ4n2dcM5iXfrTp3YKOftC/IUmX6htxeV9XYVjMwnd
    UHfQfoXJfSO33pQMftHITxHPXagyhg5hFGJwoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521724536; bh=KBtLSku6s5um14GBQNX4dpTwjmfSAoUCgnqaWHhNxac=; b=R
    xeIl2AtC/nvWGnlndsYIPEnOEIi3jrMrSyKgKQNMzUq0UxWK5WXbP6HwiFWoT5mM
    EogbyENpBhgkAI7OD+cnvKz7yR5YHA04ZiRTFvZCXePPi8sv/n8Yoz2bDZpJDIPA
    F2avfNyIQxHO/eBRDZw1WVyL4x4Czsl4JxXIBaMuqPR8rbun+zIuPWFJDdhXfHyo
    NLOxeKGYErTcqgS6pcOkoRjtili64zMEj+KIcR2MZrxYBhaw40lMM6ZW/qfzYVl3
    PwFSdgg3MRcV5FrXI5WK7KFkFawS1ztiP4pLLwkyrey/uHRAU6DU+ur3zqDa1UuA
    BhrMFdiCT+eDCRFsACLuQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZTZZBn/2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uJcndKIC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZTZZBn/2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uJcndKIC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755039AbeCVNPd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 09:15:33 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42010 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbeCVNPc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 09:15:32 -0400
X-Google-Smtp-Source: AG47ELu27JvsChvsx0PN5PMl4QEzMDXOgcaPqRVmzNyXGLo/hnRPyl2wmbqoXSGvRV4MumEY+oKWsg==
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180319171849.024066323@linuxfoundation.org>
 <20180320075012.GB10034@kroah.com> <20180321131843.GA27151@kroah.com>
 <20180321174043.GB6008@roeck-us.net> <20180322082058.GD30498@kroah.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b7d6fd2e-a9b3-24be-d499-b6b78e5a1da8@roeck-us.net>
Date: Thu, 22 Mar 2018 06:15:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322082058.GD30498@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/22/2018 01:20 AM, Greg Kroah-Hartman wrote:
> On Wed, Mar 21, 2018 at 10:40:43AM -0700, Guenter Roeck wrote:
>> On Wed, Mar 21, 2018 at 02:18:43PM +0100, Greg Kroah-Hartman wrote:
>>> On Tue, Mar 20, 2018 at 08:50:12AM +0100, Greg Kroah-Hartman wrote:
>>>> On Mon, Mar 19, 2018 at 07:04:43PM +0100, Greg Kroah-Hartman wrote:
>>>>> This is the start of the stable review cycle for the 4.4.123 release.
>>>>> There are 134 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
>>>>> Anything received after that time might be too late.
>>>>>
>>>>> The whole patch series can be found in one patch at:
>>>>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc1.gz
>>>>> or in the git tree and branch at:
>>>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
>>>>> and the diffstat can be found below.
>>>>
>>>> -rc2 is out to fix a build error that was in -rc1:
>>>>   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc2.gz
>>>
>>> And now -rc3 is out to hopefully resolve the last of the reported
>>> problems:
>>>
>>>    	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc3.gz
>>>
>>
>> Almost. For 4.4.122-132-g78a7af7:
>>
>> Build results:
>> 	total: 145 pass: 145 fail: 0
>> Qemu test results:
>> 	total: 127 pass: 125 fail: 2
>> Failed tests:
>> 	powerpc:mpc8544ds:mpc85xx_defconfig
>> 	powerpc:mpc8544ds:mpc85xx_smp_defconfig
>>
>> Error log:
>> drivers/mtd/nand/fsl_ifc_nand.c: In function 'fsl_ifc_chip_init':
>> drivers/mtd/nand/fsl_ifc_nand.c:995:23: error: 'FSL_IFC_VERSION_2_0_0' undeclared
>>
>> Most likely commit 2a39eeb6949c ("mtd: nand: ifc: update bufnum mask for ver >=
>> 2.0.0") doesn't really apply to v4.4 and older kernels.
> 
> Yeah, good catch, now dropping this one.
> 
> Odd that the Qemu test fails, but the build doesn't?
> 

To conserve energy and time, I don't run a compile-only test if the same image is built
as part of the qemu tests.

Guenter
