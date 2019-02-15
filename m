Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EC2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6320D222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ppTJDv9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391128AbfBOIRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:17:48 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:22203 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfBOIRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:17:46 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4415jN1pZxz9v0N7;
        Fri, 15 Feb 2019 09:17:44 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ppTJDv9l; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id syPr5znEh3vp; Fri, 15 Feb 2019 09:17:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4415jN0XnTz9v0N6;
        Fri, 15 Feb 2019 09:17:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550218664; bh=/IYfdqjsfG04HbnvS71uX5PXXDKwZ2gTBhWl5fa4PCs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ppTJDv9l3E/gU+xZFj9JtfZgwxY/u0O/dXZcvPn0Zv6BClJtdb2rPdXkGZVFGDo1q
         TZAIngmqPdaZLe2tVngoJ8TymMzfFiXjS2bEUFcK3z9CPIhY8x57OXRjNbshcpkND3
         g3ASGsyRIE+r4GwDGjIwtHCXM6jyqxVg6nqcgzJc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0CBCE8B8BB;
        Fri, 15 Feb 2019 09:17:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EPtKIS6xP_FL; Fri, 15 Feb 2019 09:17:44 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 069088B8BA;
        Fri, 15 Feb 2019 09:17:44 +0100 (CET)
Subject: Re: [PATCH 01/11] powerpc: remove dead ifdefs in <asm/checksum.h>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-2-hch@lst.de>
 <e7a2efe3-f56c-7dfd-6613-dc9229556673@c-s.fr> <20190214170510.GC32441@lst.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d5451fc4-9183-702a-e9ed-4a2be1f82a11@c-s.fr>
Date:   Fri, 15 Feb 2019 09:17:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214170510.GC32441@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/02/2019 à 18:05, Christoph Hellwig a écrit :
> On Thu, Feb 14, 2019 at 09:26:19AM +0100, Christophe Leroy wrote:
>> Could you also remove the 'config GENERIC_CSUM' item in
>> arch/powerpc/Kconfig ?
> 
> All the separate declarations go away later in this series.
> 

I saw, but the purpose of the later patch is to replace arch defined 
GENERIC_CSUM by a common one that arches select. For the powerpc you are 
not in that case as the powerpc does not select GENERIC_CSUM.

So I really believe that all stale bits of remaining GENERIC_CSUM in 
powerpc should go away as a single dedicated patch, as a fix of commit 
d4fde568a34a ("powerpc/64: Use optimized checksum routines on 
little-endian")

Regarding the #ifdef __KERNEL__ , I think we should do a wide cleanup in 
arch/powerpc/include/asm, not only asm/checksum.h

Christophe
