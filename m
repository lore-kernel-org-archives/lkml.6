Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D427B16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D4E20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D4E20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbeG3SGh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:06:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31429 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeG3SGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:06:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41fQ6R6cSkz9tvg1;
        Mon, 30 Jul 2018 18:30:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id taGs690wZ9oO; Mon, 30 Jul 2018 18:30:39 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41fQ6R61zvz9tvfg;
        Mon, 30 Jul 2018 18:30:39 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 4D10465B; Mon, 30 Jul 2018 18:30:47 +0200 (CEST)
Received: from 37.173.209.192 ([37.173.209.192]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Mon, 30 Jul 2018 18:30:47 +0200
Date:   Mon, 30 Jul 2018 18:30:47 +0200
Message-ID: <20180730183047.Horde.g9hQ_3EXmF6St0upNs2DDw1@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Alastair D'Silva <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in
 show_signal_msg()
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
 <20180727145811.12334-5-muriloo@linux.ibm.com>
 <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
 <20180730152838.GA23704@kermit-br-ibm-com>
In-Reply-To: <20180730152838.GA23704@kermit-br-ibm-com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :

> Hi, Christophe.
>
> On Fri, Jul 27, 2018 at 06:40:23PM +0200, LEROY Christophe wrote:
>> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
>>
>> > Simplify the message format by using REG_FMT as the register format.  This
>> > avoids having two different formats and avoids checking for MSR_64BIT.
>>
>> Are you sure it is what we want ?
>
> Yes.
>
>> Won't it change the behaviour for a 32 bits app running on a 64bits kernel ?
>
> In fact, this changes how many zeroes are prefixed when displaying  
> the registers
> (%016lx vs. %08lx format).  For example, 32-bits userspace, 64-bits kernel:

Indeed that's what I suspected. What is the real benefit of this  
change ? Why not keep the current format for 32bits userspace ? All  
those leading zeroes are pointless to me.

>
> before this series:
>   [66475.002900] segv[4599]: unhandled signal 11 at 00000000 nip  
> 10000420 lr 0fe61854 code 1
>
> after this series:
>   [   73.414535] segv[3759]: segfault (11) at 0000000000000000 nip  
> 0000000010000420 lr 000000000fe61854 code 1 in segv[10000000+10000]
>   [   73.414641] segv[3759]: code: 4e800421 80010014 38210010  
> 7c0803a6 4bffff30 9421ffd0 93e1002c 7c3f0b78
>   [   73.414665] segv[3759]: code: 39200000 913f001c 813f001c  
> 39400001 <91490000> 39200000 7d234b78 397f0030
>
> Have you spotted any other behaviour change?

Not as of today

Christophe

>
> Cheers
> Murilo


