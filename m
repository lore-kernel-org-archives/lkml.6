Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785C1C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EA120878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EA120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeJCMsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:48:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7683 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbeJCMsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:48:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42Q54l6z8hz9ttBf;
        Wed,  3 Oct 2018 08:01:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vGwqjLLVCLoD; Wed,  3 Oct 2018 08:01:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42Q54l6PJpz9ttBW;
        Wed,  3 Oct 2018 08:01:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0CF9F8B8B6;
        Wed,  3 Oct 2018 08:01:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4JjkpgZc2H9L; Wed,  3 Oct 2018 08:01:43 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C60B08B8B5;
        Wed,  3 Oct 2018 08:01:43 +0200 (CEST)
Subject: Re: [RFC PATCH v3 7/7] powerpc/64: Modify CURRENT_THREAD_INFO()
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <e218eef4c27f7cf00c41914ba977b29edba943ff.1538396659.git.christophe.leroy@c-s.fr>
 <20181003154442.5d77ad9c@roar.ozlabs.ibm.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <a8901d0b-e81d-cf5b-2cb0-926c42424ec4@c-s.fr>
Date:   Wed, 3 Oct 2018 08:01:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003154442.5d77ad9c@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/10/2018 à 07:44, Nicholas Piggin a écrit :
> On Mon,  1 Oct 2018 12:30:31 +0000 (UTC)
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> CURRENT_THREAD_INFO() now uses the PACA to retrieve 'current' pointer,
>> it doesn't use 'sp' anymore.
> 
> Can you remove this too now? I think it will be clearer what's going on
> and easier to read once everyone remembers current is the same offset as
> current thread_info.

Ok I will.

Christophe

> 
> Overall nice series, thanks for doing this.
> 
> Thanks,
> Nick
> 
