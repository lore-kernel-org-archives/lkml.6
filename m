Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3939493-1519682312-2-138969054434558307
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519682311; b=U+sxY6kkENEOvcHiwU7v5VORriQ04y+ukY0tZICW6DrI85+
    A9//d2IkhsyRg+0iTXt7KKuSldi6je3K/6QIBoX7+E9WIPjw8WE2wFBhL9hyXcsG
    7zj0JYRwrjTSSuLCELeQtPPZHYV5bxWAuy2aXC8vkSD6aaH0NgXgRrJfmWMknkdx
    SFhDILPbDrXPRF3z6YOCzcS56GNykqCdC8ILYv7pC/6bXg+e/fsv8dUgWN6cq4se
    c7Soc3S3RIwMOhjz2wvUqAmNuxWUP/2LlDr9ryhFAdaTcV4p4/N5wXTjgAJQtC8+
    uxXukpXWLUkQEhCNo9u89zr1qmWV1sXRZNrgBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519682311; bh=NRSc761KczmhR65wxFyREhYkZjNbP7zZhipr2+PClaQ=; b=e
    jQtIUA1ULHc/sFeltGzCQ1mA7baSyc0gzNB3D+qr7T+6jnENnUZ+adWQvHCkHBx9
    xj7suq0Y1UFJLLjqs+vck141AMn/VsFlqNam0TbuKWNSkNKKRPPDRXhvgjDVXQ3G
    u/1M1nGHexw35wELHziZ55qoe0G4Uu2tcuj60PcZQpMpiJEWANMDWH5Hfca6htHT
    noyjCFzHRqh04wEC11nxhTWcgzT5GgzLfzLKhsLh2Rm3b3LkDjcPwSEk1sf9E1nR
    3yGwVJMfxW4km/IOmoSNZcd1j2ld/O9khpnp3y4nceKNndDS6Ai98OK6WZjdBlH9
    X22PpJJxxkBGFP+rLs7Xw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=pW4NAMyY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=pW4NAMyY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeBZV6Q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 16:58:16 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:40105 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBZV6P (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 16:58:15 -0500
Subject: Re: [PATCH 4.14 00/54] 4.14.23-stable review
To: Tony Lindgren <tony@atomide.com>,
        Guenter Roeck <linux@roeck-us.net>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <shuahkh@osg.samsung.com>,
        <patches@kernelci.org>, <ben.hutchings@codethink.co.uk>,
        <lkft-triage@lists.linaro.org>, <stable@vger.kernel.org>
References: <20180226202144.375869933@linuxfoundation.org>
 <81b4e3e9-b631-6fbc-f45c-6fa740e33494@ti.com>
 <20180226211917.GA2211@roeck-us.net> <20180226214519.GF16043@atomide.com>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <878cd95c-e4be-3d07-5689-d3918fccd3e9@ti.com>
Date: Mon, 26 Feb 2018 15:56:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226214519.GF16043@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Tony

On 02/26/2018 03:45 PM, Tony Lindgren wrote:
> * Guenter Roeck <linux@roeck-us.net> [180226 21:20]:
>> On Mon, Feb 26, 2018 at 02:58:24PM -0600, Dan Murphy wrote:
>>> Tony L/Greg
>>>
>>> On 02/26/2018 02:21 PM, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 4.14.23 release.
>>>> There are 54 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Wed Feb 28 20:21:22 UTC 2018.
>>>> Anything received after that time might be too late.
>>>>
>>>
>>> We have a build issue on 4.14.22 and can be re-created with this rc as well.
>>>
>>> arch/arm/mach-omap2/omap-secure.o: In function `omap3_save_secure_ram':
>>> omap-secure.c:(.text+0xe4): undefined reference to `save_secure_ram_context'
>>> make: *** [vmlinux] Error 1
>>>
>>> The issue was introduced with the back port of
>>>
>>> b59a1da647f163d0bf035f823a908b45c357643a ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context
>>>
>> Looks like you may have CONFIG_PM disabled, is that correct ?
>> Is there a default configuration that we can use to reproduce
>> the problem ?
> 
> It should be fixed with this commit in mainline kernel:
> 
> 863204cfdae9 ("ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds")

Thanks for sharing.  I cherry picked this into the failing build and it built successfully.

So can pull this into 4.14.23-rc.  If our "TI next" merge cycle is successful we
should see this error go away.  We missed it last week because the offending commit caused
a merge conflict with our TI tree.

I tested this against the multi_v7_defconfig with these CONFIG flags amended.  Ignoring the override warnings
CONFIG_SOC_AM43XX=y
CONFIG_ARCH_OMAP2PLUS=y
# Disable Socs other than AM43xx
CONFIG_ARCH_OMAP2=n
CONFIG_ARCH_OMAP3=n
CONFIG_ARCH_OMAP4=n
CONFIG_SOC_OMAP5=n
CONFIG_SOC_AM33XX=n
CONFIG_SOC_DRA7XX=n
CONFIG_ARCH_KEYSTONE=n

Tested-by: Dan Murphy <dmurphy@ti.com>

> 
> Regards,
> 
> Tony
> 


-- 
------------------
Dan Murphy
