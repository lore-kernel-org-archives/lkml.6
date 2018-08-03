Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5B2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9788B21717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9788B21717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbeHCL56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:57:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39364 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbeHCL56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:57:58 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flWuL-0005uy-4h; Fri, 03 Aug 2018 12:02:05 +0200
Date:   Fri, 3 Aug 2018 12:02:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Shier <pshier@google.com>
cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de,
        konrad.wilk@oracle.com, dwmw@amazon.co.uk,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Peter Feiner <pfeiner@google.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH] proc: added ept_ad flag to /proc/cpuinfo
In-Reply-To: <CACwOFJSta=jM7LDiEtT-V_UnCwhggurDa4B+dViqLcdyPvYGxQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808031158400.1745@nanos.tec.linutronix.de>
References: <20180730211254.173686-1-pshier@google.com> <alpine.DEB.2.21.1807302342570.1725@nanos.tec.linutronix.de> <CACwOFJQqqh6m2x+JXBnmeCzS7Zb-3e+5iPzp_vAZPGCqW+i_8w@mail.gmail.com> <alpine.DEB.2.21.1808011954410.1835@nanos.tec.linutronix.de>
 <CACwOFJSta=jM7LDiEtT-V_UnCwhggurDa4B+dViqLcdyPvYGxQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Thu, 2 Aug 2018, Peter Shier wrote:
> Thank you Thomas. I missed what I think is your fundamental point
> regarding duplication created by this patch between CPU feature bits
> and KVM's consumption of the IA32_VMX_EPT_VPID_CAP MSR.
> 
> Should all the features in this MSR be exposed via CPU feature bits
> and should KVM consume only from there rather than reading the MSR
> directly? There are 16 feature bits in the MSR per SDM Vol 3d section
> A.10.

Uuurg. Probably not, unless they are important somehow for similar reasons
like the one you are exposing. I assume they are not, so using the MSR and
picking all bits directly from there is ok.

But thanks for taking a look as noew we at least know why it doesn't make
sense to convert VMX over as it has to read the MSR anyway.

Thanks,

	tglx


