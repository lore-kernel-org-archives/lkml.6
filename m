Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4883C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C80320846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C80320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933453AbeFTUkD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:40:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51132 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933148AbeFTUkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:40:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 419xXV4brkz9tvf7;
        Wed, 20 Jun 2018 22:39:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id z8BgJ3zG8xHk; Wed, 20 Jun 2018 22:39:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 419xXV3yTHz9tvf5;
        Wed, 20 Jun 2018 22:39:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EF58F8B83E;
        Wed, 20 Jun 2018 22:39:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jInhoYD73Tgz; Wed, 20 Jun 2018 22:39:58 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 49AD68B82D;
        Wed, 20 Jun 2018 22:39:58 +0200 (CEST)
Subject: Re: [PATCH 01/11] crypto: shash: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
References: <20180620190408.45104-1-keescook@chromium.org>
 <20180620190408.45104-2-keescook@chromium.org>
 <638faf05-946a-1345-dda4-f75fee5b07d9@c-s.fr>
 <CAGXu5jKmZ2jn1V8rd3B5BcS0z_WOj0x4eThSG=DYdxSj+fnd2g@mail.gmail.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <073a8f9e-8ad5-6fd5-e9b8-33e2c9a65e37@c-s.fr>
Date:   Wed, 20 Jun 2018 22:39:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKmZ2jn1V8rd3B5BcS0z_WOj0x4eThSG=DYdxSj+fnd2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 20/06/2018 à 22:36, Kees Cook a écrit :
> On Wed, Jun 20, 2018 at 12:30 PM, Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>>
>> On 06/20/2018 07:03 PM, Kees Cook wrote:
>>>
>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>> removes the VLAs in SHASH_DESC_ON_STACK (via crypto_shash_descsize())
>>> by using the maximum allowable size (which is now more clearly captured
>>> in a macro). Similar limits are turned into macros as well.
>>>
>>> [1]
>>> https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>>
>> Got the following warnings:
>>
>> crypto/testmgr.c: In function ‘alg_test_crc32c.part.4’:
>> crypto/testmgr.c:1896:1: warning: the frame size of 2088 bytes is larger
>> than 1024 bytes [-Wframe-larger-than=]
>> crypto/hmac.c: In function ‘hmac_setkey’:
>> crypto/hmac.c:88:1: warning: the frame size of 2088 bytes is larger than
>> 1024 bytes [-Wframe-larger-than=]
> 
> Ah yes. I didn't do 32-bit builds. So, here's the issue: this uncovers
> the frame size problems that were hidden by in being a VLA before. It
> was always possible for the frame to get this big, it's just that the
> compiler couldn't see it.
> 
> For qat, I raised the -Wframe-larger-than flag. It seems we'll need to
> do this in some other places too.

Maybe the issue is because I have selected 16k pages ?

Christophe

> 
> -Kees
> 
