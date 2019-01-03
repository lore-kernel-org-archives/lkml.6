Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988BBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1C7217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfACTav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:30:51 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:47217 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfACTau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:30:50 -0500
Received: from oxbsltgw35.schlund.de ([212.227.220.134]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1q8m-1gcwpb3SFE-002GgX; Thu, 03 Jan 2019 20:30:07 +0100
Date:   Thu, 3 Jan 2019 20:30:06 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     mark.rutland@arm.com, julien.thierry@arm.com, mlangsdo@redhat.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        steven.price@arm.com, shankerd@codeaurora.org,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ykaukab@suse.de, Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Message-ID: <1951199845.271163.1546543806398@email.ionos.de>
In-Reply-To: <db5968e6-609b-1a1f-464d-436327dd1738@arm.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
 <20190103163740.GC3529@e103592.cambridge.arm.com>
 <db5968e6-609b-1a1f-464d-436327dd1738@arm.com>
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:yKSS8p5egjlaMhfhDeQJPIdcmGhd5xl+oENISsah/WG0MujPa2h
 LiJMMCQfW6PJ7Eqb6eOi9GIn0PtuqJuNzQe+lzjg8s7o+Kxv+fchFK4zeE5rWaRNBXs3WHb
 twJVYOfDA8BNqd0LJCGuflSdsIvfhsrOAq2FzC0PW4K3DmSrH1AmZd51HDxqM5ItLJGjsKm
 igvqWwly+YzfdmD1huaQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pW995/OWosI=:4S/PKYyQXhoWhzTuLBtOvm
 4i82PGUuiX8qrxniqMs0zyhWzTTXvBZV5beXckYtn9X9/DM9caKtF1mMCXcQr95kDuosZj/HQ
 VyWTe7QGvbKjziZXFvxdgq/xDtgjczTeN5LTiy4zvOsfvZ9Pq7h9YhTb5hX2UI99b6BevZ9I2
 8eIbuQ/GWIFaaky/macSzOPqoNj/tqG+wfCrdDRZCqFpL+N16YjLR0umKQIfkntKYipLJCeDz
 z8WH51ps2dNVU6rZFxWSDPnVJ99JEmqvEFnKkre+i31wC4qxTelrxn1aDKE/hCGtKQl0bykNj
 C+Em/5Z+fY0q5ov33Jm7qyyatgXvO2EXy33zgs/64Hb/3wt0fdnFVAsHq9d6jIT45wuVbBAeV
 TivN1+XinOOAe5N1z3JcvReq5UzMtRNmhOwldRVG5GCp6CeUwNwMWW2qQQmabI5MVGc7/5qlZ
 81K1ZaT73S5GynEZEAdlDgQn+cEApsAj5b7+CGb5zfFh8HsJIOf0Fld8H+Pdh2GTS1hM+mI55
 f0arSTJ2RdG2WOPqA8sRLkkKuB2q1IgL1f0Bp2w9AH/P1vRhBxwJfZLTsRAykwAxnIqfqyp/3
 1I8VlEKdXcsTSMuq1E45tuVSQjHozQmd+zC27LmR9TZY7ki5AcdQTM3nvavy3OaBe647NSPtT
 9WNJBjhnLIo8ifxd5PVT9IIuWVcjdXAkArcpCGXON4KGZT1FJvPJ32VrLqqRhs5/afdf0gypP
 qRIP3DFW3j565ctOIw6cr6y31zGnwkcjUbhPFsrWdf4SC1jjEeg4MWNARRo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

> Jeremy Linton <jeremy.linton@arm.com> hat am 3. Januar 2019 um 17:46 geschrieben:
> 
> 
> Hi,
> 
> On 01/03/2019 10:37 AM, Dave Martin wrote:
> > On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
> >> There is a lot of variation in the Arm ecosystem. Because of this,
> >> there exist possible cases where the kernel cannot authoritatively
> >> determine if a machine is vulnerable.
> >>
> >> Rather than guess the vulnerability status in cases where
> >> the mitigation is disabled or the firmware isn't responding
> >> correctly, we need to display an "Unknown" state.
> >>

i applied your patch series on linux-next-20190103. On my Raspberry Pi 3B+ (defconfig) i'm getting this from sysfs:

l1tf:Not affected
meltdown:Not affected
spec_store_bypass:Unknown
spectre_v1:Mitigation: __user pointer sanitization
spectre_v2:Unknown

AFAIK it has 4 Cortex-A53 cores (no PSCI firmware), so shouldn't be affected.

How can this be fixed?

Thanks
Stefan
