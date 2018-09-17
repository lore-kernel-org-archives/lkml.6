Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CCFECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D2D214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D2D214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeIQOu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:50:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54259 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeIQOu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:50:59 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1plO-0006jr-GR; Mon, 17 Sep 2018 11:24:14 +0200
Date:   Mon, 17 Sep 2018 11:24:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     zhong jiang <zhongjiang@huawei.com>
cc:     mingo@redhat.com, jikos@kernel.org, hpa@zytor.com, x86@kernel.org,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apm: Fix a unused function warning
In-Reply-To: <1537164066-39990-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <alpine.DEB.2.21.1809171123180.16580@nanos.tec.linutronix.de>
References: <1537164066-39990-1-git-send-email-zhongjiang@huawei.com>
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

On Mon, 17 Sep 2018, zhong jiang wrote:

> Fix the following compile warning:
> 
> arch/x86/kernel/apm_32.c:1643:12: warning: ?proc_apm_show? defined but not used [-Wunused-function]
>  static int proc_apm_show(struct seq_file *m, void *v)

Thanks for taking care, but it's already fixed the same way with:

 002b87d2aace ("x86/APM: Fix build warning when PROC_FS is not enabled")

Thanks,

	tglx
