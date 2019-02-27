Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277A7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7C2218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfB0Vbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 16:31:48 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53051 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfB0Vbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 16:31:47 -0500
Received: from p5492e5b8.dip0.t-ipconnect.de ([84.146.229.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gz6no-0006fs-9R; Wed, 27 Feb 2019 22:31:44 +0100
Date:   Wed, 27 Feb 2019 22:31:43 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        x86@kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/stacktrace: export save_stack_trace_tsk_reliable
In-Reply-To: <20190227211748.9545-1-joe.lawrence@redhat.com>
Message-ID: <alpine.DEB.2.21.1902272219160.1644@nanos.tec.linutronix.de>
References: <20190227211748.9545-1-joe.lawrence@redhat.com>
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

On Wed, 27 Feb 2019, Joe Lawrence wrote:

> The ppc64le implementation of save_stack_trace_tsk_reliable() is
> exported, so do the same with x86.

And what's the in tree module user of this? I can't find one and just
because PPC has an export with no user is not a convincing argument to add
another one. The proper solution is to remove the unused PPC export.

Thanks,

	tglx




