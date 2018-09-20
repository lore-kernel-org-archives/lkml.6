Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AB0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC4D21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC4D21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbeITX1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:27:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:9359 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbeITX1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:27:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 10:43:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="264349378"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.148])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2018 10:42:46 -0700
Date:   Thu, 20 Sep 2018 10:42:45 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peng Hao <penghao122@sina.com.cn>, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        peng.hao2@zte.com, Peng Hao <peng.hao2@zte.com.cn>
Subject: Re: [PATCH RESEND] kvm/x86: propagate fetch fault into guest
Message-ID: <20180920174245.GA10381@linux.intel.com>
References: <1537311828-4547-1-git-send-email-penghao122@sina.com.cn>
 <1537367635.9937.4.camel@intel.com>
 <a3f05921-d802-efd6-65bb-7cb99f804f0f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3f05921-d802-efd6-65bb-7cb99f804f0f@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 06:32:10PM +0200, Paolo Bonzini wrote:
> On 19/09/2018 16:33, Sean Christopherson wrote:
> > On Tue, 2018-09-18 at 19:03 -0400, Peng Hao wrote:
> >> From: Peng Hao <peng.hao2@zte.com.cn>
> >>
> >> When handling ept misconfig exit, it will call emulate instruction
> >> with insn_len = 0. The decode instruction function may return a fetch
> >> fault and should propagate to guest.
> > 
> > What fault is encountered, e.g. #PF, #UD, etc...?  Something like a
> > #UD at this point should result in an exit to userspace as it means
> > KVM was unable to emulate an instruction that was successfully
> > decoded by hardware.
> 
> If it's the same bug as https://lore.kernel.org/patchwork/patch/850077/
> it would be a #PF.

Indeed it is, let's move this discussion to that thread.
