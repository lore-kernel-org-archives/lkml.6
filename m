Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA677C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3D120645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3D120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJJQfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:35:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44986 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJJQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:35:46 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gAAZW-0004Fw-O6; Wed, 10 Oct 2018 11:14:27 +0200
Date:   Wed, 10 Oct 2018 11:14:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Baoquan He <bhe@redhat.com>
cc:     Borislav Petkov <bp@alien8.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-acpi@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, rjw@rjwysocki.net, lenb@kernel.org,
        ard.biesheuvel@linaro.org, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com, Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
In-Reply-To: <20181010090620.GF25297@MiWiFi-R3L-srv>
Message-ID: <alpine.DEB.2.21.1810101113070.10278@nanos.tec.linutronix.de>
References: <20181010084119.17539-1-fanc.fnst@cn.fujitsu.com> <20181010085920.GB5533@zn.tnic> <20181010090620.GF25297@MiWiFi-R3L-srv>
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

On Wed, 10 Oct 2018, Baoquan He wrote:

> Hi Boris,
> 
> On 10/10/18 at 10:59am, Borislav Petkov wrote:
> > ... and we just picked up
> > 
> > https://lkml.kernel.org/r/20181001140843.26137-1-msys.mizuma@gmail.com
> > 
> > and without having looked at the rest of your stuff, if people accept
> > your solution, we don't need the silly parameter anymore, right?
> > 
> > Which means, we should not rush the whole thing yet until the whole
> > KASLR vs movable memory gets solved properly.
> 
> Masa's patches solves the problem in memory region KASLR which later hot
> added memory may be big than the default padding 10 TB.
> 
> Chao's patches is trying to fix a conflict between 'movable_node' and
> kernel text KASLR. If 'movable_node' specified, we rely on SRAT to get
> which memory region is movable or immovable, and movable region can be
> hot removed. But if kernel is randomized into movable memory, it can't
> be hot removed any more, this is a regression after KASLR introduced.
> So this is a different issue than Masa's.

Yes, it's different, but if the SRAT information is available early, then
the command line parameter can go away because then the required
information for Masa's problem is available as well.

Thanks,

	tglx
