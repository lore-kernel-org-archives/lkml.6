Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41021ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1050F2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1050F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeKARX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:23:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57034 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeKARX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:23:59 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gI8ER-0000Qm-3H; Thu, 01 Nov 2018 09:21:35 +0100
Date:   Thu, 1 Nov 2018 09:21:34 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Igor Stoppa <igor.stoppa@gmail.com>
cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/17] prmem: documentation
In-Reply-To: <8675e9d8-0ef0-7515-a894-097d4be25b73@gmail.com>
Message-ID: <alpine.DEB.2.21.1811010909480.1642@nanos.tec.linutronix.de>
References: <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com> <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net> <20181030175814.GB10491@bombadil.infradead.org> <20181030182841.GE7343@cisco> <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com> <20181030213557.GE10491@bombadil.infradead.org> <CALCETrW1FcT88u0QY9k_PMOeZj0G8H6KNb5Bnreo-12NvmmCEQ@mail.gmail.com> <20181031100237.GN744@hirez.programming.kicks-ass.net> <659CFC78-22BF-492B-B2E4-B8E89AA08446@amacapital.net>
 <20181031210032.GA3159@hirez.programming.kicks-ass.net> <2E29C35B-3F98-473D-A874-0D9B9B15B399@amacapital.net> <4124995b-4363-9b37-19b1-1879bf04978b@gmail.com> <CALCETrWCvAfyfBWgcmhy8TGByiX3ZXXSOkLtZFdM385fDqYJVw@mail.gmail.com>
 <8675e9d8-0ef0-7515-a894-097d4be25b73@gmail.com>
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

Igor,

On Thu, 1 Nov 2018, Igor Stoppa wrote:
> On 01/11/2018 01:19, Andy Lutomirski wrote:
> 
> > ISTM you don't need that atomic operation -- you could take a spinlock
> > and then just add one directly to the variable.
> 
> It was my intention to provide a 1:1 conversion of existing code, as it should
> be easier to verify the correctness of the conversion, as long as there isn't
> any significant degradation in performance.
> 
> The rework could be done afterward.

Please don't go there. The usual approach is to

  1) Rework existing code in a way that the new functionality can be added
     with minimal effort afterwards and without creating API horrors.

  2) Verify correctness of the rework

  3) Add the new functionality
  
That avoids creation of odd functionality and APIs in the first place, so
they won't be used in other places and does not leave half cleaned up code
around which will stick for a long time.

Thanks,

	tglx
