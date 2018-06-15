Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CCAC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342F2204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342F2204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756539AbeFOS5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:57:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51498 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756509AbeFOS5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:57:50 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fTtum-0005Wl-N8; Fri, 15 Jun 2018 20:57:40 +0200
Date:   Fri, 15 Jun 2018 20:57:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        andrew.cooper3@citrix.com, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Kees Cook <keescook@chromium.org>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [PATCH v1 3/3] x86/bugs: Switch the selection of mitigation from
 CPU vendor to CPU features
In-Reply-To: <5090fe69-61fd-99cb-f9d0-908cd6250d25@amd.com>
Message-ID: <alpine.DEB.2.21.1806152057020.1582@nanos.tec.linutronix.de>
References: <20180601145921.9500-1-konrad.wilk@oracle.com> <20180601145921.9500-4-konrad.wilk@oracle.com> <2a3e0323-7086-f764-1a3b-7ce4891e8784@amd.com> <20180611140116.GA26199@char.us.oracle.com> <5090fe69-61fd-99cb-f9d0-908cd6250d25@amd.com>
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

On Tue, 12 Jun 2018, Tom Lendacky wrote:
> On 6/11/2018 9:01 AM, Konrad Rzeszutek Wilk wrote:
> >> I think you will have to keep the case statements and explicitly check for
> >> X86_FEATURE_AMD_SSBD before using SPEC_CTRL.
> > 
> > .. we could or alternatively add an extra check for X86_FEATURE_AMD_SSBD ?
> 
> Whichever you feel is best, so long as we only use SPEC_CTRL for SSBD on
> AMD when X86_FEATURE_AMD_SSBD is present.

Is there anyone working on a fix or has this been forgotten?

Thanks,

	tglx
