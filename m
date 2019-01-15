Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1258EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B362085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfAOKoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:44:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42022 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfAOKoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:44:15 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjMCM-0003gx-PC; Tue, 15 Jan 2019 11:43:59 +0100
Date:   Tue, 15 Jan 2019 11:43:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Juergen Gross <jgross@suse.com>
cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        hpa@zytor.com, mingo@redhat.com, bp@alien8.de, hans@knorrie.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] xen: Fix x86 sched_clock() interface for xen
In-Reply-To: <20190114124413.3742-1-jgross@suse.com>
Message-ID: <alpine.DEB.2.21.1901151142590.1865@nanos.tec.linutronix.de>
References: <20190114124413.3742-1-jgross@suse.com>
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

On Mon, 14 Jan 2019, Juergen Gross wrote:

> Commit f94c8d11699759 ("sched/clock, x86/tsc: Rework the x86 'unstable'
> sched_clock() interface") broke Xen guest time handling across
> migration:
> 
> [  187.249951] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [  187.251137] OOM killer disabled.
> [  187.251137] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [  187.252299] suspending xenstore...
> [  187.266987] xen:grant_table: Grant tables using version 1 layout
> [18446743811.706476] OOM killer enabled.
> [18446743811.706478] Restarting tasks ... done.
> [18446743811.720505] Setting capacity to 16777216

I see that it's broken, but the changelog could do with an explanation WHY
it broke.

Other than that this looks about right.

Thanks,

	tglx
