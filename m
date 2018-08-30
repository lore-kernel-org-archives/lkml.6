Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704C1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D3B2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D3B2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeH3Qrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:47:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50088 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbeH3Qrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:47:36 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvMKE-0002vT-Hw; Thu, 30 Aug 2018 14:45:26 +0200
Date:   Thu, 30 Aug 2018 14:45:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Gu Zhimin <kookoo.gu@intel.com>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
        Yu Chen <yu.c.chen@intel.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86, hibernate: Fix nosave_regions setup for
 hibernation
In-Reply-To: <73b18a8b87a465fc442366cccf5542307c4f1ae9.1535361949.git.kookoo.gu@intel.com>
Message-ID: <alpine.DEB.2.21.1808301441550.1210@nanos.tec.linutronix.de>
References: <cover.1535361949.git.kookoo.gu@intel.com> <73b18a8b87a465fc442366cccf5542307c4f1ae9.1535361949.git.kookoo.gu@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018, Gu Zhimin wrote:
> 
> Fix this problem by changing pfn limit from max_low_pfn to max_pfn.
> This issue should also exist on 64bits systems, if there are reserved
> regions above 4GB.

Should? Can we please have facts and not some half baken assumptions? 

On 64bit max_low_pfn is the same as max_pfn. See init_mem_mapping().

Thanks,

	tglx
