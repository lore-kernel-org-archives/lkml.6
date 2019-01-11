Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLACK autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE44C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6AE20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfAKFZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:25:37 -0500
Received: from ozlabs.org ([203.11.71.1]:44133 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfAKFZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:25:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43bWXt46Gwz9sN1;
        Fri, 11 Jan 2019 16:25:34 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH kernel] powerpc/stack_protector: Fix external modules building
In-Reply-To: <CAK7LNAQUDMhXxku2wqq=VX2cbntMWgsvrFL4C5Bk=x1TU79wjg@mail.gmail.com>
References: <20190110054216.74248-1-aik@ozlabs.ru> <CAK7LNAQUDMhXxku2wqq=VX2cbntMWgsvrFL4C5Bk=x1TU79wjg@mail.gmail.com>
Date:   Fri, 11 Jan 2019 16:25:33 +1100
Message-ID: <877efbg3zm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> On Thu, Jan 10, 2019 at 2:44 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
...
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index 488c9ed..0492f62 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -419,7 +419,11 @@ archheaders:
>>  ifdef CONFIG_STACKPROTECTOR
>>  prepare: stack_protector_prepare
>>
>> +ifeq ($(KBUILD_EXTMOD),)
>>  stack_protector_prepare: prepare0
>> +else
>> +stack_protector_prepare:
>> +endif
>
>
> Honestly, I think this is ugly.

Yes I would call it a hack :)

> Do you want me to send an alternative solution?

I don't grok how external modules are built well enough to work out what
the right solution is. So if you can come up with something better that
would be awesome.

cheers
