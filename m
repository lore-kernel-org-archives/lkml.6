Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9575C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE84121773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfBLNZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:25:06 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43311 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBLNZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:25:05 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gtY3S-0003fA-Dv; Tue, 12 Feb 2019 14:24:54 +0100
Date:   Tue, 12 Feb 2019 14:24:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
In-Reply-To: <61791002-0928-fa79-8cba-9625eb0418dd@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1902121422180.3710@nanos.tec.linutronix.de>
References: <20190212044914.15490-1-aubrey.li@linux.intel.com> <20190212044914.15490-2-aubrey.li@linux.intel.com> <alpine.DEB.2.21.1902121358050.3710@nanos.tec.linutronix.de> <61791002-0928-fa79-8cba-9625eb0418dd@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1912037268-1549977894=:3710"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1912037268-1549977894=:3710
Content-Type: text/plain; charset=iso-8859-7
Content-Transfer-Encoding: 8BIT

On Tue, 12 Feb 2019, Li, Aubrey wrote:

> On 2019/2/12 21:03, Thomas Gleixner wrote:
> I didn't include the first patch, because I saw it's already in tip
> tree. Did you use tip tree?

Yes, that's my bad, forgot to switch branches. That still does not solve:

> > arch/x86/kernel/fpu/xstate.c: At top level:
> > arch/x86/kernel/fpu/xstate.c:1279:6: warning: no previous prototype for ¡arch_proc_pid_status¢ [-Wmissing-prototypes]
> >  void arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
> >       ^~~~~~~~~~~~~~~~~~~~
> Sorry for this, May I know how to replicate it on my side?

make W=1 ....

And please take your time and do not shoot out half baken patch series
every 5 minutes.

Thanks,

	tglx
--8323329-1912037268-1549977894=:3710--
