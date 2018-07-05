Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD523C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73618241A7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73618241A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbeGEGQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:16:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49177 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbeGEGQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:16:03 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faxYW-0003r5-RJ; Thu, 05 Jul 2018 08:15:52 +0200
Date:   Thu, 5 Jul 2018 08:15:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Yang, Bin" <bin.yang@intel.com>
cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm: fix cpu stuck issue in
 __change_page_attr_set_clr
In-Reply-To: <404E7043-0ADB-4A40-9A07-EBE33F26C8CB@intel.com>
Message-ID: <alpine.DEB.2.21.1807050811220.1579@nanos.tec.linutronix.de>
References: <1530180340-18593-1-git-send-email-bin.yang@intel.com> <alpine.DEB.2.21.1807031442030.1601@nanos.tec.linutronix.de> <0131cecd5d0456c2a109f4b8bdbfe558389671dd.camel@intel.com> <alpine.DEB.2.21.1807040849520.1816@nanos.tec.linutronix.de>
 <3224aae1d09788aba687fd7bd9e088f233016fc8.camel@intel.com> <alpine.DEB.2.21.1807041119260.1816@nanos.tec.linutronix.de> <34a76fad5c43c11ce8ceb491537b453d8053bdb2.camel@intel.com> <alpine.DEB.2.21.1807041221110.1816@nanos.tec.linutronix.de>
 <E0B0C3E3-5AA5-4AEC-A11A-B55040A007C3@intel.com> <alpine.DEB.2.21.1807050708320.1579@nanos.tec.linutronix.de> <404E7043-0ADB-4A40-9A07-EBE33F26C8CB@intel.com>
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

On Thu, 5 Jul 2018, Yang, Bin wrote:

> Sorry for the misunderstanding. I mean I will improve the check loop in patch v2. 
> I just submitted patch v2. Thanks in advance for your kind review.

Did you actually read what I wrote?

> On Thu, 5 Jul 2018, Yang, Bin wrote:
> 
> Please do not top post.

Here again: Please do not top post.

and further down:

> and that can be done smart without massive looping in 4K steps, but we
> really want to analyze _first_ whether the checks are just silently fixing
> up sloppy callers and whether they are needed at all.

I can't see any analysis of that in your V2.

Thanks,

	tglx


