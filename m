Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75949C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C2120660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfANJ7H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:59:07 -0500
Received: from ozlabs.org ([203.11.71.1]:59979 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbfANJ7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:59:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dTSt3ZpZz9sBQ;
        Mon, 14 Jan 2019 20:58:54 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        dalias@libc.org, davem@davemloft.net, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, jcmvbkbc@gmail.com, firoz.khan@linaro.org,
        ebiederm@xmission.com, deepa.kernel@gmail.com,
        linux@dominikbrodowski.net, akpm@linux-foundation.org,
        dave@stgolabs.net, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
In-Reply-To: <87pnsz28k2.fsf@concordia.ellerman.id.au>
References: <20190110162435.309262-1-arnd@arndb.de> <20190110162435.309262-15-arnd@arndb.de> <87pnsz28k2.fsf@concordia.ellerman.id.au>
Date:   Mon, 14 Jan 2019 20:58:52 +1100
Message-ID: <87muo31rxf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Hi Arnd,
>
> Arnd Bergmann <arnd@arndb.de> writes:
>> The IPC system call handling is highly inconsistent across architectures,
>> some use sys_ipc, some use separate calls, and some use both.  We also
>> have some architectures that require passing IPC_64 in the flags, and
>> others that set it implicitly.
...
>
> We already have a gap at 366-377 from when we tried to add the split IPC
> calls a few years back.
>
> I guess I don't mind leaving that gap and using the common numbers as
> you've done here.
>
> But it would be good to add a comment pointing out that we have room
> at 366 for more arch specific syscalls as well.
>
> cheers

Guess I sent that one twice. 🤦

cheers
