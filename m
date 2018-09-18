Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2AEECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AE0206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AE0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeIRPYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:24:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:61023 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbeIRPYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:24:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 02:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="91520529"
Received: from unknown (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga001.jf.intel.com with ESMTP; 18 Sep 2018 02:53:01 -0700
Message-ID: <5BA0CC1E.6030202@intel.com>
Date:   Tue, 18 Sep 2018 17:57:50 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Andi Kleen <ak@linux.intel.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kan.liang@intel.com" <kan.liang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "like.xu@intel.com" <like.xu@intel.com>
Subject: Re: [PATCH v2 7/8] KVM: PMU: support to save/restore the guest lbr
 stack on vCPU switching
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com> <1536233456-12173-8-git-send-email-wei.w.wang@intel.com> <33183CC9F5247A488A2544077AF19020DB0F1D5F@dggeml511-mbx.china.huawei.com> <20180918025616.GA10360@tassilo.jf.intel.com>
In-Reply-To: <20180918025616.GA10360@tassilo.jf.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 10:56 AM, Andi Kleen wrote:
>>> From: Like Xu <like.xu@intel.com>
>>>
>>> This patch adds support to KVM to save/restore the lbr stack on vCPU
>>> context switching.
>>>
>>> When the guest sets the ACTIVE bit of MSR_KVM_PV_LBR_CTRL, a perf event
>>> is created on the host for the related vCPU. This perf event ensures the
>>> LBR stack to be saved/restored when the vCPU thread is scheduled out/in.
>>> The perf event is removed and freed when the guest clears the ACTIVE
>>> bit.
>>>
>> What about live migration? Does LBR stack need to be saved on the source side and
>> restored on the dest side with the passthrough mode?
> Yes it should. Either for call stack LBR, or when it is frozen/disabled.
>
> When it's not frozen/disabled and not in call stack LBR mode it likely doesn't
> hurt either, but it's not strictly needed because it will
> be replaced so quickly.

Yes, should be supported. We are working on v3 with the suggested lazy 
save approach, and will send it out shortly.

Best,
Wei
