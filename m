Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BD2C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEB320811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEB320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeLKIQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:16:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeLKIQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:16:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFB158830E;
        Tue, 11 Dec 2018 08:16:12 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-82.ams2.redhat.com [10.36.116.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1D5C608F6;
        Tue, 11 Dec 2018 08:16:07 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, bp@alien8.de,
        vapier@gentoo.org, hjl.tools@gmail.com, dalias@libc.org,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Can we drop upstream Linux x32 support?
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
        <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
Date:   Tue, 11 Dec 2018 09:16:05 +0100
In-Reply-To: <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 10 Dec 2018 17:40:33 -0800")
Message-ID: <871s6o32d6.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 11 Dec 2018 08:16:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds:

> Apparently the main real use case is for extreme benchmarking. It's
> the only use-case where the complexity of maintaining a whole
> development environment and distro is worth it, it seems. Apparently a
> number of Spec submissions have been done with the x32 model.

Are you sure GCC was used for that?

ICC has a 32-bit pointer mode which does not change the (64-bit) kernel
interface.

Thanks,
Florian
