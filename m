Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78293C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7BE2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7BE2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeFSXNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:13:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58538 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeFSXN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:13:28 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVPoH-00052u-QP; Wed, 20 Jun 2018 01:13:14 +0200
Date:   Wed, 20 Jun 2018 01:13:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH v10 6/7] x86/paravirt: add active_sched_clock to
 pv_time_ops
In-Reply-To: <20180615174204.30581-7-pasha.tatashin@oracle.com>
Message-ID: <alpine.DEB.2.21.1806200110370.10546@nanos.tec.linutronix.de>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com> <20180615174204.30581-7-pasha.tatashin@oracle.com>
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

On Fri, 15 Jun 2018, Pavel Tatashin wrote:
> Early boot clock might differ from the clock that is used later on,
> therefore add a new field to pv_time_ops, that shows currently active
> clock. If platform supports early boot clock, this field will be changed
> to use that clock early in boot, and later will be replaced with the
> permanent clock.

I'm not seeing why this is required. If a hypervisor provides a
sched_clock() override then it's not the kernels problem to make sure that
it is usable.

Thanks,

	tglx
