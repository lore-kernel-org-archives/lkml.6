Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4060154-1519294690-2-7710808344863341623
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='fr',
  MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519294689; b=wEJTq/ugTuM1EKh2j8SKb8JuzQBNky3quPpe9wNzSk7O190
    Sc0EeTGhugPQROLosCQCD684GBEFsus5Ev3M71rV/moXO6tVEez8HbCDyqKBLdJu
    2Ehv8Dgaish2JkpmYttg++KTdqmoglDIZPCMGFoO6YGQ4Eggwbm0AI/sakeu53jx
    qMHNl8u+sn4LqJoFAPqfJRL15q1uJmwsuYNXfQdnz78uwJ+MxFpQTdpNNS/h3AcG
    qE8PPXYkqSzuzajN/8Y7IXZcKAKKMr/an0znk8kmkwBVWhxJf8Jlz9lfFtlNDO3+
    Ci09xvXfJTc2VdCRlfzSaKsiUmdRHMkkFmMf59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519294689; bh=bLWRuIqVlxhuhZ2kFoWyqA1b4TFS8XN+ZQgaNEvPqVI=; b=Y
    cOBlnW2YlBj7jn8sok+TPpxtF2rRBgF6Nj82RFXr4DhAxGUcu2S7xIZd6q+veXaI
    h8AxdtpZoXrdyRzPZU37nzDJgDPvErZvE3EtdV7lCMNJ31jY1+MtjiSLM7X91nCk
    mHgF0zCATLkUUDZLiUOImoJcOY/nHVApZKKi7gG7UqxeXzBaGDxr+b1jB4mkoi0n
    yk38HNkgUx1FNs04AvxaprhmU7pDkXw4MO3KMItJ0PDAECpOXK2TlNAyPXQv8KJB
    dG+qkRgvPpU2lvujvWUtxalEgfgFIPUYB+rgdLoHEPVYhg28akjacyCcrMqmrEEX
    dBXXoI3sL1o2YCb7lBfFQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeBVKRy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 05:17:54 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:8138 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753197AbeBVKRw (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 05:17:52 -0500
Subject: Re: [PATCH 4.14, 4.9] crypto: talitos - fix Kernel Oops on hashing an
 empty file
To: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180222070616.A15E36CBD4@po15720vm.idsi0.si.c-s.fr>
 <AM0PR0402MB3329F7DB21610C75674BA7AD98CD0@AM0PR0402MB3329.eurprd04.prod.outlook.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <2477a391-ab2c-5454-af00-2507269662fb@c-s.fr>
Date: Thu, 22 Feb 2018 11:17:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <AM0PR0402MB3329F7DB21610C75674BA7AD98CD0@AM0PR0402MB3329.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 22/02/2018 à 09:30, Horia Geantă a écrit :
> On 2/22/2018 9:08 AM, Christophe Leroy wrote:
>> Upstream 87a81dce53b1ea61acaeefa5191a0376a2d1d721
>>
>> Performing the hash of an empty file leads to a kernel Oops
>>
>> [   44.504600] Unable to handle kernel paging request for data at address 0x0000000c
>> [   44.512819] Faulting instruction address: 0xc02d2be8
>> [   44.524088] Oops: Kernel access of bad area, sig: 11 [#1]
>> [   44.529171] BE PREEMPT CMPC885
>> [   44.532232] CPU: 0 PID: 491 Comm: md5sum Not tainted 4.15.0-rc8-00211-g3a968610b6ea #81
>> [   44.540814] NIP:  c02d2be8 LR: c02d2984 CTR: 00000000
>> [   44.545812] REGS: c6813c90 TRAP: 0300   Not tainted  (4.15.0-rc8-00211-g3a968610b6ea)
>> [   44.554223] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 48222822  XER: 20000000
>> [   44.560855] DAR: 0000000c DSISR: c0000000
>> [   44.560855] GPR00: c02d28fc c6813d40 c6828000 c646fa40 00000001 00000001 00000001 00000000
>> [   44.560855] GPR08: 0000004c 00000000 c000bfcc 00000000 28222822 100280d4 00000000 10020008
>> [   44.560855] GPR16: 00000000 00000020 00000000 00000000 10024008 00000000 c646f9f0 c6179a10
>> [   44.560855] GPR24: 00000000 00000001 c62f0018 c6179a10 00000000 c6367a30 c62f0000 c646f9c0
>> [   44.598542] NIP [c02d2be8] ahash_process_req+0x448/0x700
>> [   44.603751] LR [c02d2984] ahash_process_req+0x1e4/0x700
>> [   44.608868] Call Trace:
>> [   44.611329] [c6813d40] [c02d28fc] ahash_process_req+0x15c/0x700 (unreliable)
>> [   44.618302] [c6813d90] [c02060c4] hash_recvmsg+0x11c/0x210
>> [   44.623716] [c6813db0] [c0331354] ___sys_recvmsg+0x98/0x138
>> [   44.629226] [c6813eb0] [c03332c0] __sys_recvmsg+0x40/0x84
>> [   44.634562] [c6813f10] [c03336c0] SyS_socketcall+0xb8/0x1d4
>> [   44.640073] [c6813f40] [c000d1ac] ret_from_syscall+0x0/0x38
>> [   44.645530] Instruction dump:
>> [   44.648465] 38c00001 7f63db78 4e800421 7c791b78 54690ffe 0f090000 80ff0190 2f870000
>> [   44.656122] 40befe50 2f990001 409e0210 813f01bc <8129000c> b39e003a 7d29c214 913e003c
>>
>> This patch fixes that Oops by checking if src is NULL.
>>
>> Fixes: 6a1e8d14156d4 ("crypto: talitos - making mapping helpers more generic")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Isn't this needed also in 4.15.y?

It is already in 4.15, see 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/drivers/crypto/talitos.c?h=v4.15.4&id=e76a4b126d1e7fbd0124cb885331a45e9a24f32b

Christophe

> 
> Thanks,
> Horia
> 
