Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C873C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01831214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01831214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeIZSDj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:03:39 -0400
Received: from ozlabs.org ([203.11.71.1]:51071 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbeIZSDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:03:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Kx90140Dz9s4s;
        Wed, 26 Sep 2018 21:51:00 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Russell Currey <ruscur@russell.cc>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] powerpc/64: add stack protector support
In-Reply-To: <284752d1-6c32-bdca-72d3-4d8616b26fbf@c-s.fr>
References: <2b934594d21ade67a4092637cf9e6b7d2d131187.1537801613.git.christophe.leroy@c-s.fr> <e84d65fb4744cf8260eb2fc9474765a7f3a60573.1537801613.git.christophe.leroy@c-s.fr> <0797fc91-6400-2508-1cc0-4bba78aafbbb@c-s.fr> <d203ccfce64c8f9fd403162f2fa3807ade7f1d28.camel@russell.cc> <30fb4e6b-0981-c53c-a1db-94138eaad268@c-s.fr> <20180926092806.GM23155@gate.crashing.org> <284752d1-6c32-bdca-72d3-4d8616b26fbf@c-s.fr>
Date:   Wed, 26 Sep 2018 21:50:59 +1000
Message-ID: <87o9ckfpek.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 26/09/2018 à 11:28, Segher Boessenkool a écrit :
>> On Wed, Sep 26, 2018 at 09:58:30AM +0200, Christophe LEROY wrote:
>>> Segher, any idea about this problem ?
>> 
>>>>> arch/powerpc/platforms/powermac/bootx_init.o: In function `bootx_printf':
>>>>> /var/lib/jenkins-slave/workspace/snowpatch/snowpatch-linux-
>>>>> sparse/linux/arch/powerpc/platforms/powermac/bootx_init.c:88:
>>>>> undefined reference to `__stack_chk_fail_local'
>> 
>> Are you building as PIC?  Are you linking libssp_nonshared.a?  Why not?
>
> Spotted, thanks.
>
> arch/powerpc/platforms/powermac/Makefile contains:
>
> CFLAGS_bootx_init.o  		+= -fPIC
...
>
> Or maybe stack protection on bootx_init doesn't make much sense and we 
> could just do the following ?
>
> CFLAGS_bootx_init.o  		+= -fPIC $(call cc-option, -fno-stack-protector)

That would be fine by me.

cheers
