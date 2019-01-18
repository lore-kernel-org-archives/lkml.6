Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575C5C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB312086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="R9WeU/KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfARRp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:45:26 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42686 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728514AbfARRpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:45:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6FC948EE3EB;
        Fri, 18 Jan 2019 09:45:21 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TXlpfntxv04P; Fri, 18 Jan 2019 09:45:20 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 322D28EE10C;
        Fri, 18 Jan 2019 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1547833520;
        bh=XXQLXCymB8vOJAkOPmNQI+AOkRgkwA1dHK7GADdM3yU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R9WeU/KMkVaa6iP7Pp3wYocx0/dXtN94bF6JMCXpNgrPa0+6kXx+p8ugiGNGWeFvK
         NyXTpJiwFZR4Yx64OlyySakUFsNn1vA3uDfYr89rHvphDI6UKfVMm7YpmablmnonUb
         SSSVbS9S63Tvu2GKjTbrRiEXQzC+FJCjZHgJo2VE=
Message-ID: <1547833518.2794.36.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 00/29] y2038: add time64 syscalls
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dennis Clarke <dclarke@blastwave.org>,
        Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org,
        davem@davemloft.net, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        deepa.kernel@gmail.com, ebiederm@xmission.com,
        firoz.khan@linaro.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 18 Jan 2019 09:45:18 -0800
In-Reply-To: <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
References: <20190118161835.2259170-1-arnd@arndb.de>
         <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 11:57 -0500, Dennis Clarke wrote:
> On 1/18/19 11:18 AM, Arnd Bergmann wrote:
> > This is a minor update of the patches I posted last week, I
> > would like to add this into linux-next now, but would still do
> > changes if there are concerns about the contents. The first
> > version did not see a lot of replies, which could mean that
> > either everyone is happy with it, or that it was largely ignored.
> > 
> > See also the article at https://lwn.net/Articles/776435/.
> 
> I would be happy to read "Approaching the kernel year-2038 end game"
> however it is behind a pay wall.  Perhaps it may be best to just
> host interesting articles about open source idea elsewhere.

Hey, this is an unfair characterization: lwn.net operates an early
access subscription model, so you can't read the above for 14 days
after publication without paying for an lwn.net subscription, but by
the time these patches are upstream there will be no paywall because it
will expire on 24 January and that URL will then be readable by all. 
That makes LWN.net a nice, reliable resource for us while still
supporting some business model to keep it going.

James

