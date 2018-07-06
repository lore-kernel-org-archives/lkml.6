Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60565C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22170224F9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22170224F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934747AbeGFTXy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:23:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55882 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934536AbeGFTXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:23:52 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbWKB-0003rt-99; Fri, 06 Jul 2018 21:23:23 +0200
Date:   Fri, 6 Jul 2018 21:23:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        x86@kernel.org, kvm@vger.kernel.org
Subject: Re: [patch 6/7] x86/kvmclock: Move kvmclock vsyscall param and init
 to kvmclock
In-Reply-To: <f7773add-7cac-f57f-af27-bd871bb7a0d7@redhat.com>
Message-ID: <alpine.DEB.2.21.1807062123080.1592@nanos.tec.linutronix.de>
References: <20180706161307.733337643@linutronix.de> <20180706162049.765314976@linutronix.de> <f7773add-7cac-f57f-af27-bd871bb7a0d7@redhat.com>
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

On Fri, 6 Jul 2018, Paolo Bonzini wrote:
> On 06/07/2018 18:13, Thomas Gleixner wrote:
> > @@ -241,6 +269,9 @@ void __init kvmclock_init(void)
> >  		return;
> >  	}
> >  
> > +	if (!hypervisor_is_type(X86_HYPER_KVM))
> > +		kvmclock_vsyscall = 0;
> > +
> 
> No need for this; by the time you get here, the condition will always be
> true.  And if you don't have kvmclock, hv_clock will be NULL and
> initialization will be skipped anyway in kvm_setup_vsyscall_timeinfo.

Right, stupid me.
