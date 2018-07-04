Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4943BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC1D21A12
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC1D21A12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933922AbeGDJUt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:20:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46696 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932576AbeGDJUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:20:47 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fadxl-0002wX-IA; Wed, 04 Jul 2018 11:20:37 +0200
Date:   Wed, 4 Jul 2018 11:20:37 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Yang, Bin" <bin.yang@intel.com>
cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm: fix cpu stuck issue in
 __change_page_attr_set_clr
In-Reply-To: <3224aae1d09788aba687fd7bd9e088f233016fc8.camel@intel.com>
Message-ID: <alpine.DEB.2.21.1807041119260.1816@nanos.tec.linutronix.de>
References: <1530180340-18593-1-git-send-email-bin.yang@intel.com>  <alpine.DEB.2.21.1807031442030.1601@nanos.tec.linutronix.de>  <0131cecd5d0456c2a109f4b8bdbfe558389671dd.camel@intel.com>  <alpine.DEB.2.21.1807040849520.1816@nanos.tec.linutronix.de>
 <3224aae1d09788aba687fd7bd9e088f233016fc8.camel@intel.com>
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

On Wed, 4 Jul 2018, Yang, Bin wrote:

> You are completely right. After considering, I think my patch is like a
> workaround but not real fix. I am trying to re-write a new patch
> without cache implementation.

Care to explain the actual problem coherently _before_ writing yet another
patch?

Thanks,

	tglx
