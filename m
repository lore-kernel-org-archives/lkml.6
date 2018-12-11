Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C76C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FF62064D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FF62064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbeLKCYV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 21:24:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42683 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeLKCYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 21:24:20 -0500
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wBB2N3nv3634698
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 10 Dec 2018 18:23:04 -0800
Date:   Mon, 10 Dec 2018 18:22:56 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com> <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Can we drop upstream Linux x32 support?
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>
CC:     the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        bp@alien8.de, fweimer@redhat.com, vapier@gentoo.org,
        hjl.tools@gmail.com, dalias@libc.org, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
From:   hpa@zytor.com
Message-ID: <DC97ED04-0FAB-4A4E-BD24-456B5A0978DF@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 10, 2018 5:40:33 PM PST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Mon, Dec 10, 2018 at 5:23 PM Andy Lutomirski <luto@kernel.org>
>wrote:
>>
>> I'm seriously considering sending a patch to remove x32 support from
>> upstream Linux.  Here are some problems with it:
>
>I talked to Arnd (I think - we were talking about all the crazy ABI's,
>but maybe it was with somebody else) about exactly this in Edinburgh.
>
>Apparently the main real use case is for extreme benchmarking. It's
>the only use-case where the complexity of maintaining a whole
>development environment and distro is worth it, it seems. Apparently a
>number of Spec submissions have been done with the x32 model.
>
>I'm not opposed to trying to sunset the support, but let's see who
>complains..
>
>              Linus

The use case aside, I need to address the technical issues in this post; some of the behaviors that Andy is pointing out area quite intentional, even if they are perhaps somewhat confusing at first glance. That being said, some were due to tradeoffs that might have been wrong.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
