Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB090C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D8120844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D8120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeIHPFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:05:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37455 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeIHPFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:05:53 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyaLy-0006GY-DY; Sat, 08 Sep 2018 12:20:34 +0200
Date:   Sat, 8 Sep 2018 12:20:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dou Liyang <dou_liyang@163.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        hpa@zytor.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH v2 2/2] irq/matrix: Spread managed interrupts on
 allocation
In-Reply-To: <20180908070037.31154-2-dou_liyang@163.com>
Message-ID: <alpine.DEB.2.21.1809081159240.1402@nanos.tec.linutronix.de>
References: <20180908070037.31154-1-dou_liyang@163.com> <20180908070037.31154-2-dou_liyang@163.com>
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

On Sat, 8 Sep 2018, Dou Liyang wrote:
> Spread managed interrupt on allocation as well.
> 
> Fixes: a0c9259dc4e1("irq/matrix: Spread interrupts on allocation")

No. This is an enhancement and not a fix.

> -	cpumask_and(vector_searchmask, vector_searchmask, affmsk);
> -	cpu = cpumask_first(vector_searchmask);
> -	if (cpu >= nr_cpu_ids)
> -		return -EINVAL;

Removing this check changes the return value for the empty search mask case
from EINVAL to ENOSPC. Doesn't matter much I think, but it might be worth
to mention in the changelog.

Thanks,

	tglx
