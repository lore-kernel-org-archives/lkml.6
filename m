Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1415164-1521552915-2-9637493884595614720
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
    t=1521552914; b=aw7cEK5dKXtFu2ueZ+3hY8CySyGFyHWmdRLya8aOZxuiU1u
    VhcppGGZgRfgpY29/Zr8at/Wed9GrMOgftcQ5xsKqWV11V2+8zwRkGr360hU/lAv
    wKBaunTTEv19PIR6ae7YExsinwNLgVCZaVtceYK5u+O8udKjzqxUIOdk5dTcMl3a
    thSAygeOAfkNHqlYweuHkJz/TmLjkqvYTcK5mXvrZ2kZJ5DB2UQgjP1QeP9/ZQm2
    2w+1kree/6XPvzPzIdy7f7dhWOf1rOu5vw9duduFecZ/0MhtnaLVRhHV9PBPBAIq
    V3MvBenpTqZxpdSFV7Rpw8CnewV3nEPDr8KzEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521552914; bh=Ok0NR7wup3padoROKP3CjFW0yTyfj+R1xQt166QBaEE=; b=I
    wIWmAqfc74MVm3ayaTJHXr78C7luwN0KDb8WB+aQC5uUHUwr/XY/+K5iqbWH4iv0
    bRIvlbpos7ZNG3U7wqoFdzP6W6oK36vLk5vNeHs0PxYmfGGO4bsP3Zd230Erp6AT
    op7SgQS00VOLwAU6rFZvJQTxeMWPqPVGoLUr97cZMbnjHN+xp57O8rFCGvZIiq/+
    fGKaKKvYq81NtYdm49ksbrTx8FsLL8m5kLt9venTaqg27PSVEQGb/A/KS4BTYbcg
    AIqDIHgmT+yLELdnZ0UNA3Kc9++G16PDLqaIk6k6pVv1EthqmhipqojUMzNxdiYS
    e+ipmVzyd9vMGU9hOv8eg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CngN7No9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EtBy+R2a;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CngN7No9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EtBy+R2a;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbeCTNfE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 09:35:04 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33104 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbeCTNfD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 09:35:03 -0400
X-Google-Smtp-Source: AG47ELtxPJys2jrLYKFFsM8VZzFDun/qYgDeLcwMGT5FIIZREu9O5sK8exWtw+LFK4tmX14sJUiE/w==
Subject: Re: [PATCH 4.9 000/241] 4.9.89-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180319180751.172155436@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ba41bdff-3068-a2e5-717f-715aeab56197@roeck-us.net>
Date: Tue, 20 Mar 2018 06:35:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/19/2018 11:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.89 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.9.88-239-g393003b:

Build results:
	total: 145 pass: 143 fail: 2
Failed builds:
	arm:allmodconfig
	x86_64:allnoconfig

arm:

sound/soc/sh/rcar/cmd.c: In function 'rsnd_cmd_init':
sound/soc/sh/rcar/cmd.c:85:14: warning: array subscript is below array bounds

drivers/net/ethernet/marvell/mvpp2.c: In function 'mvpp2_probe':
drivers/net/ethernet/marvell/mvpp2.c:6423:10: error: 'struct mvpp2' has no member named 'hw_version'

drivers/net/ethernet/marvell/mvpp2.c:6423:26: error: 'MVPP22' undeclared

x86_64:

arch/x86/kernel/sys_x86_64.c: In function ‘find_start_end’:
arch/x86/kernel/sys_x86_64.c:103:7: error: implicit declaration of function ‘in_compat_syscall’

Guenter
