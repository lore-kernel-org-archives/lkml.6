Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE627C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E31B20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E31B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeLMQCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:02:48 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58934 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbeLMQCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:02:48 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gXTRi-0008Ka-00; Thu, 13 Dec 2018 16:02:42 +0000
Date:   Thu, 13 Dec 2018 11:02:42 -0500
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can we drop upstream Linux x32 support?
Message-ID: <20181213160242.GV23599@brightrain.aerifal.cx>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <70bb54b2-8ed3-b5ee-c02d-6ef66c4f27eb@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70bb54b2-8ed3-b5ee-c02d-6ef66c4f27eb@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:29:14AM +0100, John Paul Adrian Glaubitz wrote:
> I can't say anything about the syscall interface. However, what I do know
> is that the weird combination of a 32-bit userland with a 64-bit kernel
> interface is sometimes causing issues. For example, application code usually
> expects things like time_t to be 32-bit on a 32-bit system. However, this
> isn't the case for x32 which is why code fails to build.

I don't see any basis for this claim about expecting time_t to be
32-bit. I've encountered some programs that "implicitly assume" this
by virtue of assuming they can cast time_t to long to print it, or
similar. IIRC this was an issue in busybox at one point; I'm not sure
if it's been fixed. But any software that runs on non-Linux unices has
long been corrected. If not, 2038 is sufficiently close that catching
and correcting any such remaining bugs is more useful than covering
them up and making the broken code work as expected.

Rich
