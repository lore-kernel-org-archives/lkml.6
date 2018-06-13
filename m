Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0397BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592C720693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592C720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933998AbeFMD61 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 23:58:27 -0400
Received: from ozlabs.org ([203.11.71.1]:35803 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933696AbeFMD60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 23:58:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 415Cf84zfqz9s2g;
        Wed, 13 Jun 2018 13:58:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, wei.guo.simon@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 3/4] powerpc/lib: implement strlen() in assembly
In-Reply-To: <baaf4fa9-ff0b-0bcb-8662-dafb794caab4@c-s.fr>
References: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr> <8b89f2e21f7e3a865105eeeeda509243db393454.1528791416.git.christophe.leroy@c-s.fr> <20180612145315.GJ27520@gate.crashing.org> <baaf4fa9-ff0b-0bcb-8662-dafb794caab4@c-s.fr>
Date:   Wed, 13 Jun 2018 13:58:24 +1000
Message-ID: <877en3tk0v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 12/06/2018 à 16:53, Segher Boessenkool a écrit :
>> On Tue, Jun 12, 2018 at 09:14:53AM +0000, Christophe Leroy wrote:
>>> ---
>>> Not tested on PPC64.
>> 
>> It won't be acceptable until that happens.  It also is likely quite bad
>> performance on all 64-bit CPUs from the last fifteen years or so.  Or you
>> did nothing to prove otherwise, at least.
>
> Will it be as bad as the generic implementation which does it byte per 
> byte ?
>
> I don't have any 64 bits target, can someone test it using the test app 
> I have added in selftests ?

I /can/ but I won't have time this week.

> Or should I just leave it as is for 64 bits and just do the 
> implementation for 32 bits until someone wants to try and do it for PPC64 ?

That's probably best yeah.

cheers
