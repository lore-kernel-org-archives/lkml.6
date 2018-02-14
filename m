Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032046AbeBNXRK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 18:17:10 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41226 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031971AbeBNXRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 18:17:08 -0500
X-Google-Smtp-Source: AH8x224lHuKj//U3+TOQcGkIaE/ZLy+hSSKdlBA+tn8o39yJZkUIaLrcEiMxOwI4B3sCxdIAN6Nf0Q==
Date: Thu, 15 Feb 2018 00:17:04 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>, Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave@sr71.net>,
        hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk,
        linux-tip-commits@vger.kernel.org,
        Arjan van de Ven <arjan@infradead.org>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: hpwdt: Remove spinlock acquire and BIOS calls
 from NMI context
Message-ID: <20180214231704.xv2iwqsfvljoybul@gmail.com>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
 <a85c28b8-1255-3264-bb4a-89e85e3c6009@sr71.net>
 <20180212165835.GO25181@hirez.programming.kicks-ass.net>
 <20180213075540.3lkikkpgjoe6ocjk@gmail.com>
 <5c3ba123-abbe-f153-7b75-a89d31d25c72@linux.intel.com>
 <20180214093159.mdzfupne547bi5qx@gmail.com>
 <20180214094404.GA18349@pd.tnic>
 <20180214181342.GA27600@anatevka.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214181342.GA27600@anatevka.americas.hpqcorp.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jerry Hoemann <jerry.hoemann@hpe.com> wrote:

> 
> Ingo,
> 
> I have a patch set under review that brings hpwdt into compliance
> with the watchdog core.
> 
> One of the changes removes the callback into firmware in hpwdt_pretimeout
> and its associated spinlock.
> 
> https://lkml.org/lkml/2018/2/12/30

 drivers/watchdog/hpwdt.c | 490 +----------------------------------------------
 1 file changed, 8 insertions(+), 482 deletions(-)

Very nice, and this should solve all the NMI handling complications!

> I will add you to the CC list of the next version of the set.

Thanks!

	Ingo
