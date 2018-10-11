Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29553C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3902075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3902075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeJLGpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:45:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48802 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJLGpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:45:06 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gAkAX-0003yj-Ms; Fri, 12 Oct 2018 01:15:01 +0200
Date:   Fri, 12 Oct 2018 01:15:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jann Horn <jannh@google.com>
cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, kristen@linux.intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
In-Reply-To: <CAG48ez0P7dq+j7gy0dbbS8aLOPC-M3rsbNPuHwXHAMh_bfSQgw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1810120113450.1457@nanos.tec.linutronix.de>
References: <20181011185458.10186-1-kristen@linux.intel.com> <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com> <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com>
 <CAG48ez0P7dq+j7gy0dbbS8aLOPC-M3rsbNPuHwXHAMh_bfSQgw@mail.gmail.com>
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

On Thu, 11 Oct 2018, Jann Horn wrote:
> On Thu, Oct 11, 2018 at 10:56 PM Kees Cook <keescook@chromium.org> wrote:
> > Seems like just changing this with "ax == 0" into "ax >= 0" would solve that?
> 
> As spender points out on twitter
> (https://twitter.com/grsecurity/status/1050497259937370118 - thanks,
> spender!), struct pt_regs stores register values as "unsigned long",
> and so you'll need to use something like IS_ERR_VALUE().

Ha, so it's not only me who noticed, but then I'm not reading twitter...

Thanks,

	tglx

