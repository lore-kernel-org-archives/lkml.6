Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E76C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B162083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B162083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbeKGGcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:32:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeKGGcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:32:09 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DEC5A94B;
        Tue,  6 Nov 2018 21:05:00 +0000 (UTC)
Date:   Tue, 6 Nov 2018 13:04:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     jeyu@kernel.org, willy@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        jannh@google.com, keescook@chromium.org, kristen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com
Subject: Re: [PATCH v8 0/4] KASLR feature to randomize each loadable module
Message-Id: <20181106130459.7a2669604a2c274edbe25971@linux-foundation.org>
In-Reply-To: <20181102192520.4522-1-rick.p.edgecombe@intel.com>
References: <20181102192520.4522-1-rick.p.edgecombe@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Nov 2018 12:25:16 -0700 Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:

> This is V8 of the "KASLR feature to randomize each loadable module" patchset.
> The purpose is to increase the randomization and also to make the modules
> randomized in relation to each other instead of just the base, so that if one
> module leaks the location of the others can't be inferred.

I'm not seeing any info here which explains why we should add this to
Linux.

What is the end-user value?  What problems does it solve?  Are those
problems real or theoretical?  What are the exploit scenarios and how
realistic are they?  etcetera, etcetera.  How are we to decide to buy
this thing if we aren't given a glossy brochure?

> There is a small allocation performance degradation versus v7 as a
> trade off, but it is still faster on average than the existing
> algorithm until >7000 modules.

lol.  How did you test 7000 modules?  Using the selftest code?
