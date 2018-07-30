Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605E5FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2363B20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2363B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbeG3OAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:00:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56104 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeG3OAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:00:20 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fk7Et-0002Cr-GF; Mon, 30 Jul 2018 14:25:27 +0200
Date:   Mon, 30 Jul 2018 14:25:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/speculation: Support Enhanced IBRS on future CPUs
In-Reply-To: <1532465636-25240-1-git-send-email-sai.praneeth.prakhya@intel.com>
Message-ID: <alpine.DEB.2.21.1807301423260.2518@nanos.tec.linutronix.de>
References: <1532465636-25240-1-git-send-email-sai.praneeth.prakhya@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018, Sai Praneeth Prakhya wrote:

> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
> 
> Some future Intel processors may support "Enhanced IBRS" which is an
> "always on" mode i.e. IBRS bit in SPEC_CTRL MSR is enabled once and
> never disabled. According to specification[1], this should simplify
> software enabling and improve performance.

SHOULD is not really helpful. The question is whether it does improve
performance in practice or not. You really want to add numbers comparing
retpoutine and enhanced IBRS.

Thanks,

	tglx
