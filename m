Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeCLGyE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 02:54:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45348 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeCLGyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 02:54:03 -0400
Date: Sun, 11 Mar 2018 23:53:47 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        andi <andi@firstfloor.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4.16-rc4 1/2] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
In-Reply-To: <d109lwfe.fsf@gmail.com>
Message-ID: <alpine.DEB.2.21.1803112350190.1485@nanos.tec.linutronix.de>
References: <d109lwfe.fsf@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018, Jason Vas Dias wrote:

checkpatch.pl still reports:

   total: 15 errors, 3 warnings, 165 lines checked

> +notrace static u64 vread_tsc_raw(void)
> +{
> +	u64 tsc, last=gtod->raw_cycle_last;
> +	if( likely( gtod->has_rdtscp ) )
> +		tsc	= rdtscp((void*)0);

Plus I asked more than once to split that rdtscp() stuff into a separate
patch.

You surely are free to ignore my review comments, but rest assured that I'm
free to ignore the crap you insist to send me as well.

Thanks,

	tglx
