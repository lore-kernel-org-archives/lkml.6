Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729A8C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DE020C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DE020C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=petrovitsch.priv.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeKUJiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:38:04 -0500
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:4311 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUJiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 04:38:03 -0500
Received: from thorin.petrovitsch.priv.at (80-110-99-3.cgn.dynamic.surfer.at [80.110.99.3])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id wAKN4pSj005548
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO);
        Wed, 21 Nov 2018 00:04:53 +0100
Subject: Re: Cleaning up numbering for new x86 syscalls?
To:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Daniel Colascione <dancol@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>
References: <CALCETrVPcgKarpTOsdTfODkNA76W04WvW+tNWoOx6+Em0KS04A@mail.gmail.com>
 <20181120073352.GA79825@gmail.com>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Message-ID: <87cbf7b4-9e77-adc1-8e18-14dd206f0b79@petrovitsch.priv.at>
Date:   Wed, 21 Nov 2018 00:04:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120073352.GA79825@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-DCC-MGTINTERNET-Metrics: esgaroth.tuxoid.at 1170; Body=11 Fuz1=11 Fuz2=11
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 08:33, Ingo Molnar wrote:
[...]
> 6. Is x32 even used in practice? I still think it was a mistake to add it 
>    and some significant distributions like Fedora are not enabling it.

x32 works as far as gcc/gas/ld is concerned (at least for compiling
non-trivial programs).
Finding a distribution that actually *delivers* x32 libraries is another
thing (and said non-trivial software uses ATM e.g. libxml2) - at least I
can't find an "x32-Ubuntu".
And no, I don't see a compelling reason to (try to) build the n+1.
architecture for the major distributions.
And yes, lots of stuff will not compile out of the box (especially if
one uses a somewhat sane set of gcc options - not only -Wall -Wextra
-Werror) but if one gets software to compile for i386 and x86_64,
getting it to compile for x32 is a Friday afternoon job (more or less).
And yes, there is enough hardware/systems out there that uses 64bit CPUs
(for whatever reason - if only that one can't get a 32bit CPU for that
board) but will never ever need more than 2-3 GB RAM .....

MfG,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
