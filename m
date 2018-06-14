Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 06B1DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB13E208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB13E208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754944AbeFNIci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:32:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46833 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754685AbeFNIce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:32:34 -0400
Received: from p4fea5fc6.dip0.t-ipconnect.de ([79.234.95.198] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fTNfl-0007RC-CH; Thu, 14 Jun 2018 10:32:01 +0200
Date:   Thu, 14 Jun 2018 10:32:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nicholas Piggin <npiggin@gmail.com>
cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 12/23] kernel/watchdog: Introduce a struct for NMI
 watchdog operations
In-Reply-To: <20180614123250.230667f6@roar.ozlabs.ibm.com>
Message-ID: <alpine.DEB.2.21.1806141029070.1581@nanos.tec.linutronix.de>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com> <20180613174141.539fc6c1@roar.ozlabs.ibm.com> <20180613084219.GT12258@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806131121180.2280@nanos.tec.linutronix.de> <20180613215225.2a938abc@roar.ozlabs.ibm.com> <20180614013117.GC22652@voyager> <20180614123250.230667f6@roar.ozlabs.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018, Nicholas Piggin wrote:
> On Wed, 13 Jun 2018 18:31:17 -0700
> > I could look into creating the library for
> > common code and relocate the hpet watchdog into arch/x86 for the hpet-
> > specific parts.
> 
> If you can investigate that approach, that would be appreciated. I hope
> I did not misunderstand you there, Thomas.

I'm not against cleanups and consolidation, quite the contrary.

But this stuff just adds new infrastructure w/o showing that it's actually
a cleanup and consolidation.

Thanks,

	tglx
