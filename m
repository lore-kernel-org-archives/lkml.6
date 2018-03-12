Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeCLHYT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:24:19 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41979 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeCLHYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:24:17 -0400
X-Google-Smtp-Source: AG47ELvbT3CizVZi1KBRzrvgJ6nToAgK40pMrSrpz0+pMe0l1NAHk+UhhCZ+gsbmyav8JDsDtziShw==
Date: Mon, 12 Mar 2018 08:24:13 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Vas Dias <jason.vas.dias@gmail.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, andi <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4.16-rc4 1/2] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
Message-ID: <20180312072413.toyd5ztkgaah35xg@gmail.com>
References: <d109lwfe.fsf@gmail.com>
 <alpine.DEB.2.21.1803112350190.1485@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803112350190.1485@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 12 Mar 2018, Jason Vas Dias wrote:
> 
> checkpatch.pl still reports:
> 
>    total: 15 errors, 3 warnings, 165 lines checked
> 
> > +notrace static u64 vread_tsc_raw(void)
> > +{
> > +	u64 tsc, last=gtod->raw_cycle_last;
> > +	if( likely( gtod->has_rdtscp ) )
> > +		tsc	= rdtscp((void*)0);
> 
> Plus I asked more than once to split that rdtscp() stuff into a separate
> patch.
> 
> You surely are free to ignore my review comments, but rest assured that I'm
> free to ignore the crap you insist to send me as well.

In addition to Thomas's review feedback I'd strongly urge the careful reading of 
Documentation/SubmittingPatches as well:

 - When sending multiple patches please use git-send-mail

 - Please don't send several patch iterations per day!

 - Code quality of the submitted patches is atrocious, please run them through
   scripts/checkpatch.pl (and make sure they pass) to at least enable the reading 
   of them.

 - ... plus dozens of other details described in Documentation/SubmittingPatches.

Thanks,

	Ingo
