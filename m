Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669A1C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2451520657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2451520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeKAVUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:20:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57361 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKAVUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:20:46 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIBvC-0003h3-Oq; Thu, 01 Nov 2018 13:17:58 +0100
Date:   Thu, 1 Nov 2018 13:17:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Woodhouse, David" <dwmw@amazon.co.uk>
cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "zhenzhong.duan@oracle.com" <zhenzhong.duan@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@suse.de" <bp@suse.de>,
        "srinivas.eeda@oracle.com" <srinivas.eeda@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "luto@kernel.org" <luto@kernel.org>
Subject: Re: [PATCH v2 1/2] retpolines: Only enable retpoline support when
 compiler support it
In-Reply-To: <90a9eed724b28d5af57a71694a95b4cd92728ccc.camel@amazon.co.uk>
Message-ID: <alpine.DEB.2.21.1811011317400.1642@nanos.tec.linutronix.de>
References: <991cbe9b-1e31-4b12-b572-91fde5c79699@default>  <20181101095002.GA118944@gmail.com> <90a9eed724b28d5af57a71694a95b4cd92728ccc.camel@amazon.co.uk>
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

On Thu, 1 Nov 2018, Woodhouse, David wrote:
> On Thu, 2018-11-01 at 10:50 +0100, Ingo Molnar wrote:
> > * Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:
> > 
> > > Since retpoline capable compilers are widely available, make
> > > CONFIG_RETPOLINE hard depend on it.
> > > 
> > > The check of RETPOLINE is changed to CONFIG_RETPOLINE.
> > > 
> > > This change is based on suggestion in https://lkml.org/lkml/2018/9/18/1016
> > > 
> > > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > 
> > Please turn such 'based on suggestions' into proper tags as well, i.e. 
> > something like:
> > 
> >   Suggested-by: David Woodhouse <dwmw2@infradead.org>
> 
> I think the suggestion came from PeterZ; I just acked it.
> 
> Although on furthe reflection, I think I'd prefer a build break if
> retpoline is enabled in the kernel config and the compiler doesn't
> support it. This patch would make it silently fail to be secure.

Agreed.

Thanks,

	tglx
