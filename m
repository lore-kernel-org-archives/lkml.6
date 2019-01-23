Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF59FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F6821019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfAWXKm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:10:42 -0500
Received: from ozlabs.org ([203.11.71.1]:33889 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfAWXKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:10:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43lLcG3g6bz9s7h;
        Thu, 24 Jan 2019 10:10:38 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     LEROY Christophe <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v13 00/10] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
In-Reply-To: <20190119182113.Horde.DK6jqX3cEzsvR0fKFZrY2g4@messagerie.si.c-s.fr>
References: <cover.1547195976.git.christophe.leroy@c-s.fr> <87zhrx2bf1.fsf@concordia.ellerman.id.au> <20190119182113.Horde.DK6jqX3cEzsvR0fKFZrY2g4@messagerie.si.c-s.fr>
Date:   Thu, 24 Jan 2019 10:10:37 +1100
Message-ID: <875zufx95e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LEROY Christophe <christophe.leroy@c-s.fr> writes:
> Michael Ellerman <mpe@ellerman.id.au> a écrit :
>
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
>>> moves the thread_info into task_struct.
>>>
>>> Moving thread_info into task_struct has the following advantages:
>>> - It protects thread_info from corruption in the case of stack
>>> overflows.
>>> - Its address is harder to determine if stack addresses are
>>> leaked, making a number of attacks more difficult.
>>>
>>> Changes since v12:
>>>  - Patch 1: Taken comment from Mike (re-introduced the 'panic' in  
>>> case memblock allocation fails in setup_64.c
>>>  - Patch 1: Added alloc_stack() function in setup_32.c to also  
>>> panic in case of allocation failure.
>>
>> Hi Christophe,
>>
>> I can't get this series to boot on qemu mac99. I'm getting eg:
>
> Problem new with version 13 or it is the first time you test ?

I did test a previous version of the series, but I'm not sure if I
tested pmac32 before. So I don't have a known good version.

>> [    0.981514] NFS: Registering the id_resolver key type
>> [    0.981752] Key type id_resolver registered
>> [    0.981868] Key type id_legacy registered
>> [    0.995711] Unrecoverable exception 0 at 0 (msr=0)
>> [    0.996091] Oops: Unrecoverable exception, sig: 6 [#1]
>> [    0.996314] BE PAGE_SIZE=4K MMU=Hash PowerMac
>> [    0.996617] Modules linked in:
>> [    0.996869] CPU: 0 PID: 416 Comm: modprobe Not tainted  
>> 5.0.0-rc2-gcc-7.3.0-00043-g53f2de798792 #342
>
> Comm:modprobe  ==> Something wrong with modules ? I never tested with  
> CONFIG_MODULES.

Yep good clue.

cheers
