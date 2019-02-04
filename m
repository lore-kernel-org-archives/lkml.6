Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA34C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CD720821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfBDRtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:49:16 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56084 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfBDRtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:49:16 -0500
Received: from [176.12.107.132] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gqiMl-000317-SK; Mon, 04 Feb 2019 18:49:08 +0100
Date:   Mon, 4 Feb 2019 17:49:06 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
In-Reply-To: <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com> <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
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

On Fri, 1 Feb 2019, Fenghua Yu wrote:

> On some platforms, a feature (e.g. #AC for split lock) may not be
> enumerated by CPUID or non architectural way in IA32_CORE_CAPABILITY.
> To enable the feature on the platforms, a new kernel option setcpuid
> is added.
> 
> The feature is defined in cpufeatures.h. The kernel option setcpuid
> takes either feature bit or cpu cap flag corresponding to the feature.
> The format of the option:
> setcpuid=<feature bit>
> setcpuid=<feature capability flag>
> 
> Check cpufeatures.h for valid feature bit numbers and check capflags.c
> or /proc/cpuinfo for valid feature capability flags.
> 
> Enabling multiple features are supported.
> 
> Please note kernel may malfunction if some features are enabled by
> the option.
> 
> This option behaves like existing kernel option clearcpuid.

No it does NOT. clearcpuid allows to disable things.

This allows to enable random CPUID bits without any sanity checking. Not
going to happen. We made it clear in the past that functionality needs to
be detectable by enumeration. We do quirks for broken crap, but this is
just not how it works.

Thanks,

	tglx

