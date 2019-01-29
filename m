Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073A6C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF91320882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfA2VNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:13:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45191 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbfA2VNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:13:34 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goahF-00076D-Qk; Tue, 29 Jan 2019 22:13:29 +0100
Date:   Tue, 29 Jan 2019 22:13:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>, Jiri Kosina <jikos@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org,
        Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] cpu/hotplug: Fix "SMT disabled by BIOS" detection for
 KVM
In-Reply-To: <20190129203734.zzhw2koob4hdrrr7@treble>
Message-ID: <alpine.DEB.2.21.1901292213030.1950@nanos.tec.linutronix.de>
References: <92bb3175ad0fa9200baae41707ad39a56c05732d.1548694307.git.jpoimboe@redhat.com> <20190129203734.zzhw2koob4hdrrr7@treble>
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

On Tue, 29 Jan 2019, Josh Poimboeuf wrote:
> > Fixes: 73d5e2b47264 ("cpu/hotplug: detect SMT disabled by BIOS")
> > Reported-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> NACK - Need to export "sched_smt_present" so KVM can call
> sched_smt_active().

You beat me to it. Was just about to tell you :)
