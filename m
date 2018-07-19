Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA30C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2222084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2222084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbeGSMqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:46:17 -0400
Received: from ozlabs.org ([203.11.71.1]:54021 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbeGSMqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:46:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41WXj72ZP9z9rxs;
        Thu, 19 Jul 2018 22:03:22 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Malaterre <malat@debian.org>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/prom_init: remove linux,stdout-package property
In-Reply-To: <20180718162116.GA24748@kermit-br-ibm-com>
References: <20180712171904.18971-1-muriloo@linux.ibm.com> <87a7qoq3z2.fsf@concordia.ellerman.id.au> <20180718162116.GA24748@kermit-br-ibm-com>
Date:   Thu, 19 Jul 2018 22:03:19 +1000
Message-ID: <878t67cu0o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
> On Wed, Jul 18, 2018 at 07:37:37PM +1000, Michael Ellerman wrote:
>> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
>> > This property was added in 2004 by
>> >
>> >     https://github.com/mpe/linux-fullhistory/commit/689fe5072fe9a0dec914bfa4fa60aed1e54563e6
>> >
>> > and the only use of it, which was already inside `#if 0`, was removed a month
>> > later by
>> >
>> >     https://github.com/mpe/linux-fullhistory/commit/1fbe5a6d90f6cd4ea610737ef488719d1a875de7
>> >
>> > Fixes: https://github.com/linuxppc/linux/issues/125
>> 
>> That is going to confuse some scripts that are expecting that to be a
>> "Fixes: <some commit>" tag :)
>> 
>> The proper tag to use there would be "Link:".
>> 
>> But, I'd prefer we didn't add github issue links to the history, as I'm
>> not sure they won't bit-rot eventually. Not because I'm a anti-Microsoft
>> conspiracy person but just because it's a repo I set up and manage and
>> there's no long term plan for it necessarily.
>> 
>> > ---
>> >  arch/powerpc/kernel/prom_init.c | 2 --
>> >  1 file changed, 2 deletions(-)
>> 
>> Including the link here would be ideal, as it means it doesn't end up in
>> the commit history, but it does end up in the mail archive. So if we
>> ever really need to find it, it should be there.
>> 
>> cheers
>
> Hi, Michael.
>
> Thanks for reviewing it.  I've sent v2 with your suggestions:
>
>     https://lkml.kernel.org/r/20180718161544.12134-1-muriloo@linux.ibm.com

Thanks.

I had actually already applied the first version, but I didn't say that
in my email did I :}

So I've rebased and applied your v2, thanks.

cheers
