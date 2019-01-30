Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05897C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD2621873
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfA3IGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:06:06 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46196 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfA3IGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:06:05 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goksl-0006rr-38; Wed, 30 Jan 2019 09:06:03 +0100
Date:   Wed, 30 Jan 2019 09:06:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: Re: [PATCH] acpi_pm: Reduce PMTMR counter read contention
In-Reply-To: <1548141807-25825-1-git-send-email-zhenzhong.duan@oracle.com>
Message-ID: <alpine.DEB.2.21.1901300903350.1950@nanos.tec.linutronix.de>
References: <1548141807-25825-1-git-send-email-zhenzhong.duan@oracle.com>
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

On Tue, 22 Jan 2019, Zhenzhong Duan wrote:

> On a large system with many CPUs, using PMTMR as the clock source can
> have a significant impact on the overall system performance because
> of the following reasons:
>  1) There is a single PMTMR counter shared by all the CPUs.
>  2) PMTMR counter reading is a very slow operation.
> 
> Using PMTMR as the default clock source may happen when, for example,
> the TSC clock calibration exceeds the allowable tolerance and HPET
> disabled by nohpet on kernel command line. Sometimes the performance

The question is why would anyone disable HPET on a larger machine when the
TSC is wreckaged?

I'm not against the change per se, but I really want to understand why we
need all the complexity for something which should never be used in a real
world deployment.

Thanks,

	tglx
