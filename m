Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAD0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286102087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfBYIro convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:47:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36013 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfBYIro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:47:44 -0500
Received: from [IPv6:2601:646:8680:2bb1:a106:e287:aa34:4a8c] ([IPv6:2601:646:8680:2bb1:a106:e287:aa34:4a8c])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x1P8l8qU1623112
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 25 Feb 2019 00:47:09 -0800
Date:   Mon, 25 Feb 2019 00:47:00 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190223083942.GF32477@hirez.programming.kicks-ass.net>
References: <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com> <20190219090409.GW32494@hirez.programming.kicks-ass.net> <20190219124808.GG8501@fuggles.cambridge.arm.com> <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com> <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com> <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de> <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com> <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de> <20190222222635.GK14054@worktop.programming.kicks-ass.net> <CE650687-ECB3-4A7C-96BA-A061D54AEF40@zytor.com> <20190223083942.GF32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
From:   hpa@zytor.com
Message-ID: <15DE0017-9AE5-4E7A-96CD-E5E9F5B72516@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 23, 2019 12:39:42 AM PST, Peter Zijlstra <peterz@infradead.org> wrote:
>On Fri, Feb 22, 2019 at 03:39:48PM -0800, hpa@zytor.com wrote:
>> Objtool could also detect CLAC-STAC or STAC-CLAC sequences without
>> memory operations and remove them; don't know how often that happens,
>> but I know it *does* happen.
>
>Objtool doesn't know about memops; that'd be a lot of work. Also,
>objtool doesn't actually rewrite the text, at best it could warn about
>such occurences.

It doesn't have to understand the contents of the memop, but it seems that the presence of a modrm with mode ≠ 3 should be plenty. It needs to know that much in order to know the length of instructions anyway. For extra credit, ignore LEA or hinting instructions.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
