Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55879C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E20206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=schoebel-theuer.de header.i=@schoebel-theuer.de header.b="h96pvSO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbeLNVl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:41:27 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:15020 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbeLNVl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544823684;
        s=strato-dkim-0002; d=schoebel-theuer.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=bMSKCa/7E+BrBoPOgFkZPRw065Ro+f+aqWXPOfJWdFI=;
        b=h96pvSO4SNe+lAbrrg8iBn4VPYG/vsZTUMGmvFZOTejlZ9muZ3+sjPV/QB4nA/qFnw
        vMec17syO1+nzzlbVdI8Uoh2tBUNvMMnq/BDdY1klB47NxoLNt4Ybh+xv+l2V+93P3gD
        Vh1IKVaZhrVO8LpPKouyzdSnClMl/bG+ls9eyfGRV9qCpZ5qjomOy22cV0Cy4p7+gcB7
        UEBd4cs/2L7o4BpMoxcgPUcv3zNyp6iySgWjdtaqZkrWbSIGfIPrH/Tv808MsFfx9VpC
        o4Nk7OYi+wyE1Rcof3KX3ymXAv/eFcX8BoOhxQ52ODw7JrteCQQ/0sC6BoIpDb6I3mEr
        YNrw==
X-RZG-AUTH: ":OH8QVVOrc/CP6za/qRmbF3BWedPGA1vjs2e0bDjfg8OiOrPJifeRMRhMbfKobJAvSmsJbFO0KIY="
X-RZG-CLASS-ID: mo00
Received: from [192.168.2.24]
        by smtp.strato.de (RZmta 44.8 DYNA|AUTH)
        with ESMTPSA id V03c59uBELfK6uQ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 14 Dec 2018 22:41:20 +0100 (CET)
Subject: Re: Can we drop upstream Linux x32 support?
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <6577ac4f-524c-37f4-a4d0-6eb94ec7d9a5@schoebel-theuer.de>
 <CALCETrV0fVLZKG6JrOvzvOzP06UxhZW=LbHpPXbonoeFdPJB1A@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Sch=c3=b6bel-Theuer?= <thomas@schoebel-theuer.de>
Message-ID: <35905587-2d7b-c0ab-e081-2b938d60e881@schoebel-theuer.de>
Date:   Fri, 14 Dec 2018 22:41:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CALCETrV0fVLZKG6JrOvzvOzP06UxhZW=LbHpPXbonoeFdPJB1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 22:24, Andy Lutomirski wrote:
> I should clarify again: I am not suggesting that we drop 32-bit
> support in the forseeable future.  (Well, I might eventually suggest
> that we drop support for 32-bit *hardware* at some point, but not for
> 32-bit compat software.)  Linux's compat code is quite robust and is
> even fairly maintainable.
>
> I'm talking about x32, which is a different beast.
>
OK, this does not really make a big difference for large-scale 
enterprise users. Some day in the very distant future any legacy system 
will disappear, eventually.

So from my viewpoint the mentioned roadmap / timing requirements will 
remain the same, whatever you are dropping.

Enterprise-critical use cases will probably need to be migrated to 
KVM/qemu together with their old kernel versions, anyway (because the 
original hardware will be no longer available in a few decades).

