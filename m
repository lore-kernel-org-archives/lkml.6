Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF44FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95594222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502706AbfBNQVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:21:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:2447 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391561AbfBNQVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:21:54 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 08:21:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; 
   d="scan'208";a="126495020"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2019 08:21:50 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 405DF301247; Thu, 14 Feb 2019 08:21:50 -0800 (PST)
Date:   Thu, 14 Feb 2019 08:21:50 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, peterz@infradead.org, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com, jmattson@google.com
Subject: Re: [PATCH v5 03/12] KVM/x86: KVM_CAP_X86_GUEST_LBR
Message-ID: <20190214162150.GJ16922@tassilo.jf.intel.com>
References: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
 <1550135174-5423-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550135174-5423-4-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	case KVM_CAP_X86_GUEST_LBR:
> +		r = -EINVAL;
> +		if (cap->args[0] &&
> +		    x86_perf_get_lbr_stack(&kvm->arch.lbr_stack)) {
> +			pr_err("Failed to enable the guest lbr feature\n");

Remove the pr_err. We don't want unprivileged users trigger unlimited
kernel printk.



