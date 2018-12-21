Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B314C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7129021903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbeLUGsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 01:48:12 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:59163 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730676AbeLUGsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 01:48:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43LfMs1M9Dz9vC2L;
        Fri, 21 Dec 2018 07:48:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 94YfZ2MBPxVa; Fri, 21 Dec 2018 07:48:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43LfMs0YYfz9vC2K;
        Fri, 21 Dec 2018 07:48:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EB7DF8B8E1;
        Fri, 21 Dec 2018 07:48:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZlqXfQ8e9pLc; Fri, 21 Dec 2018 07:48:09 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BEEA58B75F;
        Fri, 21 Dec 2018 07:48:09 +0100 (CET)
Subject: Re: [RFC PATCH v2 04/11] powerpc/mm: Add a framework for Kernel
 Userspace Access Protection
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
 <df38a42e7c3cce892d7f6bbd88b5388774c8bef0.1543356926.git.christophe.leroy@c-s.fr>
 <87sgyrpivq.fsf@concordia.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f3816474-c91b-c0a8-0e97-2f6caf9fd3fa@c-s.fr>
Date:   Fri, 21 Dec 2018 07:48:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <87sgyrpivq.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/12/2018 à 06:07, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> This patch implements a framework for Kernel Userspace Access
>> Protection.
>>
>> Then subarches will have to possibility to provide their own
>> implementation by providing setup_kuap() and lock/unlock_user_access()
>>
>> Some platform will need to know the area accessed and whether it is
>> accessed from read, write or both. Therefore source, destination and
>> size and handed over to the two functions.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> I think some of this code came from Russell's original patch?
> 
> In which case we should have his signed-off-by here.
> 

Yes that's right the ppc64 part is from Russel. As it's still an RFC and 
there is still some work to be done I didn't pay much attention to 
Signed-off and other tags yet.

Signed-off-by: Russell Currey <ruscur@russell.cc>


Christophe
