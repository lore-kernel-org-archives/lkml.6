Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1887AC282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FA4213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfBJTjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 14:39:55 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37299 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBJTjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 14:39:55 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gsux6-0000J7-Mf; Sun, 10 Feb 2019 20:39:44 +0100
Date:   Sun, 10 Feb 2019 20:39:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ira Weiny <ira.weiny@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/gup.c: Remove unused write variable
In-Reply-To: <20190209173109.9361-1-ira.weiny@intel.com>
Message-ID: <alpine.DEB.2.21.1902102029560.8784@nanos.tec.linutronix.de>
References: <20190209173109.9361-1-ira.weiny@intel.com>
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

Ira,

On Sat, 9 Feb 2019, ira.weiny@intel.com wrote:

nice patch. Just a few nitpicks vs. the subject and the change log.

> Subject: [PATCH] mm/gup.c: Remove unused write variable

We usually avoid filenames in the subsystem prefix. mm/gup: is sufficient.

But what's a bit more confusing is 'write variable'. You are not removing a
variable, you are removing a unused function argument. That's two different
things.

> write is unused in gup_fast_permitted so remove it.

When referencing functions please use brackets so it's clear that you talk
about a function, i.e. gup_fast_permitted().

So the correct subject line would be:

  Subject: [PATCH] mm/gup: Remove write argument from gup_fast_permitted()

Thanks,

	tglx
