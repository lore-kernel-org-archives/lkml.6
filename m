Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF81BECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944952081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944952081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeKAC5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:57:17 -0400
Received: from verein.lst.de ([213.95.11.211]:39195 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729997AbeKAC5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:57:15 -0400
Received: by newverein.lst.de (Postfix, from userid 107)
        id 697586F9C1; Wed, 31 Oct 2018 18:58:11 +0100 (CET)
Received: from blackhole (p5B33FFCA.dip0.t-ipconnect.de [91.51.255.202])
        by newverein.lst.de (Postfix) with ESMTPSA id 4B3366F9B7;
        Wed, 31 Oct 2018 18:58:07 +0100 (CET)
Date:   Wed, 31 Oct 2018 18:58:00 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, kristina.martsenko@arm.com
Subject: Re: [PATCH v4 1/3] arm64: implement ftrace with regs
Message-ID: <20181031185800.6aa17c91@blackhole>
In-Reply-To: <20181031141819.lv2tuj4ne5nf3lh3@lakrids.cambridge.arm.com>
References: <20181026142008.D922868C94@newverein.lst.de>
        <20181026142148.6353A68C94@newverein.lst.de>
        <20181031121002.hmag2mwvlpzwobvf@lakrids.cambridge.arm.com>
        <nycvar.YFH.7.76.1810311417361.30233@cbobk.fhfr.pm>
        <20181031141819.lv2tuj4ne5nf3lh3@lakrids.cambridge.arm.com>
Organization: LST e.V.
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 14:18:19 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Oct 31, 2018 at 02:19:07PM +0100, Jiri Kosina wrote:

> > Other architectures do rely on that. That's exactly for example why
> > on x86 we use '-pg -mfentry', to make sure we hook the function
> > *before* prologue.  
> 
> Ah, I'd missed -mfentry for x86. I now see that's also the case with
> __gnu_mcount_nc on arch/arm, so that covers my confusion.

Yes, fentry used to be the prerequisite, but it's everything but
portable. PPC64 already had the profile-kernel switch, which was
becoming just usable as we got at live patching.

I'm hoping that the patchable-function-entry will become the future
de-facto standard.

	Torsten
