Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDA9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA03C20883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfACHQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:16:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:20164 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbfACHQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 02:16:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 23:16:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,434,1539673200"; 
   d="scan'208";a="264048398"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga004.jf.intel.com with ESMTP; 02 Jan 2019 23:16:41 -0800
Message-ID: <5C2DB81F.3000906@intel.com>
Date:   Thu, 03 Jan 2019 15:22:07 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Jim Mattson <jmattson@google.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        like.xu@intel.com, Jann Horn <jannh@google.com>,
        arei.gonglei@huawei.com
Subject: Re: [PATCH v4 04/10] KVM/x86: intel_pmu_lbr_enable
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com> <1545816338-1171-5-git-send-email-wei.w.wang@intel.com> <CALMp9eRPvxPCnAnWr8+U98PzZLQ8LzeBRMyPk0qROKBzSzSnRQ@mail.gmail.com>
In-Reply-To: <CALMp9eRPvxPCnAnWr8+U98PzZLQ8LzeBRMyPk0qROKBzSzSnRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 07:26 AM, Jim Mattson wrote:
> On Wed, Dec 26, 2018 at 2:01 AM Wei Wang <wei.w.wang@intel.com> wrote:
>> The lbr stack is architecturally specific, for example, SKX has 32 lbr
>> stack entries while HSW has 16 entries, so a HSW guest running on a SKX
>> machine may not get accurate perf results. Currently, we forbid the
>> guest lbr enabling when the guest and host see different lbr stack
>> entries.
> How do you handle live migration?

This feature is gated by the QEMU "lbr=true" option.
So if the lbr fails to work on the destination machine,
the destination side QEMU wouldn't be able to boot,
and migration will not happen.

Best,
Wei
