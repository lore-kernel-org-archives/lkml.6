Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38C8C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1A12084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1A12084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeLED1W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:27:22 -0500
Received: from ozlabs.org ([203.11.71.1]:59699 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeLED1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:27:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 438kgX1yKvz9s7W;
        Wed,  5 Dec 2018 14:27:20 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        rashmicy@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: dump block address translation on book3s/32
In-Reply-To: <bab9eb25-a6f4-966c-ceaa-00147b50726d@c-s.fr>
References: <26cc609706833f78e3195e3d35c0372b2f40cae3.1542181167.git.christophe.leroy@c-s.fr> <878t1uva0q.fsf@concordia.ellerman.id.au> <9cb14c1f-02ce-a2a5-94e6-95afb4d3e168@c-s.fr> <87o9ap2uif.fsf@concordia.ellerman.id.au> <bab9eb25-a6f4-966c-ceaa-00147b50726d@c-s.fr>
Date:   Wed, 05 Dec 2018 14:27:20 +1100
Message-ID: <87r2ewhcvb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 16/11/2018 à 11:20, Michael Ellerman a écrit :
>> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>> 
>>> Le 15/11/2018 à 12:46, Michael Ellerman a écrit :
>>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>>
>>>>> This patch adds a debugfs file to dump block address translation:
>>>>>
>>>>> ~# cat /sys/kernel/debug/block_address_translation
>>>>
>>>> My instinct is it should be in /sys/kernel/debug/powerpc. But I guess
>>>> the other page table dump files are not.
>>>
>>> Lol.
>>>
>>> Looks like we have the same instinct ...
>>>
>>> But you rejected my patch https://patchwork.ozlabs.org/patch/750426/ :)
>> 
>> Haha. My argument was that the kernel page table dump is not powerpc
>> specific, but this file *is* powerpc specific. Though I guess it's in
>> the same are as the page table / hash table dump, so it may as well live
>> next to them.
>
> I see you took the first version in next-test. It doesn't handle the 
> case of 64bits phys addresses. v3 does.
>
> I just sent v4 which does to v3 the changes you did (__init and powerpc/ 
> subdir)

Thanks.

cheers
