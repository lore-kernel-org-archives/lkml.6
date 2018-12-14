Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB4FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A8E206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeLNRZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:25:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:1337 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbeLNRZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:25:19 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43GcrC3357z9ty3h;
        Fri, 14 Dec 2018 18:25:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SqUqShKRkt_c; Fri, 14 Dec 2018 18:25:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43GcrC2TNCz9ty3f;
        Fri, 14 Dec 2018 18:25:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 02BD58B8F1;
        Fri, 14 Dec 2018 18:25:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lBQ4xbLWaXAJ; Fri, 14 Dec 2018 18:25:16 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D972B8B8EB;
        Fri, 14 Dec 2018 18:25:16 +0100 (CET)
Subject: Re: [PATCH v2] crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK
To:     Sasha Levin <sashal@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <7f27d91e7e78d8aac28e8b6c600fd874b7d5be9f.1544686398.git.christophe.leroy@c-s.fr>
 <20181214013937.1E29D20879@mail.kernel.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <cb5cabc4-5c64-3bec-f46e-8d66e2695ac1@c-s.fr>
Date:   Fri, 14 Dec 2018 18:25:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181214013937.1E29D20879@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/12/2018 à 02:39, Sasha Levin a écrit :
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 4de9d0b547b9 crypto: talitos - Add ablkcipher algorithms.
> 
> The bot has tested the following trees: v4.19.9, v4.14.88, v4.9.145, v4.4.167, v3.18.129,
> 
> v4.19.9: Build OK!
> v4.14.88: Failed to apply! Possible dependencies:
>      2e13ce0812c6 ("crypto: talitos - DMA map key in setkey()")
>      9a655608a468 ("crypto: talitos - simplify tests in ipsec_esp()")
>      da9de146ebd9 ("crypto: talitos - remove to_talitos_ptr_len()")
> 
> v4.9.145: Failed to apply! Possible dependencies:
>      2e13ce0812c6 ("crypto: talitos - DMA map key in setkey()")
>      9a655608a468 ("crypto: talitos - simplify tests in ipsec_esp()")
>      da9de146ebd9 ("crypto: talitos - remove to_talitos_ptr_len()")
> 
> v4.4.167: Failed to apply! Possible dependencies:
>      246a87cda070 ("crypto: talitos - move mapping helpers before IPSEC functions")
>      2e13ce0812c6 ("crypto: talitos - DMA map key in setkey()")
>      549bd8bc5987 ("crypto: talitos - Implement AEAD for SEC1 using HMAC_SNOOP_NO_AFEU")
>      6a1e8d14156d ("crypto: talitos - making mapping helpers more generic")
>      8e409fe10695 ("crypto: talitos - check return value of sg_nents_for_len")
>      9a655608a468 ("crypto: talitos - simplify tests in ipsec_esp()")
>      b096b544d6c3 ("crypto: talitos - using helpers for all talitos_ptr operations")
>      da9de146ebd9 ("crypto: talitos - remove to_talitos_ptr_len()")
>      e04a61bebc5d ("crypto: talitos - fix memory corruption on SEC2")
> 
> v3.18.129: Failed to apply! Possible dependencies:
>      032d197eaaea ("crypto: talitos - Refactor the sg in/out chain allocation")
>      185eb79f6a65 ("crypto: talitos - Add a helper function to clear j_extent field")
>      20ec9d814e68 ("crypto: sahara - fix spinlock initialization")
>      538caf83374c ("crypto: talitos - helper function for ptr len")
>      5a2bb93f5992 ("crypto: sahara - add support for SHA1/256")
>      5be4d4c94b1f ("crypto: replace scatterwalk_sg_next with sg_next")
>      922f9dc8d366 ("crypto: talitos - fill in talitos descriptor iaw SEC1 or SEC2+")
>      a2b35aa86eea ("crypto: talitos - remove param 'extent' in map_single_talitos_ptr()")
>      a861afbc931b ("crypto: ablkcipher - fixed style errors in ablkcipher.c")
>      aeb4c132f33d ("crypto: talitos - Convert to new AEAD interface")
>      bde9079f3cd5 ("crypto: talitos - avoid out of bound scatterlist iterator")
>      c0c3c89ae347 ("crypto: sahara - replace tasklets with kthread")
>      edc6bd698a4d ("crypto: talitos - talitos_ptr renamed ptr for more lisibility")
>      f129430dd87d ("crypto: nx - Fixing the limit number of bytes to be processed")
> 
> 
> How should we proceed with this patch?

I'll backport it once it is in linux tree.

Christophe

> 
> --
> Thanks,
> Sasha
> 
